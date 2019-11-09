package com.myboot.springboot.comment.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;
 
@Repository("commentDAO")
public class CommentDAO {
//    @Autowired
//    private JdbcTemplate jdbcTemplate;
//    public List<Map<String, Object>> findAllMap() {
//        return this.jdbcTemplate.queryForList("SELECT * from board limit 10");
//    }
    
    @Autowired
    private SqlSessionTemplate sqlSession;
 
    public List<Map<String, Object>> selectCommentList(int idx) {
    	return sqlSession.selectList("comment.list", idx);
    }
    
    public int selectCommentListNum(int idx) {
    	return sqlSession.selectOne("comment.listNum", idx);
    }
    
    public void insertComment(Map<String, Object> map) {
		sqlSession.insert("comment.insert", map);
	}
    
    public int deleteComment(Map<String, Object> map) throws Exception {
		return sqlSession.delete("comment.delete", map);
	}
    
}