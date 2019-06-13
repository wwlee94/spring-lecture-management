<%@ page import="org.springframework.security.core.Authentication" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="com.lecture.lecturemanagement.member.Member" %>
<%@ page import="com.lecture.lecturemanagement.login.security.SecurityMember" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<nav class="navbar navbar-expand navbar-dark bg-dark static-top">

    <a class="navbar-brand mr-1" href="/">Time Manager</a>

    <button class="btn btn-link btn-sm text-white order-1 order-sm-0" id="sidebarToggle" href="#">
        <i class="fas fa-bars"></i>
    </button>

    <!-- Navbar Search -->
    <form class="d-none d-md-inline-block form-inline ml-auto mr-0 mr-md-3 my-2 my-md-0">
        <div class="input-group">
        </div>
    </form>

    <!-- Navbar -->
    <ul class="navbar-nav ml-auto ml-md-0 navbar-right">
        <li class="nav-item dropdown no-arrow mx-1">
        </li>
        <li class="nav-item dropdown no-arrow mx-1" style="padding: 10px;color: white;">
            <sec:authorize access="isAnonymous()">
                로그인 해주세요
            </sec:authorize>
            <sec:authorize access="isAuthenticated()">
                <%
                    Authentication auth= SecurityContextHolder.getContext().getAuthentication();
                    Object principal = auth.getPrincipal();
                    String name = ((SecurityMember)principal).getUsername();
                %>
                <%= name %> 님 환영합니다 !
            </sec:authorize>
        </li>

        <li class="nav-item dropdown no-arrow">

            <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown"
               aria-haspopup="true" aria-expanded="false">
                <i class="fas fa-user-circle fa-fw"></i>
            </a>
            <div class="dropdown-menu dropdown-menu-right" aria-labelledby="userDropdown">
                <sec:authorize access="isAnonymous()">
                    <a class="dropdown-item" href="/security/login">로그인</a>
                    <a class="dropdown-item" href="/security/signUp">회원가입</a>
                </sec:authorize>
                <sec:authorize access="isAuthenticated()">
                    <a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal">로그아웃</a>
                </sec:authorize>
            </div>
        </li>
    </ul>

</nav>