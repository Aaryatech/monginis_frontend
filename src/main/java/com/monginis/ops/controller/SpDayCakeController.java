package com.monginis.ops.controller;

import java.util.Date;
import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import com.monginis.ops.common.Common;
import com.monginis.ops.constant.Constant;
import com.monginis.ops.model.ConfiguredSpDayCkResponse;
import com.monginis.ops.model.FrMenu;
import com.monginis.ops.model.Franchisee;
import com.monginis.ops.model.GetConfiguredSpDayCk;
import com.monginis.ops.model.GetFrItem;
import com.monginis.ops.model.Main;
import com.monginis.ops.model.Orders;
import com.monginis.ops.model.TabTitleData;

@Controller
public class SpDayCakeController {

	private static final Logger logger = LoggerFactory.getLogger(ItemController.class);
	private  List<GetFrItem> frItemList = new ArrayList<>();
	private  List<GetFrItem> prevFrItemList = new ArrayList<>();
	Date productionDate;
	Date deliDate;
	
	private static int currentMenuId = 0;
	List<String> subCatList = new ArrayList<>();
	public MultiValueMap<String, Object> map;

	ConfiguredSpDayCkResponse configuredSpDayCkRes;

	@RequestMapping(value = "/showSpDayCake", method = RequestMethod.GET)
	public ModelAndView displaySpDayCake(HttpServletRequest request,
			HttpServletResponse response) {

		ModelAndView model = new ModelAndView("order/spdaycake");
	

		RestTemplate restTemplate = new RestTemplate();

		 configuredSpDayCkRes = restTemplate.getForObject(Constant.URL + "getSpDayCkList",
				ConfiguredSpDayCkResponse.class);
		List<GetConfiguredSpDayCk> configureSpDayFrList = new ArrayList<GetConfiguredSpDayCk>();

		configureSpDayFrList = configuredSpDayCkRes.getConfiguredSpDayCkList();

	
		model.addObject("configureSpDayFrList", configureSpDayFrList);

		return model;
	}	
	@RequestMapping(value = "/searchItems", method = RequestMethod.POST)
	public ModelAndView searchItems(HttpServletRequest request,
			HttpServletResponse response) {

		ModelAndView model = new ModelAndView("order/spdaycake");
		HttpSession session = request.getSession();
		Franchisee frDetails = (Franchisee) session.getAttribute("frDetails");

		ArrayList<FrMenu> menuList = (ArrayList<FrMenu>) session.getAttribute("menuList");
		
		List<GetConfiguredSpDayCk> configureSpDayFrList = new ArrayList<GetConfiguredSpDayCk>();

		configureSpDayFrList = configuredSpDayCkRes.getConfiguredSpDayCkList();
		
		
		int spdayId=Integer.parseInt(request.getParameter("spdayId"));
		
		GetConfiguredSpDayCk spDayCk=new GetConfiguredSpDayCk();
		
	   for(GetConfiguredSpDayCk getConfiguredSpDayCk:configureSpDayFrList)
	   {
		  if(getConfiguredSpDayCk.getSpdayId()==spdayId)
		  {
			  spDayCk=getConfiguredSpDayCk;
		  }
	   }
	   System.out.println("Special Day Cake Response:"+spDayCk.toString());
	   
		String delDate=request.getParameter("datepicker");
		try {
			
	    //  Date deliveryDate=Main.stringToDate(delDate);
			
			DateFormat dmyFormat = new SimpleDateFormat("dd-MM-yyyy");
			Date deliveryDate = dmyFormat.parse(delDate);
	      System.out.println("Delivery date "+deliveryDate);
		
		Calendar cal = Calendar.getInstance();
		cal.setTime(deliveryDate);

		 deliDate = cal.getTime();
		 
		cal.add(Calendar.DATE, -1);
		
		// manipulate date
		//c.add(Calendar.DATE, prodTime);
			productionDate = cal.getTime();

			
			DateFormat ymdFormat = new SimpleDateFormat("yyyy-MM-dd");

			String strProdDate = ymdFormat.format(productionDate);
		
			
			System.out.println("String ymd  date is: " +strProdDate);

			
	

		 map = new LinkedMultiValueMap<String, Object>();

			map.add("items",spDayCk.getItemId());
			map.add("frId", frDetails.getFrId());
			map.add("date", strProdDate);
			map.add("menuId",spDayCk.getMenuId());
			

			RestTemplate restTemplate = new RestTemplate();

			ParameterizedTypeReference<List<GetFrItem>> typeRef = new ParameterizedTypeReference<List<GetFrItem>>() {
			};
			ResponseEntity<List<GetFrItem>> responseEntity = restTemplate.exchange(Constant.URL + "/getFrItems",
					HttpMethod.POST, new HttpEntity<>(map), typeRef);

			frItemList = responseEntity.getBody();
			prevFrItemList = responseEntity.getBody();
			System.out.println("Fr Item List " + frItemList.toString());
			
			model.addObject("frDetails", frDetails);
			model.addObject("itemList", frItemList);
			model.addObject("menuId", spDayCk.getMenuId());

			model.addObject("configureSpDayFrList", configureSpDayFrList);
	       } catch (Exception e) {

	        	System.out.println("Exception Item List " + e.getMessage());
	      }
		

		return model;
	}		
		
		
	@RequestMapping("/saveSpDayCakeOrder")
	public ModelAndView helloWorld(HttpServletRequest request, HttpServletResponse res) throws IOException {

		HttpSession session = request.getSession();
		Franchisee frDetails = (Franchisee) session.getAttribute("frDetails");

		ModelAndView mav = new ModelAndView("redirect:/showSpDayCake");

		String orderDate = "";
		

		String todaysDate = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
		SimpleDateFormat dateFrmt = new SimpleDateFormat("yyyy-MM-dd");

		orderDate = todaysDate;
		String prodDate = dateFrmt.format(productionDate);
		String deliveryDt = dateFrmt.format(deliDate);
		
		int menuId = Integer.parseInt(request.getParameter("menuId"));
		int rateCat = frDetails.getFrRateCat();
		
		List<GetFrItem> orderList = new ArrayList<>();
		for (int i = 0; i < frItemList.size(); i++) {

			GetFrItem frItem = frItemList.get(i);

			try {
				Integer id = frItem.getId();
				System.out.println("id " + id);

				String strQty = request.getParameter(String.valueOf(id));
				
				
				int qty = Integer.parseInt(strQty);

				System.out.println(" " + frItem.getItemQty() + "=?" + strQty);

				if (qty != frItem.getItemQty()) {

					frItem.setItemQty(qty);
					orderList.add(frItem);

				}

			} catch (Exception e) {
				System.out.println("Except OrderList " + e.getMessage());
			}

		}

		System.out.println("Order List " + orderList.toString());

		try {

			RestTemplate restTemplate = new RestTemplate();

			String url = Constant.URL + "placeOrder";

			ObjectMapper mapperObj = new ObjectMapper();

			List<Orders> orders = new ArrayList<>();

			for (int i = 0; i < orderList.size(); i++) {

				GetFrItem frItem = orderList.get(i);

				Orders order = new Orders();
				order.setDeliveryDate(Common.stringToSqlDate(deliveryDt));
				order.setEditQty(0);
				order.setFrId(frDetails.getFrId());
				order.setIsEdit(1);
				order.setIsPositive(1);
				order.setItemId(frItem.getId().toString());
				order.setMenuId(menuId);
				order.setOrderDate(Common.stringToSqlDate(orderDate));
				order.setOrderDatetime(todaysDate);
				order.setOrderQty(frItem.getItemQty());
				order.setOrderSubType(Integer.parseInt(frItem.getItemGrp2()));
				order.setOrderType(Integer.parseInt(frItem.getItemGrp1()));
				order.setProductionDate(Common.stringToSqlDate(prodDate));
				order.setRefId(frItem.getId());
				order.setUserId(2);
			

				if (rateCat == 1) {
					order.setOrderMrp(frItem.getItemMrp1());
					order.setOrderRate(frItem.getItemRate1());

				} else if (rateCat == 2) {
					order.setOrderMrp(frItem.getItemMrp2());
					order.setOrderRate(frItem.getItemRate2());

				} else if (rateCat == 3) {
					order.setOrderMrp(frItem.getItemMrp3());
					order.setOrderRate(frItem.getItemRate3());

				}

				orders.add(order);

			}

			String jsonStr = null;

			try {
				jsonStr = mapperObj.writeValueAsString(orders);
				System.out.println("Converted JSON: " + jsonStr);
			} catch (IOException e) {
				System.out.println("Excep converting java 2 json " + e.getMessage());
				e.printStackTrace();
			}

			HttpHeaders headers = new HttpHeaders();
			headers.setContentType(MediaType.APPLICATION_JSON);

			HttpEntity<String> entity = new HttpEntity<String>(jsonStr, headers);

			ResponseEntity<String> orderListResponse = restTemplate.exchange(url, HttpMethod.POST, entity,
					String.class);

			System.out.println("Place Order Response" + orderListResponse.toString());

		} catch (Exception e) {
			System.out.println("Except Placing order " + e.getMessage());
		}

	
	return mav;
	}
	
		
		
		
		
/*
	subCatList=new ArrayList<>();

	

	Date date = new Date(Calendar.getInstance().getTime().getTime());
	DateFormat df = new SimpleDateFormat("yyyy-MM-dd");

	String currentDate = df.format(date);

	HttpSession session = request.getSession();
	Franchisee frDetails = (Franchisee) session.getAttribute("frDetails");

	ArrayList<FrMenu> menuList = (ArrayList<FrMenu>) session.getAttribute("menuList");

	DateFormat dfReg = new SimpleDateFormat("yyyy-MM-dd");

	String todaysDate = dfReg.format(date);

	// order ,production ,delivery date logic

	int isSameDayApplicable = menuList.get(0).getIsSameDayApplicable();

	

	ZoneId z = ZoneId.of("Asia/Calcutta");
	LocalTime currentTime = LocalTime.now(z); // Explicitly specify the desired/expected time zone.

	
	currentTime = currentTime.plusHours(15);
	System.out.println("current time " + currentTime);
	

	String orderDate = "";
	String productionDate = "";
	String deliveryDate = "";

	if (formatedFromTime.isBefore(formatedToTime)) {

		orderDate = todaysDate;
		productionDate = todaysDate;

		if (isSameDayApplicable == 0 || isSameDayApplicable == 2) {

			deliveryDate = incrementDate(todaysDate, 1);
			System.out.println("inside 1.1");

		} else if (isSameDayApplicable == 1) {

			deliveryDate = todaysDate;

			System.out.println("inside 1.2");

		}

	} else {

		if (currentTime.isAfter(formatedFromTime)) {

			orderDate = todaysDate;
			productionDate = incrementDate(todaysDate, 1);
			deliveryDate = incrementDate(todaysDate, 2);

			System.out.println("inside 2.1");
		} else {

			orderDate = todaysDate;
			productionDate = todaysDate;
			deliveryDate = incrementDate(todaysDate, 1);
			System.out.println("inside 2.2");
		}

	}

	System.out.println("Order date: " + orderDate);
	System.out.println("Production date: " + productionDate);
	System.out.println("Delivery date: " + deliveryDate);

	frItemList = new ArrayList<GetFrItem>();
	prevFrItemList=new ArrayList<GetFrItem>();
	try {

		System.out.println("Date is : " + currentDate);
		currentMenuId = menuList.get(index).getMenuId();

		 map = new LinkedMultiValueMap<String, Object>();

		map.add("items", menuList.get(index).getItemShow());
		map.add("frId", frDetails.getFrId());
		map.add("date", productionDate);
		map.add("menuId", menuList.get(index).getMenuId());

		RestTemplate restTemplate = new RestTemplate();

		ParameterizedTypeReference<List<GetFrItem>> typeRef = new ParameterizedTypeReference<List<GetFrItem>>() {
		};
		ResponseEntity<List<GetFrItem>> responseEntity = restTemplate.exchange(Constant.URL + "/getFrItems",
				HttpMethod.POST, new HttpEntity<>(map), typeRef);

		frItemList = responseEntity.getBody();
		prevFrItemList = responseEntity.getBody();
		System.out.println("Fr Item List " + frItemList.toString());
	} catch (Exception e) {

		System.out.println("Exception Item List " + e.getMessage());
	}

	Set<String> setName = new HashSet<String>();

	float grandTotal = 0;

	for (int i = 0; i < frItemList.size(); i++) {

		if (frDetails.getFrRateCat() == 1) {
			grandTotal = grandTotal + (frItemList.get(i).getItemQty() * frItemList.get(i).getItemRate1());
		} else if (frDetails.getFrRateCat() == 2) {
			grandTotal = grandTotal + (frItemList.get(i).getItemQty() * frItemList.get(i).getItemRate2());

		} else if (frDetails.getFrRateCat() == 3) {
			grandTotal = grandTotal + (frItemList.get(i).getItemQty() * frItemList.get(i).getItemRate3());

		}
		setName.add(frItemList.get(i).getSubCatName());

	}

	subCatList.addAll(setName);

	List<TabTitleData> subCatListWithQtyTotal = new ArrayList<>();

	for (int i = 0; i < subCatList.size(); i++) {

		String subCat = subCatList.get(i);
		int qty = 0;
		int total = 0;

		for (int j = 0; j < frItemList.size(); j++) {

			if (frItemList.get(j).getSubCatName().equalsIgnoreCase(subCat)) {

				qty = qty + frItemList.get(j).getItemQty();

				if (frDetails.getFrRateCat() == 1) {

					total = total + (frItemList.get(j).getItemRate1() * frItemList.get(j).getItemQty());

				} else if (frDetails.getFrRateCat() == 2) {

					total = total + (frItemList.get(j).getItemRate2() * frItemList.get(j).getItemQty());

				} else if (frDetails.getFrRateCat() == 3) {

					total = total + (frItemList.get(j).getItemRate3() * frItemList.get(j).getItemQty());

				}

			}

		}

		TabTitleData tabTitleData = new TabTitleData();
		tabTitleData.setName(subCat);
		tabTitleData.setHeader(subCat + " (Rs." + total + ")" + "(Qty- " + qty + ")");

		subCatListWithQtyTotal.add(tabTitleData);

	}

	System.out.println(subCatList);

	// toTime

	SimpleDateFormat _24HourSDF = new SimpleDateFormat("HH:mm");
	SimpleDateFormat _12HourSDF = new SimpleDateFormat("hh:mm a");
	java.util.Date toTime12Hrs = null;
	try {
		toTime12Hrs = _24HourSDF.parse(toTime);
	} catch (ParseException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}

	model.addObject("menuList", menuList);

	model.addObject("subCatListTitle", subCatListWithQtyTotal);

	model.addObject("itemList", frItemList);
	model.addObject("grandTotal", grandTotal);
	model.addObject("frDetails", frDetails);

	model.addObject("currentDate", todaysDate);
	model.addObject("toTime", _12HourSDF.format(toTime12Hrs));
	model.addObject("orderDate", orderDate);
	model.addObject("productionDate", productionDate);
	model.addObject("deliveryDate", deliveryDate);*/


	public String incrementDate(String date, int day) {

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar c = Calendar.getInstance();
		try {
			c.setTime(sdf.parse(date));

		} catch (ParseException e) {
			System.out.println("Exception while incrementing date " + e.getMessage());
			e.printStackTrace();
		}
		c.add(Calendar.DATE, day); // number of days to add
		date = sdf.format(c.getTime());

		return date;

	}
}
