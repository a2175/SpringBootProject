package com.myboot.springboot.common.controller;

import java.io.File;
import java.net.URLEncoder;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.myboot.springboot.common.common.CommandMap;
import com.myboot.springboot.common.service.CommonService;

@RestController
@RequestMapping("/common")
public class CommonController {	
	private static String filePath;

    public CommonController() {
    	String os = System.getProperty("os.name");
    	if(os.toLowerCase().contains("windows")) {
    		filePath = "C:\\Users\\Administrator\\Desktop\\file\\";
    	}
    	else {
    		filePath = "/var/lib/tomcat8/file/";
    	}
    }
	
	@Resource(name="commonService")
	private CommonService commonService;
	
	@RequestMapping(value="/files/{idx}", method=RequestMethod.GET)
	public void downloadFile(CommandMap commandMap, HttpServletResponse response) throws Exception{
		Map<String,Object> map = commonService.selectFileInfo(commandMap.getMap());
		String storedFileName = (String)map.get("stored_file_name");
		String originalFileName = (String)map.get("original_file_name");
		
		byte fileByte[] = FileUtils.readFileToByteArray(new File(filePath+storedFileName));
		
		response.setContentType("application/octet-stream");
		response.setContentLength(fileByte.length);
		response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(originalFileName,"UTF-8")+"\";");
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.getOutputStream().write(fileByte);
		response.getOutputStream().flush();
		response.getOutputStream().close();
	}
	
}