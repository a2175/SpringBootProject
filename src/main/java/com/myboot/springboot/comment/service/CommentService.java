package com.myboot.springboot.comment.service;

import java.util.Map;

public interface CommentService {

	Map<String, Object> selectCommentList(Map<String, Object> map) throws Exception;
	
	void insertComment(Map<String, Object> map) throws Exception;
	
	int deleteComment(Map<String, Object> map) throws Exception;
	
}
