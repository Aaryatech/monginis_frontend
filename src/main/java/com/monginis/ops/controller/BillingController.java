package com.monginis.ops.controller;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.jasper.tagplugins.jstl.core.Catch;
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
import com.monginis.ops.model.PostBillDataCommon;
import com.monginis.ops.model.PostBillHeader;


@Controller
public class BillingController {
	
	
	public GetBillHeaderResponse billHeadeResponse;
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
		
		
		map.add("fromDate", fromDate);
		
		map.add("toDate", toDate);
		
		map.add("frId", frId);
		
	
		 // billHeadeResponse = restTemplate.postForObject(Constant.URL + "getBillHeader",
		//		map, GetBillHeaderResponse.class);
		ParameterizedTypeReference<GetBillHeaderResponse> typeRef = new ParameterizedTypeReference<GetBillHeaderResponse>() {
		};
		ResponseEntity<GetBillHeaderResponse> responseEntity = restTemplate.exchange(Constant.URL + "getBillHeader",
				HttpMethod.POST, new HttpEntity<>(map), typeRef);
		
		billHeadeResponse = responseEntity.getBody();	

		billHeader = billHeadeResponse.getGetBillHeaders();

		
		
		
		
		modelAndView.addObject("billHeader",billHeader);
		
		return modelAndView;
	
	}
	
	
	@RequestMapping(value = "/showBillDetailProcess", method = RequestMethod.GET)
	public ModelAndView   showBillDetailProcess(HttpServletRequest request,
			HttpServletResponse response) {
		System.out.println("inside process of bill details front end ***********************************");
		ModelAndView modelAndView = new ModelAndView("billing/billDetails");
		String billNo=request.getParameter("billNo");
		String billDate=request.getParameter("billDate");
		String billStatus=request.getParameter("billStatus");
		String grandTotal=request.getParameter("grandTotal");
		System.out.println("billNo: "+billNo +"  Date : "+billDate +"  billStatus :"+billStatus);
		try {
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
		}
		catch (Exception e) {
		System.out.println("ex in bill detail "+e.getMessage());
		e.printStackTrace();
		}
		
		modelAndView.addObject("billDate", billDate);
		modelAndView.addObject("billNo", billNo);
		modelAndView.addObject("billStatus", billStatus);
		modelAndView.addObject("grandTotal", grandTotal);
		
	return modelAndView;
	
}
	
	
	
	@RequestMapping(value = "/updateBillStatus", method = RequestMethod.GET)
	public @ResponseBody void updateBillStatus(HttpServletRequest request,
		HttpServletResponse response) {
		
		
		String billNo=request.getParameter("billNo");
		System.out.println("Bill No : "+ billNo);
		
		PostBillDataCommon postBillDataCommon=new PostBillDataCommon();
		
		List<PostBillHeader> postBillHeaderList=new ArrayList<PostBillHeader>();
		
		 System.out.println("Headerdgdgdfg List "+billHeadeResponse.getGetBillHeaders().toString());
		PostBillHeader postBillHeader=new PostBillHeader();
		try {
			GetBillHeader getBillHeader=new GetBillHeader();
			 List<GetBillHeader> getBillHeaders=billHeadeResponse.getGetBillHeaders();
			 
			 System.out.println("Header List "+getBillHeaders.toString());
		for(int i=0;i<billHeadeResponse.getGetBillHeaders().size();i++)
		{
			if(billHeadeResponse.getGetBillHeaders().get(i).getBillNo()==Integer.parseInt(billNo))
			{
				System.out.println("first date :"+ billHeadeResponse.getGetBillHeaders().get(i).getBillDate());
				
				/*Date date=null;
				String convertedDate=null;
				try {
					SimpleDateFormat ymdSDF = new SimpleDateFormat("yyyy-MM-dd");
					SimpleDateFormat dmySDF = new SimpleDateFormat("dd-MM-yyyy");
					Date dmyDate = dmySDF.parse(billHeadeResponse.getGetBillHeaders().get(i).getBillDate());
					
					convertedDate=ymdSDF.format(dmyDate);
					
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				System.out.println("  yyyy mm dd "+convertedDate);
				
				SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-DD");
				//String dateInString = "Jan 1, 2015"; 
				 
				try{
				 
				 date = formatter.parse(convertedDate);
				System.out.println(date);
				System.out.println(formatter.format(date));  
				//billDate =formatter.format(date);
				 
				}catch(ParseException e){
				e.printStackTrace();
				}
				// Date dt =sm.parse(billHeadeResponse.getGetBillHeaders().get(i).getBillDate());
				//System.out.println("dfghj"+date);
*/				
				
				getBillHeader=billHeadeResponse.getGetBillHeaders().get(i);
				//postBillHeader.setBillDate(date);
				
				
				/*postBillHeader.setBillNo(Integer.parseInt(billNo));
				postBillHeader.setDelStatus(billHeadeResponse.getGetBillHeaders().get(i).getDelStatus());
				postBillHeader.setFrCode(billHeadeResponse.getGetBillHeaders().get(i).getFrCode());
				postBillHeader.setFrId(billHeadeResponse.getGetBillHeaders().get(i).getFrId());
				postBillHeader.setGrandTotal(billHeadeResponse.getGetBillHeaders().get(i).getGrandTotal());
				postBillHeader.setInvoiceNo(billHeadeResponse.getGetBillHeaders().get(i).getInvoiceNo());
				postBillHeader.setRemark(billHeadeResponse.getGetBillHeaders().get(i).getRemark());
				postBillHeader.setStatus(2);
				postBillHeader.setTaxableAmt(billHeadeResponse.getGetBillHeaders().get(i).getTaxableAmt());
				postBillHeader.setTaxApplicable(billHeadeResponse.getGetBillHeaders().get(i).getTaxApplicable());
				postBillHeader.setTotalTax(billHeadeResponse.getGetBillHeaders().get(i).getTotalTax());
		
				//postBillHeader.setPostBillDetailsList(billHeadeResponse.getGetBillHeaders().get(i).get;);
				//postBillDataCommon.setPostBillHeadersList((billHeadeResponse.getGetBillHeaders());
*/			}
		}
		//postBillHeaderList.add(postBillHeader);
		//postBillDataCommon.setPostBillHeadersList(postBillHeaderList);
		getBillHeader.setStatus(2);
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
