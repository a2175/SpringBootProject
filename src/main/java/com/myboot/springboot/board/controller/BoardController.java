package com.myboot.springboot.board.controller;

import javax.annotation.Resource;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.myboot.springboot.board.service.BoardService;
import com.myboot.springboot.common.common.CommandMap;

@RestController
public class BoardController {
	
	@Resource(name="boardService")
    private BoardService boardService;
	
	@RequestMapping("/board/openBoardList.do")
	public ModelAndView openBoardList(CommandMap commandMap) throws Exception {
		ModelAndView mv = new ModelAndView("board/boardList");
        
        mv.addObject("list", boardService.selectBoardList());
        
        return mv;
	}
	
}