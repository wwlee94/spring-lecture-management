package com.lecture.lecturemanagement.report;

import com.lecture.lecturemanagement.member.Member;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.util.List;

@Entity
@Getter
@Setter
public class Report {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length=50)
    private String name;

    @Column(nullable = false, length=50)
    private String Info;

    @Column(nullable = false, length=50)
    private String manager;

    @Column(length=50)
    private String password;

    @ManyToMany(fetch = FetchType.LAZY, cascade={CascadeType.PERSIST,CascadeType.MERGE})
    private List<Member> members;

}
