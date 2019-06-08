package com.lecture.lecturemanagement;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;

@EnableJpaAuditing
@SpringBootApplication
public class LecturemanagementApplication {

    public static void main(String[] args) {
        SpringApplication.run(LecturemanagementApplication.class, args);
    }

}
