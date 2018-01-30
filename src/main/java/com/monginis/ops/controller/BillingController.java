package com.monginis.ops.controller;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.TimeZone;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.annotation.Scope;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
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

import com.monginis.ops.billing.GetBillDetail;
import com.monginis.ops.billing.GetBillDetailsResponse;
import com.monginis.ops.billing.GetBillHeader;
import com.monginis.ops.billing.GetBillHeaderResponse;
import com.monginis.ops.billing.Info;
import com.monginis.ops.constant.Constant;
import com.monginis.ops.model.Franchisee;
import com.monginis.ops.model.GetRepTaxSell;
import com.monginis.ops.model.GetSellBillHeader;


@Controller
@Scope("session")
public class BillingController {
	
	
	public GetBillHeaderResponse billHeadeResponse;
	public List<GetBillDetail> billDetailsList;
	
	
	@RequestMapping(value = "/showBill", method = RequestMethod.GET)
	public ModelAndView showBill(HttpServletRequest request,
			HttpServletResponse response) {
		
		ModelAndView modelAndView = new ModelAndView("billing/showBill");
		List<GetBillHeader> billHeader=new ArrayList<GetBillHeader>();

		try {
		     HttpSession session = request.getSession();
		     Franchisee frDetails = (Franchisee) session.getAttribute("frDetails");
		
		     RestTemplate restTemplate = new RestTemplate();
				
				MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
				DateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
				Date date = new Date();				
				System.out.println(dateFormat.format(date));
				
				
				int frId=frDetails.getFrId();
				
				
				map.add("fromDate", dateFormat.format(date));
				
				map.add("toDate", dateFormat.format(date));
				
				map.add("frId", frId);
				
			
				
				ParameterizedTypeReference<GetBillHeaderResponse> typeRef = new ParameterizedTypeReference<GetBillHeaderResponse>() {
				};
				ResponseEntity<GetBillHeaderResponse> responseEntity = restTemplate.exchange(Constant.URL + "getBillHeader",
						HttpMethod.POST, new HttpEntity<>(map), typeRef);
				
				billHeadeResponse = responseEntity.getBody();	

				billHeader = billHeadeResponse.getGetBillHeaders();
				modelAndView.addObject("fromDate", dateFormat.format(date));
				modelAndView.addObject("toDate", dateFormat.format(date));
				
				modelAndView.addObject("billHeader",billHeader);
		}
		catch(Exception e)
		{
			System.out.println("Exception in showBill"+e.getMessage());
		}
		return modelAndView;

	}
	
	
	@RequestMapping(value = "/showBillProcess", method = RequestMethod.POST)
	public ModelAndView   showBillProcess(HttpServletRequest request,
			HttpServletResponse response) {
		
		System.out.println("inside show bill process");

		
		HttpSession session = request.getSession();
		Franchisee frDetails = (Franchisee) session.getAttribute("frDetails");
		
		
		List<GetBillHeader> billHeader=new ArrayList<GetBillHeader>();
		
		
		ModelAndView modelAndView = new ModelAndView("billing/showBill");
		
		try {
		
		RestTemplate restTemplate = new RestTemplate();
		
		MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
		
		String fromDate= request.getParameter("from_datepicker");
		
		String toDate= request.getParameter("to_datepicker");
		
		modelAndView.addObject("fromDate",fromDate);
		modelAndView.addObject("toDate",toDate);
		
		int frId=frDetails.getFrId();
		
		
		map.add("fromDate", fromDate);
		
		map.add("toDate", toDate);
		
		map.add("frId", frId);
		
	
		
		ParameterizedTypeReference<GetBillHeaderResponse> typeRef = new ParameterizedTypeReference<GetBillHeaderResponse>() {
		};
		ResponseEntity<GetBillHeaderResponse> responseEntity = restTemplate.exchange(Constant.URL + "getBillHeader",
				HttpMethod.POST, new HttpEntity<>(map), typeRef);
		
		billHeadeResponse = responseEntity.getBody();	

		billHeader = billHeadeResponse.getGetBillHeaders();
		System.out.println("billHeader"+billHeader.toString());
		modelAndView.addObject("billHeader",billHeader);
		
		}catch (Exception e) {
			
			System.out.println("ex in getting bills "+e.getMessage());
			e.printStackTrace();
		}
		return modelAndView;
	
	}
	
	
	@RequestMapping(value = "/showBillDetailProcess", method = RequestMethod.GET)
	public ModelAndView   showBillDetailProcess(HttpServletRequest request,
			HttpServletResponse response) {
		
		ModelAndView modelAndView = new ModelAndView("billing/billDetails");
		
		try {
			
		String billNo=request.getParameter("billNo");
		String billDate=request.getParameter("billDate");
		String billStatus=request.getParameter("billStatus");
		String grandTotal=request.getParameter("grandTotal");
		System.out.println("billNo: "+billNo +"  Date : "+billDate +"  billStatus :"+billStatus);
		
		RestTemplate restTemplate = new RestTemplate();
		MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

		HttpSession session = request.getSession();
		Franchisee frDetails = (Franchisee) session.getAttribute("frDetails");
		
		map.add("billNo", billNo);

		GetBillDetailsResponse billDetailsResponse = restTemplate.postForObject(Constant.URL + "getBillDetails",
				map, GetBillDetailsResponse.class);

		billDetailsList = new ArrayList<GetBillDetail>();
		billDetailsList = billDetailsResponse.getGetBillDetails();
		
		modelAndView.addObject("billDetailsList",billDetailsList);
		
		modelAndView.addObject("billDate", billDate);
		modelAndView.addObject("billNo", billNo);
		modelAndView.addObject("billStatus", billStatus);
		modelAndView.addObject("grandTotal", grandTotal);
		
		}catch (Exception e) {
		System.out.println("ex in bill detail "+e.getMessage());
		e.printStackTrace();
		}
		
		
		
	return modelAndView;
	
}
	
	
	
