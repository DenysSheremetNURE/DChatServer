package org.example.dchatserverview.JSON;

import org.example.dchatserverview.UIClasses.Message;

import java.util.List;

public class GetMessageResponse extends BaseResponse{
    public List<Message> messages;

    public GetMessageResponse(){}

    public GetMessageResponse(List<Message> messages){
        this.type = "MESSAGES";
        this.messages = messages;
    }


}
