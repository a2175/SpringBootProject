package com.myboot.springboot.common.service;

import java.util.Map;

public interface CommonService {

	Map<String, Object> selectFileInfo(int idx) throws Exception;
	
}