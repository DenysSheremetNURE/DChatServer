package org.example.dchatserverview.JSON;

public class ServerLoginResponce {
    public String status;
    public String message;

    public ServerLoginResponce(){}

    public ServerLoginResponce(String status, String message){
        this.status = status;
        this.message = message;
    }
}
