<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Home</title>
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<body>
<input type="button" id="regBtn" value="게시글 등록">
<table class="boardList" border="1">
	<tr>
		<th>번호</th>
		<th>제목</th>
		<th>작성자</th>
		<th>작성일</th>
		<th>수정일</th>
	</tr>
</table>

<script type="text/javascript" src="/resources/js/board.js"></script>
<script>
	

	$(function(){
	
		var boardTable = $(".boardList");
		showList(1);
		
		function showList(page){
			
			boardService.getList({page: page || 1}, function(list){
				
				var str = "<tr><th>번호</th><th>제목</th><th>내용</th><th>작성자</th><th>작성일</th><th>수정일</th></tr>";
				if(list == null || list.length == 0){
					boardTable.html("");
					
					return
				}
				for(var i=0, len=list.length || 0; i < len; i++){
					str += "<tr><th>"+list[i].bno+"</th><th><a href=/me/get?bno="+list[i].bno+">"+list[i].title+"</a></th><th>"+list[i].content+"</th><th>"+list[i].writer+"</th><th>"+list[i].regdate+"</th><th>"+list[i].updatedate+"</th></tr>";
				}
				
				boardTable.html(str);
			});
		}
	});

	
	/*	
	boardService.add(
		{title:"ajax", content:"ajax", writer:"ajax"}
		,
		function(result){
			alert("result: " + result);
		}
	);
	*/
	
	/*
	boardService.getList({page:1}, function(list){
		for(var i=0, len = list.length || 0; i < len; i++){
			console.log(list[i]);
		}
	});
	*/
	
	/*
	boardService.remove(18, function(count){
		
		console.log(count);
		
		if(count === "success"){
			alert("removed");
		}
	}, function(err){
		alert("error");
	});
	*/
	
	/*
	boardService.update({
		bno : 19,
		title : "yoyo",
		content : "title!"
	},function(result){
		alert("수정 완료..");
	});
	*/
	
	/*
	boardService.get(10, function(data){
		console.log(data);
	});
	*/
</script>
<script type="text/javascript">
$("#regBtn").on("click", function(){
	self.location = "/me/register";
});
</script>
</body>
</html>
