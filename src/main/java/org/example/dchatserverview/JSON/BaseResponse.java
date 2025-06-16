package org.example.dchatserverview.JSON;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown = true)
public class BaseResponse {
    public String type;

    public BaseResponse(){}

    public String getType(){
        return type;
    }
}
