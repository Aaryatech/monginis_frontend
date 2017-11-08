package com.monginis.ops.controller;


import java.time.LocalDate;
import java.time.YearMonth;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import com.monginis.ops.constant.Constant;
import com.monginis.ops.model.BillWisePurchaseList;
import com.monginis.ops.model.BillWisePurchaseReport;
import com.monginis.ops.model.BillWiseTaxReport;
import com.monginis.ops.model.BillWiseTaxReportList;
import com.monginis.ops.model.CategoryList;
import com.monginis.ops.model.Franchisee;
import com.monginis.ops.model.ItemWiseDetail;
import com.monginis.ops.model.ItemWiseDetailList;
import com.monginis.ops.model.ItemWiseReport;
import com.monginis.ops.model.ItemWiseReportList;
import com.monginis.ops.model.MCategory;
import com.monginis.ops.model.Main;
import com.monginis.ops.model.MonthWiseReport;
import com.monginis.ops.model.MonthWiseReportList;
import com.monginis.ops.model.SpCakeResponse;

@Controller
public class ReportsController {

	
	
	@RequestMapping(value = "/billWisePurchaseReport", method = RequestMethod.GET)
	public ModelAndView viewBill(HttpServletRequest request,
				HttpServletResponse response) {

			ModelAndView model = new ModelAndView("report/purchaseReport/billWisePurchaseReport");
			return model;			
	}
	@RequestMapping(value = "/billTaxReport", method = RequestMethod.GET)
	public ModelAndView billTaxReport(HttpServletRequest request,
				HttpServletResponse response) {

			ModelAndView model = new ModelAndView("report/purchaseReport/billWiseTaxReport");
			return model;			
	}
	@RequestMapping(value = "/itemWiseDetailReport", method = RequestMethod.GET)
	public ModelAndView itemWiseDetailReport(HttpServletRequest request,
				HttpServletResponse response) {

			ModelAndView model = new ModelAndView("report/purchaseReport/itemWiseDetail");
			
			RestTemplate restTemplate = new RestTemplate();


			CategoryList allCategoryResponse = restTemplate.getForObject(Constant.URL + "showAllCategory",
					CategoryList.class);

			List<MCategory>  catList = allCategoryResponse.getmCategoryList();
			
			System.out.println("catList :"+catList.toString());
			model.addObject("catList", catList);
			
			
			return model;			
	}
	@RequestMapping(value = "/itemWiseReport", method = RequestMethod.GET)
	public ModelAndView itemWiseReport(HttpServletRequest request,
				HttpServletResponse response) {

			ModelAndView model = new ModelAndView("report/purchaseReport/itemWiseReport");
			
			RestTemplate restTemplate = new RestTemplate();


			CategoryList allCategoryResponse = restTemplate.getForObject(Constant.URL + "showAllCategory",
					CategoryList.class);

			List<MCategory>  catList = allCategoryResponse.getmCategoryList();
			
			System.out.println("catList :"+catList.toString());
			model.addObject("catList", catList);
			
			
			return model;			
	}
	@RequestMapping(value = "/monthWisePurchaseReport", method = RequestMethod.GET)
	public ModelAndView monthWisePurchaseReport(HttpServletRequest request,
				HttpServletResponse response) {

			ModelAndView model = new ModelAndView("report/purchaseReport/monthWisePurchase");
			return model;			
	}
	//----------------------------------Bill Wise Purchase Report---------------------------------------------
	@RequestMapping(value = "/findBillWisePurchase", method = RequestMethod.GET)
	public @ResponseBody List<BillWisePurchaseReport> getBillWisePurchase(HttpServletRequest request,
		HttpServletResponse response) {
				
		
		System.out.println("in method");
		String fromDate=request.getParameter("fromDate");
		System.out.println("fromDate"+fromDate);
		
		String toDate=request.getParameter("toDate");
		System.out.println("toDate"+toDate);

		
		HttpSession ses = request.getSession();
		Franchisee frDetails = (Franchisee) ses.getAttribute("frDetails");
			
		RestTemplate restTemplate = new RestTemplate();
					
		MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
		int frId=frDetails.getFrId();
		System.out.println("frId"+frId);
		
		map.add("frId", frId);
		map.add("fromDate", Main.formatDate(fromDate));
		map.add("toDate",Main.formatDate(toDate));

		
		List<BillWisePurchaseReport> billWisePurchaseReportList=new ArrayList<BillWisePurchaseReport>();
	   try {
		      BillWisePurchaseList billWisePurchaseList=restTemplate.postForObject(Constant.URL + "/showBillWisePurchaseReport",map,
		    		  BillWisePurchaseList.class);
		    
		      billWisePurchaseReportList=billWisePurchaseList.getBillWisePurchaseList();
		      
		   }
		   catch (Exception e) {
			     e.printStackTrace();
			     System.out.println(e.getMessage());
		   }
		
		   System.out.println("BillReportBillWise: "+billWisePurchaseReportList.toString());
	
	  return billWisePurchaseReportList;
	
	}
	
