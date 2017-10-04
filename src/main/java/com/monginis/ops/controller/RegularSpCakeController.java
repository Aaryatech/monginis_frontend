package com.monginis.ops.controller;



import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalTime;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.monginis.ops.constant.Constant;
import com.monginis.ops.model.SubCategoryResponse;
import com.monginis.ops.util.ImageS3Util;
import com.monginis.ops.model.ErrorMessage;
import com.monginis.ops.model.EventList;
import com.monginis.ops.model.Flavour;
import com.monginis.ops.model.FrMenu;
import com.monginis.ops.model.Franchisee;
import com.monginis.ops.model.GetRegularSpCkItem;
import com.monginis.ops.model.MCategory;
import com.monginis.ops.model.Main;
import com.monginis.ops.model.RegularSpCake;
import com.monginis.ops.model.RegularSpCkItemResponse;
import com.monginis.ops.model.SubCategory;
   
@Controller
public class RegularSpCakeController {
	
	private static final Logger logger = LoggerFactory.getLogger(ItemController.class);
	EventList eventList;
	ArrayList<FrMenu> menuList;
	private static int currentMenuId = 0;
	private static int globalIndex = 2;
	String itemShow;
	 List<MCategory>  mCategories;
	
	 RegularSpCkItemResponse regularSpCkItemList;
	String spImage = "0463a490-b678-46d7-b31d-d7d6bae5c954-ats.png";//Default Image to spCake order Page
   //--------------------------Show Regular Special Cake Order Page--------------------------------------
		@RequestMapping(value = "/showRegularSpCakeOrder/{index}", method = RequestMethod.GET)
		public ModelAndView displayregularSpCakeOrder(@PathVariable("index") int index,HttpServletRequest request,
				HttpServletResponse response) {
			
			logger.info("/regularSpCkOrder  request mapping");

			ModelAndView model = new ModelAndView("order/regularSpCkOrder");
			HttpSession session = request.getSession();
			
			
			RestTemplate restTemplate = new RestTemplate();
	         try {
	        	     menuList = (ArrayList<FrMenu>) session.getAttribute("menuList");

	 			    currentMenuId = menuList.get(index).getMenuId();
	 			    System.out.println("MenuList" + currentMenuId);
	 			    globalIndex = index;
	 			    
	 			   Franchisee frDetails = (Franchisee) session.getAttribute("frDetails");
	 				itemShow = menuList.get(globalIndex).getItemShow();
	 				
				    logger.info("/ITEMSHOW"+itemShow);

	 				
	 		/*		MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
	 				map.add("frId", frDetails.getFrId());
	 				map.add("menuId",currentMenuId);
	 				map.add("items",itemShow);
	 		           System.out.println(itemShow);

	 				
	 		       String[] configuredSpCodeArr = restTemplate.postForObject(Constant.URL + "/searchSpCodes",
	 		    		   map,String[].class);*/

	        	    MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
				    map.add("catId",2);
		
				    SubCategoryResponse categoryResponse = restTemplate.postForObject(Constant.URL + "/getSubCategories",
		    		             map,SubCategoryResponse.class);
				    logger.info("/regularSpCkOrder  request mapping"+categoryResponse.toString());
              
				
	                EventList eventList = restTemplate.getForObject(Constant.URL + "/showEventList", EventList.class);
			        logger.info("/regularSpCkOrder Event List"+eventList.toString());
		
			        mCategories=categoryResponse.getmCategoryList();
			        List<SubCategory> subCategories = new ArrayList<SubCategory>();
				     for(MCategory  mCategory:mCategories)
				     {
				    	 subCategories=mCategory.getSubCategory();
				     }
			        
				    model.addObject("frDetails",frDetails);
			        
				    model.addObject("eventList", eventList);
			
				    model.addObject("categoryResponse", subCategories);
				     
				  //  model.addObject("frDetails",frDetails);

				  
				    model.addObject("url", Constant.SPCAKE_IMAGE_URL);

			} catch (Exception e) {
				/*System.out.println("Show Sp Cake List Excep: " + e.getMessage());
				model.addObject("menuList", menuList);
				model.addObject("specialCakeList", specialCakeList);
				model.addObject("eventList", eventList);
				model.addObject("flavourList", flavourList);
				model.addObject("spBookb4", 0);
				model.addObject("configuredSpCodeList", configuredSpCodeList);
				// model.addObject("spImage", specialCake.getSpImage());
				model.addObject("url", Constant.SPCAKE_IMAGE_URL);*/
				
			   //  model.addObject("frDetails",frDetails);

				//logger.e
				
			}

			return model;
		}
	    //-----------------------------------END-----------------------------------------

