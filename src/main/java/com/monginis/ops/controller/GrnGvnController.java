package com.monginis.ops.controller;

import java.math.BigDecimal;
import java.sql.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.monginis.ops.billing.Info;
import com.monginis.ops.constant.Constant;
import com.monginis.ops.model.Franchisee;
import com.monginis.ops.model.GetGrnGvnDetails;
import com.monginis.ops.model.GetGrnGvnDetailsList;
import com.monginis.ops.model.grngvn.GetBillsForFr;
import com.monginis.ops.model.grngvn.GetBillsForFrList;
import com.monginis.ops.model.grngvn.GetGrnConfResponse;
import com.monginis.ops.model.grngvn.GetGrnItemConfig;
import com.monginis.ops.model.grngvn.GrnGvn;
import com.monginis.ops.model.grngvn.PostGrnGvnList;
import com.monginis.ops.util.ImageS3Util;

@Controller
public class GrnGvnController {

	public GetGrnConfResponse grnConfResponse;
	public List<GetGrnItemConfig> grnConfList;
	public List<GetGrnGvnDetails> grnGvnDetailsList;
	GetGrnGvnDetailsList getGrnGvnDetailsList;

	@RequestMapping(value = "/showGrn", method = RequestMethod.GET)
	public ModelAndView showBill(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("show Grn displayed");
		ModelAndView modelAndView = new ModelAndView("grngvn/showgrn");

		HttpSession session = request.getSession();
		Franchisee frDetails = (Franchisee) session.getAttribute("frDetails");

		RestTemplate restTemplate = new RestTemplate();

		MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

		map.add("frId", frDetails.getFrId());
		grnConfResponse = restTemplate.postForObject(Constant.URL + "getGrnItemConfig", map, GetGrnConfResponse.class);

		grnConfList = grnConfResponse.getGetGrnItemConfigs();
		System.out.println("grn conf list =" + grnConfList.toString());
		System.out.println("grn conf list size= ********************" + grnConfList.size());

		modelAndView.addObject("grnConfList", grnConfList);

		return modelAndView;

	}

	public static float roundUp(float d) {
		return BigDecimal.valueOf(d).setScale(2, BigDecimal.ROUND_HALF_UP).floatValue();
	}

