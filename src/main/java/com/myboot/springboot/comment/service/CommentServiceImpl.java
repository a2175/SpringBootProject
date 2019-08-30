package com.myboot.springboot.comment.service;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.myboot.springboot.comment.dao.CommentDAO;

@Service("commentService")
public class CommentServiceImpl implements CommentService {

	@Resource(name="commentDAO")
    private CommentDAO commentDAO;

	@Override
	public Map<String, Object> selectCommentList(Map<String, Object> map) throws Exception {
		Map<String, Object> resultMap = new HashMap<String,Object>();
		
		resultMap.put("list", commentDAO.selectCommentList(map));
		resultMap.put("listNum", commentDAO.selectCommentListNum(map));

		return resultMap;
	}

	@Override
	public void insertComment(Map<String, Object> map) throws Exception {
		commentDAO.insertComment(map);
	}

	@Override
	public int deleteComment(Map<String, Object> map) throws Exception {
		return commentDAO.deleteComment(map);
	}
	
}
