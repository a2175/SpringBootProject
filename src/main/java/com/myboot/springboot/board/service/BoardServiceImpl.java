package com.myboot.springboot.board.service;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.myboot.springboot.board.dao.BoardDAO;

@Service("boardService")
public class BoardServiceImpl implements BoardService {

	@Resource(name="boardDAO")
    private BoardDAO boardDAO;
	
	@Override
	public Map<String, Object> selectBoardList(int page_num) throws Exception {
		Map<String, Object> resultMap = new HashMap<String,Object>();

		resultMap.put("list", boardDAO.selectBoardList(page_num));
		resultMap.put("listNum", boardDAO.selectBoardListNum());

		return resultMap;
	}
	
	@Override
	public Map<String, Object> selectBoardSearchList(int page_num, String keyword) throws Exception {
		Map<String, Object> resultMap = new HashMap<String,Object>();
		
		resultMap.put("list", boardDAO.selectBoardSearchList(page_num, keyword));
		resultMap.put("listNum", boardDAO.selectBoardSearchListNum(keyword));

		return resultMap;
	}
	
	@Override
	public Map<String, Object> selectBoardDetail(int idx) throws Exception {
		return boardDAO.selectBoardDetail(idx);
	}
	
	@Override
	public void insertBoard(Map<String, Object> map) throws Exception {
		boardDAO.insertBoard(map);
	}

	@Override
	public int updateBoard(Map<String, Object> map) throws Exception {
		return boardDAO.updateBoard(map);
	}

	@Override
	public int deleteBoard(Map<String, Object> map) throws Exception {
		return boardDAO.deleteBoard(map);
	}
	
}
