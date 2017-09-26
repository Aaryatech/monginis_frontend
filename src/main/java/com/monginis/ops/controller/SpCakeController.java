package com.monginis.ops.controller;


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

import com.monginis.ops.util.ImageS3Util;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.monginis.ops.constant.Constant;
import com.monginis.ops.model.ErrorMessage;
import com.monginis.ops.model.EventList;
import com.monginis.ops.model.Flavour;
import com.monginis.ops.model.FlavourList;
import com.monginis.ops.model.FrMenu;
import com.monginis.ops.model.Franchisee;
import com.monginis.ops.model.SearchSpCakeResponse;
import com.monginis.ops.model.SpCakeOrder;
import com.monginis.ops.model.SpCakeOrderRes;
import com.monginis.ops.model.SpCakeResponse;
import com.monginis.ops.model.SpecialCake;


@Controller
public class SpCakeController {
	
	private static final Logger logger = LoggerFactory.getLogger(ItemController.class);
	
	FlavourList flavourList;
	EventList eventList;
	
	private static int globalIndex = 2;
	ArrayList<FrMenu> menuList;
	
	private static int currentMenuId = 0;

	SpCakeOrder spCakeOrder = new SpCakeOrder();

	List<SpecialCake> specialCakeList;
	SpecialCake specialCake;

	String spImage = "0463a490-b678-46d7-b31d-d7d6bae5c954-ats.png";//Default Image to spCake order Page

    //------------------------Show Special Cake Order Page----------------------------
	@RequestMapping(value = "/showSpCakeOrder/{index}", method = RequestMethod.GET)
	public ModelAndView displaySpCakeOrder(@PathVariable("index") int index, HttpServletRequest request,
			HttpServletResponse response) {
		

		ModelAndView model = new ModelAndView("order/spcakeorder");
		
		HttpSession session = request.getSession();

		logger.info("/item order request mapping. index:" + index);

		RestTemplate restTemplate = new RestTemplate();

		try {
			menuList = (ArrayList<FrMenu>) session.getAttribute("menuList");

			currentMenuId = menuList.get(index).getMenuId();
			System.out.println("MenuList" + currentMenuId);

			SpCakeResponse spCakeResponse = restTemplate.getForObject(Constant.URL + "/showSpecialCakeList",
					SpCakeResponse.class);

			System.out.println("SpCake Controller SpCakeList Response " + spCakeResponse.toString());

			flavourList = restTemplate.getForObject(Constant.URL + "/showFlavourList", FlavourList.class);
			System.out.println("flavour Controller flavourList Response " + flavourList.toString());

			eventList = restTemplate.getForObject(Constant.URL + "/showEventList", EventList.class);
			System.out.println("Event Controller EventList Response " + eventList.toString());

			specialCakeList = new ArrayList<SpecialCake>();

			specialCakeList = spCakeResponse.getSpecialCake();
			System.out.println("MenuList Response " + menuList.toString());

			globalIndex = index;

			System.out.println("Special Cake List:" + specialCakeList.toString());
			model.addObject("menuList", menuList);
			model.addObject("specialCakeList", specialCakeList);
			model.addObject("eventList", eventList);
			model.addObject("flavourList", flavourList);
			model.addObject("spBookb4", 0);
			// model.addObject("spImage", specialCake.getSpImage());
			model.addObject("url", Constant.SPCAKE_IMAGE_URL);

		} catch (Exception e) {
			System.out.println("Show Sp Cake List Excep: " + e.getMessage());
			model.addObject("menuList", menuList);
			model.addObject("specialCakeList", specialCakeList);
			model.addObject("eventList", eventList);
			model.addObject("flavourList", flavourList);
			model.addObject("spBookb4", 0);
			// model.addObject("spImage", specialCake.getSpImage());
			model.addObject("url", Constant.SPCAKE_IMAGE_URL);
		}

		return model;
	}
    //-----------------------------------END-----------------------------------------

	
    //------------------------Search Special Cake Process----------------------------

