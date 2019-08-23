<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>

<div class="board_view auto-center">
    <h3>글보기</h3>
    <div class="table">
        <div class="tr">
            <div class="lbl">작성자</div>
            <div class="desc">${data.name }</div>
        </div>
        <div class="tr">
            <div class="lbl">제목</div>
            <div class="desc">${data.subject }</div>
        </div>
        <div class="tr">
            <div class="lbl">내용</div>
            <div class="desc content">${data.content }</div>
        </div>
    </div>

    <div class="btn_group">
        <a class="btn-default" href="/board/openBoardList.do">목록</a>
        <a class="btn-submit" href="/board/openBoardUpdate.do?idx=${param.idx}">수정</a>
        <a class="btn-submit" href="/board/openBoardDelete.do?idx=${param.idx}">삭제</a>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp"%> 