package com.company.domain;


public class Criteria {

	private int pageNum;//게시글 페이지 번호
	private int amount;//한 페이지에 보여줄 게시글 갯수
	
	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	public Criteria() {
		this(1,10);
	}
	
	public int getPageStart() {
		return (this.pageNum -1) * amount;
	}

	public int getPageNum() {
		return pageNum;
	}

	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}

	
}
