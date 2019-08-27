package com.myboot.springboot.chat.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.myboot.springboot.chat.service.ChatService;
import com.myboot.springboot.common.common.CommandMap;

@RestController
public class ChatController {
	
	@Resource(name="chatService")
    private ChatService chatService;
	
	@RequestMapping(value="/chat/openChatList.do")
	public ModelAndView openChatList(CommandMap commandMap) throws Exception {
		ModelAndView mv = new ModelAndView("chat/chatList");
		
        return mv;
	}
	
	@RequestMapping(value="/chat/selectChatList.do")
	public List<Map<String, Object>> selectChatList(CommandMap commandMap) throws Exception {
        return chatService.selectChatList();
	}
	
	@RequestMapping(value="/chat/insertChat.do")
    public void insertChat(CommandMap commandMap) throws Exception{
        chatService.insertChat(commandMap.getMap());
    }

}