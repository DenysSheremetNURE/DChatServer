package org.example.dchatserverview.JSON;

public class LogoutRequest extends BaseRequest{
    public String user;

    public LogoutRequest(){command = "LOGOUT";}
}
