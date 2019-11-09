package com.myboot.springboot.comment.controller;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.myboot.springboot.comment.service.CommentService;
import com.myboot.springboot.common.common.CommandMap;

@RestController
@RequestMapping("/comment")
public class CommentController {
	
	@Resource(name="commentService")
    private CommentService commentService;
	
	@RequestMapping(value="/{post-idx}", method=RequestMethod.GET)
	public Map<String, Object> selectCommentList(@PathVariable("post-idx") int idx) throws Exception{
		return commentService.selectCommentList(idx);
	}
	
	@RequestMapping(value="/{post-idx}", method=RequestMethod.POST)
	public void insertComment(CommandMap commandMap, @PathVariable("post-idx") int idx) throws Exception{
		commandMap.put("idx", idx);
		commentService.insertComment(commandMap.getMap());
	}
	
	@RequestMapping(value="/{idx}", method=RequestMethod.DELETE)
	public int deleteComment(CommandMap commandMap, @PathVariable("idx") int idx) throws Exception{ 
		commandMap.put("idx", idx);
		return commentService.deleteComment(commandMap.getMap());
	}
	
}