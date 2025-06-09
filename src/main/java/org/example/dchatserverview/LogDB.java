package org.example.dchatserverview;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class LogDB {

    public static void insertLog(String type, String message){
        String sql = "INSERT INTO logs (type, message) VALUES (?, ?)";
        try (Connection conn = LogDBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, type);
            stmt.setString(2, message);
            stmt.executeUpdate();

        } catch (SQLException e) {
            System.err.println("Message log error: " + e.getMessage());
        }
    }


    public static List<String> loadRecentLogs(int limit) {
        List<String> logs = new ArrayList<>();
        String sql = "SELECT timestamp, type, message FROM logs ORDER BY id DESC LIMIT ?";

        try (Connection conn = LogDBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, limit);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Timestamp time = rs.getTimestamp("timestamp");
                String type = rs.getString("type");
                String message = rs.getString("message");
                logs.add("[" + time + "] " + type + ": " + message);
            }

        } catch (SQLException e) {
            System.err.println("Log reading error: " + e.getMessage());
        }

        return logs;
    }


}