		 //-------------------------GET ALL Regular Cakes(AJAX METHOD)-------------------------
		@RequestMapping(value = "/getAllRegularSpCk", method = RequestMethod.GET)
		public @ResponseBody List<GetRegularSpCkItem> getAllItems(@RequestParam(value = "regular_sp_cake", required = true) int subCatId) {

			List<GetRegularSpCkItem> regularSpCkItems=new ArrayList<GetRegularSpCkItem>();
			 RestTemplate restTemplate = new RestTemplate();
			try {
			 MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
		     map.add("itemGrp2", subCatId);
		     map.add("items", itemShow);

		   regularSpCkItemList=restTemplate.postForObject(Constant.URL + "getRegularSpCkItems",map,RegularSpCkItemResponse.class);
		     
		    regularSpCkItems=regularSpCkItemList.getGetRegularSpCkItems();

		     
		    logger.info("AJAXITEMSHOW"+itemShow);

		    logger.info("regularSpCkItems"+regularSpCkItems.toString());
			}
			catch(Exception e)
			{
	           	 logger.error("EXC");
			
		}
		//----------------------------------------END--------------------------------------------

			return regularSpCkItems;

	
	
		}
		 //-------------------------GET ALL Regular Cakes(AJAX METHOD)-------------------------
		@RequestMapping(value = "/getSpecialCkById", method = RequestMethod.GET)
		public @ResponseBody GetRegularSpCkItem getSpecialCkById(@RequestParam(value = "itemCategories", required = true) int id) {
			
			List<GetRegularSpCkItem> regularSpCkItems=new ArrayList<GetRegularSpCkItem>();
		    regularSpCkItems=regularSpCkItemList.getGetRegularSpCkItems();
		    GetRegularSpCkItem getRegularSpCkItem=new GetRegularSpCkItem();

		     for(GetRegularSpCkItem regularSpCkItem:regularSpCkItems)
		     {
		    	 if(regularSpCkItem.getId()==id)
		    	 {
		    		 getRegularSpCkItem=regularSpCkItem;
		    	 }
		     

		
		}
				return getRegularSpCkItem;
		}
		
