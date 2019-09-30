package com.myboot.springboot.chat.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.HtmlUtils;

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
	
	@MessageMapping("/list")
    @SendTo("/list")
    public List<Map<String, Object>> list() throws Exception { 
        return chatService.selectChatList();
    }
	
	@MessageMapping("/insert")
    @SendTo("/update")
    public Map<String, String> insert(Map<String, String> map) throws Exception {   
        map.put("name", HtmlUtils.htmlEscape(map.get("name")));
        map.put("content", HtmlUtils.htmlEscape(map.get("content")));

        chatService.insertChat(map);
        
        return map;
    }
	
}