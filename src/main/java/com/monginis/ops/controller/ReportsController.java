package com.monginis.ops.controller;


import java.awt.Dimension;
import java.awt.Insets;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.OutputStream;
import java.time.LocalDate;
import java.time.YearMonth;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;
import org.zefer.pd4ml.PD4Constants;
import org.zefer.pd4ml.PD4ML;

import com.monginis.ops.constant.Constant;
import com.monginis.ops.model.BillWisePurchaseList;
import com.monginis.ops.model.BillWisePurchaseReport;
import com.monginis.ops.model.BillWiseTaxReport;
import com.monginis.ops.model.BillWiseTaxReportList;
import com.monginis.ops.model.CategoryList;
import com.monginis.ops.model.Franchisee;
import com.monginis.ops.model.GetRepFrDatewiseSellResponse;
import com.monginis.ops.model.GetRepFrItemwiseSellResponse;
import com.monginis.ops.model.GetRepMenuwiseSellResponse;
import com.monginis.ops.model.GetRepTaxSell;
import com.monginis.ops.model.GetSellBillHeader;
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

	public static List<GetRepTaxSell> getRepTaxSell;
	public static List<GetRepFrDatewiseSellResponse> getRepFrDatewiseSellResponse;
	public static List<GetSellBillHeader> getSellBillHeaderList;
	//List<GetRepFrDatewiseSellResponse> getRepFrDatewiseSellResponse;
	public static List<GetRepMenuwiseSellResponse> getRepFrMenuwiseSellResponseList;
	public static List<GetRepFrItemwiseSellResponse> getRepFrItemwiseSellResponseList;
	//List<GetRepFrItemwiseSellResponse> getRepFrItemwiseSellResponseList;
