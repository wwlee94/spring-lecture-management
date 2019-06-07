package com.lecture.lecturemanagement.report;

import com.lecture.lecturemanagement.member.Member;
import com.lecture.lecturemanagement.member.MemberRepository;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import java.security.Principal;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/report")
public class ReportController {

    @Autowired
    MemberRepository memberRepository;
    @Autowired
    ReportRepository reportRepository;

    @Autowired
    private EntityManagerFactory entityManagerFactory;
    private EntityManager entityManager;

    private Logger LOGGER = LogManager.getLogger(this.getClass());

    //report index page 에 들어 왔을경우 불린다.
    @RequestMapping("")
    public String reportIndexPage(Model model, Principal principal) {

        String username = principal.getName();

        LOGGER.info("CALLED :: /report/index");
        LOGGER.info("UserName :: " + username);

        Member member = memberRepository.findByUemail(username);

        List<Report> myReports = member.getReports();
        List<Report> otherReports = reportRepository.findAll();

        model.addAttribute("username", username);
        model.addAttribute("myReportList", myReports);
        model.addAttribute("otherReportList", otherReports);

        return "report/index";
    }

    @RequestMapping(value = "/room/{roomNo}")
    public String roomDetailView(@PathVariable String roomNo, Model model) {

        LOGGER.info("CALLED :: /room/" + roomNo);

        Optional<Report> report = reportRepository.findById((long) Integer.parseInt(roomNo));
        List<Member> members = report.get().getMembers();

        model.addAttribute("roomNo", roomNo);
        model.addAttribute("members", members);
        model.addAttribute("report", report.get());

        return "report/room";
    }

    @RequestMapping(value = "/report/{roomNo}")
    public String reportView(@PathVariable String roomNo) {

        LOGGER.info("CALLED :: /report/" + roomNo);

        return "report/report";
    }

    @PostMapping(value = "/create")
    public void createRoom(Report data) {

        LOGGER.info("CALLED :: /create/");

        List<Member> members = new ArrayList<>();
        members.add(memberRepository.findByUemail(data.getManager()));

        data.setMembers(members);
        reportRepository.save(data);
    }


    //방 나가기
    @PostMapping(value = "/delete/{roomNo}")
    public void deleteRoom(@PathVariable Long roomNo, Principal principal) {

        LOGGER.info("CALLED :: /delete/" + roomNo); //log

        String username = principal.getName();
        Optional<Report> reportOptional = reportRepository.findById(roomNo); // 방번호로 DB탐색

        Report report = reportOptional.get(); // 객체로 생성

        int size = report.getMembers().size();

        if (size == 1) { //마지막 남은 사람이라면
            LOGGER.info("CALLED :: /delete/" + roomNo + " 번방 삭제");
            reportRepository.delete(report);
        } else if (report.getManager().equals(username)) {
            LOGGER.info("CALLED :: /delete/" + roomNo + " 방장 넘긴후 방 나가기");
            report.getMembers().forEach((item) -> {
                if (item.getUemail().equals(username)) {
                    report.getMembers().remove(item);
                }
            });
            report.setManager(report.getMembers().get(0).getUemail());

            reportRepository.save(report);
        } else {
            LOGGER.info("CALLED :: /delete/" + roomNo + " 방 나가기");
            report.getMembers().forEach((item) -> {
                if (item.getUemail().equals(username)) {
                    report.getMembers().remove(item);
                }
            });
            reportRepository.save(report);
        }
    }



}
