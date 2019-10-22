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
	<input type="button" id='modifyBtn' value="수정">
	<input type="button" id='deleteBtn' value="삭제">
</div>

<script type="text/javascript" src="/resources/js/board.js"></script>
<script>
var bno = ${bno};

var boardInput = $(".boardInput");
var inputTitle = boardInput.find("input[name='title']");
var inputContent = boardInput.find("textarea[name='content']");
var inputWriter = boardInput.find("input[name='writer']");

$(function(){
	boardService.get(bno, function(board){
		inputTitle.val(board.title);
		inputContent.val(board.content);
		inputWriter.val(board.writer)
		.attr("readonly", "readonly");
	});
});

$("#deleteBtn").on("click", function(e){
	boardService.remove(bno, function(result){
		alert("글을 삭제했습니다.");
		self.location = "/me";
	});
});

$("#modifyBtn").on("click", function(e){
	self.location = "/me/modify?bno=" + bno;
})
</script>
</body>
</html>