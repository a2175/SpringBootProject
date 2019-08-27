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
	public Map<String, Object> selectBoardList(Map<String, Object> map) throws Exception {
		Map<String, Object> resultMap = new HashMap<String,Object>();
		
		resultMap.put("list", boardDAO.selectBoardList(map));
		resultMap.put("listNum", boardDAO.selectListNum().get("count"));

		return resultMap;
	}
	
	@Override
	public Map<String, Object> selectBoardDetail(Map<String, Object> map) throws Exception {
		return boardDAO.selectBoardDetail(map);
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
