package com.monginis.ops.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;



@Controller
public class StockController {		

		@RequestMapping(value = "/showstockdetail")
		public ModelAndView displayStockDetails(HttpServletRequest request,
			HttpServletResponse response) {
		ModelAndView model = new ModelAndView("stock/stockdetails");
		//System.out.println("I am here");
		
		return model;
		
		
	}
		@RequestMapping(value = "/end_StockMonth", method = RequestMethod.POST)
		public String showOpeningStock(HttpServletRequest request,
			HttpServletResponse response) {
			
			
			return "currentmonthstock";
			
		}
}
