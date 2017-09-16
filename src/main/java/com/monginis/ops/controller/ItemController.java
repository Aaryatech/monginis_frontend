package com.monginis.ops.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
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

import com.monginis.ops.constant.Constant;
import com.monginis.ops.model.FrMenu;
import com.monginis.ops.model.Franchisee;
import com.monginis.ops.model.GetFrItem;
import com.monginis.ops.model.Orders;

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
		DateFormat df = new SimpleDateFormat("yyyy/MM/dd");

		String currentDate = df.format(date);

		HttpSession session = request.getSession();
		Franchisee frDetails = (Franchisee) session.getAttribute("frDetails");

		ArrayList<FrMenu> menuList = (ArrayList<FrMenu>) session.getAttribute("menuList");
		frItemList = new ArrayList<GetFrItem>();
		try {

			System.out.println("Date is : " + currentDate);
			currentMenuId = menuList.get(index).getMenuId();
		
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			
			map.add("items", menuList.get(index).getItemShow());
			map.add("frId", frDetails.getFrId());
			map.add("date", currentDate);
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
			grandTotal = grandTotal + (frItemList.get(i).getItemQty() * frItemList.get(i).getItemRate1());
			setName.add(frItemList.get(i).getSubCatName());

		}

		subCatList.addAll(setName);
		System.out.println(subCatList);

		DateFormat dfReg = new SimpleDateFormat("dd/MM/yyyy");

		String todaysDate = dfReg.format(date);

		model.addObject("menuList", menuList);
		model.addObject("subCatList", subCatList);
		model.addObject("itemList", frItemList);
		model.addObject("grandTotal", grandTotal);
		model.addObject("frDetails", frDetails);

		model.addObject("currentDate", todaysDate);
		model.addObject("toTime", menuList.get(index).getTime());

		return model;

	}

	@RequestMapping("/saveOrder")
	public ModelAndView helloWorld(HttpServletRequest request, HttpServletResponse res) throws IOException {

		HttpSession session = request.getSession();
		Franchisee frDetails = (Franchisee) session.getAttribute("frDetails");

		ModelAndView mav = new ModelAndView("redirect:/showSavouries/" + globalIndex);

		List<GetFrItem> orderList = new ArrayList<>();
		for (int i = 0; i < frItemList.size(); i++) {

			GetFrItem frItem = frItemList.get(i);

			try {
				String id = frItem.getItemId();
				System.out.println("id " + id);

				String strQty = request.getParameter(id);
				int qty = Integer.parseInt(strQty);

				System.out.println(" " + id + ":" + strQty);

				if (qty > frItem.getItemQty()) {

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

			Date date = new Date(Calendar.getInstance().getTime().getTime());
			DateFormat df = new SimpleDateFormat("yyyy/MM/dd");

			String currentDate = df.format(date);

			List<Orders> orders = new ArrayList<>();

			for (int i = 0; i < orderList.size(); i++) {

				GetFrItem frItem = orderList.get(i);
				Orders o = new Orders();

				o.setDeliveryDate(date);
				o.setEditQty(frItem.getItemQty());
				o.setFrId(frDetails.getFrId());
				o.setIsEdit(1);
				o.setIsPositive(1);
				o.setItemId(frItem.getItemId());
				o.setMenuId(frItem.getMenuId());
				o.setOrderDate(date);
				o.setOrderDatetime(currentDate);
				o.setOrderMrp(frItem.getItemMrp1());
				o.setOrderQty(frItem.getItemQty());
				o.setOrderSubType(Integer.parseInt(frItem.getItemGrp2()));
				o.setOrderType(Integer.parseInt(frItem.getItemGrp1()));
				o.setProductionDate(date);
				o.setRefId(frItem.getId());
				o.setUserId(2);
				o.setOrderRate(frItem.getItemRate1());
				o.setMenuId(currentMenuId);
				orders.add(o);

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

}
