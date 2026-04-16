package org.example.dchatserverview;

import javafx.application.Platform;
import javafx.scene.control.Label;
import javafx.scene.control.ListView;

import java.time.LocalDateTime;

public class LogService {
    private static ListView<Label> logView;

    public static void bind(ListView<Label> view) {
        logView = view;
    }

    public static void log(String type, String message) {

        String time = LocalDateTime.now().toString();
        String consoleLog = String.format("[%s] [%s] %s", time, type, message);

        if ("ERROR".equals(type)) {
            System.err.println(consoleLog); // Красный текст в большинстве консолей
        } else {
            System.out.println(consoleLog);
        }

        LogDB.insertLog(type, message);

        if (!"true".equals(System.getenv("IS_DOCKER")) && logView != null){
            Label label = new Label(type + ": " + message);

            String color;
            switch (type) {
                case "ERROR", "LOGOUT" -> color = "red";
                case "WARN", "DISCONNECT" -> color = "orange";
                case "SERVER" -> color = "grey";
                case "CHAT" -> color = "blue";
                default -> color = "green";
            }

            label.setStyle("-fx-font-family: monospace; -fx-text-fill: " + color + ";");

            Platform.runLater(() -> {
                logView.getItems().add(label);
                logView.scrollTo(logView.getItems().size() - 1);
            });
        }
    }

    public static void loadToUI(String message) {
        if ("true".equals(System.getenv("IS_DOCKER")) || logView == null) {
            return;
        }

        Label label = new Label(message);


        label.setStyle("-fx-font-family: monospace; -fx-text-fill: grey;");

        Platform.runLater(() -> {
            logView.getItems().add(label);
            logView.scrollTo(logView.getItems().size() - 1);
        });
    }

}
