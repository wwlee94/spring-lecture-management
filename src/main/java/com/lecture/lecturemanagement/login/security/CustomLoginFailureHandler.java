package com.lecture.lecturemanagement.login.security;

import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


/*
실패하는 경우는 주로 실패 횟수에 따라 캡차를 걸거나 접속을 차단합니다.
또한 보안이 중요한 서비스라면 지속적인 실패에 대해 이메일을 보내줍니다.
 */
public class CustomLoginFailureHandler implements AuthenticationFailureHandler {

    @Override
    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
                                        AuthenticationException exception) throws IOException, ServletException {

        request.setAttribute("loginid", request.getParameter("email"));
        System.out.println(request.getParameter("email"));
        System.out.println("login Fail !! "+exception.getLocalizedMessage());

        request.getRequestDispatcher("/security/login").forward(request, response);
    }

}
