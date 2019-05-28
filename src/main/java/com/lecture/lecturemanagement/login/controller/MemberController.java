package com.lecture.lecturemanagement.login.controller;

import com.lecture.lecturemanagement.member.Member;
import com.lecture.lecturemanagement.member.MemberRepository;
import com.lecture.lecturemanagement.member.MemberRole;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.Arrays;

@Controller
@RequestMapping("/member")
public class MemberController {

    @Autowired
    MemberRepository memberRepository;

    //불리는 시점 : 회원가입이 끝나고 불린다.
    //1. 스프링 시큐리티에서 지원해주는 BCryptPasswordEncoder를 이용해 회원 비밀번호를 암호화.
    //2. MemberRole을 BASIC 으로 정의해 Member에 넣어주고 save를 했다.
    @PostMapping("")
    public String create(Member member) {

        System.out.println(member.getUid());
        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        System.out.println(member.getUpw());
        member.setUpw(passwordEncoder.encode(member.getUpw()));
        System.out.println(member.getUpw());

        MemberRole role = new MemberRole();
        role.setRoleName("BASIC");

        member.setRoles(Arrays.asList(role));   //member의 uid 와 join 되는 memberRole
        memberRepository.save(member);

        return "redirect:/";
    }
}