	@RequestMapping(value = "/insertGrnProcess", method = RequestMethod.POST)
	public ModelAndView insertGrnProcess(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView modelAndView = new ModelAndView("grngvn/showgrn");
		try {
			System.out.println("insert grn displayed");

			HttpSession session = request.getSession();
			Franchisee frDetails = (Franchisee) session.getAttribute("frDetails");

			RestTemplate restTemplate = new RestTemplate();

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

			// PostGrnGvnList postGrnGvnList=new PostGrnGvnList();

			List<GrnGvn> postGrnGvnList = new ArrayList<GrnGvn>();

			PostGrnGvnList postGrnList = new PostGrnGvnList();

			grnConfList = grnConfResponse.getGetGrnItemConfigs();

			for (int i = 0; i < grnConfList.size(); i++) {

				DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				Calendar cal = Calendar.getInstance();
				System.out.println("************* Date Time " + dateFormat.format(cal.getTime()));

				DateFormat dateFormatDate = new SimpleDateFormat("yyyy-MM-dd");
				Calendar calDate = Calendar.getInstance();
				System.out.println("************* Date  " + dateFormatDate.format(calDate.getTime()));

				GrnGvn postGrnGvn = new GrnGvn();

				int grnQty = Integer.parseInt(request.getParameter("grn_qty" + grnConfList.get(i).getItemId()));
				String frGrnRemark = request.getParameter("grn_remark" + grnConfList.get(i).getItemId());
				int isEdit=Integer.parseInt(request.getParameter("is_edit"+grnConfList.get(i).getItemId()));
				
				System.out.println("is Edit "+isEdit);
				
				System.out.println("fr grn remark= " + frGrnRemark);

				if (frGrnRemark == null || frGrnRemark == "") {
					frGrnRemark = "no remark entered";
					// System.out.println("fr grn remark "+frGrnRemark);

				}
				System.out.println("fr grn remark " + frGrnRemark);

				System.out.println("******************** grn qty for " + i + "is=" + grnQty);

				float grnAmt = grnQty * grnConfList.get(i).getRate();
				grnAmt = roundUp(grnAmt);

				if (grnConfList.get(i).getGrnType() == 0) {
					grnAmt = grnAmt * 75 / 100;
					postGrnGvn.setGrnGvnAmt(roundUp(grnAmt));
				}

				if (grnConfList.get(i).getGrnType() == 1) {
					grnAmt = grnAmt * 90 / 100;
					postGrnGvn.setGrnGvnAmt(roundUp(grnAmt));
				}

				if (grnConfList.get(i).getGrnType() == 2) {
					postGrnGvn.setGrnGvnAmt(roundUp(grnAmt));
				}

				java.sql.Date grnGvnDate = new java.sql.Date(Calendar.getInstance().getTime().getTime());

				postGrnGvn.setGrnGvnDate(grnGvnDate);// 1
				System.out.println("c date *********" + grnGvnDate);
				System.out.println("c date time *********" + dateFormat.format(cal.getTime()));

				postGrnGvn.setBillNo(grnConfList.get(i).getBillNo());// 2
				postGrnGvn.setFrId(frDetails.getFrId());// 3
				postGrnGvn.setItemId(grnConfList.get(i).getItemId());// 4
				postGrnGvn.setItemRate(grnConfList.get(i).getRate());// 5
				postGrnGvn.setItemMrp(grnConfList.get(i).getMrp());// 6
				postGrnGvn.setGrnGvnQty(grnQty);// 7
				// postGrnGvn.setGrnGvnAmt(grnAmt);//8
				postGrnGvn.setGrnType(grnConfList.get(i).getGrnType());// 9
				postGrnGvn.setIsGrn(1);// 10
				postGrnGvn.setIsGrnEdit(isEdit);// 11
				postGrnGvn.setGrnGvnEntryDateTime(dateFormat.format(cal.getTime()));// 12
				postGrnGvn.setFrGrnGvnRemark(frGrnRemark);// 13
				postGrnGvn.setGvnPhotoUpload1("grn:no photo");// 14
				postGrnGvn.setGvnPhotoUpload2("grn:no photo");// 15
				postGrnGvn.setGrnGvnStatus(1);// 16
				postGrnGvn.setApprovedLoginGate(0);// 17
				postGrnGvn.setApproveimedDateTimeGate(dateFormat.format(cal.getTime()));// 18
				postGrnGvn.setApprovedRemarkGate("gate remark");// 19

				postGrnGvn.setApprovedLoginStore(0);// 20
				postGrnGvn.setApprovedDateTimeStore(dateFormat.format(cal.getTime()));// 21
				postGrnGvn.setApprovedRemarkStore("store remark");// 22
				postGrnGvn.setApprovedLoginAcc(0);// 23
				postGrnGvn.setGrnApprovedDateTimeAcc(dateFormat.format(cal.getTime()));// 24
				postGrnGvn.setApprovedRemarkAcc("account remark");// 25

				postGrnGvn.setDelStatus(0);// 26
				postGrnGvn.setGrnGvnQtyAuto(0);// 27

				postGrnGvnList.add(postGrnGvn);

			}

			modelAndView.addObject("grnConfList", grnConfList);
			System.out.println("postGrnGvnList************----- " + postGrnGvnList.toString());

			System.out.println("****postGrnGvnList size*******-- " + postGrnGvnList.size());

			postGrnList.setGrnGvn(postGrnGvnList);

			System.out.println("post grn for rest----- " + postGrnList.toString());
			System.out.println("post grn for rest size " + postGrnList.getGrnGvn().size());

			Info info = restTemplate.postForObject(Constant.URL + "insertGrnGvn", postGrnList, Info.class);

		} catch (Exception e) {
			System.out.println("exce in grn insert " + e.getMessage());
			e.printStackTrace();
		}

		return modelAndView;

	}

	List<GetBillsForFr> frBillList;

	@RequestMapping(value = "/showGvn", method = RequestMethod.GET)
	public ModelAndView showGvnProcess(HttpServletRequest request, HttpServletResponse response) {

		System.out.println("inside showGvn ");
		ModelAndView modelAndView = new ModelAndView("grngvn/showgvn");
		System.out.println("after  showGvn ");

		HttpSession session = request.getSession();
		Franchisee frDetails = (Franchisee) session.getAttribute("frDetails");

		RestTemplate restTemplate = new RestTemplate();

		MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

		int frId = frDetails.getFrId();
		System.out.println("fr Id =" + frId);
		try {
			map.add("frId", frId);

			GetBillsForFrList billsForFr = restTemplate.postForObject(Constant.URL + "getBillsForFr", map,
					GetBillsForFrList.class);

			frBillList = billsForFr.getGetBillsForFr();

			modelAndView.addObject("frBillList", frBillList);

			System.out.println("frBillList  " + frBillList.toString());

		} catch (Exception e) {
			System.out.println("ex in shw gvn " + e.getMessage());
		}

		return modelAndView;
	}

