package com.monginis.ops.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import com.monginis.ops.common.DateConvertor;
import com.monginis.ops.constant.Constant;
import com.monginis.ops.model.FrSupplier;
import com.monginis.ops.model.Franchisee;
import com.monginis.ops.model.TSellReport;

@Controller
@Scope("session")
public class SellReport {
	
	@RequestMapping(value = "/hsnWiseReport", method = RequestMethod.GET)
	public ModelAndView hsnWiseReport(HttpServletRequest request,
				HttpServletResponse response) {

			ModelAndView model = new ModelAndView("report/sellReport/hsnWiseReport");
			 
			return model;			
	}
	
	@RequestMapping(value = "/getHsnWiseReport", method = RequestMethod.GET)
	@ResponseBody
	public List<TSellReport> getHsnWiseReport(HttpServletRequest request,
				HttpServletResponse response) {

		List<TSellReport> tSellReport = new ArrayList<TSellReport>();
			try {
			HttpSession ses = request.getSession();
			Franchisee frDetails = (Franchisee) ses.getAttribute("frDetails");
			String fromDate = request.getParameter("fromDate");
			String toDate = request.getParameter("toDate");
			
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("frId", frDetails.getFrId());
			map.add("fromDate", DateConvertor.convertToYMD(fromDate));
			map.add("toDate", DateConvertor.convertToYMD(toDate));
			
			RestTemplate rest = new RestTemplate();
			tSellReport = rest.postForObject(Constant.URL + "/tSellReport",map,
					List.class);
			
			System.out.println("tSellReport " + tSellReport);
			
			}
			catch(Exception e)
			{
				e.printStackTrace();
				
			}
			return tSellReport;			
	}

}
