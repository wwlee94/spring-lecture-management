package com.lecture.lecturemanagement.webSocket;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.security.Principal;

@Controller
@RequestMapping("/report")
public class ChatingController {

    @RequestMapping("/chat/{roomNo}")
    public String chatingpage(@PathVariable String roomNo,Model model, Principal principal) {

        String username = principal.getName();

        System.out.println(username);

        return "report/chating";
    }

}
