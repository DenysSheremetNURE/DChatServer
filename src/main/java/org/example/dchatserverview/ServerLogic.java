package org.example.dchatserverview;

import org.example.dchatserverview.SessionData.UserCountController;

import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;
import java.net.SocketException;

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
                try{
                    Socket clientSocket = serverSocket.accept();
                    System.out.println("Client " + clientSocket + " is connected...");
                    LogService.log("ACTION", "Client " + clientSocket.getInetAddress() + " is connected...");

                    ClientHandler handler = new ClientHandler(clientSocket);
                    Thread thread = new Thread(handler);
                    thread.start();
                } catch (SocketException e){
                    System.out.println("Server socket is close. Shutting down...");
                    break;
                }

            }
        } catch (IOException e){
            throw new RuntimeException(e);
        }
    }

    public void shutdownServer(){
        try {
            for (Socket client : UserCountController.getSockets()) {
                if (client != null && !client.isClosed()) {
                    client.close();
                }
            }

            if (serverSocket != null && !serverSocket.isClosed()) {
                serverSocket.close();
            }

        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
