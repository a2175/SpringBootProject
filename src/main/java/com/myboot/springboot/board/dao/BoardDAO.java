package com.myboot.springboot.board.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.util.StringUtils;

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
 
    public List<Map<String, Object>> selectBoardList(Map<String, Object> map) {
        String strPageIndex = (String)map.get("page");

        int nPageIndex = 0;
        int nPageRow = 15;
         
        if(StringUtils.isEmpty(strPageIndex) == false){
            nPageIndex = Integer.parseInt(strPageIndex) - 1;
        }

        map.put("START", (nPageIndex * nPageRow));
        map.put("END", nPageRow);
        
    	return sqlSession.selectList("board.list", map);
    }
    
    public Map<String, Object> selectListNum() {
    	return sqlSession.selectOne("board.listNum");
    }
    
    public List<Map<String, Object>> selectBoardSearchList(Map<String, Object> map) {
        String strPageIndex = (String)map.get("page");

        int nPageIndex = 0;
        int nPageRow = 15;
         
        if(StringUtils.isEmpty(strPageIndex) == false){
            nPageIndex = Integer.parseInt(strPageIndex) - 1;
        }

        map.put("START", (nPageIndex * nPageRow));
        map.put("END", nPageRow);
        
    	return sqlSession.selectList("board.searchList", map);
    }
    
    public Map<String, Object> selectSearchListNum(Map<String, Object> map) {
    	return sqlSession.selectOne("board.searchListNum", map);
    }
    
    public Map<String, Object> selectBoardDetail(Map<String, Object> map) {
    	return sqlSession.selectOne("board.detail", map);
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