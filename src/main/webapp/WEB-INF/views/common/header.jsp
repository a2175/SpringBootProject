<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Spring Boot</title>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
  <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/common.css'/>" />
  <script src="<c:url value='/resources/js/common.js'/>"></script>
</head>
<body>
  <header id="header">
    <div>
      <div id="logo">
        <h3><a href="<c:url value='/'/>">Spring Boot HOMPAGE</a></h3>
      </div>
    </div>
    <nav id="gnb">
      <ul>
        <li><a href="<c:url value='/board/pages/1'/>">게시판</a></li>
        <li><a href="<c:url value='/chat'/>">채팅</a></li>
      </ul>
    </nav>
  </header>
  <form id="commonForm" name="commonForm"></form>
