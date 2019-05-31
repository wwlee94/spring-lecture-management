package com.lecture.lecturemanagement.login.security;

import com.lecture.lecturemanagement.login.controller.LoginController;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
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

    private Logger LOGGER = LogManager.getLogger(this.getClass());

    @Override
    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
                                        AuthenticationException exception) throws IOException, ServletException {

        request.setAttribute("loginid", request.getParameter("email"));

        LOGGER.error("LOGIN FAIL  :: "+request.getParameter("email"));

        request.getRequestDispatcher("/security/login").forward(request, response);
    }

}
