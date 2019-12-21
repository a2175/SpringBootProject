package com.myboot.springboot.common.dao;
 
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.Map;
 
@Repository("commonDAO")
public class CommonDAO {

	@Autowired
    private SqlSessionTemplate sqlSession;
	
	public Map<String, Object> selectFileInfo(Map<String, Object> map) throws Exception{
	    return sqlSession.selectOne("common.selectFileInfo", map);
	}

}