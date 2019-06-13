package com.lecture.lecturemanagement.login.security;

import com.lecture.lecturemanagement.login.controller.LoginController;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

//이전 페이지 정보를 받아 Redirect하는 SavedRequestAwareAuthenticationSuccessHandler
//AuthenticationSuccessHandler인터페이스를 구현하는
// SimpleUrlAuthenticationSuccessHandler를 상속하는
// SavedRequestAwareAuthenticationSuccessHandler를 상속해서 구현하면 된다
public class CustomLoginSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler {

    private Logger LOGGER = LogManager.getLogger(this.getClass());

    public CustomLoginSuccessHandler(String defaultTargetUrl) {
        setDefaultTargetUrl(defaultTargetUrl);
    }

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
                                        Authentication authentication) throws ServletException, IOException {

        LOGGER.info("LOGIN SUCCESS :: ");

        //((SecurityMember)authentication.getPrincipal()).setIp(getClientIp(request));

        HttpSession session = request.getSession();
        if (session != null) {
            String redirectUrl = (String) session.getAttribute("prevPage");
            if (redirectUrl != null) {
                session.removeAttribute("prevPage");
                getRedirectStrategy().sendRedirect(request, response, redirectUrl);
            } else {
                super.onAuthenticationSuccess(request, response, authentication);
            }
        } else {
            super.onAuthenticationSuccess(request, response, authentication);
        }
    }

}