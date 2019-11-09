package com.myboot.springboot.board.controller;

import javax.annotation.Resource;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.myboot.springboot.board.service.BoardService;
import com.myboot.springboot.common.common.CommandMap;

@RestController
@RequestMapping("/board")
public class BoardController {
	
	@Resource(name="boardService")
    private BoardService boardService;
	
	@RequestMapping(value="/page/{page_num}", method=RequestMethod.GET)
	public ModelAndView openBoardList(@PathVariable("page_num") int page_num) throws Exception {
		ModelAndView mv = new ModelAndView("board/boardList");
		
		mv.addObject("data", boardService.selectBoardList(page_num));
		mv.addObject("page_num", page_num);

        return mv;
	}
	
	@RequestMapping(value="/page/{page_num}/{keyword}", method=RequestMethod.GET)
	public ModelAndView openBoardSearchList(@PathVariable("page_num") int page_num, @PathVariable("keyword") String keyword) throws Exception {
		ModelAndView mv = new ModelAndView("board/boardList");
		
		mv.addObject("data", boardService.selectBoardSearchList(page_num, keyword));
		mv.addObject("page_num", page_num);
		mv.addObject("keyword", keyword);

        return mv;
	}
	
	@RequestMapping(value="/post/{idx}", method=RequestMethod.GET)
	public ModelAndView openBoardDetail(@PathVariable("idx") int idx) throws Exception {
		ModelAndView mv = new ModelAndView("board/boardDetail");

		mv.addObject("data", boardService.selectBoardDetail(idx));
		mv.addObject("idx", idx);
		
        return mv;
	}
	
	@RequestMapping(value="/post", method=RequestMethod.POST)
    public ModelAndView insertBoard(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("redirect:/board/page/1");

        boardService.insertBoard(commandMap.getMap());
        
        return mv;
    }
	
    @RequestMapping(value="/post/{idx}", method=RequestMethod.PUT)
    public int updateBoard(CommandMap commandMap, @PathVariable("idx") int idx) throws Exception{
    	commandMap.put("idx", idx);
        return boardService.updateBoard(commandMap.getMap());
    }
	
    @RequestMapping(value="/post/{idx}", method=RequestMethod.DELETE)
    public int deleteBoard(CommandMap commandMap, @PathVariable("idx") int idx) throws Exception{
    	commandMap.put("idx", idx);
        return boardService.deleteBoard(commandMap.getMap());
    }
    
	@RequestMapping(value="/write", method=RequestMethod.GET)
	public ModelAndView openBoardWrite(CommandMap commandMap) throws Exception {
		ModelAndView mv = new ModelAndView("board/boardWrite");
        
        return mv;
	}
	
	@RequestMapping(value="/edit/{idx}", method=RequestMethod.GET)
    public ModelAndView openBoardUpdate(@PathVariable("idx") int idx) throws Exception{
        ModelAndView mv = new ModelAndView("board/boardUpdate");
        
        mv.addObject("data", boardService.selectBoardDetail(idx));
		mv.addObject("idx", idx);
        
        return mv;
    }
    
	@RequestMapping(value="/delete/{idx}", method=RequestMethod.GET)
    public ModelAndView openBoardDelete(@PathVariable("idx") int idx) throws Exception{
        ModelAndView mv = new ModelAndView("board/boardDelete");
        
        mv.addObject("idx", idx);
        
        return mv;
    }
    
}