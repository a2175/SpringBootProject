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
	<div id="comment_list"></div>
    <div class="submit_comment">
        <div class="input">
            <div class="tr"><input type="text" id='name' placeholder="닉네임"></div>
            <div class="tr"><input type="password" id='pw' placeholder="비밀번호"></div>
        </div>
        <div class="desc"><textarea id="content" rows="5" placeholder="내용"></textarea></div>
        <div class="btn_group">
            <a class="btn-submit" id="submit" href="">등록</a>
        </div>
    </div>
    <div class="btn_group">
        <a class="btn-default" href="<c:url value='/board/openBoardList.do'/>">목록</a>
        <a class="btn-submit" href="<c:url value='/board/openBoardUpdate.do?idx=${param.idx}'/>">수정</a>
        <a class="btn-submit" href="<c:url value='/board/openBoardDelete.do?idx=${param.idx}'/>">삭제</a>
    </div>
</div>

<script type="text/javascript">
    fn_selectCommentList();
    
    document.getElementById("submit").addEventListener('click', function(e){
        e.preventDefault();
        fn_insertComment();
    });
    
    function fn_selectCommentList() {
        var comAjax = new ComAjax();
        comAjax.setUrl("<c:url value='/comment/selectCommentList.do'/>");
        comAjax.setCallback("fn_selectCommentListCallback");
        comAjax.addParam("idx", "${param.idx}");
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
                        "<div class='delete'>" + "<a href='#' id='opendel'><img src='<c:url value='/resources/img/delete.jpg'/>'></a>" + "</div>" +
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
    
    function fn_checkComment(name, pw, content) {
        if(name.length == 0) { alert("닉네임을 입력해주세요."); return false; }
        if(pw.length == 0) { alert("비밀번호를 입력해주세요."); return false; }
        if(content.length == 0) { alert("내용을 입력해주세요."); return false; }

        return true;
	}
    
    function fn_insertComment() {
        var name = document.getElementById("name").value;
        var pw = document.getElementById("pw").value;
        var content = document.getElementById("content").value;
        
        if(fn_checkComment(name, pw, content)) {       
            var comAjax = new ComAjax();
            comAjax.setUrl("<c:url value='/comment/insertComment.do'/>");
            comAjax.setCallback('fn_selectCommentList');
            comAjax.addParam("idx", "${param.idx}");
            comAjax.addParam("name", name);
            comAjax.addParam("pw", pw);
            comAjax.addParam("content", content);
            comAjax.ajax();
            
            document.getElementById("name").value = '';
            document.getElementById("pw").value = '';
            document.getElementById("content").value = '';
        }
    }
    
    function fn_openDeleteComment(obj) {
        if(document.getElementById("comment_list").querySelector(".btn_group") != null)
            document.getElementById("comment_list").querySelector(".btn_group").remove();
        
        var div = document.createElement("div");
        div.className = "btn_group";
        var str = "<input type='password' id='commentpw' placeholder='비밀번호'>" +
                  "<a id='commentdelete' class='btn-submit' href=''>확인</a>" +
                  "<a id='commentcencel' class='btn-submit' href=''>취소</a>";
        div.innerHTML = str;
        
        obj.parentElement.appendChild(div);
        document.querySelector("a[id='commentdelete']").addEventListener('click', function(e){
            e.preventDefault();
            fn_deleteComment(this);
        }); 
        
        document.querySelector("a[id='commentcencel']").addEventListener('click', function(e){
            e.preventDefault();
            fn_deleteCencel(this);
        });
    }
    
    function fn_deleteComment(obj) {
        var idx = obj.parentElement.parentElement.querySelector("#idx").value;
        var pw = obj.parentElement.querySelector("#commentpw").value;
        var comAjax = new ComAjax();
        comAjax.setUrl("<c:url value='/comment/deleteComment.do'/>");
        comAjax.setCallback("fn_deleteCommentCallback");
        comAjax.addParam("idx", idx);
        comAjax.addParam("pw", pw);
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