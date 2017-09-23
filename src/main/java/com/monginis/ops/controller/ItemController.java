package com.monginis.ops.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
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
import com.monginis.ops.model.FrMenu;
import com.monginis.ops.model.Franchisee;
import com.monginis.ops.model.GetFrItem;
import com.monginis.ops.model.Orders;
import com.monginis.ops.model.TabTitleData;

@Controller
public class ItemController {

	private static final Logger logger = LoggerFactory.getLogger(ItemController.class);
	private static List<GetFrItem> frItemList = new ArrayList<>();

	private static int globalIndex = 2;
	private static int currentMenuId = 0;

	@RequestMapping(value = "/showSavouries/{index}", method = RequestMethod.GET)
	public ModelAndView displaySavouries(@PathVariable("index") int index, HttpServletRequest request,
			HttpServletResponse response) {

		ModelAndView model = new ModelAndView("order/itemorder");
		logger.info("/item order request mapping. index:" + index);

		globalIndex = index;

		Date date = new Date(Calendar.getInstance().getTime().getTime());
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");

		String currentDate = df.format(date);

		HttpSession session = request.getSession();
		Franchisee frDetails = (Franchisee) session.getAttribute("frDetails");

		ArrayList<FrMenu> menuList = (ArrayList<FrMenu>) session.getAttribute("menuList");
		
		
		
		DateFormat dfReg = new SimpleDateFormat("yyyy-MM-dd");

		String todaysDate = dfReg.format(date);

		// order ,production ,delivery date logic

		int isSameDayApplicable = menuList.get(index).getIsSameDayApplicable();

		String fromTime = menuList.get(index).getFromTime();
		String toTime = menuList.get(index).getToTime();

		ZoneId z = ZoneId.of("Asia/Calcutta");
		LocalTime currentTime = LocalTime.now(z); // Explicitly specify the desired/expected time zone.

		LocalTime formatedFromTime = LocalTime.parse(fromTime);
		LocalTime formatedToTime = LocalTime.parse(toTime);

		 currentTime = currentTime.plusHours(15);
		System.out.println("current time " + currentTime);
		System.out.println("from time " + formatedFromTime);

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
		try {

			System.out.println("Date is : " + currentDate);
			currentMenuId = menuList.get(index).getMenuId();

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

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

			System.out.println("Fr Item List " + frItemList.toString());
		} catch (Exception e) {

			System.out.println("Exception Item List " + e.getMessage());
		}

		Set<String> setName = new HashSet<String>();

		List<String> subCatList = new ArrayList<>();

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

	
		model.addObject("menuList", menuList);

		model.addObject("subCatListTitle", subCatListWithQtyTotal);

		model.addObject("itemList", frItemList);
		model.addObject("grandTotal", grandTotal);
		model.addObject("frDetails", frDetails);

		model.addObject("currentDate", todaysDate);
		model.addObject("toTime", menuList.get(index).getTime());
		model.addObject("orderDate", orderDate);
		model.addObject("productionDate", productionDate);
		model.addObject("deliveryDate", deliveryDate);

		return model;

	}

	@RequestMapping("/saveOrder")
	public ModelAndView helloWorld(HttpServletRequest request, HttpServletResponse res) throws IOException {

		HttpSession session = request.getSession();
		Franchisee frDetails = (Franchisee) session.getAttribute("frDetails");

		ModelAndView mav = new ModelAndView("redirect:/showSavouries/" + globalIndex);

		String orderDate = "";
		String productionDate = "";
		String deliveryDate = "";
		
		
		String menuId = request.getParameter("menuId");
		int rateCat = frDetails.getFrRateCat();
		System.out.println("Fr Rate Cat " + rateCat);

		System.out.println("Current menu id: " + currentMenuId + " menu id from jsp: " + menuId);

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

		System.out.println("\nLocal time" + now + "Is Early :" + isLate);
		System.out.println("Local time" + now + "Is Late :" + isLate);

		Boolean isSameDay = fromTimeLocalTime.isBefore(toTimeLocalTIme);
		Boolean isValid = false;

		if (isSameDay) {

			if (!isLate && !isEarly) {

				isValid = true;
			}
		} else {

			if (fromTimeLocalTime.isBefore(now) && now.isAfter(toTimeLocalTIme)) {
				isValid = true;
			}
		}
		System.out.println(" is valid " + isValid);

		if (isValid) {
			// date verification

			// LocalTime formatedFromTime = LocalTime.parse(fromTime);
			// LocalTime formatedToTime = LocalTime.parse(toTime);

			// currentTime = currentTime.plusHours(15);
			System.out.println("current time " + now);
			System.out.println("from time " + fromTimeLocalTime);

			
			String todaysDate = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
			int isSameDayApplicable = menuList.get(globalIndex).getIsSameDayApplicable();

			if (fromTimeLocalTime.isBefore(toTimeLocalTIme)) {

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

				if (now.isAfter(fromTimeLocalTime)) {

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

			// if date time verified then place order

			List<GetFrItem> orderList = new ArrayList<>();
			for (int i = 0; i < frItemList.size(); i++) {

				GetFrItem frItem = frItemList.get(i);

				try {
					String id = frItem.getItemId();
					System.out.println("id " + id);

					String strQty = request.getParameter(id);
					int qty = Integer.parseInt(strQty);

					System.out.println(" " + id + ":" + strQty);

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
					order.setDeliveryDate(Common.stringToSqlDate(deliveryDate));
					order.setEditQty(frItem.getItemQty());
					order.setFrId(frDetails.getFrId());
					order.setIsEdit(1);
					order.setIsPositive(1);
					order.setItemId(frItem.getId().toString());
					order.setMenuId(frItem.getMenuId());
					order.setOrderDate(Common.stringToSqlDate(orderDate));
					order.setOrderDatetime(todaysDate);
					order.setOrderQty(frItem.getItemQty());
					order.setOrderSubType(Integer.parseInt(frItem.getItemGrp2()));
					order.setOrderType(Integer.parseInt(frItem.getItemGrp1()));
					order.setProductionDate(Common.stringToSqlDate(productionDate));
					order.setRefId(frItem.getId());
					order.setUserId(2);
					order.setMenuId(currentMenuId);

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

		} else { // time out for place order

		}
		return mav;

	}

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
