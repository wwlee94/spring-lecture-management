package com.lecture.lecturemanagement.calendar;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Entity
@Getter
@Setter
public class TimeTable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length=50)
    private String uid;

    @Column(nullable = false, length=50)
    private String subject;

    @Column(nullable = false, length=50)
    private String professor;

    @Column(nullable = false, length=50)
    private String location;

    @Column(nullable = false, length=50)
    private LocalDateTime start_date;

    @Column(nullable = false, length=50)
    private LocalDateTime end_date;

    //시작일 str타입
    @Transient
    private String str_start_date;

    //종료일 str타입
    @Transient
    private String str_end_date;

    //시간표 색상 랜덤
    @Transient
    private int color;

    //수업 코드 CS1108
    @Transient
    private String lecture_code;

    //수업 시간 - 월화23,금23,24
    @Transient
    private String lecture_time;

    //구분 -> 전공,교필...
    @Transient
    private String division;

    //성적
    @Transient
    private int grade;


    //기본 정보들 초기화
    public void setUpdateTimeTable(long id, String subject, String professor, String location, String start_date, String end_date){
        this.setId(id);
        this.setSubject(subject);
        this.setProfessor(professor);
        this.setLocation(location);
        this.setStart_date(LocalDateTime.parse(start_date, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
        this.setEnd_date(LocalDateTime.parse(end_date, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
    }
}
