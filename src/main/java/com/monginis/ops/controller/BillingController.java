package com.monginis.ops.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;


import com.monginis.ops.billing.GetBillDetail;
import com.monginis.ops.billing.GetBillDetailsResponse;
import com.monginis.ops.billing.GetBillHeader;
import com.monginis.ops.billing.GetBillHeaderResponse;
import com.monginis.ops.constant.Constant;
import com.monginis.ops.model.Franchisee;


@Controller
public class BillingController {
	
	public static List<GetBillDetail> billDetailsList;
	
	
	@RequestMapping(value = "/showBill", method = RequestMethod.GET)
	public ModelAndView showBill() {
		ModelAndView modelAndView = new ModelAndView("billing/showBill");
		
		return modelAndView;

	}
	
	
	@RequestMapping(value = "/showBillProcess", method = RequestMethod.POST)
	public ModelAndView   showBillProcess(HttpServletRequest request,
			HttpServletResponse response) {
		
		HttpSession session = request.getSession();
		Franchisee frDetails = (Franchisee) session.getAttribute("frDetails");
		
		
		List<GetBillHeader> billHeader=new ArrayList<GetBillHeader>();
		
		
		//List<GetBillHeader> billHeadersList = new ArrayList<>();
		ModelAndView modelAndView = new ModelAndView("billing/showBill");
		
		RestTemplate restTemplate = new RestTemplate();
		
		MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
		
		String fromDate= request.getParameter("from_datepicker");
		
		String toDate= request.getParameter("to_datepicker");
		
		int frId=frDetails.getFrId();
		
		System.out.println("from date "+fromDate);
		
		System.out.println("to Date "+toDate);
		
		System.out.println("fr Id "+frId);
		
		map.add("fromDate", fromDate);
		
		map.add("toDate", toDate);
		
		map.add("frId", frId);
		
	
		GetBillHeaderResponse billHeadeResponse = restTemplate.postForObject(Constant.URL + "getBillHeader",
				map, GetBillHeaderResponse.class);

		billHeader = billHeadeResponse.getGetBillHeaders();

		System.out.println(" *** get Bill response  " + billHeadeResponse.getGetBillHeaders());
		
		System.out.println("thank you");
		
		modelAndView.addObject("billHeader",billHeader);
		
		return modelAndView;
	
	}
	
	
	@RequestMapping(value = "/showBillDetailProcess/{billNo}", method = RequestMethod.GET)
	public ModelAndView   showBillDetailProcess(@PathVariable int billNo, HttpServletRequest request,
			HttpServletResponse response) {
		ModelAndView modelAndView = new ModelAndView("billing/billDetails");
		RestTemplate restTemplate = new RestTemplate();
		
		HttpSession session = request.getSession();
		Franchisee frDetails = (Franchisee) session.getAttribute("frDetails");
		
		MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
		map.add("billNo", billNo);

		GetBillDetailsResponse billDetailsResponse = restTemplate.postForObject(Constant.URL + "getBillDetails",
				map, GetBillDetailsResponse.class);

	billDetailsList = new ArrayList<GetBillDetail>();
		billDetailsList = billDetailsResponse.getGetBillDetails();
		System.out.println("bill detail response "+billDetailsList.toString());
		System.out.println("bill detail size "+billDetailsList.size());
		modelAndView.addObject("billDetailsList",billDetailsList);
		
		
	return modelAndView;
	
}
}
