package com.lecture.lecturemanagement.calendar;

import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.ColumnDefault;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Entity
@Getter
@Setter
public class CalendarTable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length=50)
    private String uid;

    @Column(nullable = false, length=50)
    private String title;

    @Column(nullable = false, length=50)
    private String explanation;

    @Column(nullable = false, length=50)
    private String location;

    @Column(nullable = false, length=50)
    @ColumnDefault(value = "")
    private LocalDateTime start_date;

    @Column(nullable = false, length=50)
    @ColumnDefault(value = "")
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

    //기본 정보들 초기화
    public void setUpdateTimeTable(long id, String title, String explanation, String location, String start_date, String end_date){
        this.setId(id);
        this.setTitle(title);
        this.setExplanation(explanation);
        this.setLocation(location);
        this.setStart_date(LocalDateTime.parse(start_date, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
        this.setEnd_date(LocalDateTime.parse(end_date, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
    }

    //기본 정보들 초기화
    public void setUpdateTimeTableDefault(long id, String title, String explanation, String location, LocalDateTime start_date, LocalDateTime end_date){
        this.setId(id);
        this.setTitle(title);
        this.setExplanation(explanation);
        this.setLocation(location);
        this.setStart_date(start_date);
        this.setEnd_date(end_date);
    }

}
