package com.myboot.springboot.comment.service;

import java.util.Map;

public interface CommentService {

	Map<String, Object> selectCommentList(int idx) throws Exception;
	
	void insertComment(Map<String, Object> map) throws Exception;
	
	int deleteComment(Map<String, Object> map) throws Exception;
	
}
