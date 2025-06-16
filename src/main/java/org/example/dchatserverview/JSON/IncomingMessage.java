package org.example.dchatserverview.JSON;

import org.example.dchatserverview.UIClasses.Message;

public class IncomingMessage extends BaseResponse{
    public Message data;

    public IncomingMessage() {}

    public Message getData() {
        return data;
    }
}