//	List<GetRepFrItemwiseSellResponse> getRepFrItemwiseSellResponseList;
	public static List<BillWisePurchaseReport> billWisePurchaseReportList;
	public static List<ItemWiseDetail> itemWiseDetailReportList;
	public static List<ItemWiseReport> itemWiseReportList;
	public static List<BillWiseTaxReport> billWiseTaxReport;
	public static 	List<MonthWiseReport> monthWiseReportList;
	
	
	@RequestMapping(value = "/viewBillWisePurchaseReport", method = RequestMethod.GET)
	public ModelAndView viewBill(HttpServletRequest request,
				HttpServletResponse response) {

			ModelAndView model = new ModelAndView("report/purchaseReport/billWisePurchaseReport");
			return model;			
	}
	@RequestMapping(value = "/viewBillTaxPurchaseReport", method = RequestMethod.GET)
	public ModelAndView billTaxReport(HttpServletRequest request,
				HttpServletResponse response) {

			ModelAndView model = new ModelAndView("report/purchaseReport/billWiseTaxReport");
			return model;			
	}
	@RequestMapping(value = "/viewItemWiseDetailReport", method = RequestMethod.GET)
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
	@RequestMapping(value = "/viewItemWiseReport", method = RequestMethod.GET)
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
	@RequestMapping(value = "/viewMonthWisePurchaseReport", method = RequestMethod.GET)
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

		
		  billWisePurchaseReportList=new ArrayList<BillWisePurchaseReport>();
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

			
			 itemWiseDetailReportList=new ArrayList<ItemWiseDetail>();
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

					
					  itemWiseReportList=new ArrayList<ItemWiseReport>();
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

					
				 billWiseTaxReport=new ArrayList<BillWiseTaxReport>();
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

					
					  monthWiseReportList=new ArrayList<MonthWiseReport>();
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
				//Sell Report Start
				
				@RequestMapping(value = "/viewBillwiseSell", method = RequestMethod.GET)
				public ModelAndView viewBillwiseSell(HttpServletRequest request,
							HttpServletResponse response) {

						ModelAndView model = new ModelAndView("report/sellReport/repFrSellBillwiseSell");
						return model;			
				}
				
				
				@RequestMapping(value = "/getBilwiselReport", method = RequestMethod.GET)
				public @ResponseBody List<GetSellBillHeader> getSellBillHeader(HttpServletRequest request,
					HttpServletResponse response) {
							
					
					System.out.println("in method");
					String fromDate=request.getParameter("fromDate");
					String toDate=request.getParameter("toDate");
					
					HttpSession ses = request.getSession();
					Franchisee frDetails = (Franchisee) ses.getAttribute("frDetails");
						
								RestTemplate restTemplate = new RestTemplate();
								
					MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
					int frId=frDetails.getFrId();
					map.add("frId", frId);
					map.add("fromDate", fromDate);
					map.add("toDate", toDate);
					 
				  getSellBillHeaderList=new ArrayList<GetSellBillHeader>();
					try {
					  
					ParameterizedTypeReference<List<GetSellBillHeader>> typeRef = new ParameterizedTypeReference<List<GetSellBillHeader>>() {
					};
					ResponseEntity<List<GetSellBillHeader>> responseEntity = restTemplate.exchange(Constant.URL + "getSellBillHeader",
							HttpMethod.POST, new HttpEntity<>(map), typeRef);
					
					getSellBillHeaderList = responseEntity.getBody();	
					}
					catch (Exception e) {
						e.printStackTrace();
						System.out.println(e.getMessage());
					}
					
					
					 System.out.println("Sell Bill Header "+getSellBillHeaderList.toString());
					
						
								
					
				
				return getSellBillHeaderList;
				
				}

				@RequestMapping(value = "/viewDatewiseSellBill", method = RequestMethod.GET)
				public ModelAndView viewDatewiseSellBill(HttpServletRequest request,
							HttpServletResponse response) {

						ModelAndView model = new ModelAndView("report/sellReport/repFrSelldatewise");
						return model;			
				}
				
				@RequestMapping(value = "/getDatewiselReport", method = RequestMethod.GET)
				public @ResponseBody List<GetRepFrDatewiseSellResponse> getDatewiseSellBill(HttpServletRequest request,
					HttpServletResponse response) {
							
					
					System.out.println("in method");
					String fromDate=request.getParameter("fromDate");
					String toDate=request.getParameter("toDate");
					
					HttpSession ses = request.getSession();
					Franchisee frDetails = (Franchisee) ses.getAttribute("frDetails");
						
								RestTemplate restTemplate = new RestTemplate();
								
					MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
					int frId=frDetails.getFrId();
					map.add("frId", frId);
					map.add("fromDate", fromDate);
					map.add("toDate", toDate);
					 
				 getRepFrDatewiseSellResponse=new ArrayList<GetRepFrDatewiseSellResponse>();
					try {
					  
					ParameterizedTypeReference<List<GetRepFrDatewiseSellResponse>> typeRef = new ParameterizedTypeReference<List<GetRepFrDatewiseSellResponse>>() {
					};
					ResponseEntity<List<GetRepFrDatewiseSellResponse>> responseEntity = restTemplate.exchange(Constant.URL + "getRepDatewiseSell",
							HttpMethod.POST, new HttpEntity<>(map), typeRef);
					
					getRepFrDatewiseSellResponse = responseEntity.getBody();	
					}
					catch (Exception e) {
						e.printStackTrace();
						System.out.println(e.getMessage());
					}
					
					
					
					
					 System.out.println("Sell Bill Header "+getRepFrDatewiseSellResponse.toString());
					
						
								
					
				
				return getRepFrDatewiseSellResponse;
				
				}
				
				@RequestMapping(value = "/viewMonthwiseSellBill", method = RequestMethod.GET)
				public ModelAndView viewMonthwiseSellBill(HttpServletRequest request,
							HttpServletResponse response) {

						ModelAndView model = new ModelAndView("report/sellReport/repFrMonthwiseSell");
						return model;			
				}
				
				@RequestMapping(value = "/getMonthwiselReport", method = RequestMethod.GET)
				public @ResponseBody List<GetRepFrDatewiseSellResponse> getMonthwiseSellBill(HttpServletRequest request,
					HttpServletResponse response) {
							
					
					System.out.println("in method");
					String fromDate=request.getParameter("fromDate");
					String toDate=request.getParameter("toDate");
					
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
					map.add("frId", frId);
				
					map.add("fromDate",""+fDate);
					map.add("toDate",""+tDate);
				 
					  getRepFrDatewiseSellResponse=new ArrayList<GetRepFrDatewiseSellResponse>();
				
					try {
					  
					ParameterizedTypeReference<List<GetRepFrDatewiseSellResponse>> typeRef = new ParameterizedTypeReference<List<GetRepFrDatewiseSellResponse>>() {
					};
					ResponseEntity<List<GetRepFrDatewiseSellResponse>> responseEntity = restTemplate.exchange(Constant.URL + "getRepMonthwiseSell",
							HttpMethod.POST, new HttpEntity<>(map), typeRef);
					
					getRepFrDatewiseSellResponse = responseEntity.getBody();	
					}
					catch (Exception e) {
						e.printStackTrace();
						System.out.println(e.getMessage());
					}
					
					
					
					
					 System.out.println("Sell Bill Header "+getRepFrDatewiseSellResponse.toString());
					
						
								
					
				
				return getRepFrDatewiseSellResponse;
				
				}
				
				@RequestMapping(value = "/viewItemwiseSellBill", method = RequestMethod.GET)
				//@RequestMapping(value = "/viewChart", method = RequestMethod.GET)
				public ModelAndView viewItemwiseSellBill(HttpServletRequest request,
							HttpServletResponse response) {

						ModelAndView model = new ModelAndView("report/sellReport/repFrItemwiseSell");
						
						/*List<MCategory> mCategoryList;
						RestTemplate restTemplate = new RestTemplate();
						
						CategoryList categoryList = restTemplate.getForObject(Constant.URL + "showAllCategory",
								CategoryList.class);

						mCategoryList = categoryList.getmCategoryList();
						
						System.out.println("Category list  " +mCategoryList);
						List<MCategory> newMcategoryList=new ArrayList<MCategory>();
						for(int i=0;i<mCategoryList.size();i++)
						{
							if(mCategoryList.get(i).getCatId()!=5)
							{
								newMcategoryList.add(mCategoryList.get(i));
							}
						}
						System.out.println("New Category list  " +newMcategoryList);
						model.addObject("unSelectedCatList", newMcategoryList);*/
						return model;			
				}
				
				
				@RequestMapping(value = "/getMenuwiselReport", method = RequestMethod.GET)
				public @ResponseBody List<GetRepMenuwiseSellResponse> getMenuwisellReport(HttpServletRequest request,
					HttpServletResponse response) {
							
					
					System.out.println("in method");
					String fromDate=request.getParameter("fromDate");
					String toDate=request.getParameter("toDate");
					//String catId=request.getParameter("category");
					
					/*catId = catId.substring(1, catId.length() - 1);
					catId = catId.replaceAll("\"", "");*/
					
					HttpSession ses = request.getSession();
					Franchisee frDetails = (Franchisee) ses.getAttribute("frDetails");
						
								RestTemplate restTemplate = new RestTemplate();
								
					MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
					int frId=frDetails.getFrId();
					map.add("frId", frId);
					map.add("fromDate", fromDate);
					map.add("toDate", toDate);
					 
				 
				  getRepFrMenuwiseSellResponseList=new ArrayList<GetRepMenuwiseSellResponse>();
					try {
					  
					ParameterizedTypeReference<List<GetRepMenuwiseSellResponse>> typeRef = new ParameterizedTypeReference<List<GetRepMenuwiseSellResponse>>() {
					};
					ResponseEntity<List<GetRepMenuwiseSellResponse>> responseEntity = restTemplate.exchange(Constant.URL + "getRepMenuwiseSell",
							HttpMethod.POST, new HttpEntity<>(map), typeRef);
					
					getRepFrMenuwiseSellResponseList = responseEntity.getBody();	
					}
					catch (Exception e) {
						e.printStackTrace();
						System.out.println(e.getMessage());
					}
					
					
					
					
					 System.out.println("Sell Bill Header "+getRepFrMenuwiseSellResponseList.toString());
					
						
								
					
				
				return getRepFrMenuwiseSellResponseList;
				
				}
				
				@RequestMapping(value = "/getItemwiselReport", method = RequestMethod.GET)
				public @ResponseBody List<GetRepFrItemwiseSellResponse> getItemwisellReport(HttpServletRequest request,
					HttpServletResponse response) {
							
					
					System.out.println("in method");
					String fromDate=request.getParameter("fromDate");
					String toDate=request.getParameter("toDate");
					String catId=request.getParameter("category");
					
					/*catId = catId.substring(1, catId.length() - 1);
					catId = catId.replaceAll("\"", "");*/
					
					HttpSession ses = request.getSession();
					Franchisee frDetails = (Franchisee) ses.getAttribute("frDetails");
						
								RestTemplate restTemplate = new RestTemplate();
								
					MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
					int frId=frDetails.getFrId();
					map.add("frId", frId);
					map.add("fromDate", fromDate);
					map.add("toDate", toDate);
					map.add("catId", catId);
					System.out.println(catId);
				  getRepFrItemwiseSellResponseList=new ArrayList<GetRepFrItemwiseSellResponse>();
					try {
					  
					ParameterizedTypeReference<List<GetRepFrItemwiseSellResponse>> typeRef = new ParameterizedTypeReference<List<GetRepFrItemwiseSellResponse>>() {
					};
					ResponseEntity<List<GetRepFrItemwiseSellResponse>> responseEntity = restTemplate.exchange(Constant.URL + "getRepItemwiseSell",
							HttpMethod.POST, new HttpEntity<>(map), typeRef);
					
					getRepFrItemwiseSellResponseList = responseEntity.getBody();	
					}
					catch (Exception e) {
						e.printStackTrace();
						System.out.println(e.getMessage());
					}
					
					
					
					
					 System.out.println("Sell Bill Header "+getRepFrItemwiseSellResponseList.toString());
					
						
								
					
				
				return getRepFrItemwiseSellResponseList;
				
				}
				
				
				@RequestMapping(value = "/viewDateItemwiseSellBill", method = RequestMethod.GET)
				public ModelAndView viewDateItemwiseSellBill(HttpServletRequest request,
							HttpServletResponse response) {

						ModelAndView model = new ModelAndView("report/sellReport/repFrDateItemwiseSell");
						
						List<MCategory> mCategoryList;
						RestTemplate restTemplate = new RestTemplate();
						
						CategoryList categoryList = restTemplate.getForObject(Constant.URL + "showAllCategory",
								CategoryList.class);

						mCategoryList = categoryList.getmCategoryList();
						
						System.out.println("Category list  " +mCategoryList);
						List<MCategory> newMcategoryList=new ArrayList<MCategory>();
						for(int i=0;i<mCategoryList.size();i++)
						{
							if(mCategoryList.get(i).getCatId()!=5 )
							{
								newMcategoryList.add(mCategoryList.get(i));
							}
						}
						System.out.println("New Category list  " +newMcategoryList);
						model.addObject("unSelectedCatList", newMcategoryList);
						return model;			
				}
				
				@RequestMapping(value = "/getDateItemwiselReport", method = RequestMethod.GET)
				public @ResponseBody List<GetRepFrItemwiseSellResponse> getDateItemwiselReport(HttpServletRequest request,
					HttpServletResponse response) {
							
					
					System.out.println("in method");
					String fromDate=request.getParameter("fromDate");
					String toDate=request.getParameter("toDate");
					String catId=request.getParameter("category");
					
					/*catId = catId.substring(1, catId.length() - 1);
					catId = catId.replaceAll("\"", "");*/
					
					HttpSession ses = request.getSession();
					Franchisee frDetails = (Franchisee) ses.getAttribute("frDetails");
						
								RestTemplate restTemplate = new RestTemplate();
								
					MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
					int frId=frDetails.getFrId();
					map.add("frId", frId);
					map.add("fromDate", fromDate);
					map.add("toDate", toDate);
					map.add("catId", catId);
					System.out.println(catId);
				  getRepFrItemwiseSellResponseList=new ArrayList<GetRepFrItemwiseSellResponse>();
					try {
					  
					ParameterizedTypeReference<List<GetRepFrItemwiseSellResponse>> typeRef = new ParameterizedTypeReference<List<GetRepFrItemwiseSellResponse>>() {
					};
					ResponseEntity<List<GetRepFrItemwiseSellResponse>> responseEntity = restTemplate.exchange(Constant.URL + "getRepDateItemwiseSell",
							HttpMethod.POST, new HttpEntity<>(map), typeRef);
					
					getRepFrItemwiseSellResponseList = responseEntity.getBody();	
					}
					catch (Exception e) {
						e.printStackTrace();
						System.out.println(e.getMessage());
					}
					
					
					
					
					 System.out.println("Sell Bill Header "+getRepFrItemwiseSellResponseList.toString());
					
						
								
					
				
				return getRepFrItemwiseSellResponseList;
				
				}
				
				@RequestMapping(value = "/getDateCatwisellReport", method = RequestMethod.GET)
				public @ResponseBody List<GetRepFrItemwiseSellResponse> getDateCatwiselReport(HttpServletRequest request,
					HttpServletResponse response) {
							
					
					System.out.println("in method");
					String fromDate=request.getParameter("fromDate");
					String toDate=request.getParameter("toDate");
					String catId=request.getParameter("category");
					
					/*catId = catId.substring(1, catId.length() - 1);
					catId = catId.replaceAll("\"", "");*/
					
					HttpSession ses = request.getSession();
					Franchisee frDetails = (Franchisee) ses.getAttribute("frDetails");
						
								RestTemplate restTemplate = new RestTemplate();
								
					MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
					int frId=frDetails.getFrId();
					map.add("frId", frId);
					map.add("fromDate", fromDate);
					map.add("toDate", toDate);
					map.add("catId", catId);
					System.out.println(catId);
			  getRepFrItemwiseSellResponseList=new ArrayList<GetRepFrItemwiseSellResponse>();
					try {
					  
					ParameterizedTypeReference<List<GetRepFrItemwiseSellResponse>> typeRef = new ParameterizedTypeReference<List<GetRepFrItemwiseSellResponse>>() {
					};
					ResponseEntity<List<GetRepFrItemwiseSellResponse>> responseEntity = restTemplate.exchange(Constant.URL + "getRepDateCatwiseSell",
							HttpMethod.POST, new HttpEntity<>(map), typeRef);
					
					getRepFrItemwiseSellResponseList = responseEntity.getBody();	
					}
					catch (Exception e) {
						e.printStackTrace();
						System.out.println(e.getMessage());
					}
					
					
					
					
					 System.out.println("Sell Bill Header "+getRepFrItemwiseSellResponseList.toString());
					
						
								
					
				
				return getRepFrItemwiseSellResponseList;
				
				}
				
				@RequestMapping(value = "/viewFrTaxSellBill", method = RequestMethod.GET)
				public ModelAndView viewFrTaxSellBill(HttpServletRequest request,
							HttpServletResponse response) {

						ModelAndView model = new ModelAndView("report/sellReport/repFrTaxSell");
						return model;			
				}
				
				@RequestMapping(value = "/getTaxSellReport", method = RequestMethod.GET)
				public @ResponseBody List<GetRepTaxSell> getFrTaxSellBill(HttpServletRequest request,
					HttpServletResponse response) {
							
					
					System.out.println("in method");
					String fromDate=request.getParameter("fromDate");
					String toDate=request.getParameter("toDate");
					
					HttpSession ses = request.getSession();
					Franchisee frDetails = (Franchisee) ses.getAttribute("frDetails");
						
								RestTemplate restTemplate = new RestTemplate();
								
					MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
					int frId=frDetails.getFrId();
					map.add("frId", frId);
					map.add("fromDate", fromDate);
					map.add("toDate", toDate);
				  getRepTaxSell=new ArrayList<GetRepTaxSell>();
					getRepTaxSell=new ArrayList<GetRepTaxSell>();
					try {
					  
					ParameterizedTypeReference<List<GetRepTaxSell>> typeRef = new ParameterizedTypeReference<List<GetRepTaxSell>>() {
					};
					ResponseEntity<List<GetRepTaxSell>> responseEntity = restTemplate.exchange(Constant.URL + "getRepTaxSell",
							HttpMethod.POST, new HttpEntity<>(map), typeRef);
					
					getRepTaxSell = responseEntity.getBody();	
					}
					catch (Exception e) {
						e.printStackTrace();
						System.out.println(e.getMessage());
					}
					
					
					
					
					 System.out.println("Sell Bill Header "+getRepTaxSell.toString());
					
						
								
					
				
				return getRepTaxSell;
				
				}
				
				@RequestMapping(value = "/viewFrBillwiseTaxSellBill", method = RequestMethod.GET)
				public ModelAndView viewFrBillwiseTaxSellBill(HttpServletRequest request,
							HttpServletResponse response) {

						ModelAndView model = new ModelAndView("report/sellReport/repFrBillwiseTaxSell");
						return model;			
				}
				
				
				@RequestMapping(value = "/getBillwiseTaxSellReport", method = RequestMethod.GET)
				public @ResponseBody List<GetRepTaxSell> getFrBillwiseTaxSellBill(HttpServletRequest request,
					HttpServletResponse response) {
							
					
					System.out.println("in method");
					String fromDate=request.getParameter("fromDate");
					String toDate=request.getParameter("toDate");
					
					HttpSession ses = request.getSession();
					Franchisee frDetails = (Franchisee) ses.getAttribute("frDetails");
						
								RestTemplate restTemplate = new RestTemplate();
								
					MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
					int frId=frDetails.getFrId();
					map.add("frId", frId);
					map.add("fromDate", fromDate);
					map.add("toDate", toDate);
					//getFrGrnDetail
					System.out.println(frId + fromDate +toDate);
				  getRepTaxSell=new ArrayList<GetRepTaxSell>();
					try {
					  
					ParameterizedTypeReference<List<GetRepTaxSell>> typeRef = new ParameterizedTypeReference<List<GetRepTaxSell>>() {
					};
					ResponseEntity<List<GetRepTaxSell>> responseEntity = restTemplate.exchange(Constant.URL + "getRepBillwiseTaxSell",
							HttpMethod.POST, new HttpEntity<>(map), typeRef);
					
					getRepTaxSell = responseEntity.getBody();	
					}
					catch (Exception e) {
						e.printStackTrace();
						System.out.println(e.getMessage());
					}
							
					 System.out.println("Sell Bill Header "+getRepTaxSell.toString());
					
				return getRepTaxSell;
				
				}
				
				@RequestMapping(value = "/viewFrDatewiseTaxSellBill", method = RequestMethod.GET)
				public ModelAndView viewFrDatewiseTaxSellBill(HttpServletRequest request,
							HttpServletResponse response) {

						ModelAndView model = new ModelAndView("report/sellReport/repFrDatewiseTaxSell");
						return model;			
				}
				
				@RequestMapping(value = "/getDatewiseTaxSellReport", method = RequestMethod.GET)
				public @ResponseBody List<GetRepTaxSell> getFrDatewiseTaxSellBill(HttpServletRequest request,
					HttpServletResponse response) {
							
					
					System.out.println("in method");
					String fromDate=request.getParameter("fromDate");
					String toDate=request.getParameter("toDate");
					
					HttpSession ses = request.getSession();
					Franchisee frDetails = (Franchisee) ses.getAttribute("frDetails");
						
								RestTemplate restTemplate = new RestTemplate();
								
					MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
					int frId=frDetails.getFrId();
					map.add("frId", frId);
					map.add("fromDate", fromDate);
					map.add("toDate", toDate);
					  getRepTaxSell=new ArrayList<GetRepTaxSell>();
					try {
					  
					ParameterizedTypeReference<List<GetRepTaxSell>> typeRef = new ParameterizedTypeReference<List<GetRepTaxSell>>() {
					};
					ResponseEntity<List<GetRepTaxSell>> responseEntity = restTemplate.exchange(Constant.URL + "getRepDatewiseTaxSell",
							HttpMethod.POST, new HttpEntity<>(map), typeRef);
					
					getRepTaxSell = responseEntity.getBody();	
					}
					catch (Exception e) {
						e.printStackTrace();
						System.out.println(e.getMessage());
					}
							
					 System.out.println("Sell Bill Header "+getRepTaxSell.toString());
					
				return getRepTaxSell;
				
				}
				
				//Sell report End
				/*
				@RequestMapping(value = "/view1Chart", method = RequestMethod.GET)
				public ModelAndView viewChart(HttpServletRequest request,
							HttpServletResponse response) {

						ModelAndView model = new ModelAndView("report/sellReport/datewiseChart");
						model.addObject("msg", "hhhh");
						return model;			
				}*/
				
				
				//Report PDF Begins
				
				@RequestMapping(value = "/showSellDatewiseReportpPdf", method = RequestMethod.GET)
				public ModelAndView showSellDatewiseReportpPdf(HttpServletRequest request,
						HttpServletResponse response) {
					
					ModelAndView model=new ModelAndView("report/sellReport/sellReportPdf/repFrSellDatewisePdf");
					model.addObject("reportList", getRepFrDatewiseSellResponse);
					return model;
				}
				
				@RequestMapping(value = "/showSellMonthwiseReportpPdf", method = RequestMethod.GET)
				public ModelAndView showSellMonthwiseReportpPdf(HttpServletRequest request,
						HttpServletResponse response) {
					
					ModelAndView model=new ModelAndView("report/sellReport/sellReportPdf/repFrMonthwiseSellPdf");
					String month[]= {"0","Jan","Feb","Mar","April","May","Jun","July","Aug","Sep","Oct","Nov","Dec"};
					model.addObject("reportList", getRepFrDatewiseSellResponse);
					model.addObject("month", month);
					return model;
				}
				
				@RequestMapping(value = "/showSellItemwiseReportpPdf", method = RequestMethod.GET)
				public ModelAndView showSellItemwiseReportpPdf(HttpServletRequest request,
						HttpServletResponse response) {
					
					ModelAndView model=new ModelAndView("report/sellReport/sellReportPdf/repFrItemwiseSellPdf");
					model.addObject("reportList", getRepFrItemwiseSellResponseList);
					return model;
				}
				
				@RequestMapping(value = "/showSellDateItemwisewiseReportpPdf", method = RequestMethod.GET)
				public ModelAndView showSellDateItemwisewiseReportpPdf(HttpServletRequest request,
						HttpServletResponse response) {
					
					ModelAndView model=new ModelAndView("report/sellReport/sellReportPdf/repFrDateItemwiseSellPdf");
					model.addObject("reportList", getRepFrItemwiseSellResponseList);
					return model;
				}
				
				@RequestMapping(value = "/showSellBillwiseReportpPdf", method = RequestMethod.GET)
				public ModelAndView showSellBillwiseReportpPdf(HttpServletRequest request,
						HttpServletResponse response) {
					
					ModelAndView model=new ModelAndView("report/sellReport/sellReportPdf/repFrSellBillwiseSellPdf");
					model.addObject("reportList", getSellBillHeaderList);
					return model;
				}
				
				@RequestMapping(value = "/showSellTaxReportpPdf", method = RequestMethod.GET)
				public ModelAndView showSellTaxReportpPdf(HttpServletRequest request,
						HttpServletResponse response) {
					
					ModelAndView model=new ModelAndView("report/sellReport/sellReportPdf/repFrTaxSellPdf");
					model.addObject("reportList", getRepTaxSell);
					return model;
				}
				
				@RequestMapping(value = "/showSellTaxDatewiseReportpPdf", method = RequestMethod.GET)
				public ModelAndView showSellTaxDatewiseReportpPdf(HttpServletRequest request,
						HttpServletResponse response) {
					
					ModelAndView model=new ModelAndView("report/sellReport/sellReportPdf/repFrDatewiseTaxSellPdf");
					model.addObject("reportList", getRepTaxSell);
					return model;
				}
				
				@RequestMapping(value = "/showSellTaxBillwiseReportpPdf", method = RequestMethod.GET)
				public ModelAndView showSellTaxBillwiseReportpPdf(HttpServletRequest request,
						HttpServletResponse response) {
					
					ModelAndView model=new ModelAndView("report/sellReport/sellReportPdf/repFrBillwiseTaxSellPdf");
					model.addObject("reportList", getRepTaxSell);
					return model;
				}
				
				@RequestMapping(value = "/showPurchaseTaxBillwiseReportPdf", method = RequestMethod.GET)
				public ModelAndView showPurchaseTaxBillwiseReportpPdf(HttpServletRequest request,
						HttpServletResponse response) {
					
					ModelAndView model=new ModelAndView("report/purchaseReport/purchaseReportPdf/billWiseTaxReportPdf");
					model.addObject("reportList", billWiseTaxReport);
					return model;
				}
				@RequestMapping(value = "/showPurchaseMonthwiseReportPdf", method = RequestMethod.GET)
				public ModelAndView showPurchaseMonthwiseReportpPdf(HttpServletRequest request,
						HttpServletResponse response) {
					
					ModelAndView model=new ModelAndView("report/purchaseReport/purchaseReportPdf/monthWisePurchasePdf");
						String month[]= {"0","Jan","Feb","Mar","April","May","Jun","July","Aug","Sep","Oct","Nov","Dec"};
					
					model.addObject("month", month);
					model.addObject("reportList", monthWiseReportList);
					return model;
				}
				@RequestMapping(value = "/showPurchaseItemwiseReportpPdf", method = RequestMethod.GET)
				public ModelAndView showPurchaseItemwiseReportpPdf(HttpServletRequest request,
						HttpServletResponse response) {
					
					ModelAndView model=new ModelAndView("report/purchaseReport/purchaseReportPdf/itemWiseReportPdf");
					model.addObject("reportList", itemWiseReportList);
					return model;
				}
				@RequestMapping(value = "/showPurchaseItemwiseDetailPdf", method = RequestMethod.GET)
				public ModelAndView showPurchaseItemwiseDetailpPdf(HttpServletRequest request,
						HttpServletResponse response) {
					
					ModelAndView model=new ModelAndView("report/purchaseReport/purchaseReportPdf/itemWiseDetailPdf");
					model.addObject("reportList", itemWiseDetailReportList);
					return model;
				}
				@RequestMapping(value = "/showPurchaseBillwiseReportPdf", method = RequestMethod.GET)
				public ModelAndView showPurchaseBillwiseReportPdf(HttpServletRequest request,
						HttpServletResponse response) {
					
					ModelAndView model=new ModelAndView("report/purchaseReport/purchaseReportPdf/billWisePurchaseReportPdf");
					model.addObject("reportList", billWisePurchaseReportList);
					return model;
				}  
				
				
				private Dimension format = PD4Constants.A4;
				private boolean landscapeValue = false;
				private int topValue = 0;
				private int leftValue = 0;
				private int rightValue = 0;
				private int bottomValue = 0;
				private String unitsValue = "m";
				private String proxyHost = "";
				private int proxyPort = 0;

				private int userSpaceWidth = 750;
				private static  int BUFFER_SIZE = 1024;
				
				@RequestMapping(value = "/pdf", method = RequestMethod.GET)
				public void showPDF(HttpServletRequest request, HttpServletResponse response) {

					String url=request.getParameter("reportURL");
					// http://monginis.ap-south-1.elasticbeanstalk.com
					File f = new File("/ordermemo221.pdf");

					try {
						runConverter(Constant.ReportURL+url, f);
					} catch (IOException e) {
						// TODO Auto-generated catch block

						System.out.println("Pdf conversion exception " + e.getMessage());
					}

					// get absolute path of the application
					ServletContext context = request.getSession().getServletContext();
					String appPath = context.getRealPath("");
					String filename = "ordermemo221.pdf";
					String filePath = "/ordermemo221.pdf";

					// construct the complete absolute path of the file
					String fullPath = appPath + filePath;
					File downloadFile = new File(filePath);
					FileInputStream inputStream = null;
					try {
						inputStream = new FileInputStream(downloadFile);
					} catch (FileNotFoundException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					try {
						// get MIME type of the file
						String mimeType = context.getMimeType(fullPath);
						if (mimeType == null) {
							// set to binary type if MIME mapping not found
							mimeType = "application/pdf";
						}
						System.out.println("MIME type: " + mimeType);

						String headerKey = "Content-Disposition";

						// response.addHeader("Content-Disposition", "attachment;filename=report.pdf");
						response.setContentType("application/pdf");

						// get output stream of the response
						OutputStream outStream;

						outStream = response.getOutputStream();

						byte[] buffer = new byte[BUFFER_SIZE];
						int bytesRead = -1;

						// write bytes read from the input stream into the output stream

						while ((bytesRead = inputStream.read(buffer)) != -1) {
							outStream.write(buffer, 0, bytesRead);
						}

						inputStream.close();
						outStream.close();

					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}

				private void runConverter(String urlstring, File output) throws IOException {

					if (urlstring.length() > 0) {
						if (!urlstring.startsWith("http://") && !urlstring.startsWith("file:")) {
							urlstring = "http://" + urlstring;
						}

						java.io.FileOutputStream fos = new java.io.FileOutputStream(output);

						if (proxyHost != null && proxyHost.length() != 0 && proxyPort != 0) {
							System.getProperties().setProperty("proxySet", "true");
							System.getProperties().setProperty("proxyHost", proxyHost);
							System.getProperties().setProperty("proxyPort", "" + proxyPort);
						}

						PD4ML pd4ml = new PD4ML();

						try {
							pd4ml.setPageSize(landscapeValue ? pd4ml.changePageOrientation(format) : format);
						} catch (Exception e) {
							System.out.println("Pdf conversion ethod excep " + e.getMessage());
						}

						if (unitsValue.equals("mm")) {
							pd4ml.setPageInsetsMM(new Insets(topValue, leftValue, bottomValue, rightValue));
						} else {
							pd4ml.setPageInsets(new Insets(topValue, leftValue, bottomValue, rightValue));
						}

						pd4ml.setHtmlWidth(userSpaceWidth);

						pd4ml.render(urlstring, fos);
					}
				}
}
