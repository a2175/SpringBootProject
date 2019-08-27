package com.myboot.springboot.chat.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.myboot.springboot.chat.dao.ChatDAO;

@Service("chatService")
public class ChatServiceImpl implements ChatService {

	@Resource(name="chatDAO")
    private ChatDAO chatDAO;
	
	@Override
	public List<Map<String, Object>> selectChatList() throws Exception {
		return chatDAO.selectChatList();
	}

	@Override
	public void insertChat(Map<String, Object> map) throws Exception {
		chatDAO.insertChat(map);
	}
	
}
