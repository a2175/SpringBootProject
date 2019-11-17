<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>

<div class="board_list auto-center">
	<h3>총 게시물 수 : ${data.listNum}</h3>
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
			<c:forEach var="row" items="${data.list}" varStatus="status">
				<tr>
					<td>${row.idx }</td>
					<td class="al_l"><a href="<c:url value='/board/posts/${row.idx }'/>">${row.subject } <c:if test="${row.commentNum > 0}">[${row.commentNum}]</c:if></a>
					<td>${row.name }</td>
					<td>${row.date }</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="btn_group">
		 제목 검색: <input type="text" id="keyword" name="keyword" value="${param.keyword}">
      	<a href="#this" class="btn-submit" id="search">검색</a>
		<a class="btn-default" href="<c:url value='/board/posts/write'/>">작성</a>
	</div>
	<div id="PAGE_NAVI" style="margin: auto; display: table;"></div>
</div>

<script type="text/javascript">
	var params = {
	   divId : "PAGE_NAVI",
	   pageIndex : "${pageNum}",
	   totalCount : "${data.listNum}",
	   eventName : "<c:url value='/board/pages/'/>",
	   keyword : "${keyword}"
	};
	gfn_renderPaging(params);
	
	document.getElementById("search").addEventListener('click', function(e){
	    e.preventDefault();
	    fn_openBoardSearchList();
	});
	
	document.getElementById("keyword").addEventListener('keydown', function(e){
		if (e.keyCode == 13) {
		  e.preventDefault();
		  fn_openBoardSearchList();
		}
	});
	
	function fn_openBoardSearchList() {
	   keyword = document.getElementById("keyword").value;
	   location.href = "<c:url value='/board/pages/1/'/>" + keyword;
	}
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>