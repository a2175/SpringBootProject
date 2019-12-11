package com.myboot.springboot.board.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface BoardService {

	Map<String, Object> selectBoardList(int page_num) throws Exception;
	
	Map<String, Object> selectBoardSearchList(int page_num, String keyword) throws Exception;
	
	Map<String, Object> selectBoardDetail(int idx) throws Exception;
	
	void insertBoard(Map<String, Object> map, HttpServletRequest request) throws Exception;
	
	int updateBoard(Map<String, Object> map, HttpServletRequest request) throws Exception;
	
	int deleteBoard(Map<String, Object> map) throws Exception;
}
