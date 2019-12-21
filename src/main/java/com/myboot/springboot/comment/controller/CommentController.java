package com.myboot.springboot.comment.controller;

import java.util.Map;

import javax.annotation.Resource;

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
	
	@RequestMapping(value="/{postIdx}", method=RequestMethod.GET)
	public Map<String, Object> selectCommentList(CommandMap commandMap) throws Exception{
		return commentService.selectCommentList(commandMap.getMap());
	}
	
	@RequestMapping(value="/{postIdx}", method=RequestMethod.POST)
	public void insertComment(CommandMap commandMap) throws Exception{
		commentService.insertComment(commandMap.getMap());
	}
	
	@RequestMapping(value="/{idx}", method=RequestMethod.DELETE)
	public int deleteComment(CommandMap commandMap) throws Exception{ 
		return commentService.deleteComment(commandMap.getMap());
	}
	
}