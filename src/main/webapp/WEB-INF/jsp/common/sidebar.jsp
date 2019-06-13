<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!-- Sidebar -->
<ul class="sidebar navbar-nav">
    <li class="nav-item" id="sidebar-1">
        <a class="nav-link" href="/">
            <i class="fas fa-fw fa-tachometer-alt"></i>
            <span>시작하기</span>
        </a>
    </li>
    <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="pagesDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            <i class="fas fa-fw fa-folder"></i>
            <span>회원 관리</span>
        </a>
        <div class="dropdown-menu" aria-labelledby="pagesDropdown">
            <sec:authorize access="isAnonymous()">
                <a class="dropdown-item" href="/security/login">로그인</a>
                <a class="dropdown-item" href="/security/signUp">회원가입</a>
            </sec:authorize>
            <sec:authorize access="isAuthenticated()">
                <a class="dropdown-item" href="/logout">로그아웃</a>
            </sec:authorize>


        </div>
    </li>
    <li class="nav-item" id="sidebar-2">
        <a class="nav-link" href="/lecture">
            <i class="fas fa-fw fa-table"></i>
            <span>강좌 목록</span></a>
    </li>
    <li class="nav-item" id="sidebar-3">
        <a class="nav-link" href="/calendar/timetable">
            <i class="fas fa-fw fa-clock"></i>
            <span>시간표 관리</span></a>
    </li>
    <li class="nav-item" id="sidebar-4">
        <a class="nav-link" href="/calendar/calendartable">
            <i class="fas fa-fw fa-calendar"></i>
            <span>일정 관리</span></a>
    </li>
    <li class="nav-item" id="sidebar-5">
        <a class="nav-link" href="/report">
            <i class="fas fa-fw fa-calendar"></i>
            <span>그룹 관리</span></a>
    </li>
</ul>