	/*
	 * @RequestMapping(value = "/getItemForCategory", method = RequestMethod.GET)
	 * public @ResponseBody List<GetItemByCatId>
	 * getItemForCategory(@RequestParam(value = "catId", required = true) int catId)
	 * {
	 * 
	 * 
	 * List<GetItemByCatId> itemList = new ArrayList<GetItemByCatId>(); RestTemplate
	 * restTemplate = new RestTemplate();
	 * 
	 * MultiValueMap<String, Object> map = new LinkedMultiValueMap<String,
	 * Object>();
	 * 
	 * map.add("catId", catId);
	 * 
	 * GetItemByCatIdList getItemByCateId=restTemplate.postForObject(Constant.URL+
	 * "getItemByCategoryId",map, GetItemByCatIdList.class);
	 * 
	 * itemList=getItemByCateId.getGetItemByCatId();
	 * System.out.println("items for selected category "+itemList.toString());
	 * 
	 * return itemList; }
	 */

	@RequestMapping(value = "/getGvnBillDetails", method = RequestMethod.GET)
	public ModelAndView getGvnBillDetails(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView modelAndView = new ModelAndView("grngvn/showgvn");

		int billNo = Integer.parseInt(request.getParameter("bill_no"));
		System.out.println("selected bill no " + billNo);

		RestTemplate restTemplate = new RestTemplate();

		MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

		map.add("billNo", billNo);

		grnConfResponse = restTemplate.postForObject(Constant.URL + "getGvnItemConfig", map, GetGrnConfResponse.class);

		grnConfList = grnConfResponse.getGetGrnItemConfigs();
		// public List<GetGrnItemConfig> grnConfList;
		System.out.println("gvn conf list " + grnConfList.toString());

		modelAndView.addObject("gvnConfList", grnConfList);

		modelAndView.addObject("frBillList", frBillList);

		return modelAndView;

	}