	@RequestMapping(value = "/searchSpCake", method = RequestMethod.POST)
	public ModelAndView searchSpCakeBySpCode(HttpServletRequest request, HttpServletResponse response) {

		System.out.println("inside search sp cake request");

		String spCode = request.getParameter("sp_code");
		ModelAndView model = new ModelAndView("order/spcakeorder");

		RestTemplate restTemplate = new RestTemplate();
		MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

		map.add("spCode", spCode);
		try {
			SearchSpCakeResponse searchSpCakeResponse = restTemplate.postForObject(Constant.URL + "/searchSpecialCake", map, SearchSpCakeResponse.class);
            ErrorMessage errorMessage=searchSpCakeResponse.getErrorMessage();
			specialCake=searchSpCakeResponse.getSpecialCake();

			if (errorMessage.getError()==false) {


				String itemShow = menuList.get(globalIndex).getItemShow();

				HttpSession session = request.getSession();

				Franchisee frDetails = (Franchisee) session.getAttribute("frDetails");

				List<String> arrShowItem = Arrays.asList(itemShow.split("\\s*,\\s*"));

				int isfound = 0;
				System.out.println("item Show " + itemShow);

				for (String spId : arrShowItem) {
					if (Integer.parseInt(spId) == specialCake.getSpId()) {
						isfound = 1;
						System.out.println("Sp Cake Math " + spId);

					}
				}

				if (isfound == 0) {

					System.out.println("Sp Cake Not  Math ");
					model = new ModelAndView("order/spcakeorder");
					// specialCake = null;

					model.addObject("menuList", menuList);
					model.addObject("eventList", eventList);
					model.addObject("flavourList", flavourList);
					model.addObject("url", Constant.SPCAKE_IMAGE_URL);
					model.addObject("spBookb4", 0);
					model.addObject("sprRate", 0);
					model.addObject("specialCakeList", specialCakeList);

					return model;

				}

				String spImage = specialCake.getSpImage();

				System.out.println("Sp RESPONSE" + specialCake.toString());
				float sprRate;
				if (frDetails.getFrRateCat() == 1) {
					sprRate = specialCake.getMrpRate1();

				} else if (frDetails.getFrRateCat() == 2) {
					sprRate = specialCake.getMrpRate2();
				} else {
					sprRate = specialCake.getMrpRate3();
				}

				model.addObject("sprRate", sprRate);

				model.addObject("specialCake", specialCake);
				model.addObject("eventList", eventList);

				int spBookb4 = Integer.parseInt(specialCake.getSpBookb4());

				System.out.println("spBookb4" + spBookb4);

				model.addObject("spBookb4", spBookb4);
				model.addObject("isFound", "");
				model.addObject("specialCakeList", specialCakeList);


			} else {

				System.out.println(" inside else:");
				model = new ModelAndView("order/spcakeorder");
				model.addObject("menuList", menuList);
				model.addObject("eventList", eventList);
				model.addObject("flavourList", flavourList);
				model.addObject("url", Constant.SPCAKE_IMAGE_URL);
				model.addObject("spBookb4", 0);
				model.addObject("sprRate", 0);
				model.addObject("isFound", false);
				model.addObject("specialCakeList", specialCakeList);

				return model;

			}
		} catch (Exception e) {
			model = new ModelAndView("order/spcakeorder");

			System.out.println("search  Sp Cake  Excep: " + e.getMessage());
			model.addObject("menuList", menuList);
			model.addObject("eventList", eventList);
			model.addObject("flavourList", flavourList);
			model.addObject("url", Constant.SPCAKE_IMAGE_URL);
			model.addObject("spBookb4", 0);
			model.addObject("sprRate", 0);
			model.addObject("isFound", false);
			model.addObject("specialCakeList", specialCakeList);

			return model;
		}
		
		model.addObject("menuList", menuList);
		// int spBookb4 = Integer.parseInt(specialCake.getSpBookb4());
		model.addObject("eventList", eventList);
		model.addObject("flavourList", flavourList);
		model.addObject("url", Constant.SPCAKE_IMAGE_URL);
		// model.addObject("spBookb4", spBookb4);
		model.addObject("isFound", "");
		model.addObject("specialCakeList", specialCakeList);


		return model;
	}
//--------------------------END------------------------------------------
	@RequestMapping(value = "/getFlavourBySpfId", method = RequestMethod.GET)
	public @ResponseBody List<Flavour> flavourById(@RequestParam(value = "spType", required = true) int spType) {
		
		List<Flavour> flavoursListWithAddonRate = new ArrayList<Flavour>();

		System.out.println("SpType:: " + spType);
        
		List<Flavour> flavoursList = new ArrayList<Flavour>();
		List<Flavour> filterFlavoursList = new ArrayList<Flavour>();


    try {
			
	
		flavoursList = flavourList.getFlavour();

		System.out.println("DB Sptype" + flavoursList.get(0).getSpType());

		for (int i = 0; i < flavoursList.size(); i++) {

			if (flavoursList.get(i).getSpType() == spType) {
				filterFlavoursList.add(flavoursList.get(i));

			}
		  }
		  for (Flavour flavour : filterFlavoursList) {
			if (specialCake.getIsAddonRateAppli() == 1) {
				flavoursListWithAddonRate.add(flavour);
			  } else {
				flavour.setSpfAdonRate(0.0);
				flavoursListWithAddonRate.add(flavour);
			 }
		  }
		   System.out.println("Filter Item List " + flavoursListWithAddonRate.toString());
	 }
		catch(Exception e)
		{
			System.out.println("Exception in getFlavourBySpfId() AJAX CALL");
			
		}

		return flavoursListWithAddonRate;
		
	}
	 //------------------------Get Addon Rate AJAX method(spcakeorder)----------------------------
	@RequestMapping(value = "/getAddOnRate", method = RequestMethod.GET)
	public @ResponseBody Flavour getAddOnRate(@RequestParam(value = "spfId", required = true) double spfId) {
		List<Flavour> flavoursList = new ArrayList<Flavour>();
		Flavour filteredFlavour = new Flavour();
		flavoursList = flavourList.getFlavour();

		for (Flavour flavour : flavoursList) {

			if (flavour.getSpfId() == spfId) {

				filteredFlavour = flavour;
			}
		}

		return filteredFlavour;
	}
    //--------------------------------------END------------------------------------

	
    //------------------------Order Special Cake Process----------------------------
	@RequestMapping(value = "/orderSpCake", method = RequestMethod.POST)
	public ModelAndView addItemProcess(HttpServletRequest request, HttpServletResponse response,
			@RequestParam("order_photo") MultipartFile orderPhoto,
			@RequestParam("cust_choice_ck") MultipartFile custChoiceCk) throws JsonProcessingException {

		ModelAndView mav = new ModelAndView("order/orderRes");

		HttpSession session = request.getSession();

		Franchisee frDetails = (Franchisee) session.getAttribute("frDetails");
		int frId = frDetails.getFrId();
		
		
		ArrayList<FrMenu> menuList = (ArrayList<FrMenu>) session.getAttribute("menuList");

		
		// menu timing verification
        String fromTime = menuList.get(globalIndex).getFromTime();
		String toTime = menuList.get(globalIndex).getToTime();
		System.out.println("before order placing: from time " + fromTime + " to time " + toTime);

		ZoneId z = ZoneId.of("Asia/Calcutta");
		LocalTime now = LocalTime.now(z); // Explicitly specify the desired/expected time zone.

		LocalTime fromTimeLocalTime = LocalTime.parse(fromTime);
		LocalTime toTimeLocalTIme = LocalTime.parse(toTime);

		Boolean isLate = now.isAfter(toTimeLocalTIme);
		Boolean isEarly = now.isBefore(fromTimeLocalTime);
		
		if (!isLate && !isEarly) {		

		int spId = Integer.parseInt(request.getParameter("sp_id"));
		System.out.println("1" + spId);
		String spCode = request.getParameter("sp_code");
		System.out.println("2" + spCode);

		String spName = request.getParameter("sp_name");
		System.out.println("3" + spName);
		/*
		 * String orderPhoto1=request.getParameter("order_photo");
		 * System.out.println("4" + orderPhoto);
		 */

		/*
		 * String custChCk=request.getParameter("cust_choice_ck");
		 * System.out.println("4.1" + custChCk);
		 */
		String spMinWeight = request.getParameter("sp_min_weight");
		System.out.println("5" + spMinWeight);

		String spMaxWeight = request.getParameter("sp_max_weight");
		System.out.println("6" + spMaxWeight);

		String spProTime = request.getParameter("sp_pro_time");
		System.out.println("7" + spProTime);
		int prodTime = Integer.parseInt(spProTime);

		String spEdt = request.getParameter("sp_est_del_date");
		System.out.println("8" + spEdt);

		int spType = Integer.parseInt(request.getParameter("sptype"));
		System.out.println("9" + spType);

		String spFlavour = request.getParameter("spFlavour");
		System.out.println("10" + spFlavour);

		String spWeight = request.getParameter("spwt");
		System.out.println("11" + spWeight);

		String spEvents = request.getParameter("sp_event");
		System.out.println("12" + spEvents);

		String spInstructions = request.getParameter("sp_instructions");
		System.out.println("13" + spInstructions);

		String spDeliveryDt = request.getParameter("datepicker");
		System.out.println("14" + spDeliveryDt);

		String spBookForDate = request.getParameter("datepicker3");
		System.out.println("16" + spBookForDate);

		String spCustDOB = request.getParameter("datepicker4");
		System.out.println("17" + spCustDOB);

		String spBookForDOB = request.getParameter("datepicker5");
		System.out.println("18" + spBookForDOB);

		String spCustMobileNo = request.getParameter("sp_cust_mobile_no");
		System.out.println("19" + spCustMobileNo);

		String spBookForNum = request.getParameter("sp_book_for_number");
		System.out.println("20" + spBookForNum);

		String spCustName = request.getParameter("sp_cust_name");
		System.out.println("21" + spCustName);

		String spBookedForName = request.getParameter("sp_booked_for_name");
		System.out.println("22" + spBookedForName);

		String spGrand = request.getParameter("sp_grand");
		System.out.println("23" + spGrand);

		String spPrice = request.getParameter("sp_calc_price");
		System.out.println("24" + spPrice);

		String spAddRate = request.getParameter("sp_add_rate");
		System.out.println("25" + spAddRate);

		String spSubTotal = request.getParameter("sp_sub_total");
		System.out.println("26" + spSubTotal);

		String tax1 = request.getParameter("t1");
		System.out.println("27" + tax1);

		String tax2 = request.getParameter("t2");
		System.out.println("28" + tax2);

		String tax1Amt = request.getParameter("t1");
		System.out.println("29" + tax1Amt);

		String tax2Amt = request.getParameter("t2");// tax2 amt
		System.out.println("30" + tax2Amt);

		String rmAmount = request.getParameter("rm_amount");
		System.out.println("31" + rmAmount);

		String spAdvance = request.getParameter("adv");
		System.out.println("32" + spAdvance);

		String spPlace = request.getParameter("sp_place");
		System.out.println("33" + spPlace);
		String spPhoUpload = request.getParameter("spPhoUpload");

		String eventName = request.getParameter("event_name");

		String isCustCh = request.getParameter("isCustCh");

		String productionTime = request.getParameter("production_time");

		String spImage = request.getParameter("prevImage");
		String custChCk = "";
		String orderPhoto1 = "";

		if (!orderPhoto.getOriginalFilename().equalsIgnoreCase("")) {

			System.out.println("Empty image");
			orderPhoto1 = ImageS3Util.uploadPhotoCakeImage(orderPhoto);
		}

		if (!custChoiceCk.getOriginalFilename().equalsIgnoreCase("")) {

			System.out.println("Empty image");
			custChCk = ImageS3Util.uploadPhotoCakeImage(custChoiceCk);
		}

		spCakeOrder = new SpCakeOrder();
		spCakeOrder.setFrCode(frDetails.getFrCode());

		spCakeOrder.setFrId(frId);

		// -----Order Date And Production Date------

		final SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date currentDate = new Date();

		// convert date to calendar
		Calendar c = Calendar.getInstance();
		c.setTime(currentDate);

		// Current Date
		Date orderDate = c.getTime();

		// manipulate date
		c.add(Calendar.DATE, prodTime);
		Date currentDatePlusProdTime = c.getTime();

		System.out.println("Todays date is: " + currentDate);
		// -------------------------------------------

		spCakeOrder.setItemId(spCode);
		spCakeOrder.setOrderDate(dateFormat.format(orderDate));
		spCakeOrder.setRmAmount(rmAmount);
		spCakeOrder.setSpAddRate(spAddRate);
		spCakeOrder.setSpAdvance(spAdvance);

		spCakeOrder.setSpBookedForName(spBookedForName);
		spCakeOrder.setSpBookForDOB(spBookForDOB);
		spCakeOrder.setSpBookForNumber(spBookForNum);
		spCakeOrder.setSpCustDOB(spCustDOB);
		spCakeOrder.setSpInstructions(spInstructions);
		spCakeOrder.setOrderPhoto(orderPhoto1);
		spCakeOrder.setOrderPhoto2(custChCk);

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
		spCakeOrder.setSpProduDate(dateFormat.format(currentDatePlusProdTime));
		spCakeOrder.setSpProTime(spProTime);
		spCakeOrder.setSpSubTotal(spSubTotal);
		spCakeOrder.setSpType(spType);

		spCakeOrder.setSpWeight(spWeight);
		spCakeOrder.setTax1(tax1);
		spCakeOrder.setTax1Amt(tax1Amt);
		spCakeOrder.setTax2Amt(tax2Amt);
		spCakeOrder.setTax2(tax2);

		spCakeOrder.setMenuId(currentMenuId);

		try {
			HttpHeaders httpHeaders = new HttpHeaders();
			httpHeaders.set("Content-Type", "application/json");

			ObjectMapper mapper = new ObjectMapper();
			String jsonInString = mapper.writeValueAsString(spCakeOrder);
			System.out.println("All Sp Order Data" + jsonInString.toString());

			HttpEntity<String> httpEntity = new HttpEntity<String>(jsonInString.toString(), httpHeaders);

			RestTemplate restTemplate = new RestTemplate();
			SpCakeOrderRes spCakeOrderRes = restTemplate.postForObject(Constant.URL + "/placeSpCakeOrder", httpEntity,
					SpCakeOrderRes.class);

			SpCakeOrder spCake = spCakeOrderRes.getSpCakeOrder();

			List<Flavour> flavoursList = new ArrayList<Flavour>();
			Flavour filteredFlavour = new Flavour();

			flavoursList = flavourList.getFlavour();

			for (Flavour flavour : flavoursList) {

				if (flavour.getSpfId() == Integer.parseInt(spFlavour)) {

					filteredFlavour = flavour;
				}
			}

			String flavourName = filteredFlavour.getSpfName();
			System.out.println("Sptype=" + spType);

			mav.addObject("spType", spType);
			mav.addObject("specialCake", spCake);
			mav.addObject("spImage", spImage);
			mav.addObject("URL", Constant.SPCAKE_IMAGE_URL);

			mav.addObject("spName", spName);
			mav.addObject("productionTime", productionTime);
			mav.addObject("flavourName", flavourName);
			// mav.addObject("spImage", spImage);
			mav.addObject("isCustCh", isCustCh);
			mav.addObject("spPhoUpload", spPhoUpload);
			mav.addObject("PHOTO_URL", Constant.PHOTO_CAKE_URL);
			mav.addObject("globalIndex", globalIndex);
			System.out.println("SpCakeRes:" + spCake.toString());

		} catch (Exception e) {
			System.out.println("Exc" + e.getMessage());
			mav.addObject("eventList", eventList);
			mav.addObject("flavourList", flavourList);
			

		}
		}
		else           //End of if -Timeout
		{
			mav = new ModelAndView("order/spcakeorder");
			mav.addObject("errorMessage", "Special Cake Order TimeOut");
			

			mav.addObject("menuList", menuList);
			mav.addObject("eventList", eventList);
			mav.addObject("flavourList", flavourList);
			mav.addObject("url", Constant.SPCAKE_IMAGE_URL);
			mav.addObject("spBookb4", 0);
			mav.addObject("sprRate", 0);
			mav.addObject("isFound", false);
			return mav;
			
		}
		return mav;

	}
	  //----------------------------------END----------------------------------------
	
