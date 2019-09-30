package com.myboot.springboot.chat.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;
 
@Repository("chatDAO")
public class ChatDAO {
//    @Autowired
//    private JdbcTemplate jdbcTemplate;
//    public List<Map<String, Object>> findAllMap() {
//        return this.jdbcTemplate.queryForList("SELECT * from board limit 10");
//    }
    
    @Autowired
    private SqlSessionTemplate sqlSession;
 
    public List<Map<String, Object>> selectChatList() {
    	return sqlSession.selectList("chat.list");
    }

	public void insertChat(Map<String, String> map) {
		sqlSession.insert("chat.insert", map);
	}
    
}