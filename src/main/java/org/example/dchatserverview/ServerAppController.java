package org.example.dchatserverview;

import javafx.application.Platform;
import javafx.fxml.FXML;
import javafx.scene.control.Label;
import javafx.scene.control.ListView;
import javafx.scene.layout.AnchorPane;

import java.util.List;

public class ServerAppController {

    @FXML
    private Label usersCountLabel;
    //TODO
    public static int usersCount = 0;

    @FXML
    private ListView<Label> logListView;

    public void initialize(){
        LogService.bind(logListView);

        List<String> logs = LogDB.loadRecentLogs(100);
        for(String log : logs){
            LogService.loadToUI(log);
        }

        LogService.log("SERVER", "RUNNING...");
    }

    public static void addUser(){

    }
}