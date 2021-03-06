SpringBoot + Mysql + MyBatis
==============================
SpringBoot를 사용해서 만든 간단한 RESTful CRUD 게시판과
WebSocket을 사용한 실시간 채팅 프로젝트입니다.

#version = 1.96v

[SpringBootProject 1.96v]
1. chat.jsp 시간 표시 오류 수정

[SpringBootProject 1.95v]
1. boardUpdate.jsp, chatList.jsp, common.js에서 innerHTML 사용을 createElement(), appendChild()로 대체
2. common.js의 메소드명 수정, 페이징 랜더 메소드에 사용하는 getLinkElement 메소드 추가

[SpringBootProject 1.94v]
1. boardDetail.jsp에서 innerHTML 사용을 createElement(), appendChild()로 대체

[SpringBootProject 1.93v]
1. FileUtils.java의 stored_file_name 확장자명 제거

[SpringBootProject 1.92v]
1. ArgumentResolver에서 @PathVariable를 처리하도록 변경

[SpringBootProject 1.91v]
1. 게시글 수정에서 파일 삭제 시 제대로 업로드가 안 되는 문제 수정
2. 게시글 수정, 삭제 js 수정

[SpringBootProject 1.90v]
1. 파일 첨부 구축
2. 시간 표기 수정
3. 검색 키워드 표시되도록 수정

[SpringBootProject 1.82v]
1. WebSocket 코드 수정

[SpringBootProject 1.81v]
1. tomcat-embed를 사용한 배포에서 tomcat으로 배포하도록 변경
2. 모든 URL에 <c:url>을 사용하도록 변경

[SpringBootProject 1.80v]
1. 채팅에 WebSocket을 사용하도록 변경
2. MyBatis Log4j2 설정

[SpringBootProject 1.70v]
1. Log4j2 설정
2. Interceptor 설정
3. LoggerInterceptor 설정

[SpringBootProject 1.60v]
1. 댓글 등록 구축
2. 댓글 삭제 구축
3. DAO 메소드명 수정

[SpringBootProject 1.51v]
1. 게시글 검색기능 수정
2. 게시글 검색 엔터키에 동작하도록 수정

[SpringBootProject 1.50v]
1. 게시글 검색기능 구축

[SpringBootProject 1.40v]
1. 채팅 구축

[SpringBootProject 1.30v]
1. 게시판 페이징 구축

[SpringBootProject 1.20v]
1. 게시글 상세보기 구축
2. 게시글 등록 구축
3. 게시글 수정 구축
4. 게시글 삭제 구축

[SpringBootProject 1.10v]
1. 게시판 글 목록보기 구축
2. ArgumentResolver 설정
3. MyBatis 설정

[SpringBootProject 1.00v]
1. 메인페이지 구축