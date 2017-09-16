package com.monginis.ops.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.monginis.ops.constant.Constant;
import com.monginis.ops.model.ErrorMessage;
//import com.ats.adminpanel.commons.Constants;
//import com.ats.adminpanel.model.modules.ErrorMessage;
import com.monginis.ops.model.EventList;
import com.monginis.ops.model.Flavour;
import com.monginis.ops.model.FlavourList;
import com.monginis.ops.model.SpCakeOrder;
import com.monginis.ops.model.SpCakeOrderRes;
import com.monginis.ops.model.SpCakeResponse;
import com.monginis.ops.model.SpecialCake;
import com.monginis.ops.model.Type;

@Controller
public class SpCakeController {
	FlavourList flavourList;
	EventList eventList;
	ArrayList<String> menuList;
	List<SpecialCake> specialCakeList;
	String spImage="0463a490-b678-46d7-b31d-d7d6bae5c954-ats.png";
	String url="http://monginisaurangabad.com/uploads/mongiImage/SpecialCake/";
	@RequestMapping(value = "/showSpCakeOrder", method = RequestMethod.GET)

	public ModelAndView displaySpCakeOrder(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("order/spcakeorder");
		HttpSession session = request.getSession();
		RestTemplate restTemplate = new RestTemplate();
		
		
		try {
			 menuList = (ArrayList<String>) session.getAttribute("menuList");
			SpCakeResponse spCakeResponse = restTemplate
					.getForObject(Constant.URL+"/showSpecialCakeList", SpCakeResponse.class);
			System.out.println("SpCake Controller SpCakeList Response " + spCakeResponse.toString());
			
			flavourList=restTemplate
					.getForObject(Constant.URL+"/showFlavourList", FlavourList.class);
			System.out.println("flavour Controller flavourList Response " + flavourList.toString());
			
	        eventList=restTemplate
					.getForObject(Constant.URL+"/showEventList", EventList.class);
			System.out.println("Event Controller EventList Response " + eventList.toString());
			
			
			specialCakeList=new  ArrayList<SpecialCake>();
			
			specialCakeList=spCakeResponse.getSpecialCake();
			System.out.println("Special Cake List:"+specialCakeList.toString());
			model.addObject("menuList", menuList);			
			model.addObject("specialCakeList", specialCakeList);
			model.addObject("eventList", eventList);			
			model.addObject("flavourList", flavourList);		
			model.addObject("spBookb4",0);
			model.addObject("spImage" ,spImage);
			model.addObject("url", url);
			
		} catch (Exception e) {
			System.out.println("Show Sp Cake List Excep: " + e.getMessage());
		}	
		
		return model;
	}
	
	@RequestMapping(value="/searchSpCake",method=RequestMethod.POST)
	public ModelAndView searchSpCakeBySpCode(HttpServletRequest request, HttpServletResponse response) {
        String spCode=request.getParameter("sp_code");
		ModelAndView model = new ModelAndView("order/spcakeorder");
		
	
			
	
		RestTemplate restTemplate = new RestTemplate();
	      MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
	      map.add("spCode",spCode);
		try {
			SpecialCake specialCake = restTemplate
					.postForObject(Constant.URL+"/searchSpecialCake",map,SpecialCake.class);
			if(specialCake!=null) {
				
		    spImage=specialCake.getSpImage();
				
			System.out.println("Sp RESPONSE"+specialCake.toString());
			model.addObject("specialCake", specialCake);			
		    model.addObject("eventList",eventList);
		    int spBookb4=Integer.parseInt(specialCake.getSpBookb4());
		    System.out.println("spBookb4"+spBookb4);
		    model.addObject("spBookb4",spBookb4);		
			}
			else
			{
				model = new ModelAndView("order/spcakeorder");
			}
		} catch (Exception e) {
			model = new ModelAndView("order/spcakeorder");
			System.out.println("search  Sp Cake  Excep: " + e.getMessage());
		}	
		model.addObject("menuList", menuList);			
		model.addObject("specialCakeList", specialCakeList);
		model.addObject("eventList", eventList);			
		model.addObject("flavourList", flavourList);		
		model.addObject("url", url);

		model.addObject("spImage", spImage);

		return model;
	}
		
