package com.monginis.ops.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ProfileController {
	

	@RequestMapping(value = "/editProfile")
	public ModelAndView displaySavouries(HttpServletRequest request,
		HttpServletResponse response) {
	ModelAndView model = new ModelAndView("userProfile/profile");
	System.out.println("I am here");
	
	
	return model;
	
	
}
		

}
