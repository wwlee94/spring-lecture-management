package com.lecture.lecturemanagement.login.security;

import com.lecture.lecturemanagement.member.Member;
import com.lecture.lecturemanagement.member.MemberRole;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import java.util.ArrayList;
import java.util.List;

//security 로그인 유저의 객체
public class SecurityMember extends User {

    //security에서 member의 앞에는 ROLE_ 를 붙여 주어야한다.
    private static final String ROLE_PREFIX = "ROLE_";
    private static final long serialVersionUID = 1L;

    private String ip;

    //생성자의 파라미터로 member를 받아서 Role_ 변환 후 하나의 security user 로 사용 .
    public SecurityMember(Member member) {
        super(member.getUemail(), member.getUpw(), makeGrantedAuthority(member.getRoles()));
        System.out.println(member.getUpw());
    }

    //Role_ 를 권한 앞에 붙여서 값 리턴. 하나의 member 당 여러 권한을 가질 수 있음으로 list 형식으로 반환.
    private static List<GrantedAuthority> makeGrantedAuthority(List<MemberRole> roles){
        List<GrantedAuthority> list = new ArrayList<>();
        roles.forEach(role -> list.add(new SimpleGrantedAuthority(ROLE_PREFIX + role.getRoleName())));
        return list;
    }


    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    public static String getRolePrefix() {
        return ROLE_PREFIX;
    }

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }
}
