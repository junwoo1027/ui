<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<style>
	#page {list-style-type:none; float: left;}
</style>
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

<div>
	<div>
		<i>Reply</i>
		<button id="addReplyBtn">댓글 등록</button>
	</div>
	<div>
		작성자<input id="replyer" type="text">
	</div>
	<div>
		내용<input id="reply" type="text">
	</div>
	<div>
	<input type="text" name="test">
	</div>
	<ul class="chat">
		<li>
			<div>
				<strong>주누</strong>
				<small>ㅎㅇ</small>
				<small>
					<a href="#">삭제</a>
					<a href="#">수정</a>
				</small>
			</div>
		</li>
	</ul>
	<div class="pageButton">
	</div>
</div>
<script type="text/javascript" src="./resources/js/reply.js"></script>
<script type="text/javascript" src="./resources/js/board.js"></script>
<script>

//게시글 이벤트 처리
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

<script>
//댓글 이벤트 처리

var inputReply = $("#reply").val();
var inputReplyer = $("#replyer").val();

$(function(){
	$("#addReplyBtn").on("click", function(e){
	
		var reply = {
				reply : $("#reply").val(),
				replyer : $("#replyer").val(),
				bno : bno
		}
		
		console.log(reply);
		
		replyService.add(reply, function(result){
			alert("댓글 등록했습니다.");
			
			showList(1);
		});
	});
	
	showList(1);
	
	var replyUl = $(".chat");
	
	function showList(page){
		console.log("show List " + page);
		
		replyService.getList({bno : bno, page : page || 1}, function(replyCnt, list){
			
			console.log(replyCnt);
			console.log(list);
			
			var str = "";
			
			if(list == null || list.length == 0){
				replyUl.html("");
				return;
			}
			
			for(var i=0, len = list.length || 0; i < len; i++){
				str += "<li>";
				str += "<div>작성자 : <strong>"+list[i].replyer+"</strong>";
				str += " 내용 : <small class=rep>"+list[i].reply+ "</small><small><a href=javascript:void(0) class=modReply data-rno='"+list[i].rno+"' data-reply="+list[i].reply+" data-replyer='"+list[i].replyer+"'> 수정</a><a href=javascript:void(0) class=delReply data-rno='"+list[i].rno+"'> 삭제</a></small>";
				str += "</div></li></ul></div>";
			}
			
			replyUl.html(str);
			
			showReplyPage(replyCnt);
			
		});
	}
	
	var pageNum = 1;
	var pageButton = $(".pageButton");
	
	function showReplyPage(replyCnt){
		
		var endNum = Math.ceil(pageNum / 10.0) * 10;
		var startNum = endNum - 9;
		
		var prev = startNum != 1;
		var next = false;
		
		if(endNum * 10 >= replyCnt){
			endNum = Math.ceil(replyCnt/10.0);
		}
		
		if(endNum * 10 < replyCnt){
			next = true;
		}
		
		var str = "<ul id=page>";
		
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
	

	
	$(".chat").on("click", '.delReply', function(e){
		var rno = $(this).data("rno");
		 console.log(rno);
		
		replyService.remove(rno, function(e){
			alert("댓글을 삭제했습니다.");
			
			showList(pageNum);
		});
	});	
	
	$(".chat").on("click", '.modReply', function(e){
		
		var rno = $(this).data("rno");
		var reply1 = $("input[name='test']");
		var reply3 = $('.rep');
		var replyer = $(this).data("replyer");
		var reply2 = $(this).data("reply"); 
	
//		console.log(rno);
//		console.log(reply2);
		console.log(reply1);
		if(reply2 == reply3){
		console.log(reply3);
		}
		
		var reply = {rno: rno, replyer: replyer, reply: reply1.val()};
		
//		console.log(reply);
		
//		replyService.update(reply, function(result){
//			alert("댓글 수정");
	
//			showList(pageNum);
//		});
	});
});

</script>
</body>
</html>