	//---------------------------------------------------------------------------------------------------------------------
	
	
	//----------------------------------Item Wise Detail Report---------------------------------------------
		@RequestMapping(value = "/findItemWiseDetailReport", method = RequestMethod.GET)
		public @ResponseBody List<ItemWiseDetail> findItemWiseDetailReport(HttpServletRequest request,
			HttpServletResponse response) {
					
			
			System.out.println("in method");
			String fromDate=request.getParameter("fromDate");
			System.out.println("fromDate"+fromDate);
			
			String toDate=request.getParameter("toDate");
			System.out.println("toDate"+toDate);

			int catId=Integer.parseInt(request.getParameter("catId"));
			
			HttpSession ses = request.getSession();
			Franchisee frDetails = (Franchisee) ses.getAttribute("frDetails");
				
			RestTemplate restTemplate = new RestTemplate();
						
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			int frId=frDetails.getFrId();
			System.out.println("frId"+frId);
			
			map.add("frId", frId);
			map.add("fromDate", Main.formatDate(fromDate));
			map.add("toDate",Main.formatDate(toDate));
			map.add("catId", catId);

			
			List<ItemWiseDetail> itemWiseDetailReportList=new ArrayList<ItemWiseDetail>();
		   try {
			   ItemWiseDetailList itemWiseDetailList=restTemplate.postForObject(Constant.URL + "/showItemWiseDetailsReport",map,
					   ItemWiseDetailList.class);
			    
			   itemWiseDetailReportList=itemWiseDetailList.getItemWiseDetailList();
			      
			   }
			   catch (Exception e) {
				     e.printStackTrace();
				     System.out.println(e.getMessage());
			   }
			
			   System.out.println("ItemWiseDetailReport: "+itemWiseDetailReportList.toString());
		
		  return itemWiseDetailReportList;
		
		}
		
		//---------------------------------------------------------------------------------------------------------------------
		//----------------------------------Item Wise Detail Report---------------------------------------------
				@RequestMapping(value = "/findItemWiseReport", method = RequestMethod.GET)
				public @ResponseBody List<ItemWiseReport> findItemWiseReport(HttpServletRequest request,
					HttpServletResponse response) {
							
					
					System.out.println("in method");
					String fromDate=request.getParameter("fromDate");
					System.out.println("fromDate"+fromDate);
					
					String toDate=request.getParameter("toDate");
					System.out.println("toDate"+toDate);

					int catId=Integer.parseInt(request.getParameter("catId"));
					
					HttpSession ses = request.getSession();
					Franchisee frDetails = (Franchisee) ses.getAttribute("frDetails");
						
					RestTemplate restTemplate = new RestTemplate();
								
					MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
					int frId=frDetails.getFrId();
					System.out.println("frId"+frId);
					
					map.add("frId", frId);
					map.add("fromDate", Main.formatDate(fromDate));
					map.add("toDate",Main.formatDate(toDate));
					map.add("catId", catId);

					
					List<ItemWiseReport> itemWiseReportList=new ArrayList<ItemWiseReport>();
				   try {
					   ItemWiseReportList itemWiseList=restTemplate.postForObject(Constant.URL + "/showItemWiseReport",map,
							   ItemWiseReportList.class);
					    
					   itemWiseReportList=itemWiseList.getItemWiseReportList();
					      
					   }
					   catch (Exception e) {
						     e.printStackTrace();
						     System.out.println(e.getMessage());
					   }
					
					   System.out.println("ItemWiseDetailReport: "+itemWiseReportList.toString());
				
				  return itemWiseReportList;
				
				}
				
