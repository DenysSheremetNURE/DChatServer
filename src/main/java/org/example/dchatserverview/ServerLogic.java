package org.example.dchatserverview;

import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;

public class ServerLogic {
    private ServerSocket serverSocket;

    public ServerLogic(int port){
        try {
            serverSocket = new ServerSocket(port);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }

    }

    public void start() {
        try {
            System.out.println("Server is running...");

            while (true) {
                Socket clientSocket = serverSocket.accept();
                System.out.println("Client " + clientSocket + " is connected...");
                LogService.log("ACTION", "Client " + clientSocket.getInetAddress() + " is connected...");

                ClientHandler handler = new ClientHandler(clientSocket);
                Thread thread = new Thread(handler);
                thread.start();
            }
        } catch (IOException e){
            throw new RuntimeException(e);
        }
    }
}
