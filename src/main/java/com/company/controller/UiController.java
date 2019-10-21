package com.company.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class UiController {
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home() {
		
		return "list";
	}
	
	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public void register() {
	}
	
	@GetMapping(value="/get")
	public void get() {

	}
	
}
