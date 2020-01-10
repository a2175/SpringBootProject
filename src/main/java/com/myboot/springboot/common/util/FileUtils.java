package com.myboot.springboot.common.util;
 
import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
 
import javax.servlet.http.HttpServletRequest;
 
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
 
@Component("fileUtils")
public class FileUtils {
    private static String filePath;

    public FileUtils() {
    	String os = System.getProperty("os.name");
    	if(os.toLowerCase().contains("windows")) {
    		filePath = "C:\\Users\\Administrator\\Desktop\\file\\";
    	}
    	else {
    		filePath = "/var/lib/tomcat8/file/";
    	}
    }
    
    public List<Map<String,Object>> parseInsertFileInfo(Map<String,Object> map, HttpServletRequest request) throws Exception{
        MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;
        Iterator<String> iterator = multipartHttpServletRequest.getFileNames();
         
        MultipartFile multipartFile = null;
        String originalFileName = null;
        String storedFileName = null;
         
        List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
        Map<String, Object> listMap = null;
         
        String boardIdx = String.valueOf(map.get("idx"));
         
        File file = new File(filePath);
        if(file.exists() == false){
            file.mkdirs();
        }
        
        while(iterator.hasNext()){
            multipartFile = multipartHttpServletRequest.getFile(iterator.next());
            
            if(multipartFile.isEmpty() == false){
                originalFileName = multipartFile.getOriginalFilename();
                storedFileName = CommonUtils.getRandomString();
                 
                file = new File(filePath + storedFileName);
                multipartFile.transferTo(file);
                 
                listMap = new HashMap<String,Object>();
                listMap.put("board_idx", boardIdx);
                listMap.put("original_file_name", originalFileName);
                listMap.put("stored_file_name", storedFileName);
                listMap.put("file_size", multipartFile.getSize());
                list.add(listMap);
            }
        }
        
        return list;
    }

    public List<Map<String, Object>> parseUpdateFileInfo(Map<String, Object> map, HttpServletRequest request) throws Exception{
        MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;
        Iterator<String> iterator = multipartHttpServletRequest.getFileNames();
         
        MultipartFile multipartFile = null;
        String originalFileName = null;
        String storedFileName = null;
         
        List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
        Map<String, Object> listMap = null;
        
        String boardIdx = String.valueOf(map.get("idx"));
        String requestName = null;
        String idx = null;
         
        while(iterator.hasNext()){
            multipartFile = multipartHttpServletRequest.getFile(iterator.next());
            
            if(multipartFile.isEmpty() == false){
                originalFileName = multipartFile.getOriginalFilename();
                storedFileName = CommonUtils.getRandomString();
                 
                multipartFile.transferTo(new File(filePath + storedFileName));
                 
                listMap = new HashMap<String,Object>();
                listMap.put("is_new", "yes");
                listMap.put("board_idx", boardIdx);
                listMap.put("original_file_name", originalFileName);
                listMap.put("stored_file_name", storedFileName);
                listMap.put("file_size", multipartFile.getSize());
                list.add(listMap);
            }
            else{
                requestName = multipartFile.getName();
                idx = "idx_"+requestName.substring(requestName.indexOf("_")+1);
                
                if(map.containsKey(idx) == true && map.get(idx) != null){
                	map.remove(idx);
                }
            }
        }
        
        for(int i=0; i < 3; i++) {
        	if(map.get("idx_"+Integer.toString(i)) != null) {
        		listMap = new HashMap<String,Object>();
                listMap.put("is_new", "no");
                listMap.put("idx", map.get("idx_"+Integer.toString(i)));
                listMap.put("stored_file_name", map.get("name_"+Integer.toString(i)));
                list.add(listMap);
        	}
        }
        
        return list;
    }

	public void deleteFile(Map<String, Object> tempMap) {
		File file = new File(filePath + tempMap.get("stored_file_name"));
		file.delete();
	}
}