<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	<input id= 'title' type="text" name="title">
</div>
<div>
	<label>내용</label>
	<textarea id ="content" name="content"></textarea>
</div>
<div>
	<label>작성자</label>
	<input id=" writer" type="text" name="writer">
</div>
	<input type="button" id='registerBtn' value="등록">
	<input type="button" id='cancleBtn' value="취소">
</div>
	
<script type="text/javascript" src="/resources/js/board.js"></script>
<script>
var boardInput = $(".boardInput");
var inputTitle = boardInput.find("input[name='title']");
var inputContent = $('textarea[name=content');
var inputWriter = $('input[name=writer]');

var registerBtn = $("#registerBtn");

$("#registerBtn").on("click", function(e){
	
	var board = {
			title : inputTitle.val(),
			content : inputContent.val(),
			writer : inputWriter.val()
	};
	boardService.add(board, function(result){
		alert("게시글을 등록 했습니다.");
		
		self.location = "/me";
		
	});
});

</script>
<script>
$("#cancleBtn").on("click", function(){
	self.location = "/me";
});
</script>
</body>
</html>

