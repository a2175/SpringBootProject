package com.myboot.springboot.board.service;

import java.util.Map;

public interface BoardService {

	Map<String, Object> selectBoardList(Map<String, Object> map) throws Exception;
	
	Map<String, Object> selectBoardSearchList(Map<String, Object> map) throws Exception;
	
	Map<String, Object> selectBoardDetail(Map<String, Object> map) throws Exception;
	
	void insertBoard(Map<String, Object> map) throws Exception;
	
	int updateBoard(Map<String, Object> map) throws Exception;
	
	int deleteBoard(Map<String, Object> map) throws Exception;
}