	@RequestMapping(value = "/addGvnProcess", method = RequestMethod.POST)
	public ModelAndView addGvnProcess(@RequestParam("gvn_photo1") MultipartFile[] photo1, @RequestParam("gvn_photo2") MultipartFile[] photo2,HttpServletRequest request, HttpServletResponse response
			) {
		ModelAndView modelAndView = new ModelAndView("grngvn/showgvn");

		/*
		 * int billNo=Integer.parseInt(request.getParameter("bill_no"));
		 * System.out.println("selected bill no "+billNo);
		 */
		
		RestTemplate restTemplate = new RestTemplate();
		grnConfList = grnConfResponse.getGetGrnItemConfigs();

		HttpSession session = request.getSession();
		Franchisee frDetails = (Franchisee) session.getAttribute("frDetails");

		List<GrnGvn> postGrnGvnList = new ArrayList<GrnGvn>();
		
		for(int i=0;i<photo1.length;i++) {
			
			System.out.println("Photo1  of: " +i +" image: "+ photo1[i].getOriginalFilename());
					
			
		}
		
		for(int j=0;j<photo2.length;j++) {
			
			System.out.println("Photo2  of: " +j +" image: "+ photo2[j].getOriginalFilename());

			
		}

	

		PostGrnGvnList postGrnList = new PostGrnGvnList();
		// String spImage= com.monginis.ops.util.ImageS3Util.uploadSpCakeImage(file);
		for (int i = 0; i < grnConfList.size(); i++) {
			//System.out.println("imgae name array " + photo1.toString());
			String strGvnQty = request.getParameter("gvn_qty" + grnConfList.get(i).getItemId());
			int gvnQty = Integer.parseInt(strGvnQty);
			
			System.out.println("GVN Qty of: "+grnConfList.get(i).getItemName()+" is: "+gvnQty);
	
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Calendar cal = Calendar.getInstance();
			System.out.println("************* Date Time " + dateFormat.format(cal.getTime()));

			DateFormat dateFormatDate = new SimpleDateFormat("yyyy-MM-dd");
			Calendar calDate = Calendar.getInstance();
			System.out.println("************* Date  " + dateFormatDate.format(calDate.getTime()));

			float gvnAmt = gvnQty * grnConfList.get(i).getRate();
			gvnAmt = roundUp(gvnAmt);

			String frGvnRemark = request.getParameter("gvn_remark" + grnConfList.get(i).getItemId());
			System.out.println("fr grn remark= " + frGvnRemark);

			if (frGvnRemark == null || frGvnRemark == "") {
				frGvnRemark = "no remark entered";
				// System.out.println("fr grn remark "+frGrnRemark);

			}

			if (gvnQty > 0) {
				
				
				
				GrnGvn postGrnGvn = new GrnGvn();

				java.sql.Date grnGvnDate = new java.sql.Date(Calendar.getInstance().getTime().getTime());

				postGrnGvn.setGrnGvnAmt(gvnAmt);
				postGrnGvn.setGrnGvnDate(grnGvnDate);// 1
				System.out.println("c date *********" + grnGvnDate);
				System.out.println("c date time *********" + dateFormat.format(cal.getTime()));

				postGrnGvn.setBillNo(grnConfList.get(i).getBillNo());// 2
				postGrnGvn.setFrId(frDetails.getFrId());// 3
				postGrnGvn.setItemId(grnConfList.get(i).getItemId());// 4
				postGrnGvn.setItemRate(grnConfList.get(i).getRate());// 5
				postGrnGvn.setItemMrp(grnConfList.get(i).getMrp());// 6
				postGrnGvn.setGrnGvnQty(gvnQty);// 7
				// postGrnGvn.setGrnGvnAmt(grnAmt);//8
				postGrnGvn.setGrnType(4);// 9
				postGrnGvn.setIsGrn(0);// 10
				postGrnGvn.setIsGrnEdit(1);// 11
				postGrnGvn.setGrnGvnEntryDateTime(dateFormat.format(cal.getTime()));// 12
				postGrnGvn.setFrGrnGvnRemark(frGvnRemark);// 13
				//postGrnGvn.setGvnPhotoUpload1(spImage);// 14
				//postGrnGvn.setGvnPhotoUpload2("grn:no photo");// 15
				postGrnGvn.setGrnGvnStatus(1);// 16
				postGrnGvn.setApprovedLoginGate(0);// 17
				postGrnGvn.setApproveimedDateTimeGate(dateFormat.format(cal.getTime()));// 18
				postGrnGvn.setApprovedRemarkGate("gate remark");// 19

				postGrnGvn.setApprovedLoginStore(0);// 20
				postGrnGvn.setApprovedDateTimeStore(dateFormat.format(cal.getTime()));// 21
				postGrnGvn.setApprovedRemarkStore("store remark");// 22
				postGrnGvn.setApprovedLoginAcc(0);// 23
				postGrnGvn.setGrnApprovedDateTimeAcc(dateFormat.format(cal.getTime()));// 24
				postGrnGvn.setApprovedRemarkAcc("account remark");// 25

				postGrnGvn.setDelStatus(0);// 26
				postGrnGvn.setGrnGvnQtyAuto(0);// 27
				
				
				String gvnPhoto1=ImageS3Util.uploadSpCakeImage(photo1[i]);
				postGrnGvn.setGvnPhotoUpload1(gvnPhoto1);
				String gvnPhoto2=ImageS3Util.uploadSpCakeImage(photo2[i]);

				postGrnGvn.setGvnPhotoUpload2(gvnPhoto2);

				postGrnGvnList.add(postGrnGvn);

			} // end of if

		} // end of for

		postGrnList.setGrnGvn(postGrnGvnList);

		System.out.println("post grn for rest----- " + postGrnList.toString());
		System.out.println("post grn for rest size " + postGrnList.getGrnGvn().size());

		
		  Info info=restTemplate.postForObject(Constant.URL + "insertGrnGvn",
		  postGrnList, Info.class);
		 

		return modelAndView;
	}

