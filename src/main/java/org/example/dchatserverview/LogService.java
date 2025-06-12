package org.example.dchatserverview;

import javafx.application.Platform;
import javafx.scene.control.Label;
import javafx.scene.control.ListView;

public class LogService {
    private static ListView<Label> logView;

    public static void bind(ListView<Label> view) {
        logView = view;
    }

    public static void log(String type, String message) {
        if (logView == null) {
            return;
        }

        Label label = new Label(type + ": " + message);

        String color;
        switch (type) {
            case "ERROR", "LOGOUT" -> color = "red";
            case "WARN", "DISCONNECT" -> color = "orange";
            case "SERVER" -> color = "grey";
            default -> color = "green";
        }

        label.setStyle("-fx-font-family: monospace; -fx-text-fill: " + color + ";");

        Platform.runLater(() -> {
            logView.getItems().add(label);
            logView.scrollTo(logView.getItems().size() - 1);
        });

        LogDB.insertLog(type, message);
    }

    public static void loadToUI(String message) {
        if (logView == null) {
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
