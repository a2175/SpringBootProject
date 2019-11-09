package com.myboot.springboot.board.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
 
@Repository("boardDAO")
public class BoardDAO {
//    @Autowired
//    private JdbcTemplate jdbcTemplate;
//    public List<Map<String, Object>> findAllMap() {
//        return this.jdbcTemplate.queryForList("SELECT * from board limit 10");
//    }
    
    @Autowired
    private SqlSessionTemplate sqlSession;
 
    public List<Map<String, Object>> selectBoardList(int page_num) {
        int nPageIndex = page_num - 1;
        int nPageRow = 15;
        
        Map<String, Object> map = new HashMap<>();
        map.put("START", (nPageIndex * nPageRow));
        map.put("END", nPageRow);
        
    	return sqlSession.selectList("board.list", map);
    }
    
    public int selectBoardListNum() {
    	return sqlSession.selectOne("board.listNum");
    }
    
    public List<Map<String, Object>> selectBoardSearchList(int page_num, String keyword) {
    	int nPageIndex = page_num - 1;
        int nPageRow = 15;
         
        Map<String, Object> map = new HashMap<>();
        map.put("START", (nPageIndex * nPageRow));
        map.put("END", nPageRow);
        map.put("keyword", keyword);
        
    	return sqlSession.selectList("board.searchList", map);
    }
    
    public int selectBoardSearchListNum(String keyword) {
    	return sqlSession.selectOne("board.searchListNum", keyword);
    }
    
    public Map<String, Object> selectBoardDetail(int idx) {
    	return sqlSession.selectOne("board.detail", idx);
    }
    
    public void insertBoard(Map<String, Object> map) throws Exception{
    	sqlSession.insert("board.insert", map);
    }
    
	public int updateBoard(Map<String, Object> map) throws Exception {
		return sqlSession.update("board.update", map);
	}

	public int deleteBoard(Map<String, Object> map) throws Exception {
		return sqlSession.delete("board.delete", map);
	}

}