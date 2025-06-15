package org.example.dchatserverview.JSON;

import org.example.dchatserverview.UIClasses.Message;

public class SendMessageRequest extends BaseRequest{
    public String recipient;
    public Message message;

    public SendMessageRequest(){}

    public SendMessageRequest(String recipient, Message message){
        this.command = "SEND_MESSAGE";
        this.recipient = recipient;
        this.message = message;
    }
}
