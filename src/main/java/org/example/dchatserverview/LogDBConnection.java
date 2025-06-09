package org.example.dchatserverview;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class LogDBConnection {
    private static final String URL = "jdbc:postgresql://localhost:5432/dchat?currentSchema=dchatlogs";
    private static final String USER = "postgres";
    private static final String PASSWORD = "Yjdsqltybc29";

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