				//---------------------------------------------------------------------------------------------------------------------
		
		//----------------------------------Bill Wise Tax Report---------------------------------------------
				@RequestMapping(value = "/findBillWiseTaxReport", method = RequestMethod.GET)
				public @ResponseBody List<BillWiseTaxReport> getBillWiseTaxReport(HttpServletRequest request,
					HttpServletResponse response) {
							
					
					System.out.println("in method");
					String fromDate=request.getParameter("fromDate");
					System.out.println("fromDate"+fromDate);
					
					String toDate=request.getParameter("toDate");
					System.out.println("toDate"+toDate);

					
					HttpSession ses = request.getSession();
					Franchisee frDetails = (Franchisee) ses.getAttribute("frDetails");
						
					RestTemplate restTemplate = new RestTemplate();
								
					MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
					int frId=frDetails.getFrId();
					System.out.println("frId"+frId);
					
					map.add("frId", frId);
					map.add("fromDate", Main.formatDate(fromDate));
					map.add("toDate",Main.formatDate(toDate));

					
					List<BillWiseTaxReport> billWiseTaxReport=new ArrayList<BillWiseTaxReport>();
				   try {
					      BillWiseTaxReportList billWiseTaxReportList=restTemplate.postForObject(Constant.URL + "/showBillWiseTaxReport",map,
					    		  BillWiseTaxReportList.class);
					    
					      billWiseTaxReport=billWiseTaxReportList.getBillWiseTaxReportList();
					      
					   }
					   catch (Exception e) {
						     e.printStackTrace();
						     System.out.println(e.getMessage());
					   }
					
					   System.out.println("billWiseTaxReport: "+billWiseTaxReport.toString());
				
				  return billWiseTaxReport;
				
				}
				
				//---------------------------------------------------------------------------------------------------------------------
				//----------------------------------Bill Wise Tax Report---------------------------------------------
				@RequestMapping(value = "/getMonthWisePurchaseReport", method = RequestMethod.GET)
				public @ResponseBody List<MonthWiseReport> getMonthWiseReport(HttpServletRequest request,
					HttpServletResponse response) {
							
					
					System.out.println("in method");
					String fromDate=request.getParameter("fromDate");
					System.out.println("fromDate"+fromDate);
					
					String toDate=request.getParameter("toDate");
					System.out.println("toDate"+toDate);

					
					DateTimeFormatter f = DateTimeFormatter.ofPattern( "MM/uuuu" );
					YearMonth ym = YearMonth.parse( fromDate , f );
					
					LocalDate fDate = ym.atDay( 1 );
					System.out.println("fdate"+fDate);
                    
					YearMonth ym1 = YearMonth.parse( toDate , f );
					LocalDate tDate = ym1.atEndOfMonth();
					System.out.println("tdate"+tDate);

					
					HttpSession ses = request.getSession();
					Franchisee frDetails = (Franchisee) ses.getAttribute("frDetails");
						
					RestTemplate restTemplate = new RestTemplate();
								
					MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
					int frId=frDetails.getFrId();
					System.out.println("frId"+frId);
					
					map.add("frId", frId);
					map.add("fromDate",""+fDate);
					map.add("toDate",""+tDate);

					
					List<MonthWiseReport> monthWiseReportList=new ArrayList<MonthWiseReport>();
				   try {
					      MonthWiseReportList monthWiseReportListBean=restTemplate.postForObject(Constant.URL + "/showMonthWiseReport",map,
					    		  MonthWiseReportList.class);
					    
					      monthWiseReportList=monthWiseReportListBean.getMonthWiseReportList();
					      
					   }
					   catch (Exception e) {
						     e.printStackTrace();
						     System.out.println(e.getMessage());
					   }
					
					   System.out.println("monthWiseReportList: "+monthWiseReportList.toString());
				
				  return monthWiseReportList;
				
				}
				
				//---------------------------------------------------------------------------------------------------------------------
}
