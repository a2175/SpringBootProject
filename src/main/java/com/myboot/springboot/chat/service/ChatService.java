package com.myboot.springboot.chat.service;

import java.util.List;
import java.util.Map;

public interface ChatService {

	List<Map<String, Object>> selectChatList() throws Exception;
	
	void insertChat(Map<String, String> map) throws Exception;
	
}
