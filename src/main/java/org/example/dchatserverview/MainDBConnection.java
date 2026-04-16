package org.example.dchatserverview;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class MainDBConnection {
    static boolean isDocker = "true".equals(System.getenv("IS_DOCKER"));

    private static final String URL = isDocker ? "jdbc:postgresql://chat-db:5432/dchat?currentSchema=dchatdata" : "jdbc:postgresql://localhost:5432/dchat?currentSchema=dchatdata";
    private static final String USER = "postgres";
    private static final String PASSWORD = "Yjdsqltybc29";

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
