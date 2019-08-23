<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>

<div class="board_list auto-center">
	<h3>총 게시물 수 :</h3>
	<table style="width: 100%;">
		<colgroup>
			<col width="10%">
			<col width="60%">
			<col width="15%">
			<col width="15%">
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="row" items="${list}" varStatus="status">
				<tr>
					<td>${row.idx }</td>
					<td class="al_l">
						<a href="/board/openBoardDetail.do?idx=${row.idx }" id="title">${row.subject }</a>
						<input type="hidden" id="idx" value="${row.idx }"></td>
					<td>${row.name }</td>
					<td>${row.date }</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="btn_group">
		<a class="btn-default" href="/board/openBoardWrite.do">작성</a>
	</div>
	<div id="PAGE_NAVI" style="margin: auto; display: table;"></div>
</div>

<script type="text/javascript">

</script>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>