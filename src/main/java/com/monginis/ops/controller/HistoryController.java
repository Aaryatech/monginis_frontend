package com.monginis.ops.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import com.monginis.ops.HomeController;
import com.monginis.ops.constant.Constant;
import com.monginis.ops.model.AllMenuResponse;
import com.monginis.ops.model.Franchisee;
import com.monginis.ops.model.ItemOrderHis;
import com.monginis.ops.model.ItemOrderList;
import com.monginis.ops.model.Main;
import com.monginis.ops.model.Menus;
import com.monginis.ops.model.SpOrderHis;
import com.monginis.ops.model.SpOrderHisList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Controller
@Scope("session")
public class HistoryController {
	public List<Menus> menusList;
	AllMenuResponse allMenuResponse;
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	
	
	@RequestMapping(value = "/orderHistory", method = RequestMethod.GET)
	public ModelAndView ordersHistory(HttpServletRequest request, HttpServletResponse response)
	{
		ModelAndView model = new ModelAndView("history/orderhistory");
		logger.info("/login request mapping.");
		RestTemplate rest=new RestTemplate();
	    allMenuResponse=rest.getForObject(
				Constant.URL+"/getAllMenu",
				AllMenuResponse.class);
		
		menusList= new ArrayList<Menus>();
		menusList=allMenuResponse.getMenuConfigurationPage();
		
		System.out.println("MENU LIST= "+menusList.toString());
		model.addObject("menusList",menusList);
		System.out.println("menu list is"+menusList.toString());
		model.addObject("menuId", 0);
		return model;

	}
	@RequestMapping(value = "/itemHistory", method = RequestMethod.POST)
	public ModelAndView OrderHistory(HttpServletRequest request, HttpServletResponse response) throws ParseException
	{
		
		String spDeliveryDt=request.getParameter("datepicker");

		String menuTitle="";
		
		HttpSession session=request.getSession();
		Franchisee frDetails= (Franchisee) session.getAttribute("frDetails");
		int frId=frDetails.getFrId();
		String frCode=frDetails.getFrCode();
		
		
		
		
		Menus selectedMenu=new Menus();
		int menuId=Integer.parseInt(request.getParameter("group"));
		System.out.println("spDeliveryDt"+spDeliveryDt);
		
		String parsedDate=Main.formatDate(spDeliveryDt);
		
		//String str = new SimpleDateFormat("yyyy-MM-dd").format(spDeliveryDt);
	     System.out.println("date"+parsedDate);
		ModelAndView model = new ModelAndView("history/orderhistory");

		logger.info("/order history request mapping.");
		
		try {
		
        System.out.println("menuId "+menuId);
		System.out.println("Menu List is "+menusList.toString());
		
			
	        
	
		List<SpOrderHis> spOrderHistory;
		List<ItemOrderHis> itemOrderHistory;
		for(Menus menu:menusList)
		{
			
			System.out.println("menu... "+menu.getMenuId());

			if(menu.getMenuId()==menuId)
			{
			System.out.println("menu id matched ");
				selectedMenu=menu;
				System.out.println("selected1:"+menu.getMainCatId());
				if(menu.getMainCatId()!=5)
				{
					System.out.println("item order ");

					itemOrderHistory=orderHistory(menuId,parsedDate,frId);
					System.out.println("selected1:"+itemOrderHistory.toString());
					model.addObject("orderHistory", itemOrderHistory);
				
				}
				else
				{
					System.out.println("sp cake order ");

				 spOrderHistory=spHistory(menuId,spDeliveryDt,frCode);
					System.out.println("selected2:"+spOrderHistory.toString());
				 model.addObject("orderHistory", spOrderHistory);
				
				}
				 model.addObject("selectedMenu", selectedMenu);
					break;
			}
		
			
			
			
		}
		
		}
		catch(Exception e)
		{
			System.out.println("Exception in order history"+e.getMessage());
		}
		
	
		
		
		
		menuTitle=selectedMenu.getMenuTitle();
		System.out.println("MenuTitle:"+menuTitle);
		model.addObject("menuTitle", menuTitle);

		 model.addObject("menusList", menusList);
		model.addObject("menuId", menuId);
		model.addObject("spDeliveryDt", spDeliveryDt);
		return model;

	}
	
	public List<ItemOrderHis> orderHistory(int menuId,String parsedDate,int frId)
	{
	
		
		RestTemplate rest=new RestTemplate();
		 MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
	        map.add("menuId",menuId);
	        map.add("deliveryDt",parsedDate);
	        map.add("frId",frId);
		ItemOrderList itemOrderList=rest.postForObject(
				Constant.URL+"/orderHistory",map,
				ItemOrderList.class);
		List<ItemOrderHis> itemHistory=itemOrderList.getItemOrderList();
		System.out.println("OrderList"+itemHistory.toString());
		return itemHistory;
	
	}
	
   public List<SpOrderHis> spHistory(int menuId,String parsedDate,String frCode)
	{
	  
	   System.out.println("spHistory");
		RestTemplate rest=new RestTemplate();
		 MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
	        map.add("menuId",menuId);
	        map.add("spDeliveryDt",parsedDate);
	        map.add("frCode",frCode);
		SpOrderHisList spOrderList=rest.postForObject(
				Constant.URL+"/SpCakeOrderHistory",map,
				SpOrderHisList.class);
		List<SpOrderHis> spCkHisList=spOrderList.getSpOrderList();
		System.out.println("OrderList"+spCkHisList.toString());
		return spCkHisList;
		
	}
	
}
