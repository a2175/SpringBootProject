package com.myboot.springboot.board.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.myboot.springboot.board.dao.BoardDAO;

@Service("boardService")
public class BoardServiceImpl implements BoardService {

	@Resource(name="boardDAO")
    private BoardDAO boardDAO;
	
	@Override
	public List<Map<String, Object>> selectBoardList() throws Exception {
		return boardDAO.selectBoardList();
	}
	
}