	@RequestMapping(value = "/updateBillStatus", method = RequestMethod.GET)
	public @ResponseBody void updateBillStatus(HttpServletRequest request,
		HttpServletResponse response) {
		
		
		String billNo=request.getParameter("billNo");
		System.out.println("Bill No : "+ billNo);
		
		
		
		 System.out.println("Headerdgdgdfg List "+billHeadeResponse.getGetBillHeaders().toString());
		
		try {
			GetBillHeader getBillHeader=new GetBillHeader();
			 List<GetBillHeader> getBillHeaders=billHeadeResponse.getGetBillHeaders();
			 
			 System.out.println("Header List "+getBillHeaders.toString());
		for(int i=0;i<billHeadeResponse.getGetBillHeaders().size();i++)
		{
			if(billHeadeResponse.getGetBillHeaders().get(i).getBillNo()==Integer.parseInt(billNo))
			{
				System.out.println("first date :"+ billHeadeResponse.getGetBillHeaders().get(i).getBillDate());
				
				
				
				getBillHeader=billHeadeResponse.getGetBillHeaders().get(i);
				//postBillHeader.setBillDate(date);
				
				
							}
		}
		
		getBillHeader.setStatus(2);
		
		
		SimpleDateFormat sdf = new SimpleDateFormat("kk:mm:ss ");
		TimeZone istTimeZone = TimeZone.getTimeZone("Asia/Kolkata");
		
		Date d = new Date();
		sdf.setTimeZone(istTimeZone);
		
		String strtime = sdf.format(d);
		
		
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Calendar cal = Calendar.getInstance();
		System.out.println("************* Date Time " + dateFormat.format(cal.getTime()));
		
		getBillHeader.setBillDateTime(dateFormat.format(cal.getTime()));
		getBillHeader.setTime(strtime);
		RestTemplate restTemplate = new RestTemplate();
		try {
			
		Info info = restTemplate.postForObject(Constant.URL + "updateBillStatus", getBillHeader,
					Info.class);

			System.out.println("Message :   "+info.getMessage());
			System.out.println("Error  :    "+info.getError());
			
			
	
		}catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}catch (Exception e) {
		System.out.println("ex in update bill "+e.getMessage());
		e.printStackTrace();
	}
		
	}
}
