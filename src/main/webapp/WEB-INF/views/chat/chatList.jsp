<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>

<div class="auto-center">
    <div id="chat_list" class="chat_list"></div>

    <div class="submit_chat">
        <span class="input"><input type="text" id='name' placeholder="닉네임" autofocus></span>
        <span class="desc"><textarea id="content" rows="5" placeholder="내용"></textarea></span>
        <div class="btn_group">
            <a class="btn-submit" id="submit" href="">등록</a>
        </div>
    </div>
</div>

<script type="text/javascript">
	fn_selectChatList();
	
	setInterval(function() {
	  fn_selectChatList();
	}, 1500);
	
	document.getElementById("content").addEventListener('keydown', function(e){
		if (e.keyCode == 13) {
		  e.preventDefault();
		  fn_insertChat();
		}
	});
	
	document.getElementById("submit").addEventListener('click', function(e){
		e.preventDefault();
		fn_insertChat();
	});
	
	function fn_checkComment(name, content) {
		if(name.length == 0) { alert("닉네임을 입력해주세요."); return false; }
		if(content.length == 0) { alert("내용을 입력해주세요."); return false; }
		
		return true;
	}
	
	function fn_insertChat() {
		var name = document.getElementById("name").value;
		var content = document.getElementById("content").value;
		
		if(fn_checkComment(name, content)) {
			var comAjax = new ComAjax();
			comAjax.setUrl("/chat/insertChat.do");
			comAjax.setCallback('fn_selectChatList');
			comAjax.addParam("name", name);
			comAjax.addParam("content", content);
			comAjax.ajax();
			
			document.getElementById("content").value = '';
			document.getElementById("content").focus();
		}
	}
	
	function fn_selectChatList() {
	    var comAjax = new ComAjax();
	    comAjax.setUrl("/chat/selectChatList.do");
	    comAjax.setCallback("fn_selectChatListCallback");
	    comAjax.ajax();
	}
	
	var callcounter = 0;
	function fn_selectChatListCallback(data) {
	    var data = JSON.parse(data)
	    var body = document.getElementById("chat_list");
	    var length = body.querySelectorAll(".table>.tr").length;
	    var prevScrollHeight = body.scrollHeight;

	    var str = "";
	    str += "<div class='table'>";
	    for(var key in data) {
	        str +=  "<div class='tr'>" +
	                    "<div class='lbl'>" + data[key].name + "</div>" +
	                    "<div class='desc'>" + data[key].content + "</div>" +
	                    "<div class='date'>" + data[key].date.replace('T', ' ').substr(0, 19) + "</div>" +
	                    "<input type='hidden' id='idx' value=" + data[key].idx + ">" +
	                "</div>";
	    };
	    str += "</div>";
	    body.innerHTML = str;
	
	    if(Object.keys(data).length != length && body.scrollTop == (prevScrollHeight - body.offsetHeight) || callcounter++ == 0)
	        fn_moveScrollEnd();
	}
	
	function fn_moveScrollEnd() {
	    var body = document.getElementById("chat_list");
	    body.scrollTop = body.scrollHeight;
	}
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>