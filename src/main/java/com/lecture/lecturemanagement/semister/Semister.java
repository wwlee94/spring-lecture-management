package com.lecture.lecturemanagement.semister;

import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.ColumnDefault;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Getter
@Setter
public class Semister {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length=50)
    private LocalDateTime start_date;

    @Column(nullable = false, length=50)
    private LocalDateTime end_date;

    @Column(nullable = false, length=50)
    private String type;

}
