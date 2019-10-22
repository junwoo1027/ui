package com.company.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.company.domain.Criteria;

@Controller
public class UiController {
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String list(Criteria cri, Model model) {
		System.out.println(cri.getAmount());
		System.out.println(cri.getPageNum());
		
		return "list";
	}
	
	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public void register() {
	}
	
	@GetMapping(value="/get")
	public void get(@RequestParam("bno") int bno, Model model) {
		model.addAttribute("bno", bno);
	}
	
	@GetMapping("/modify")
	public void modify(@RequestParam("bno") int bno, Model model) {
		model.addAttribute("bno", bno);
	}
	
}
