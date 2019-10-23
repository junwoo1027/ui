<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Home</title>
	
	<style>
		ul li{list-style-type:none; float: left; margin-left: 10px;}
	</style>
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<body>
<input type="button" id="regBtn" value="게시글 등록">
<table id="boardList" border="1">
	<tr>
		<th>번호</th>
		<th>제목</th>
		<th>작성자</th>
		<th>작성일</th>
		<th>수정일</th>
	</tr>
</table>

<div class="pageButton">

</div>

<script type="text/javascript" src="./resources/js/board.js"></script>
<script>


$(function(){
	
	var boardTable = $("#boardList");
	showList(1);
	
	function showList(page){
		
		console.log("page : " + page);
		boardService.getList({page: page || 1}, function(boardCnt, list){
			
			console.log(boardCnt);
			console.log(list);
			
			
			var str = "<tr><th>번호</th><th>제목</th><th>내용</th><th>작성자</th><th>작성일</th><th>수정일</th></tr>";
			
			if(list == null || list.length == 0){
//				boardTable.html("");
				
				return;
			}
			
			for(var i=0, len=list.length || 0; i < len; i++){
				str += "<tr><th>"+list[i].bno+"</th><th><a href=/me/get?bno="+list[i].bno+">"+list[i].title+"</a></th><th>"+list[i].content+"</th><th>"+list[i].writer+"</th><th>"+list[i].regdate+"</th><th>"+list[i].updatedate+"</th></tr>";
			}
			
			boardTable.html(str);
			showBoardPage(boardCnt);
		});
	}
	
var pageNum = 1;
var pageButton = $(".pageButton");

function showBoardPage(boardCnt){
	
	var endNum = Math.ceil(pageNum / 10.0) * 10;
	var startNum = endNum - 9;
	
	var prev = startNum != 1;
	var next = false;
	
	if(endNum * 10 >= boardCnt){
		endNum = Math.ceil(boardCnt/10.0);
	}
	
	if(endNum * 10 < boardCnt){
		next = true;
	}
	
	var str = "<ul>";
	
	if(prev){
		str += "<li><a href='"+(startNum -1)+"'>Previous</a></li>";
	}
	
	for(var i = startNum ; i <=endNum; i++){

		str += "<li><a href='"+i+"'>"+i+"</a></li>";
	}
	
	if(next){
		str += "<li><a href='"+(endNum+1)+"'>Next</a></li>";
	}
	str += "</ul></div>";
	
	pageButton.html(str);
}

pageButton.on("click", "li a", function(e){
	e.preventDefault();
	
	console.log("page click");
	
	var targetPageNum = $(this).attr("href");

	console.log(targetPageNum);
	
	pageNum = targetPageNum;
	
	showList(pageNum);
});
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
