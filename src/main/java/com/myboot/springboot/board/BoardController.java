package com.myboot.springboot.board;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.myboot.springboot.common.CommandMap;

@Controller
public class BoardController {
//	@RequestMapping("/")
//	public String dafult(CommandMap commandMap) {
//		System.out.println(commandMap.getMap());
//		return "dafult";
//	}
	
	@RequestMapping("/test")
	public ModelAndView welcome(CommandMap commandMap) {
		ModelAndView mv = new ModelAndView("test");
        
        mv.addObject("test", "tset");
        
        return mv;
	}
}