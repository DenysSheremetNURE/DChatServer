package org.example.dchatserverview;

import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Scene;
import javafx.stage.Stage;

import java.io.IOException;

public class ServerApp extends Application {

    private ServerLogic server;

    @Override
    public void start(Stage stage) throws IOException {
        FXMLLoader fxmlLoader = new FXMLLoader(ServerApp.class.getResource("server.fxml"));
        Scene scene = new Scene(fxmlLoader.load(), 1200, 800);
        stage.setTitle("DChat server");
        stage.setScene(scene);
        stage.show();

        stage.setOnCloseRequest(event -> {
            if (server != null) {
                server.shutdownServer();
            }
        });

        final int port = 8080;

        new Thread(()->{
            try {
                server = new ServerLogic(port);
                server.start();
            } catch (Exception e){
                System.err.println("Server start error: " + e.getMessage());
                e.printStackTrace();
            }

        }).start();
    }

    public static void main(String[] args) {
        launch();
    }
}