		  //------------------------Order Regular Special Cake Process----------------------------
		@RequestMapping(value = "/orderRegularSpCake", method = RequestMethod.POST)
		public ModelAndView orderRegularSpCake(HttpServletRequest request, HttpServletResponse response) throws JsonProcessingException, ParseException {

			ModelAndView mav;
			HttpSession session = request.getSession();

			Franchisee frDetails = (Franchisee) session.getAttribute("frDetails");
	      
			ArrayList<FrMenu> menuList = (ArrayList<FrMenu>) session.getAttribute("menuList");
			
	
				
			int rspSubCat = Integer.parseInt(request.getParameter("regular_sp_cake"));
			System.out.println("1" + rspSubCat);
			
			
			int itemId = Integer.parseInt(request.getParameter("regSpCkItem"));
			System.out.println("2" + itemId);
			

			String spName = request.getParameter("rg_sp_name");
			//System.out.println("3" + spName);
			
			
			/* * String orderPhoto1=request.getParameter("order_photo");
			 * System.out.println("4" + orderPhoto);
			 */

			String rspEvents = request.getParameter("sp_event");
			System.out.println("7" + rspEvents);

			
			String rspDeliveryDt = request.getParameter("datepicker");
			System.out.println("8" + rspDeliveryDt);
            String convertedDelDate=Main.formatDate(rspDeliveryDt);               
		
			String spCustDOB = request.getParameter("datepicker2");
			System.out.println("9" + spCustDOB);

			String rspCustMobileNo = request.getParameter("sp_cust_mobile_no");
			System.out.println("10" + rspCustMobileNo);

			String rspCustName = request.getParameter("sp_cust_name");
			System.out.println("11" + rspCustName);

		
			float rgCkGrand = Float.parseFloat(request.getParameter("sp_grand"));
			System.out.println("12" + rgCkGrand);

			float rgCkPrice = Float.parseFloat(request.getParameter("sp_calc_price"));
			System.out.println("13" + rgCkPrice);

		
			float rspSubTotal = Float.parseFloat(request.getParameter("sp_sub_total"));
			System.out.println("14" + rspSubTotal);

			float tax = Float.parseFloat(request.getParameter("t3"));
			System.out.println("15" + tax);

			

			float rspRemainingAmt = Float.parseFloat(request.getParameter("rm_amount"));
			System.out.println("16" + rspRemainingAmt);

			float rspAdvanceAmt = Float.parseFloat(request.getParameter("adv"));
			System.out.println("16" + rspAdvanceAmt);

			String spPlace = request.getParameter("sp_place");
			System.out.println("17" + spPlace);

			String rspEventsName = request.getParameter("event_name");
			System.out.println("18" + rspEventsName);

			
			float gstRs = Float.parseFloat(request.getParameter("gst_rs"));
			System.out.println("19" + gstRs);

			float rgGstAmount = Float.parseFloat(request.getParameter("m_gst_amt"));
			System.out.println("20" + rgGstAmount);

			float totalAmt = Float.parseFloat(request.getParameter("total_amt"));
			System.out.println("21" + totalAmt);

			int qty= Integer.parseInt(request.getParameter("sp_qty"));
			System.out.println("22" + qty);

			
			RegularSpCake regularSpCakeOrder = new RegularSpCake();
			

			// -----Order Date And Production Date------

			final SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			Date currentDate = new Date();

			// convert date to calendar
			Calendar c = Calendar.getInstance();
			c.setTime(currentDate);

			// Current Date
			Date orderDate = c.getTime();

		
			Date calOrderDate = c.getTime();
			
			String convertedOrderDate = dateFormat.format(calOrderDate);
			System.out.println("Todays date is: " + calOrderDate);
			// -------------------------------------------
			Date newProdDate=dateFormat.parse(convertedOrderDate);
			Calendar cal = Calendar.getInstance();
			cal.setTime (newProdDate); // convert your date to Calendar object
			int daysToDecrement = -1;
			cal.add(Calendar.DATE, daysToDecrement);
			 Date  produDate = cal.getTime();
			 System.out.println("production Date:"+produDate);
		    // String rspProduDate=dateFormat.format(produDate);
			//---------------------------------------------
			
			regularSpCakeOrder.setFrCode(frDetails.getFrCode());
			regularSpCakeOrder.setMenuId(currentMenuId);

			regularSpCakeOrder.setFrId(frDetails.getFrId());
			
			regularSpCakeOrder.setItemId(itemId);
			regularSpCakeOrder.setMenuId(currentMenuId);
			regularSpCakeOrder.setMrp(rgCkGrand);
			regularSpCakeOrder.setQty(qty);
			regularSpCakeOrder.setRateCat(frDetails.getFrRateCat());

			regularSpCakeOrder.setRspAdvanceAmt(rspAdvanceAmt);
			regularSpCakeOrder.setRspCustMobileNo(rspCustMobileNo);
			regularSpCakeOrder.setRspCustName(rspCustName);
			regularSpCakeOrder.setRspDeliveryDt(convertedDelDate);
			regularSpCakeOrder.setOrderDate(calOrderDate);
			regularSpCakeOrder.setRspEvents(rspEvents);
			regularSpCakeOrder.setRspSubCat(rspSubCat);
			regularSpCakeOrder.setRspSubTotal(rspSubTotal);
			regularSpCakeOrder.setRspRemainingAmt(rspRemainingAmt);
			regularSpCakeOrder.setTax1(tax/2);
			regularSpCakeOrder.setTax1Amt(gstRs/2);
			regularSpCakeOrder.setTax2(tax/2);
			regularSpCakeOrder.setTax2Amt(gstRs/2);
			regularSpCakeOrder.setRate(totalAmt);
			regularSpCakeOrder.setRspEventsName(rspEventsName);
			regularSpCakeOrder.setRspProduDate(produDate);
			

				HttpHeaders httpHeaders = new HttpHeaders();
				httpHeaders.set("Content-Type", "application/json");

				ObjectMapper mapper = new ObjectMapper();
				String jsonInString = mapper.writeValueAsString(regularSpCakeOrder);
				System.out.println("All Sp Order Data" + jsonInString.toString());

				HttpEntity<String> httpEntity = new HttpEntity<String>(jsonInString.toString(), httpHeaders);
				  try {
				RestTemplate restTemplate = new RestTemplate();
				ErrorMessage errorMessage= restTemplate.postForObject(Constant.URL + "/insertRegularSpCake", httpEntity,
						ErrorMessage.class);

		         mav = new ModelAndView("order/regularSpOrderRes");

			     

			

				mav.addObject("rspEvents", rspEvents);
				mav.addObject("rspEventsName", rspEventsName);
				mav.addObject("qty", qty);
				mav.addObject("URL", Constant.SPCAKE_IMAGE_URL);

				mav.addObject("rspDeliveryDt", rspDeliveryDt);
				mav.addObject("rspCustName", rspCustName);
				mav.addObject("rspCustMobileNo", rspCustMobileNo);
				mav.addObject("rspCustMobileNo", rspCustMobileNo);
				mav.addObject("rgCkPrice", rgCkPrice);
				mav.addObject("rgCkGrand", rgCkGrand);
				mav.addObject("rspSubTotal", rspSubTotal);
				mav.addObject("tax", tax);
				mav.addObject("gstRs", gstRs);
				mav.addObject("totalAmt", totalAmt);
				mav.addObject("rspAdvanceAmt", rspAdvanceAmt);
				mav.addObject("rspRemainingAmt", rspRemainingAmt);
				mav.addObject("spPlace",spPlace);
				mav.addObject("spCustDOB",spCustDOB);
				mav.addObject("spName",spName);
				mav.addObject("rspName","");
				mav.addObject("rgGstAmount",rgGstAmount);
			//	mav.addObject("url", Constant.SPCAKE_IMAGE_URL);


			} catch (Exception e) {
				 mav = new ModelAndView("order/regularSpOrderRes");
				 mav.addObject("rspEvents", rspEvents);
					mav.addObject("rspEventsName", rspEventsName);
					mav.addObject("qty", qty);
					mav.addObject("URL", Constant.SPCAKE_IMAGE_URL);

					mav.addObject("convertedDelDate", convertedDelDate);
					mav.addObject("rspCustName", rspCustName);
					mav.addObject("rspCustMobileNo", rspCustMobileNo);
					mav.addObject("rspCustMobileNo", rspCustMobileNo);
					mav.addObject("rgCkPrice", rgCkPrice);
					mav.addObject("rgCkGrand", rgCkGrand);
					mav.addObject("rspSubTotal", rspSubTotal);
					mav.addObject("tax", tax);
					mav.addObject("gstRs", gstRs);
					mav.addObject("totalAmt", totalAmt);
					mav.addObject("rspAdvanceAmt", rspAdvanceAmt);
					mav.addObject("rspRemainingAmt", rspRemainingAmt);
					mav.addObject("spPlace",spPlace);
					mav.addObject("spCustDOB",spCustDOB);
					mav.addObject("spName",spName);
					mav.addObject("rspName","");
					mav.addObject("rgGstAmount",rgGstAmount);
				System.out.println("Exc" + e.getMessage());
				

			}
		
			return mav;

		}
		  //----------------------------------END----------------------------------------
		

}
