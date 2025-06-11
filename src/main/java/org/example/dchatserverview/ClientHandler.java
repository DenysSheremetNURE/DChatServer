package org.example.dchatserverview;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.example.dchatserverview.JSON.*;
import org.example.dchatserverview.SessionData.UserCountController;

import java.io.*;
import java.net.Socket;

public class ClientHandler implements Runnable {

    private final Socket clientSocket;
    private final BufferedReader in;
    private final BufferedWriter out;

    public ClientHandler(Socket clientSocket){
        this.clientSocket = clientSocket;
        try{

            in = new BufferedReader(new InputStreamReader(clientSocket.getInputStream()));
            out = new BufferedWriter(new OutputStreamWriter(clientSocket.getOutputStream()));

        } catch (IOException e) {

            System.err.println("Client initialization error: " + e.getMessage());
            throw new RuntimeException(e);

        }
    }

    @Override
    public void run() {

        ObjectMapper mapper = new ObjectMapper();

        try{
            String message;

            while((message = in.readLine()) != null){

                BaseRequest base = mapper.readValue(message, BaseRequest.class);
                switch(base.command){
                    case "LOGIN" -> handleLogin(message, mapper); //we pass mapper cause it is too heavy to be created once more
                    case "REGISTER" -> handleRegister(message, mapper);
                    case "LOGOUT" -> handleLogout(message, mapper);
                    case "DISCONNECT" -> handleDisconnect(message, mapper);
                }

                //TODO handle the message + add to users online
            }
        } catch (IOException e) {
            System.out.println("Socket has been closed.");
        } finally {
            try{
                in.close();
                out.close();
                clientSocket.close();

                //TODO del from users online

            } catch (IOException e) {
                System.err.println("Closing client error: " + e.getMessage());
                throw new RuntimeException(e);
            }
        }
    }


    public void sendMessage(String msg){
        try{
            out.write(msg);
            out.newLine();
            out.flush();
        } catch (IOException e) {
            System.err.println("Error while sending message to client: " + e.getMessage());
            throw new RuntimeException(e);
        }
    }

    private void handleLogin(String message, ObjectMapper mapper){
        try{
            LoginRequest login = mapper.readValue(message, LoginRequest.class);
            AuthRepository repository = new AuthRepository();
            boolean isOK = repository.checkCredentials(login.username, login.password);

            ServerLoginResponce response = new ServerLoginResponce();
            response.status = isOK ? "OK" : "ERROR";
            response.message = isOK ? "Login successful" : "Wrong credentials";

            if(isOK) LogService.log("LOGIN", "user " + login.username + " has logged in");

            String json = mapper.writeValueAsString(response);
            sendMessage(json);

        } catch (JsonProcessingException e) {
            throw new RuntimeException(e);
        }
    }

    private void handleRegister(String message, ObjectMapper mapper){

    }

    private void handleLogout(String message, ObjectMapper mapper){
        try{
            LogoutRequest logout = mapper.readValue(message, LogoutRequest.class);
            if (logout.command.equals("LOGOUT")){
                if(UserCountController.isUser(clientSocket)){
                    UserCountController.deleteUser(clientSocket);
                }
            }
            LogService.log("LOGIN", "user " + logout.user + " has logged in");
        } catch (JsonProcessingException e) {
            throw new RuntimeException(e);
        } finally {
            try {
                in.close();
                out.close();
                clientSocket.close();

                UserCountController.deleteUser(clientSocket);
            } catch (IOException e) {
                System.err.println("Closing client error: " + e.getMessage());
            }
        }

    }

    private void handleDisconnect(String message, ObjectMapper mapper){
        try {
            DisconnectRequest disconnect = mapper.readValue(message, DisconnectRequest.class);

            LogService.log("DISCONNECT", disconnect.client + " has logged out.");
        } catch (JsonProcessingException e) {
            throw new RuntimeException(e);
        } finally {
            try {
                in.close();
                out.close();
                clientSocket.close();

            } catch (IOException e) {
                System.err.println("Closing client error: " + e.getMessage());
            }
        }
    }
}
