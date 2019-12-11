package com.myboot.springboot.common.service;
 
import java.util.Map;

import javax.annotation.Resource;
 
import org.springframework.stereotype.Service;

import com.myboot.springboot.common.dao.CommonDAO;
 

@Service("commonService")
public class CommonServiceImpl implements CommonService{
     
    @Resource(name="commonDAO")
    private CommonDAO commonDAO;

    @Override
    public Map<String, Object> selectFileInfo(int idx) throws Exception {
        return commonDAO.selectFileInfo(idx);
    }

}