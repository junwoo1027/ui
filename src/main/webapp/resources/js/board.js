console.log("board module");

var boardService = (function(){
	
	function add(board, callback){
		console.log("add board...");
	
		$.ajax({
			type : 'post',
			url : '/board/new',
			data : JSON.stringify(board),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr){
				if(callback){
					callback(result);
				}
			},
			error : function(xhr, status, er){
				if(error){
					error(er);
				}
			}
		})
	}
	
	function getList(param, callback, error){
		
		var page = param.page || 1;
		
		$.getJSON("/board/pages/" + page + ".json", function(data){
			if(callback){
//				callback(data);
				callback(data.boardCnt, data.list);
			}
		}).fail(function(xhr, status, err){
			if(error){
				error();
			}
		})
	}
	
	function remove(bno, callback, error){
		
		$.ajax({
			type : 'delete',
			url : '/board/' + bno,
			success : function(deleteResult, status, xhr){
				if(callback){
					callback(deleteResult);
				}
			},
			error : function(xhr, status, er){
				if(error){
					error(er);
				}
			}
		})
	}
	
	function update(board, callback, error){
		
		console.log("bno: " + board.bno);
		
		$.ajax({
			type : 'put',
			url : '/board/' + board.bno,
			data : JSON.stringify(board),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr){
				if(callback){
					callback(result);
				}
			},
			error : function(xhr, status, er){
				if(error){
					error(er);
				}
			}
		});
	}
	
	function get(bno, callback, error){
		
		console.log(bno);
		$.get("/board/" + bno + ".json", function(result){
			if(callback){
				callback(result);
			}
		}).fail(function(xhr, status, err){
			if(error){
				error();
			}
		});
	}

	return {
		add : add,
		getList : getList,
		remove : remove,
		update : update,
		get : get
	};
})();