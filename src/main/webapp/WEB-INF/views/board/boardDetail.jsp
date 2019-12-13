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
        <div class="tr">
	        <div class="lbl">첨부파일</div>
	        <c:forEach var="row" items="${list }" varStatus="status">
	        	<div class="desc">
					<a href="${pageContext.request.contextPath}/common/files/${row.idx }">${row.original_file_name }</a> (${row.file_size }kb)
				</div>
				<div class="lbl"></div>
			</c:forEach>
        </div>
    </div>
    <div id="comment_list"></div>
    <form id="comment_form" action="${pageContext.request.contextPath}/comment/${idx}" method="post">
        <div class="submit_comment">
            <div class="input">
                <div class="tr"><input type="text" id='name' name='name' placeholder="닉네임" required></div>
                <div class="tr"><input type="password" id='pw' name='pw' placeholder="비밀번호" required></div>
            </div>
            <div class="desc"><textarea id='content' name="content" rows="5" placeholder="내용" required></textarea></div>
            <div class="btn_group">
                <button class="btn-submit" type="submit">등록</button>
            </div>
        </div>
    </form>
    <div class="btn_group">
        <a class="btn-default" href="${pageContext.request.contextPath}/board/pages/1">목록</a>
        <a class="btn-submit" href="${pageContext.request.contextPath}/board/posts/${idx}/edit">수정</a>
        <a class="btn-submit" href="${pageContext.request.contextPath}/board/posts/${idx}/delete">삭제</a>
    </div>
</div>

<script type="text/javascript">
    fn_selectCommentList();

    document.getElementById("comment_form").addEventListener('submit', function(e){
        e.preventDefault();
        fn_insertComment(this);
	});
    
    function fn_selectCommentList() {
        var comAjax = new ComAjax();
        comAjax.setUrl("${pageContext.request.contextPath}/comment/${idx}");
        comAjax.setCallback("fn_selectCommentListCallback");
        comAjax.setMethod("GET");
        comAjax.ajax();
    }
    function fn_selectCommentListCallback(data) {
        data = JSON.parse(data);
        var body = document.getElementById("comment_list");
        var str = "<h4>총 댓글 수 : " + data.listNum + "</h4>";
        str += "<div class='table'>";
        for(var key in data.list) {
            str +=  "<div class='tr'>" +
                        "<div class='lbl'>" + data.list[key].name + "</div>" +
                        "<div class='desc'>" + data.list[key].content + "</div>" +
                        "<div class='date'>" + data.list[key].date.replace('T', ' ').substr(0, 19) + "</div>" +
                        "<div class='delete'>" + "<a href='#' id='opendel'><img src='${pageContext.request.contextPath}/resources/img/delete.jpg'></a>" + "</div>" +
                        "<input type='hidden' id='idx' value=" + data.list[key].idx + ">" +
                    "</div>";
        };
        str += "</div>";
        body.innerHTML = str;
        for(i=0; i<body.querySelectorAll('#opendel').length; i++) {          
            body.querySelectorAll('#opendel')[i].addEventListener('click', function(e){
                e.preventDefault();
                fn_openDeleteComment(this.parentElement);
            });
        }
    }
    
    function fn_insertComment(form) {
        var comAjax = new ComAjax(form);
        comAjax.setUrl(form.action);
        comAjax.setCallback('fn_selectCommentList');
        comAjax.ajax();
        
        document.getElementById("name").value = '';
        document.getElementById("pw").value = '';
        document.getElementById("content").value = '';
    }
    
    function fn_openDeleteComment(obj) {
        if(document.getElementById("comment_list").querySelector(".btn_group") != null)
            document.getElementById("comment_list").querySelector(".btn_group").remove();
        
        var div = document.createElement("div");
        div.className = "btn_group";
        var str = "<form id='comment_delete_form' action='' method='post'>" +
                    "<input type='hidden' name='_method' value='DELETE'>" +
                    "<input type='password' id='commentpw' name='pw' placeholder='비밀번호' required>" +
                    "<button id='commentdelete' class='btn-submit' type='submit'>확인</button>" +                
                    "<button id='commentcencel' class='btn-submit'>취소</button>" +
                  "</form>";
        div.innerHTML = str;
        
        obj.parentElement.appendChild(div);
        document.getElementById("comment_delete_form").addEventListener('submit', function(e){
            e.preventDefault();
            fn_deleteComment(this);
        }); 
        
        document.getElementById("commentcencel").addEventListener('click', function(e){
            e.preventDefault();
            fn_deleteCencel(this);
        });
    }
    
    function fn_deleteComment(form) {
        var idx = form.parentElement.parentElement.querySelector("#idx").value;
        var comAjax = new ComAjax(form);
        comAjax.setUrl("${pageContext.request.contextPath}/comment/" + idx);
        comAjax.setCallback("fn_deleteCommentCallback");
        comAjax.ajax();
    }
    
    function fn_deleteCommentCallback(data) {
        if(data == '1') {
            alert("완료되었습니다.");
            fn_selectCommentList();
        }
        else {
            alert("비밀번호가 일치하지 않습니다.");
        }
    }

    function fn_deleteCencel(obj) {
        obj.parentElement.remove();
    }
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp"%> 