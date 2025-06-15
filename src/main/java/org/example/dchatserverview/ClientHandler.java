package org.example.dchatserverview;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import javafx.application.Platform;
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
                    case "GET_MESSAGES" -> {
                        String responseJson = MessageManager.handleGetMessages(message, mapper);
                        sendMessage(responseJson);
                    }
                    case "SEND_MESSAGE" -> MessageManager.handleSendMessage(message, mapper);
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

            ServerLoginResponse response = new ServerLoginResponse();

            if(isOK){
                response.status = "OK";
                response.message = "Login successful";
                UserCountController.addUsername(clientSocket, login.username);
                LogService.log("LOGIN", "user " + login.username + " has logged in");

                Platform.runLater(() -> ServerAppController.getInstance().addUserToUserCount());

            } else {
                response.status = "ERROR";
                response.message = "Wrong credentials";
            }

            String json = mapper.writeValueAsString(response);
            sendMessage(json);


        } catch (Exception e) {
            e.printStackTrace();

            try{
                ServerLoginResponse errorResponse = new ServerLoginResponse();
                errorResponse.status = "ERROR";
                errorResponse.message = "Internal server error occurred while logging in";

                String json = mapper.writeValueAsString(errorResponse);
                sendMessage(json);
            } catch (JsonProcessingException ex) {
                ex.printStackTrace();
            }
        }
    }

    private void handleRegister(String message, ObjectMapper mapper){
        try{
            RegisterRequest register = mapper.readValue(message, RegisterRequest.class);
            AuthRepository repository = new AuthRepository();

            boolean isAlreadyRegistered = repository.checkIfAlreadyExists(register.username);

            ServerRegisterResponse response = new ServerRegisterResponse();

            if(isAlreadyRegistered) {
                response.status = "ERROR";
                response.message = "This login is already in use, try login or another username.";
            } else {
                repository.registerUser(register.username, register.password);

                response.status = "OK";
                response.message = "Successfully registered user " + register.username;

                UserCountController.addUsername(clientSocket, register.username);

                Platform.runLater(() -> ServerAppController.getInstance().addUserToUserCount());

                LogService.log("REGISTER", "user " + register.username + " has registered");
            }

            String json = mapper.writeValueAsString(response);
            sendMessage(json);

        }  catch (Exception e){
            e.printStackTrace();

            try{
                ServerRegisterResponse errorResponse = new ServerRegisterResponse();
                errorResponse.status = "ERROR";
                errorResponse.message = "Internal server error occurred during registration";

                String json = mapper.writeValueAsString(errorResponse);
                sendMessage(json);
            } catch (JsonProcessingException ex) {
                ex.printStackTrace();
            }
        }
    }

    private void handleLogout(String message, ObjectMapper mapper){
        try{
            LogoutRequest logout = mapper.readValue(message, LogoutRequest.class);
        } catch (JsonProcessingException e) {
            throw new RuntimeException(e);
        } finally {
            try {
                in.close();
                out.close();
                clientSocket.close();

                UserCountController.deleteUser(clientSocket);
                Platform.runLater(() -> ServerAppController.getInstance().removeUserFromUserCount());
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
