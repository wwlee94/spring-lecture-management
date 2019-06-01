package com.lecture.lecturemanagement.login.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    @Autowired
    CustomUserDetailsService customUserDetailsService;

    @Override
    public void configure(WebSecurity web) throws Exception
    {
        //인증할 것들을 풀어준다.(리소스 css, js ... ).
        web.ignoring().antMatchers("/static/**");
        web.ignoring().antMatchers("/calendar/**");
    }
    @Override
    protected void configure(HttpSecurity http) throws Exception
    {
        http.csrf().disable()
                .authorizeRequests()
                .antMatchers("/admin/**").hasRole("ADMIN")//ADMIN 권한을 가진 사람만  "/admin/**" 으로 접근 가능.
                .antMatchers("/report/**").hasRole("BASIC")//ADMIN 권한을 가진 사람만  "/admin/**" 으로 접근 가능.
                .antMatchers("/**").permitAll()//나머지는 모드 접근 가능
                .and()

                .formLogin()//로그인페이지 커스텀
                .loginPage("/security/login")//로그인 페이지 : 없다면 기본 제공 페이지가 뜬다.
                .loginProcessingUrl("/security/login")//로그인 처리 페이지
                .defaultSuccessUrl("/")//로그인 성공시 이동 URL
                .successHandler(successHandler())
                .failureHandler(failureHandler())
                .and()

                .logout()
                .permitAll()
                .logoutRequestMatcher(new AntPathRequestMatcher("/logout"))// "/logout" 호출할 경우 로그아웃
                .logoutSuccessUrl("/"); // 로그아웃이 성공했을 경우 이동할 페이지

    }

    @Bean
    public AuthenticationSuccessHandler successHandler() {
        return new CustomLoginSuccessHandler("/");    //default로 이동할 url
    }

    @Bean
    public AuthenticationFailureHandler failureHandler(){
        return new CustomLoginFailureHandler();
    }

    //패스워드 인코더 (상속 받아서 커스텀도 가능. )
    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        // TODO Auto-generated method stub
        auth.userDetailsService(customUserDetailsService).passwordEncoder(passwordEncoder());
    }

//    @Autowired
//    public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception {
//        auth.userDetailsService(customUserDetailsService).passwordEncoder(passwordEncoder());
//    }

}