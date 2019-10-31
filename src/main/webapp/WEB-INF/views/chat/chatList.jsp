<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>

<script src="<c:url value='/webjars/sockjs-client/sockjs.min.js'/>"></script>
<script src="<c:url value='/webjars/stomp-websocket/stomp.min.js'/>"></script>

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
   	var socket = new SockJS("http://" + location.hostname + ":8080" + "<c:url value='/chatWebSocket'/>"); 
    var stompClient = Stomp.over(socket);
    
    stompClient.connect({}, function (frame) {
    	stompClient.send("/list");

        stompClient.subscribe('/list', function (data) {
        	fn_selectChatList(JSON.parse(data.body))
        });

        stompClient.subscribe('/update', function (data) {
        	fn_updateChatList(JSON.parse(data.body))
        });
    });
    
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

    function fn_updateChatList(data) {
    	var body = document.getElementById("chat_list");
        var length = body.querySelectorAll(".table>.tr").length;
        var prevScrollHeight = body.scrollHeight;

        var str = "";
        str += "<div class='tr'>" +
                "<div class='lbl'>" + data.name + "</div>" +
                "<div class='desc'>" + data.content + "</div>" +
                "<div class='date'>" + data.date + "</div>" +
               "</div>";

        body.querySelector('.table').innerHTML += str;

        if(Object.keys(data).length != length && body.scrollTop == (prevScrollHeight - body.offsetHeight))
          fn_moveScrollEnd();
	}
    
	function fn_checkComment(name, content) {
		if(name.length == 0) { alert("닉네임을 입력해주세요."); return false; }
		if(content.length == 0) { alert("내용을 입력해주세요."); return false; }
		
		return true;
	}
	
	function fn_insertChat() {
		var name = document.getElementById("name").value;
		var content = document.getElementById("content").value;
		
		if(fn_checkComment(name, content)) {
			var data = {
				name : name,
				content : content,
				date : now()
			};
			
			stompClient.send("/insert", {}, JSON.stringify(data));
			
			document.getElementById("content").value = '';
			document.getElementById("content").focus();
		}
	}
	
	function fn_selectChatList(data) {
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
	                "</div>";
	    };
	    str += "</div>";
	    body.innerHTML = str;
    
	    fn_moveScrollEnd();
	}
	
	function fn_moveScrollEnd() {
	    var body = document.getElementById("chat_list");
	    body.scrollTop = body.scrollHeight;
	}
	
	function now() {
		var date = new Date();
		var m = date.getMonth()+1;
		var d = date.getDate();
		var h = date.getHours();
		var i = date.getMinutes();
		var s = date.getSeconds();
		return date.getFullYear()+'-'+(m>9?m:'0'+m)+'-'+(d>9?d:'0'+d)+' '+(h>9?h:'0'+h)+':'+(i>9?i:'0'+i)+':'+(s>9?s:'0'+s);
	}
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>