package org.example.dchatserverview.SessionData;

import org.example.dchatserverview.ClientHandler;
import org.example.dchatserverview.LogService;

import java.net.Socket;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

public class UserCountController {

    public static Map<Socket, String> usersCount = new HashMap<>();

    //map to search by nickname
    public static Map<String, Socket> userSockets = new HashMap<>();
    public static Map<String, ClientHandler> userHandlers = new HashMap<>();

    public static void addUsername(Socket socket, String username, ClientHandler handler){
        usersCount.put(socket, username);
        userSockets.put(username, socket);
        userHandlers.put(username, handler);
    }

    public static void deleteUser(Socket socket){
        String username = usersCount.remove(socket);
        if(username != null) userSockets.remove(username);

        username = username == null ? "user" : username;
        LogService.log("LOGOUT", username + " has logged out.");
    }

    public static Set<Socket> getSockets(){
        return usersCount.keySet();
    }

    public static boolean isUser(Socket socket){
        return usersCount.containsKey(socket);
    }

    public static Socket getSocket(String nickname){
        return userSockets.get(nickname);
    }

    public static ClientHandler getHandler(String nickname){
        return userHandlers.get(nickname);
    }
}
