package com.lecture.lecturemanagement.lecture;

import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.ColumnDefault;

import javax.persistence.*;

@Entity
@Getter
@Setter
@Table(name = "lecture")
public class Lecture {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    //학수번호
    @Column(nullable = false, length=50)
    private String lecture_code;

    //과목명
    @Column(nullable = false, length=100)
    private String lecture;

    //교수이름
    @Column(length=100)
    private String professor;

    //수업 시간
    @Column(length=50)
    private String lecture_time;

    //강의실
    @Column(length=50)
    private String location;

    //구분 ->교필,전공
    @Column(length=50)
    private String division;

    //학점
    @Column(length=50)
    private int grade;

}
