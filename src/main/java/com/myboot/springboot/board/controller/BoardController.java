package com.myboot.springboot.board.controller;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

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
	
	@RequestMapping(value="/pages/{pageNum}", method=RequestMethod.GET)
	public ModelAndView openBoardList(@PathVariable("pageNum") int pageNum) throws Exception {
		ModelAndView mv = new ModelAndView("board/boardList");
		
		mv.addObject("data", boardService.selectBoardList(pageNum));
		mv.addObject("pageNum", pageNum);

        return mv;
	}
	
	@RequestMapping(value="/pages/{pageNum}/{keyword}", method=RequestMethod.GET)
	public ModelAndView openBoardSearchList(@PathVariable("pageNum") int pageNum, @PathVariable("keyword") String keyword) throws Exception {
		ModelAndView mv = new ModelAndView("board/boardList");
		
		mv.addObject("data", boardService.selectBoardSearchList(pageNum, keyword));
		mv.addObject("pageNum", pageNum);
		mv.addObject("keyword", keyword);

        return mv;
	}
	
	@RequestMapping(value="/posts/{idx}", method=RequestMethod.GET)
	public ModelAndView openBoardDetail(@PathVariable("idx") int idx) throws Exception {
		ModelAndView mv = new ModelAndView("board/boardDetail");

		Map<String,Object> map = boardService.selectBoardDetail(idx);
		
		mv.addObject("data", map.get("data"));
		mv.addObject("list", map.get("list"));
		mv.addObject("idx", idx);

        return mv;
	}
	
	@RequestMapping(value="/posts", method=RequestMethod.POST)
    public ModelAndView insertBoard(CommandMap commandMap, HttpServletRequest request) throws Exception{
        ModelAndView mv = new ModelAndView("redirect:/board/pages/1");

        boardService.insertBoard(commandMap.getMap(), request);
        
        return mv;
    }
	
    @RequestMapping(value="/posts/{idx}", method=RequestMethod.PUT)
    public int updateBoard(CommandMap commandMap, HttpServletRequest request, @PathVariable("idx") int idx) throws Exception{
    	commandMap.put("idx", idx);
    	return boardService.updateBoard(commandMap.getMap(), request);
    }
	
    @RequestMapping(value="/posts/{idx}", method=RequestMethod.DELETE)
    public int deleteBoard(CommandMap commandMap, @PathVariable("idx") int idx) throws Exception{
    	commandMap.put("idx", idx);
        return boardService.deleteBoard(commandMap.getMap());
    }
    
	@RequestMapping(value="/posts/write", method=RequestMethod.GET)
	public ModelAndView openBoardWrite(CommandMap commandMap) throws Exception {
		ModelAndView mv = new ModelAndView("board/boardWrite");
        
        return mv;
	}
	
	@RequestMapping(value="/posts/{idx}/edit", method=RequestMethod.GET)
    public ModelAndView openBoardUpdate(@PathVariable("idx") int idx) throws Exception{
        ModelAndView mv = new ModelAndView("board/boardUpdate");
        
        Map<String,Object> map = boardService.selectBoardDetail(idx);
		
		mv.addObject("data", map.get("data"));
		mv.addObject("list", map.get("list"));
		mv.addObject("idx", idx);
        
        return mv;
    }
    
	@RequestMapping(value="/posts/{idx}/delete", method=RequestMethod.GET)
    public ModelAndView openBoardDelete(@PathVariable("idx") int idx) throws Exception{
        ModelAndView mv = new ModelAndView("board/boardDelete");
        
        mv.addObject("idx", idx);
        
        return mv;
    }
    
}