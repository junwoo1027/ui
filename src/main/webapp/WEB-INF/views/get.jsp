<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
</head>
<body>
<div class = "boardInput" id="boardInput">
<div >
	<label>제목</label>
	<input id= 'title' type="text" name="title" readonly="readonly">
</div>
<div>
	<label>내용</label>
	<textarea id ="content" name="content" readonly="readonly"></textarea>
</div>
<div>
	<label>작성자</label>
	<input id=" writer" type="text" name="writer" readonly="readonly">
</div>
	<input type="button" id='registerBtn' value="수정">
	<input type="button" id='cancleBtn' value="삭제">
</div>

<script type="text/javascript" src="/resources/js/board.js"></script>
<script>
var bno = $(this).data("bno");
var bno2 = '<c:out value="${board.bno}"/>'
console.log(bno);
console.log(bno2);
</script>
</body>
</html>