	@RequestMapping(value = "/getGrnList", method = RequestMethod.GET)
	public @ResponseBody List<GetGrnGvnDetails> getGrnDetails(HttpServletRequest request,
			HttpServletResponse response) {
		// ModelAndView modelAndView = new ModelAndView("grngvn/displaygrn");

		System.out.println("in method");
		String fromDate = request.getParameter("fromDate");
		String toDate = request.getParameter("toDate");

		HttpSession ses = request.getSession();
		Franchisee frDetails = (Franchisee) ses.getAttribute("frDetails");

		RestTemplate restTemplate = new RestTemplate();

		MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
		int frId = frDetails.getFrId();
		map.add("frId", frId);
		map.add("fromDate", fromDate);
		map.add("toDate", toDate);
		// getFrGrnDetail
		try {
			// getGrnGvnDetailsList=restTemplate.postForObject(Constant.URL+
			// "getFrGrnDetail",map, GetGrnGvnDetailsList.class);

			ParameterizedTypeReference<GetGrnGvnDetailsList> typeRef = new ParameterizedTypeReference<GetGrnGvnDetailsList>() {
			};
			ResponseEntity<GetGrnGvnDetailsList> responseEntity = restTemplate
					.exchange(Constant.URL + "getFrGrnDetails", HttpMethod.POST, new HttpEntity<>(map), typeRef);

			getGrnGvnDetailsList = responseEntity.getBody();
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}
		grnGvnDetailsList = getGrnGvnDetailsList.getGrnGvnDetails();

		System.out.println("grn conf list " + grnGvnDetailsList.toString());
		System.out.println("grn  list " + grnGvnDetailsList);

		// modelAndView.addObject("grnList",grnGvnDetailsList);
		// modelAndView.addObject("fromDate",fromDate);
		// modelAndView.addObject("toDate",toDate);

		return grnGvnDetailsList;

	}

	@RequestMapping(value = "/displayGrn", method = RequestMethod.GET)
	public ModelAndView showGrnDetails(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView modelAndView = new ModelAndView("grngvn/displaygrn");
		return modelAndView;

	}

	@RequestMapping(value = "/displayGvn", method = RequestMethod.GET)
	public ModelAndView showGvnDetails(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView modelAndView = new ModelAndView("grngvn/displaygvn");
		return modelAndView;

	}

	@RequestMapping(value = "/getGvnList", method = RequestMethod.GET)
	public @ResponseBody List<GetGrnGvnDetails> getGvnDetails(HttpServletRequest request,
			HttpServletResponse response) {
		// ModelAndView modelAndView = new ModelAndView("grngvn/displaygvn");

		System.out.println("in method");
		String fromDate = request.getParameter("fromDate");
		String toDate = request.getParameter("toDate");
		System.out.println("From " + fromDate + "   To   " + toDate);
		HttpSession ses = request.getSession();
		Franchisee frDetails = (Franchisee) ses.getAttribute("frDetails");

		RestTemplate restTemplate = new RestTemplate();

		MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
		int frId = frDetails.getFrId();
		map.add("frId", frId);
		map.add("fromDate", fromDate);
		map.add("toDate", toDate);
		// getFrGrnDetail
		try {
			// getGrnGvnDetailsList=restTemplate.postForObject(Constant.URL+
			// "getFrGvnDetail",map, GetGrnGvnDetailsList.class);

			ParameterizedTypeReference<GetGrnGvnDetailsList> typeRef = new ParameterizedTypeReference<GetGrnGvnDetailsList>() {
			};
			ResponseEntity<GetGrnGvnDetailsList> responseEntity = restTemplate
					.exchange(Constant.URL + "getFrGvnDetails", HttpMethod.POST, new HttpEntity<>(map), typeRef);

			getGrnGvnDetailsList = responseEntity.getBody();
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}
		grnGvnDetailsList = getGrnGvnDetailsList.getGrnGvnDetails();

		System.out.println("gvn  list " + grnGvnDetailsList);
		for (int i = 0; i < grnGvnDetailsList.size(); i++) {
			grnGvnDetailsList.get(i)
					.setGvnPhotoUpload1(Constant.SPCAKE_IMAGE_URL + grnGvnDetailsList.get(i).getGvnPhotoUpload1());
			grnGvnDetailsList.get(i)
					.setGvnPhotoUpload2(Constant.SPCAKE_IMAGE_URL + grnGvnDetailsList.get(i).getGvnPhotoUpload2());

		}

		// modelAndView.addObject("gvnList",grnGvnDetailsList);
		// modelAndView.addObject("fromDate",fromDate);
		// modelAndView.addObject("toDate",toDate);

		return grnGvnDetailsList;

	}

}
