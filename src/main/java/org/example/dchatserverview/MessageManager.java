package org.example.dchatserverview;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.example.dchatserverview.JSON.GetMessageRequest;
import org.example.dchatserverview.JSON.SendMessageRequest;
import org.example.dchatserverview.SessionData.UserCountController;
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

                return mapper.writeValueAsString(messages);


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

            Socket recipientSocket = UserCountController.getSocket(recipient);

            String messageJson = mapper.writeValueAsString(message);

            if (recipientSocket != null && !recipientSocket.isClosed()){
                ClientHandler handler = UserCountController.getHandler(recipient);
                if(handler != null){
                    handler.sendMessage(messageJson);
                }
            }

        } catch (IOException e){
            e.printStackTrace();
        } finally{
            if (request != null && message != null && recipient != null){
                try (Connection conn = MainDBConnection.getConnection()) {
                    String senderUsername = message.getSender();
                    long senderId = getUserId(conn, senderUsername);
                    long recipientId = getUserId(conn, recipient);
                    long chatId = getOrCreateChatId(conn, senderId, recipientId);

                    insertMessage(conn, chatId, senderId, message.getContent());

                    LogService.log("MESSAGE", "user " + senderUsername + " sent a message to user " + recipient);

                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
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
}
