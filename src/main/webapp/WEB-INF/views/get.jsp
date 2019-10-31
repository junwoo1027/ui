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
	
	div.replyModal { position:relative; z-index:1; display:none; }
	div.modalBackground { position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(0, 0, 0, 0.8); z-index:-1; }
	div.modalContent { position:fixed; top:20%; left:calc(50% - 250px); width:500px; height:250px; padding:20px 10px; background:#fff; border:2px solid #666; }
 	div.modalContent textarea { font-size:16px; font-family:'맑은 고딕', verdana; padding:10px; width:480px; height:180px; }
	div.modalContent button { font-size:20px; padding:5px 10px; margin:10px 0; background:#fff; border:1px solid #ccc; }
 	div.modalContent button.modal_cancel { margin-left:20px; }
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
				<strong></strong>
				<small></small>
				<small>
					<a href="#">삭제</a>
					<a href="#">수정</a>
				</small>
			</div>
		</li>
	</ul>
	<div class="pageButton">
	</div>
	
	<div class="replyModal">
	
		<div class="modalContent">
			<div>
				<textarea class="modal_repCon" name="modal_repCon"></textarea>
			</div>
			
			<div>
				<button type="button" class="modal_modify_btn">수정</button>
				<button type="button" class="modal_cancle">취소</button>
			</div>
		</div>
		
		<div class="modalBackground"></div>
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
			
			showList(pageNum);
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
		var replyer = $(this).data("replyer");
	
		console.log("replyer");
		
		var reply = {rno: rno, replyer: replyer, reply: reply1.val()};
		
		console.log(reply);
		
		replyService.update(reply, function(result){
			alert("댓글 수정");
	
			showList(pageNum);
		});
	}); 
	
<%--	var reply = replyUl.find("textarea[name='modal_repCon']");
	var modal = $('.replyModal');
	
	$(".chat").on("click", ".modReply", function(e){
		var rno = $(this).data("rno");
		var replyer = $(this).data("replyer");
		
		console.log($(this));
		
		
		console.log(rno);
		console.log(replyer);
		
		$(".replyModal").attr("style", "display:block;");
	});
	
	$(".modal_cancle").click(function(){
		$(".replyModal").attr("style", "display:none;");
	});
	
	
	$(".modal_modify_btn").on("click", function(e){
		
		var reply = {rno: $('.modReply').data("rno"), replyer: $('.modReply').data("replyer"), reply: "zz"};
		console.log(reply);
		
		replyService.update(reply, function(result){
			alert("댓글 수정");
			
			$(".replyModal").attr("style", "display:none;");
			
			showList(pageNum);
		});
	});--%>

	
});

</script>
</body>
</html>