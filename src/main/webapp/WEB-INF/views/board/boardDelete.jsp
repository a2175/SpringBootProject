<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>

<div class="board_write auto-center">
	<form id="form" action="${pageContext.request.contextPath}/board/posts/${idx}" method="post">
	<input type="hidden" name="_method" value="DELETE">
    <fieldset><legend>글삭제</legend>
        <h3>글삭제</h3>
        <div class="table">
            <div class="tr">
                <div class="lbl"><label for="board_pw">비밀번호</label></div>
                <div class="desc"><input type="password" id="board_pw" name="pw" size="20" title="비밀번호" required autofocus></div>
            </div>
        </div>
        <div class="btn_group">
            <a class="btn-default" href="${pageContext.request.contextPath}/board/posts/${idx}">취소</a>
            <button class="btn-submit" type="submit">완료</button>
        </div>
    </fieldset>
    </form>
</div>

<script type="text/javascript">
	document.getElementById("form").addEventListener('submit', function(e){
        e.preventDefault();
        fn_deleteBoard(this);
	});
	
    function fn_deleteBoard(form){	
		var comAjax = new ComAjax(form);
		comAjax.setUrl(form.action);
		comAjax.setCallback('fn_deleteBoardCallback');
		comAjax.ajax();
    }
    
    function fn_deleteBoardCallback(isDeleted){
    	if(isDeleted == '1'){
    		alert("완료되었습니다.");
        	window.location.href = "${pageContext.request.contextPath}/board/pages/1";
    	}
    	else{
    		alert("비밀번호가 일치하지 않습니다.");
    	}
    }
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp"%> 