	 //-----------------Showing of order Datails Page------------------------------
	@RequestMapping(value = "/orderRes", method = RequestMethod.GET)
	public ModelAndView displayHome(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView model = new ModelAndView("order/orderRes");

		return model;

	}
   //----------------------------------END--------------------------------------------

   //-----------------For Showing Special Cake order PDF------------------------------
	@RequestMapping(value = "/showSpCakeOrderPDF", method = RequestMethod.GET)
	public ModelAndView displayLogin(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("report/order");

		HttpSession session = request.getSession();

		Franchisee franchisee = (Franchisee) session.getAttribute("frDetails");

		// String delDate=spCakeOrder.getSpDeliveryDt();
		// String place=spCakeOrder.getSpPlace();
		// String custName=spCakeOrder.getSpCustName();
		// String custMob=spCakeOrder.getSpCustMobileNo();
		// String itemName=spCakeOrder.getItemId();
		// String qty="1";
		// String rate=spCakeOrder.getSpPrice();
		// String amt=spCakeOrder.getSpSubTotal();
		// String instruction=spCakeOrder.getSpInstructions();
		// String total=spCakeOrder.getSpSubTotal();
		// String adv=spCakeOrder.getSpAdvance();
		// String bal=spCakeOrder.getRmAmount();
		//

		Calendar cal = Calendar.getInstance();

		Date date = new Date();
		date.getTime();

		SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat formatTime = new SimpleDateFormat("hh-mm-ss a");

		System.out.println(cal.getTime());

		String formatted = format1.format(cal.getTime());
		System.out.println(formatted);

		String currentDate = format1.format(date);
		String time = formatTime.format(cal.getTime());
		String shopName = franchisee.getFrName();
		String tel = franchisee.getFrMob();

		model.addObject("spCakeOrder", spCakeOrder);
		model.addObject("currDate", currentDate);
		model.addObject("currTime", time);
		model.addObject("shopName", shopName);
		model.addObject("tel", tel);

		return model;

	}
   //----------------------------------END----------------------------------------
}
