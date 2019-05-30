package com.lecture.lecturemanagement;

import com.lecture.lecturemanagement.member.MemberRepository;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@SpringBootApplication(scanBasePackages={"com.lecture.lecturemanagement"})
@EnableJpaRepositories(basePackageClasses = MemberRepository.class)
public class LecturemanagementApplication {

    public static void main(String[] args) {
        SpringApplication.run(LecturemanagementApplication.class, args);
    }

}
