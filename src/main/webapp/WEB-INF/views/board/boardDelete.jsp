<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>

<div class="board_write auto-center">
    <fieldset><legend>글삭제</legend>
        <h3>글삭제</h3>
        <div class="table">
            <div class="tr">
                <div class="lbl"><label for="board_pw">비밀번호</label></div>
                <div class="desc"><input type="password" id="board_pw" name="pw" size="20" title="비밀번호" required autofocus></div>
            </div>
        </div>
        <div class="btn_group">
            <a class="btn-default" href="<c:url value='/board/openBoardDetail.do?idx=${param.idx}'/>">취소</a>
            <button id="submit" class="btn-submit">완료</button>
        </div>
    </fieldset>
</div>

<script type="text/javascript">
	document.getElementById("submit").addEventListener('click', function(e){
	    e.preventDefault();
	    fn_deleteBoard();
	});
	
    function fn_deleteBoard(){
		var pw = document.getElementById("board_pw").value;
		
		var comAjax = new ComAjax();
		comAjax.setUrl("<c:url value='/board/deleteBoard.do'/>");
		comAjax.setCallback('fn_deleteBoardCallback');
		comAjax.addParam("idx", "${param.idx}");
		comAjax.addParam("pw", pw);
		comAjax.ajax();
    }
    
    function fn_deleteBoardCallback(isDeleted){
    	if(isDeleted == '1'){
    		alert("완료되었습니다.");
        	window.location.href = "<c:url value='/board/openBoardList.do'/>";
    	}
    	else{
    		alert("비밀번호가 일치하지 않습니다.");
    	}
    }
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp"%> 