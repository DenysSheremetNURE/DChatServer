package org.example.dchatserverview;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AuthRepository {
    public boolean checkCredentials(String username, String password){
        String sql = "SELECT * FROM users WHERE username = ? AND password = ?";

        try(Connection conn = MainDBConnection.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql)){

            String hashed = HashUtil.sha256(password);

            stmt.setString(1, username);
            stmt.setString(2, hashed);
            ResultSet resultSet = stmt.executeQuery();

            return resultSet.next();
        } catch (SQLException e) {
            System.err.println(e.getMessage());
            return false;
        }
    }

    public boolean checkIfAlreadyExists(String username){
        String sql = "SELECT 1 FROM users WHERE username = ?";

        try(Connection conn = MainDBConnection.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql)){

            stmt.setString(1, username);
            ResultSet resultSet = stmt.executeQuery();

            return resultSet.next();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
