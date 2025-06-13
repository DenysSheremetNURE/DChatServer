package org.example.dchatserverview;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.example.dchatserverview.JSON.GetMessageRequest;
import org.example.dchatserverview.UIClasses.Message;

import java.io.IOException;
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
}
