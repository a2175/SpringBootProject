package com.myboot.springboot.board.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import com.myboot.springboot.board.dao.BoardDAO;
import com.myboot.springboot.common.util.FileUtils;

@Service("boardService")
public class BoardServiceImpl implements BoardService {

	@Resource(name="fileUtils")
    private FileUtils fileUtils;
	
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
		Map<String, Object> resultMap = new HashMap<String,Object>();
		
		Map<String, Object> data = boardDAO.selectBoardDetail(idx);
		List<Map<String,Object>> list = boardDAO.selectFileList(idx);
		resultMap.put("data", data);
        resultMap.put("list", list);
        
        return resultMap;
	}
	
	@Override
	public void insertBoard(Map<String, Object> map, HttpServletRequest request) throws Exception {
		boardDAO.insertBoard(map);

		List<Map<String,Object>> list = fileUtils.parseInsertFileInfo(map, request);
        
        for(int i=0, size=list.size(); i<size; i++){
        	boardDAO.insertFile(list.get(i));
        }
	}

	@Override
	public int updateBoard(Map<String, Object> map, HttpServletRequest request) throws Exception {
		int isUpdated = boardDAO.updateBoard(map);
		
		if(isUpdated == 1) {
			List<Map<String,Object>> list = fileUtils.parseUpdateFileInfo(map, request);
			
	        Map<String,Object> tempMap = null;
	        for(int i=0, size=list.size(); i<size; i++){
	            tempMap = list.get(i);
	            if(tempMap.get("is_new").equals("yes")){
	            	boardDAO.insertFile(tempMap);
	            }
	            else{
	            	fileUtils.deleteFile(tempMap);
	            	boardDAO.deleteFile(tempMap);
	            }
	        }
		}
        
		return isUpdated;
	}

	@Override
	public int deleteBoard(Map<String, Object> map) throws Exception {
		int isDeleted = boardDAO.deleteBoard(map);
		
		if(isDeleted == 1) {
			List<Map<String,Object>> fileList = boardDAO.selectFileList((int)map.get("idx"));
			
			Map<String,Object> tempMap = null;
			for(int i=0, size=fileList.size(); i<size; i++){
	            tempMap = fileList.get(i);
	            fileUtils.deleteFile(tempMap);
	        	boardDAO.deleteFile(tempMap);
	        }
		}
		
		return isDeleted;
	}
	
}
