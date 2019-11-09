<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>

<div class="board_write auto-center">
    <fieldset><legend>글수정</legend>
        <h3>글수정</h3>
        <div class="table">
            <div class="tr">
                <div class="lbl"><label for="board_name">작성자</label></div>
                <div class="desc"><input type="text" id="board_name" name="name" size="20" title="작성자" required autofocus value="${data.name}"></div>
            </div>
            <div class="tr">
                <div class="lbl"><label for="board_pw">비밀번호</label></div>
                <div class="desc"><input type="password" id="board_pw" name="pw" size="20" title="비밀번호" required></div>
            </div>
            <div class="tr">
                <div class="lbl"><label for="board_subject">제목</label></div>
                <div class="desc"><input type="text" id="board_subject" name="subject" size="80" title="제목" required value="${data.subject}"></div>
            </div>
            <div class="tr">
                <div class="lbl"><label for="board_content">내용</label></div>
                <div class="desc"><textarea id="board_content" name="content" cols="80" rows="10" title="내용" required>${data.content}</textarea></div>
            </div>
        </div>
        <div class="btn_group">
            <a class="btn-default" href="<c:url value='/board/post/${idx}'/>">취소</a>
            <button id="submit" class="btn-submit">완료</button>
        </div>
    </fieldset>
</div>

<script type="text/javascript">
	document.getElementById("submit").addEventListener('click', function(e){
	    e.preventDefault();
	    fn_updateBoard();
	});
	
    function fn_updateBoard(){
		var name = document.getElementById("board_name").value;
		var pw = document.getElementById("board_pw").value;
		var subject = document.getElementById("board_subject").value;
		var content = document.getElementById("board_content").value;
		
		var comAjax = new ComAjax();
		comAjax.setUrl("<c:url value='/board/post/${idx}'/>");
		comAjax.setCallback('fn_updateBoardCallback');
		comAjax.addParam("_method", "PUT");
		comAjax.addParam("name", name);
		comAjax.addParam("pw", pw);
		comAjax.addParam("subject", subject);
		comAjax.addParam("content", content);
		comAjax.ajax();
    }
    
    function fn_updateBoardCallback(isUpdated){
    	if(isUpdated == '1'){
    		alert("완료되었습니다.");
        	window.location.href = "<c:url value='/board/post/${idx}'/>";
    	}
    	else{
    		alert("비밀번호가 일치하지 않습니다.");
    	}
    }
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp"%> 