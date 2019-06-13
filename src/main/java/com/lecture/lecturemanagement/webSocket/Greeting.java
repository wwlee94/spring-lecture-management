package com.lecture.lecturemanagement.webSocket;

public class Greeting {

    private String content;
    private String roomNo;

    public Greeting() {
    }

    public Greeting(String content, String roomNo) {
        this.content = content;
        this.roomNo = roomNo;
    }

    public String getRoomNo() {
        return roomNo;
    }

    public String getContent() {
        return content;
    }

}