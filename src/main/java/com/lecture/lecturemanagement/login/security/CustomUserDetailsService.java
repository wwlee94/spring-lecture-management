package com.lecture.lecturemanagement.login.security;

import com.lecture.lecturemanagement.login.controller.LoginController;
import com.lecture.lecturemanagement.member.MemberRepository;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.Optional;


//CustomUserDetailsService를 구현하면서 MemberRepository와 연동해 우리의 데이터베이스에 저장된 회원정보를 바탕으로
//인증을 구현해야하는데 스프링 시큐리티의 User와 우리의 Member, GrantedAuthority와 우리의 MemberRole의 타입이
//일치하지 않는 문제가 생긴다.
@Service
public class CustomUserDetailsService implements UserDetailsService {

    private static final Logger LOGGER = LogManager.getLogger(LoginController.class);

    @Autowired
    MemberRepository memberRepository;

    // *login 으로 받은 email 값으로 memberRepository 를 이용 DB 에서 memberUser 를 불러온다.
    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {

        LOGGER.info("LOGIN TRY :: "+ email);

        SecurityMember securityMember = Optional.ofNullable(memberRepository.findByUemail(email))   //email값을 이용해 불러온 member가 null임을 대비한다.
                                  .filter(m -> m != null)  //member 가 널이 아닐 경우.
                                  .map(m -> new SecurityMember(m)).get();

        return securityMember; //security user의 형식으로 변환 후 값 리턴 .
    }
    /*
    Optional는 “존재할 수도 있지만 안 할 수도 있는 객체”, 즉, “null이 될 수도 있는 객체”을 감싸고 있는 일종의 래퍼 클래스입니다.
    Optional.ofNullable(value) : null인지 아닌지 확신할 수 없는 객체를 담고 있는 Optional 객체를 생성합니다.
        null이 넘어올 경우, NPE를 던지지 않고 Optional.empty()와 동일하게 비어 있는 Optional 객체를 얻어옵니다.
    Optional.map(value) :Optional 형식의 객체를 value 타입으로 변환
    Optional.filter :  if 조건문 없이 메소드 연쇄 호출만으로도 좀 더 읽기 편한 코드를 작성할 수 있습니다.
    */
}
