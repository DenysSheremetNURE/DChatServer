package org.example.dchatserverview.SessionData;

import org.example.dchatserverview.LogService;

import java.net.Socket;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

public class UserCountController {

    public static Map<Socket, String> usersCount = new HashMap<>();

    public static void addUser(Socket socket){
        usersCount.put(socket, null);
    }

    public static void addUsername(Socket socket, String username){
        usersCount.put(socket, username);
    }

    public static void deleteUser(Socket socket){
        String username = usersCount.remove(socket);
        username = username == null ? "user" : username;
        LogService.log("LOGOUT", username + " has logged out.");
    }

    public static Set<Socket> getSockets(){
        return usersCount.keySet();
    }

    public static boolean isUser(Socket socket){
        return usersCount.containsKey(socket);
    }
}