	@RequestMapping(value = "/getFlavourBySpfId", method = RequestMethod.GET)
	public @ResponseBody
	List<Flavour> flavourById(
			@RequestParam(value = "spType", required = true) int spType) {
		
		
		System.out.println("SpType:: "+spType );

		List<Flavour> flavoursList=new ArrayList<Flavour>();
		List<Flavour> filterFlavoursList=new ArrayList<Flavour>();

		flavoursList=flavourList.getFlavour();
		
	System.out.println("DB Sptype"+flavoursList.get(0).getSpType());
		
		for(int i=0;i<flavoursList.size();i++) {
			
			if(flavoursList.get(i).getSpType()==spType) {
				filterFlavoursList.add(flavoursList.get(i));
				
			}
		}
		System.out.println("Filter Item List " + filterFlavoursList.toString());

		
		
		return filterFlavoursList;
	}
	
	
	
	@RequestMapping(value = "/getAddOnRate", method = RequestMethod.GET)
	public @ResponseBody Flavour getAddOnRate(@RequestParam(value = "spfId", required = true) double spfId){
		List<Flavour> flavoursList=new ArrayList<Flavour>();
		Flavour filteredFlavour=new Flavour();
		flavoursList=flavourList.getFlavour();
		
           for(Flavour flavour:flavoursList) {
			
			if(flavour.getSpfId()==spfId) {
			
				filteredFlavour=flavour;
			}
		}
	
	
		return  filteredFlavour;
	}
	@RequestMapping(value = "/orderSpCake",method = RequestMethod.POST)
	public    ModelAndView addItemProcess(HttpServletRequest request, HttpServletResponse response) throws JsonProcessingException
	{
		ModelAndView mav = new ModelAndView("order/orderRes");
		
		//String frCode=request.getParameter("fr_code");
		System.out.println("Inside Order Sp");
		
	    int spId=Integer.parseInt(request.getParameter("sp_id"));
		System.out.println("1"+spId);
		String spCode=request.getParameter("sp_code");
		System.out.println("2"+spCode);

		String spName=request.getParameter("sp_name");
		System.out.println("3"+spName);

	   // String orderPhoto=request.getParameter("sp_image");
		//System.out.println("4"+orderPhoto);

		String spMinWeight=request.getParameter("sp_min_weight");
		System.out.println("5"+spMinWeight);

		String spMaxWeight=request.getParameter("sp_max_weight"); 
		System.out.println("6"+spMaxWeight);

        String spProTime=request.getParameter("sp_pro_time");
		System.out.println("7"+spProTime);

		String spEdt=request.getParameter("sp_est_del_date"); 
		System.out.println("8"+spEdt);

		int spType=Integer.parseInt(request.getParameter("sptype"));//name change
		System.out.println("9"+spType);

		String spFlavour=request.getParameter("spFlavour");//name change
		System.out.println("10"+spFlavour);

		String spWeight=request.getParameter("spwt");
		System.out.println("11"+spWeight);

		String spEvents=request.getParameter("sp_event");
		System.out.println("12"+spEvents);

		String spInstructions=request.getParameter("sp_instructions");
		System.out.println("13"+spInstructions);

		String spDeliveryDt=request.getParameter("datepicker");
		System.out.println("14"+spDeliveryDt);

	
		String spBookForDate=request.getParameter("datepicker3");
		System.out.println("16"+spBookForDate);

		
		String spCustDOB=request.getParameter("datepicker4");
		System.out.println("17"+spCustDOB);

		String spBookForDOB=request.getParameter("datepicker5");	
		System.out.println("18"+spBookForDOB);

		String spCustMobileNo=request.getParameter("sp_cust_mobile_no");
		System.out.println("19"+spCustMobileNo);

		String spBookForNum=request.getParameter("sp_book_for_number");	
		System.out.println("20"+spBookForNum);

		String spCustName=request.getParameter("sp_cust_name");
		System.out.println("21"+spCustName);

		String spBookedForName=request.getParameter("sp_booked_for_name");
		System.out.println("22"+spBookedForName);

		String spGrand=request.getParameter("sp_grand");
		System.out.println("23"+spGrand);

		String spPrice=request.getParameter("sp_calc_price");
		System.out.println("24"+spPrice);

		String spAddRate=request.getParameter("sp_add_rate");
		System.out.println("25"+spAddRate);

		String spSubTotal=request.getParameter("sp_sub_total");
		System.out.println("26"+spSubTotal);

		String tax1=request.getParameter("t1");
		System.out.println("27"+tax1);

		String tax2=request.getParameter("t2");
		System.out.println("28"+tax2);

		String tax1Amt=request.getParameter("t1");//tax1 amt cnage
		System.out.println("29"+tax1Amt);

		String tax2Amt=request.getParameter("t2");//tax2 amt
		System.out.println("30"+tax2Amt);

		String rmAmount=request.getParameter("rm_amount");
		System.out.println("31"+rmAmount);

		String spAdvance=request.getParameter("adv");
		System.out.println("32"+spAdvance);

		String spPlace=request.getParameter("sp_place");
		System.out.println("33"+spPlace);
		String spPhoUpload=request.getParameter("spPhoUpload");
		
		
		String eventName=request.getParameter("event_name");
		
		String productionTime=request.getParameter("production_time");
		RestTemplate rest = new RestTemplate();
      
		SpCakeOrder spCakeOrder=new SpCakeOrder();
		spCakeOrder.setFrCode("db01");
		spCakeOrder.setItemId(spCode);
		spCakeOrder.setOrderDate("2017/09/10");
		spCakeOrder.setRmAmount(rmAmount);
		spCakeOrder.setSpAddRate(spAddRate);
		spCakeOrder.setSpAdvance(spAdvance);
		spCakeOrder.setSpBookedForName(spBookedForName);
		spCakeOrder.setSpBookForDOB(spBookForDOB);
		spCakeOrder.setSpBookForNumber(spBookForNum);
		spCakeOrder.setSpCustDOB(spCustDOB);
		spCakeOrder.setSpInstructions(spInstructions);
		spCakeOrder.setOrderPhoto("orderPhoto");
		spCakeOrder.setSpCustMobileNo(spCustMobileNo);
		spCakeOrder.setSpCustName(spCustName);
		spCakeOrder.setSpDeliveryDt(spDeliveryDt);
		spCakeOrder.setSpEstDelDate(spEdt);
		spCakeOrder.setSpEvents(spEvents);
		spCakeOrder.setSpEventsName(eventName);
		spCakeOrder.setSpFlavour(spFlavour);
		spCakeOrder.setSpGrand(spGrand);
		spCakeOrder.setSpId(spId);
		spCakeOrder.setSpMaxWeight(spMaxWeight);
		spCakeOrder.setSpMinWeight(spMinWeight);
		spCakeOrder.setSpWeight(spWeight);
		spCakeOrder.setSpPlace(spPlace);
		spCakeOrder.setSpPrice(spPrice);
		spCakeOrder.setSpProduDate("2017/09/10");
		spCakeOrder.setSpProTime(spProTime);
		spCakeOrder.setSpSubTotal(spSubTotal);
		spCakeOrder.setSpType(spType);
		spCakeOrder.setSpVno(12);
		spCakeOrder.setSpWeight(spWeight);
		spCakeOrder.setTax1(tax1);
		spCakeOrder.setTax1Amt(tax1Amt);
		spCakeOrder.setTax2Amt(tax2Amt);
		spCakeOrder.setTax2(tax2);
	
		spCakeOrder.setMenuId(40);
		
try {
		HttpHeaders httpHeaders = new HttpHeaders();
        httpHeaders.set("Content-Type", "application/json");

		ObjectMapper mapper = new ObjectMapper();
		String jsonInString = mapper.writeValueAsString(spCakeOrder);
		System.out.println("All Sp Order Data"+jsonInString.toString());
		HttpEntity <String> httpEntity = new HttpEntity <String> (jsonInString.toString(), httpHeaders);

		RestTemplate restTemplate = new RestTemplate();
		SpCakeOrderRes spCakeOrderRes = restTemplate.postForObject(Constant.URL+"/placeSpCakeOrder", httpEntity, SpCakeOrderRes.class);
		
		SpCakeOrder spCake=spCakeOrderRes.getSpCakeOrder();
		
		List<Flavour> flavoursList=new ArrayList<Flavour>();
		Flavour filteredFlavour=new Flavour();
		
		flavoursList=flavourList.getFlavour();
		
        for(Flavour flavour:flavoursList) {
			
			if(flavour.getSpfId()==Integer.parseInt(spFlavour)) {
			
				filteredFlavour=flavour;
			}
		}
	
		String flavourName=filteredFlavour.getSpfName();
		
		mav.addObject("spType",spType);
		mav.addObject("specialCake",spCake);
		mav.addObject("spName", spName);
		mav.addObject("productionTime", productionTime);
		mav.addObject("flavourName",flavourName);
		mav.addObject("spImage",spImage);
		mav.addObject("spPhoUpload",spPhoUpload);
		System.out.println("SpCakeRes:"+spCake.toString());

   }
     catch(Exception e)
     {
	      System.out.println("Exc"+e.getMessage());
     }
    return mav;	

	}
		
	@RequestMapping(value = "/orderRes", method = RequestMethod.GET)
	public ModelAndView displayHome(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView model = new ModelAndView("order/orderRes");
	
		return model;

	}
		
}
