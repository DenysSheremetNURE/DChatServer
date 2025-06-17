package org.example.dchatserverview.JSON;

import org.example.dchatserverview.UIClasses.Message;

public class SendMessageResponse extends BaseResponse{
    public Message message;

    public SendMessageResponse(){}

    public SendMessageResponse(Message message){
        this.type = "MESSAGE";
        this.message = message;
    }
}
