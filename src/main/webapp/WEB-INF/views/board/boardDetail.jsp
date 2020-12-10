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
        var commentList = document.getElementById("comment_list");
        commentList.textContent = "";

        var listNum = document.createElement("h4");
        listNum.textContent = "총 댓글 수 : " + data.listNum;
        commentList.appendChild(listNum);

        var table = document.createElement("div");
        table.className = "table";
        
        for(var key in data.list) {
            var tr = document.createElement("div");
            tr.className = "tr";
            table.appendChild(tr);

            var name = document.createElement("div");
            name.className = "lbl";
            name.textContent = data.list[key].name;
            tr.appendChild(name);

            var content = document.createElement("div");
            content.className = "desc";
            content.textContent = data.list[key].content;
            tr.appendChild(content);

            var date = document.createElement("div");
            date.className = "date";
            date.textContent = data.list[key].date.replace('T', ' ').substr(0, 19);
            tr.appendChild(date);

            var deleteButton = document.createElement("div");
            deleteButton.className = "delete";

            var deleteButtonImg = document.createElement("img");
            deleteButtonImg.src = "${pageContext.request.contextPath}/resources/img/delete.jpg";
            deleteButton.appendChild(deleteButtonImg);

            tr.appendChild(deleteButton);

            (function(idx){
                deleteButton.addEventListener('click', function(){
                    fn_openDeleteComment(this, idx);
                });
            }(data.list[key].idx));
        }
        
        commentList.appendChild(table);
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
    
    function fn_openDeleteComment(obj, idx) {
        if(document.getElementById("comment_list").querySelector(".btn_group"))
            document.getElementById("comment_list").querySelector(".btn_group").remove();
        
        var div = document.createElement("div");
        div.className = "btn_group";

        var form = document.createElement("form");
        form.id = "comment_delete_form";
        form.method = "POST";
        
        var method = document.createElement("input");
        method.type = "hidden";
        method.name = "_method";
        method.value = "DELETE";
        form.appendChild(method);

        var password = document.createElement("input");
        password.type = "password";
        password.id = "commentpw";
        password.name = "pw";
        password.placeholder = "비밀번호";
        password.required = true;
        form.appendChild(password);

        var deleteConfirm = document.createElement("button");
        deleteConfirm.id = "commentdelete";
        deleteConfirm.className = "btn-submit";
        deleteConfirm.type = "submit";
        deleteConfirm.textContent = "확인";
        form.appendChild(deleteConfirm);

        var deleteCencel = document.createElement("button");
        deleteCencel.id = "commentcencel";
        deleteCencel.className = "btn-submit";
        deleteCencel.textContent = "취소";
        form.appendChild(deleteCencel);

        div.appendChild(form);
        obj.parentElement.appendChild(div);
        
        document.getElementById("comment_delete_form").addEventListener('submit', function(e){
            e.preventDefault();
            fn_deleteComment(this, idx);
        }); 
        
        document.getElementById("commentcencel").addEventListener('click', function(e){
            e.preventDefault();
            fn_deleteCencel(this);
        });
    }
    
    function fn_deleteComment(form, idx) {
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