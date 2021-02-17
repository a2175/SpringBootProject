<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>

<script src="${pageContext.request.contextPath}/webjars/sockjs-client/sockjs.min.js"></script>
<script src="${pageContext.request.contextPath}/webjars/stomp-websocket/stomp.min.js"></script>

<div class="auto-center">
	<div id="chat_list" class="chat_list"></div>
	<form id="form" action="" method="post">
		<div class="submit_chat">
			<span class="input"><input type="text" id='name' name="name" placeholder="닉네임" required autofocus></span>
			<span class="desc"><textarea id="content" name="content" rows="5" placeholder="내용" required></textarea></span>
			<div class="btn_group">
				<button id="submit" class="btn-submit" type="submit">등록</button>
			</div>
		</div>
	</form>
</div>

<script type="text/javascript">
   	var socket = new SockJS("${pageContext.request.contextPath}/chatWebSocket");
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
			document.getElementById("submit").click()
		}
	});
	
	document.getElementById("form").addEventListener('submit', function(e){
        e.preventDefault();
        fn_insertChat(this);
	});

    function fn_updateChatList(data) {
    	var body = document.getElementById("chat_list");
        var length = body.querySelectorAll(".table>.tr").length;
        var prevScrollHeight = body.scrollHeight;

		var tr = document.createElement("div");
		tr.className = "tr";
		body.querySelector('.table').appendChild(tr);

		var name = document.createElement("div");
		name.className = "lbl";
		name.textContent = data.name;
		tr.appendChild(name);

		var content = document.createElement("div");
		content.className = "desc";
		content.textContent = data.content;
		tr.appendChild(content);

		var date = document.createElement("div");
		date.className = "date";
		date.textContent = data.date;
		tr.appendChild(date);

        if(Object.keys(data).length != length && body.scrollTop == (prevScrollHeight - body.offsetHeight))
          fn_moveScrollEnd();
	}
    
	function fn_checkComment(name, content) {
		if(name.length == 0) { alert("닉네임을 입력해주세요."); return false; }
		if(content.length == 0) { alert("내용을 입력해주세요."); return false; }
		
		return true;
	}
	
	function fn_insertChat(form) {	
		var formData = new FormData(form);
		formData.append('date', now());
		
		stompClient.send("/insert", {}, JSON.stringify(Object.fromEntries(formData)));
		
		document.getElementById("content").value = '';
		document.getElementById("content").focus();
	}
	
	function fn_selectChatList(data) {
	    var body = document.getElementById("chat_list");
	    var length = body.querySelectorAll(".table>.tr").length;
	    var prevScrollHeight = body.scrollHeight;

		var table = document.createElement("div");
        table.className = "table";

		for(var key in data) {
			var tr = document.createElement("div");
			tr.className = "tr";
			table.appendChild(tr);

			var name = document.createElement("div");
			name.className = "lbl";
			name.textContent = data[key].name;
			tr.appendChild(name);

			var content = document.createElement("div");
			content.className = "desc";
			content.textContent = data[key].content;
			tr.appendChild(content);

			var date = document.createElement("div");
			date.className = "date";
			date.textContent = now(new Date(data[key].date));
			tr.appendChild(date);
	    };

		body.appendChild(table);
    
	    fn_moveScrollEnd();
	}
	
	function fn_moveScrollEnd() {
	    var body = document.getElementById("chat_list");
	    body.scrollTop = body.scrollHeight;
	}
	
	function now(date) {
		if(date == null) {
			date = new Date();
		}
		var m = date.getMonth()+1;
		var d = date.getDate();
		var h = date.getHours();
		var i = date.getMinutes();
		var s = date.getSeconds();
		return date.getFullYear()+'-'+(m>9?m:'0'+m)+'-'+(d>9?d:'0'+d)+' '+(h>9?h:'0'+h)+':'+(i>9?i:'0'+i)+':'+(s>9?s:'0'+s);
	}
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>