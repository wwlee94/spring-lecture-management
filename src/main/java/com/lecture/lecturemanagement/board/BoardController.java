package com.lecture.lecturemanagement.board;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Controller
@RequestMapping("/report")
public class BoardController {

    private Logger LOGGER = LogManager.getLogger(this.getClass());

    @Autowired
    BoardRepository boardRepository;

    //게시판 목록 방 홈 화면에 보여주기 (방마다 )
    @GetMapping(value = "/report/{roomNo}")
    public String reportView(@PathVariable String roomNo, Model model) {

        LOGGER.info("CALLED :: /report/" + roomNo);

        List<Board> boardList =  boardRepository.findByRoomNoOrderByCreatedDateDesc(roomNo);

        boardList.forEach((item)->{
            item.setDate(item.getCreatedDate().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
        });

        model.addAttribute("boards", boardList);

        return "report/report";
    }

    @PostMapping(value = "/report/{roomNo}")
    public void reportAdd(@RequestBody Map<String, Object> data,@PathVariable String roomNo, Model model,Principal principal) {

        LOGGER.info("CALLED :: /report/reportAdd/" + roomNo);

        String username = principal.getName();

        Board board = new Board();
        board.setRoomNo(roomNo);
        board.setUserName(username);
        board.setTitle(data.get("title").toString());
        board.setContents(data.get("contents").toString());

        boardRepository.save(board);
    }

    @GetMapping(value = "/report/{roomNo}/{bno}")
    public String reportAdd(@PathVariable String roomNo,@PathVariable Long bno,Model model) {

        LOGGER.info("CALLED :: /report/" + roomNo + "/"+bno);

        Optional<Board> boardOptional = boardRepository.findById(bno);
        Board board = boardOptional.get();

        model.addAttribute("board",board);

        return "/report/detailReport";
    }
}
