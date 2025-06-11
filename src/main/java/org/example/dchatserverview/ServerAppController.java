package org.example.dchatserverview;

import javafx.application.Platform;
import javafx.fxml.FXML;
import javafx.scene.control.Label;
import javafx.scene.control.ListView;
import javafx.scene.layout.AnchorPane;

import java.net.Socket;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class ServerAppController {

    @FXML
    private Label usersCountLabel;

    @FXML
    private ListView<Label> logListView;

    public void initialize(){
        LogService.bind(logListView);

        List<String> logs = LogDB.loadRecentLogs(100);
        System.out.println("Loaded logs from DB: " + logs.size());

        for(String log : logs){
            LogService.loadToUI(log);
        }

        LogService.log("SERVER", "RUNNING...");
    }

}