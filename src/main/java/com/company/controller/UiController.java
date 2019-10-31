package com.company.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class UiController {
	
	@GetMapping("/")
	public String index() {
		return "index";
	}
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public void list() {
		
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
