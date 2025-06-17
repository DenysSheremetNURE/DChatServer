package org.example.dchatserverview;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.example.dchatserverview.JSON.*;
import org.example.dchatserverview.SessionData.UserCountController;
import org.example.dchatserverview.UIClasses.Chat;
import org.example.dchatserverview.UIClasses.Message;

import java.io.IOException;
import java.net.Socket;
import java.sql.*;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.ArrayList;
import java.util.List;

public class MessageManager {

    public static String handleGetMessages(String message, ObjectMapper mapper){
        try{
            GetMessageRequest request = mapper.readValue(message, GetMessageRequest.class);
            String userName = request.userName;

            try(Connection conn = MainDBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(
                            "SELECT m.id, m.chat_id, u.username AS sender, m.content, m.sent_at " +
                                    "FROM dchatdata.messages m " +
                                    "JOIN dchatdata.users u ON m.sender_id = u.id " +
                                    "WHERE m.sender_id = (SELECT id FROM dchatdata.users WHERE username = ?) " +
                                    "OR m.chat_id IN (SELECT cu.chat_id FROM dchatdata.chat_users cu " +
                                    "WHERE cu.user_id = (SELECT id FROM dchatdata.users WHERE username = ?)) " +
                                    "ORDER BY m.sent_at ASC;"
                )) {

                stmt.setString(1, userName);
                stmt.setString(2, userName);
                ResultSet rs = stmt.executeQuery();

                List<Message> messages = new ArrayList<>();

                while(rs.next()){
                    Message msg = new Message();
                    msg.setId(rs.getLong("id"));
                    msg.setChatId(rs.getLong("chat_id"));
                    msg.setSender(rs.getString("sender"));
                    msg.setContent(rs.getString("content"));
                    Timestamp timestamp = rs.getTimestamp("sent_at");
                    if(timestamp != null){
                        ZonedDateTime zonedSentAt = timestamp.toInstant().atZone(ZoneId.systemDefault());
                        msg.setSentAt(zonedSentAt);
                    }
                    messages.add(msg);
                }

                GetMessageResponse response = new GetMessageResponse(messages);
                return mapper.writeValueAsString(response);


            } catch (SQLException e) {
                e.printStackTrace();
                return "[]";
            }

        } catch(IOException e){
            e.printStackTrace();
            return "[]";
        }


    }

    //TODO
    public static void handleSendMessage(String json, ObjectMapper mapper){
        SendMessageRequest request = null;
        Message message = null;
        String recipient = null;

        try{
            request = mapper.readValue(json, SendMessageRequest.class);
            message = request.message;
            recipient = request.recipient;

            //
            try(Connection conn = MainDBConnection.getConnection()){
                String senderUsername = message.getSender();
                long senderId = getUserId(conn, senderUsername);
                long recipientId = getUserId(conn, recipient);

                long chatId = getOrCreateChatId(conn, senderId, recipientId);

                long messageId = insertMessage(conn, chatId, senderId, message.getContent());

                message.setId(messageId);
                message.setChatId(chatId);

                String messageJson = mapper.writeValueAsString(new SendMessageResponse(message));

                Socket recipientSocket = UserCountController.getSocket(recipient);

                if (recipientSocket != null && !recipientSocket.isClosed()){
                    ClientHandler handler = UserCountController.getHandler(recipient);
                    if(handler != null){
                        handler.sendMessage(messageJson);
                    }
                }

                ClientHandler senderHandler = UserCountController.getHandler(message.getSender());
                if (senderHandler != null) {
                    senderHandler.sendMessage(messageJson);
                }


                LogService.log("MESSAGE", "user " + senderUsername + " sent a message to user " + recipient);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        } catch (IOException e){
            e.printStackTrace();
        }
    }

    private static long getUserId(Connection conn, String username) throws SQLException{
        String sql = "SELECT id FROM dchatdata.users WHERE username = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)){
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();
            if(rs.next()) return rs.getLong("id");
            throw new SQLException("User not found: " + username);
        }
    }

