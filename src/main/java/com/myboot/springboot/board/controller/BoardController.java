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
	
	@RequestMapping(value="/board/openBoardList.do")
	public ModelAndView openBoardList(CommandMap commandMap) throws Exception {
		ModelAndView mv = new ModelAndView("board/boardList");
		
		if(commandMap.get("keyword") == null)
			mv.addObject("data", boardService.selectBoardList(commandMap.getMap()));
		else
			mv.addObject("data", boardService.selectBoardSearchList(commandMap.getMap()));

        return mv;
	}
	
	@RequestMapping(value="/board/openBoardDetail.do")
	public ModelAndView openBoardDetail(CommandMap commandMap) throws Exception {
		ModelAndView mv = new ModelAndView("board/boardDetail");

		mv.addObject("data", boardService.selectBoardDetail(commandMap.getMap()));
		
        return mv;
	}
	
	@RequestMapping(value="/board/openBoardWrite.do")
	public ModelAndView openBoardWrite(CommandMap commandMap) throws Exception {
		ModelAndView mv = new ModelAndView("board/boardWrite");
        
        return mv;
	}
	
	@RequestMapping(value="/board/insertBoard.do")
    public ModelAndView insertBoard(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("redirect:/board/openBoardList.do");

        boardService.insertBoard(commandMap.getMap());
        
        return mv;
    }
	
	@RequestMapping(value="/board/openBoardUpdate.do")
    public ModelAndView openBoardUpdate(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("/board/boardUpdate");
         
        mv.addObject("data", boardService.selectBoardDetail(commandMap.getMap()));
        
        return mv;
    }
     
    @RequestMapping(value="/board/updateBoard.do")
    public int updateBoard(CommandMap commandMap) throws Exception{
        return boardService.updateBoard(commandMap.getMap());
    }
    
	@RequestMapping(value="/board/openBoardDelete.do")
    public ModelAndView openBoardDelete(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("/board/boardDelete");
        
        return mv;
    }
    
    @RequestMapping(value="/board/deleteBoard.do")
    public int deleteBoard(CommandMap commandMap) throws Exception{      
        return boardService.deleteBoard(commandMap.getMap());
    }
	
}