<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Spring Boot</title>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
  <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css" />
  <script src="${pageContext.request.contextPath}/resources/js/common.js"></script>
</head>
<body>
  <header id="header">
    <div>
      <div id="logo">
        <h3><a href="${pageContext.request.contextPath}/">Spring Boot HOMPAGE</a></h3>
      </div>
    </div>
    <nav id="gnb">
      <ul>
        <li><a href="${pageContext.request.contextPath}/board/pages/1">게시판</a></li>
        <li><a href="${pageContext.request.contextPath}/chat">채팅</a></li>
      </ul>
    </nav>
  </header>
  <form id="commonForm" name="commonForm"></form>
