<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>

<div class="board_write auto-center">
    <form action="${pageContext.request.contextPath}/board/posts" method="post" enctype="multipart/form-data">
    <fieldset><legend>글작성</legend>
        <h3>글작성</h3>
        <div class="table">
            <div class="tr">
                <div class="lbl"><label for="board_name">작성자</label></div>
                <div class="desc"><input type="text" id="board_name" name="name" size="20" title="작성자" required autofocus></div>
            </div>
            <div class="tr">
                <div class="lbl"><label for="board_pw">비밀번호</label></div>
                <div class="desc"><input type="password" id="board_pw" name="pw" size="20" title="비밀번호" required></div>
            </div>
            <div class="tr">
                <div class="lbl"><label for="board_subject">제목</label></div>
                <div class="desc"><input type="text" id="board_subject" name="subject" size="80" title="제목" required></div>
            </div>
            <div class="tr">
                <div class="lbl"><label for="board_content">내용</label></div>
                <div class="desc"><textarea id="board_content" name="content" cols="80" rows="10" title="내용" required></textarea></div>
            </div>
            <div class="tr">
                <div class="lbl"><label for="board_content">파일첨부</label></div>
                <div class="desc"><input type="file" id="file_0" name="file_0"></div>
                <div class="lbl"><label for="board_content"></label></div>
                <div class="desc"><input type="file" id="file_1" name="file_1"></div>
                <div class="lbl"><label for="board_content"></label></div>
                <div class="desc"><input type="file" id="file_2" name="file_2"></div>
            </div>
        </div>
        
        <div class="btn_group">
            <a class="btn-default" href="${pageContext.request.contextPath}/board/pages/1">취소</a>
            <button class="btn-submit" type="submit">완료</button>
        </div>
    </fieldset>
    </form>
</div>

<script type="text/javascript">
	var file = document.querySelectorAll("input[id^=file]");
	for(i=0; i<file.length; i++) {
		file[i].onchange = function() {
			var fileSize = this.files[0].size;
			if(fileSize > 1048576) {
				alert("첨부 파일 용량은 1MB를 넘을 수 없습니다.");
				this.value = "";
			}
		};
    }
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp"%> 