    private static Long findChatId(Connection conn, long user1, long user2) throws SQLException {
        String sql = "SELECT cu1.chat_id FROM dchatdata.chat_users cu1 JOIN dchatdata.chat_users cu2 ON cu1.chat_id = cu2.chat_id WHERE cu1.user_id = ? AND cu2.user_id = ? ";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, user1);
            stmt.setLong(2, user2);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) return rs.getLong("chat_id");
            return null;
        }
    }

    private static long createChat(Connection conn) throws SQLException {
        String sql = "INSERT INTO dchatdata.chats (created_at) VALUES (NOW()) RETURNING id";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) return rs.getLong("id");
            throw new SQLException("Failed to create chat");
        }
    }

    private static void linkUserToChat(Connection conn, long chatId, long userId) throws SQLException {
        String sql = "INSERT INTO dchatdata.chat_users (chat_id, user_id) VALUES (?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, chatId);
            stmt.setLong(2, userId);
            stmt.executeUpdate();
        }
    }

    private static long getOrCreateChatId(Connection conn, long user1, long user2) throws SQLException {
        Long chatId = findChatId(conn, user1, user2);
        if (chatId != null) return chatId;

        chatId = createChat(conn);
        linkUserToChat(conn, chatId, user1);
        linkUserToChat(conn, chatId, user2);
        return chatId;
    }

    private static long insertMessage(Connection conn, long chatId, long senderId, String content) throws SQLException {
        String sql = "INSERT INTO dchatdata.messages (chat_id, sender_id, content, sent_at) VALUES (?, ?, ?, NOW()) RETURNING id ";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, chatId);
            stmt.setLong(2, senderId);
            stmt.setString(3, content);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) return rs.getLong("id");
            throw new SQLException("Failed to insert message");
        }
    }

    private static List<Chat> getUserChats(Connection conn, String username) throws SQLException {
        String sql = """
        SELECT cu.chat_id, u.id AS user_id, u.username
        FROM dchatdata.chat_users cu
        JOIN dchatdata.chat_users cu2 ON cu.chat_id = cu2.chat_id
        JOIN dchatdata.users u ON cu.user_id = u.id
        WHERE cu2.user_id = (SELECT id FROM dchatdata.users WHERE username = ?)
        AND u.username <> ?
    """;

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, username);
            stmt.setString(2, username);
            ResultSet rs = stmt.executeQuery();

            List<Chat> chats = new ArrayList<>();
            while (rs.next()) {
                chats.add(new Chat(
                        rs.getLong("chat_id"),
                        rs.getLong("user_id"),
                        rs.getString("username")
                ));
            }
            return chats;
        }
    }


    public static void handleNewChat(String message, ObjectMapper mapper, ClientHandler handler) {
        try{
            NewChatRequest request = mapper.readValue(message, NewChatRequest.class);

            String sender = request.sender;
            String recipient = request.recipient;

            try(Connection conn = MainDBConnection.getConnection()){
                long senderId = getUserId(conn, sender);

                long recipientId;
                try {
                    recipientId = getUserId(conn, recipient);
                } catch (SQLException e){
                    handler.sendMessage(mapper.writeValueAsString(new BaseResponse("NEW_CHAT_ERR")));
                    return;
                }

                Long existingChatId = findChatId(conn, senderId, recipientId); // Long instead of long to compare to null
                if(existingChatId != null){
                    handler.sendMessage(mapper.writeValueAsString(new BaseResponse("NEW_CHAT_ERR")));
                    return;
                }

                long chatId = createChat(conn);
                linkUserToChat(conn, chatId, senderId);
                linkUserToChat(conn, chatId, recipientId);

                NewChatResponse response = new NewChatResponse(sender, recipient, recipientId, chatId);
                response.type = "NEW_CHAT_OK";

                handler.sendMessage(mapper.writeValueAsString(response));

                ClientHandler recipientHandler = UserCountController.getHandler(recipient);
                if (recipientHandler != null) {
                    NewChatResponse responseForRecipient = new NewChatResponse(recipient, sender, senderId, chatId);
                    responseForRecipient.type = "NEW_CHAT_OK";
                    recipientHandler.sendMessage(mapper.writeValueAsString(responseForRecipient));
                }

                //
                List<Chat> senderChats = getUserChats(conn, sender);
                handler.sendMessage(mapper.writeValueAsString(new GetChatsResponse(senderChats)));

                if (recipientHandler != null) {
                    List<Chat> recipientChats = getUserChats(conn, recipient);
                    recipientHandler.sendMessage(mapper.writeValueAsString(new GetChatsResponse(recipientChats)));
                }
                //

                LogService.log("CHAT", "User " + sender + " created chat with " + recipient);
            } catch (SQLException e){
                e.printStackTrace();
                handler.sendMessage(mapper.writeValueAsString(new BaseResponse("NEW_CHAT_ERR")));
            }

        } catch (IOException e) {
            e.printStackTrace();
            try{
                handler.sendMessage(mapper.writeValueAsString(new BaseResponse("NEW_CHAT_ERR")));
            } catch (JsonProcessingException ex){
                ex.printStackTrace();
            }

        }
    }

    public static String handleGetChats(String message, ObjectMapper mapper){
        try {
            GetChatsRequest request = mapper.readValue(message, GetChatsRequest.class);
            String username = request.username;

            try (Connection conn = MainDBConnection.getConnection();
                 PreparedStatement stmt = conn.prepareStatement(
                         "SELECT cu.chat_id, u.id AS user_id, u.username " +
                                 "FROM dchatdata.chat_users cu " +
                                 "JOIN dchatdata.chat_users cu2 ON cu.chat_id = cu2.chat_id " +
                                 "JOIN dchatdata.users u ON cu.user_id = u.id " +
                                 "WHERE cu2.user_id = (SELECT id FROM dchatdata.users WHERE username = ?) " +
                                 "AND u.username <> ?"
                 )) {

                stmt.setString(1, username);
                stmt.setString(2, username);
                ResultSet rs = stmt.executeQuery();

                List<Chat> chats = new ArrayList<>();

                while (rs.next()) {
                    long chatId = rs.getLong("chat_id");
                    long userId = rs.getLong("user_id");
                    String user = rs.getString("username");

                    chats.add(new Chat(chatId, userId, user));
                }

                return mapper.writeValueAsString(new GetChatsResponse(chats));

            } catch (SQLException e) {
                e.printStackTrace();
            }

        } catch (IOException e) {
            e.printStackTrace();
        }

        return "[]";
    }

}
