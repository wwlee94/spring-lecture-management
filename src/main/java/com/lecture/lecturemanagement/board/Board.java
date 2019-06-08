package com.lecture.lecturemanagement.board;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

@Entity
@Getter
@Setter
public class Board extends BaseTimeEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    //게시판 글 번호
    private int bno;

    //게시판 작성자
    @Column(length = 20, nullable = false)
    private String userName;

    //게시판 글 제목
    @Column(length = 50, nullable = false)
    private String title;

    //게시판 글 내용
    @Column(length = 250, nullable = false)
    private String contents;

    //게시판 어떤 방 ?
    @Column(length = 20, nullable = false)
    private String roomNo;

    @Column(length = 20, nullable = false)
    private int viesNum = 0;

    @Transient
    private String date;
}
