package com.lecture.lecturemanagement.board;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.security.Principal;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Controller
@RequestMapping("/report")
public class BoardController {

    private Logger LOGGER = LogManager.getLogger(this.getClass());

    @Autowired
    BoardRepository boardRepository;

    //게시판 목록 보기 (방마다 )
    @RequestMapping(value = "/report/{roomNo}")
    public String reportView(@PathVariable String roomNo, Model model) {

        LOGGER.info("CALLED :: /report/" + roomNo);

        List<Board> boardList =  boardRepository.findByRoomNo(roomNo);

        boardList.forEach((item)->{
            item.setDate(item.getCreatedDate().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
        });

        model.addAttribute("boards", boardList);

        return "report/report";
    }

//        Board board = new Board();
//
//        board.setContents("content");
//        board.setTitle("title");
//        board.setRoomNo(roomNo);
//        board.setUserName("dlfma");
//
//        boardRepository.save(board);
}
