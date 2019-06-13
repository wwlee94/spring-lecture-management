package com.lecture.lecturemanagement.webSocket;

import com.lecture.lecturemanagement.member.MemberRepository;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.util.HtmlUtils;

import java.security.Principal;

@Controller
public class GreetingController {

    @Autowired
    MemberRepository memberRepository;

    // @MessageMapping은 클라이언트에서 /hello쪽으로 메세지를 전달하면 greeting메서드가 실행
    @MessageMapping("/hello/{charRoomId}")
    //@SendTo 어노테이션에 정의된 쪽으로 결과를 return
    @SendTo("/topic/greetings")
    public Greeting greeting(@PathVariable("chatRoomId")String chatRoomId, HelloMessage message, Principal principal) throws Exception {
        String username = principal.getName();


        JSONParser parser = new JSONParser();
        Object obj = parser.parse(chatRoomId);
        JSONObject jsonObj = (JSONObject) obj;

        String uid = memberRepository.findByUemail(username).getUid();
        return new Greeting(uid+ " : " + HtmlUtils.htmlEscape(message.getName()), (String)jsonObj.get("roomId") );
    }
}
