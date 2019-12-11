<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>

<script type="text/javascript">
	if("${param.isUpdated}" == "0") {
		alert("비밀번호가 일치하지 않습니다.");
		document.location.replace("${pageContext.request.contextPath}/board/posts/${idx}/edit");
	}
	else if("${param.isUpdated}" == "1") {
		alert("완료되었습니다.");
		document.location.replace("${pageContext.request.contextPath}/board/posts/${idx}");
	}
</script>

<div class="board_write auto-center">
	<form action="${pageContext.request.contextPath}/board/posts/${idx}" method="post" enctype="multipart/form-data">
	<input type="hidden" name="_method" value="PUT">
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
            <div class="tr">
                <div class="lbl"><label for="board_content">파일첨부</label></div>
                <c:forEach var="row" items="${list }" varStatus="var">
                	<input type="hidden" name="idx_${var.index }" value="${row.idx }">
                	<input type="hidden" name="name_${var.index }" value="${row.stored_file_name }">
	               	<div class="desc">
	               		<input type="file" id="file_${var.index }" name="file_${var.index }">
	                	<a href="#this">${row.original_file_name }</a> (${row.file_size }kb)
		                <a href="#this" id="deleteFile">[삭제]</a>
	                </div>
	                <div class="lbl"><label for="board_content"></label></div>
				</c:forEach>
				<c:if test="${list.size() < 3}">
    				<c:forEach begin="${list.size()}" end="2" step="1" var="var">
    					<div class="desc">
				    		<input type="file" id="file_${var}" name="file_${var}">
				    	</div>
				    	<div class="lbl"><label for="board_content"></label></div>
					</c:forEach>
				</c:if>
            </div>
        </div>
        <div class="btn_group">
            <a class="btn-default" href="${pageContext.request.contextPath}/board/posts/${idx}">취소</a>
            <button id="submit" class="btn-submit">완료</button>
        </div>
    </fieldset>
    </form>
</div>

<script type="text/javascript">
	var deleteFileBtn = document.querySelectorAll('#deleteFile');
	for(i=0; i<deleteFileBtn.length; i++) {
		deleteFileBtn[i].addEventListener('click', function(e){
            e.preventDefault();
            this.parentElement.innerHTML = "<input type='file'>"
        });
    }
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp"%> 