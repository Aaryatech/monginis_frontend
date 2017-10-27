package com.monginis.ops.controller;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import com.monginis.ops.constant.Constant;
import com.monginis.ops.model.CategoryList;



@Controller
public class StockController {		

	CategoryList categoryList;
		@RequestMapping(value = "/showstockdetail")
		public ModelAndView showStockDetail(HttpServletRequest request, HttpServletResponse response) {

			ModelAndView model = new ModelAndView("stock/stockdetails");
		
			RestTemplate restTemplate = new RestTemplate();

			
			
			try {

				categoryList = restTemplate.getForObject(Constant.URL + "showAllCategory", CategoryList.class);

			} catch (Exception e) {
				System.out.println("Exception in getAllGategory" + e.getMessage());
				e.printStackTrace();

			}
			
			System.out.println(" Category " + categoryList.getmCategoryList());

			
		
			model.addObject("category", categoryList.getmCategoryList());

			return model;
		}
		
		
		
		@RequestMapping(value = "/end_StockMonth", method = RequestMethod.POST)
		public ModelAndView showCurrentMonthStock(HttpServletRequest request,
			HttpServletResponse response) {
			System.out.println("in end month");
			
			
			ModelAndView model = new ModelAndView("stock/currentmonthstock");
			
			return model;
			
		}
}
