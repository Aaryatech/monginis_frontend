package com.monginis.ops.controller;

import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Scope;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import com.monginis.ops.billing.SellBillDetail;
import com.monginis.ops.billing.SellBillHeader;
import com.monginis.ops.constant.Constant;
import com.monginis.ops.model.CustomerBillData;
import com.monginis.ops.model.CustomerBillItem;
import com.monginis.ops.model.FrMenu;
import com.monginis.ops.model.Franchisee;
import com.monginis.ops.model.GetCurrentStockDetails;
import com.monginis.ops.model.GetFrItem;

import com.monginis.ops.model.GetSellBillDetail;
import com.monginis.ops.model.GetSellBillHeader;
import com.monginis.ops.model.Info;
import com.monginis.ops.model.Item;
import com.monginis.ops.model.ItemResponse;
import com.monginis.ops.model.Main;
import com.monginis.ops.model.PostFrItemStockHeader;
import com.monginis.ops.model.SellBillDataCommon;

@Controller
public class CustomerBillController {

	public static List<GetCurrentStockDetails> currentStockDetailList = new ArrayList<GetCurrentStockDetails>();//

	// static ItemList
	
	public List<CustomerBillItem> customerBillItemList = new ArrayList<CustomerBillItem>();

	public static CustomerBillData customerBillDataToken1 = new CustomerBillData();

	
	public CustomerBillData customerBillDataToken2 = new CustomerBillData();

	public static CustomerBillData customerBillDataToken3 = new CustomerBillData();

	public static CustomerBillData customerBillDataToken4 = new CustomerBillData();

	public static CustomerBillData customerBillDataToken5 = new CustomerBillData();

	public static CustomerBillData customerBillDataToken6 = new CustomerBillData();

	public static CustomerBillData customerBillDataToken7 = new CustomerBillData();

	public  CustomerBillItem currentNewItem1 = new CustomerBillItem();

	
	public CustomerBillItem currentNewItem2 = new CustomerBillItem();

	public  CustomerBillItem currentNewItem3 = new CustomerBillItem();

	public  CustomerBillItem currentNewItem4 = new CustomerBillItem();

	public  CustomerBillItem currentNewItem5 = new CustomerBillItem();

	public  CustomerBillItem currentNewItem6 = new CustomerBillItem();

	public  CustomerBillItem currentNewItem7 = new CustomerBillItem();

	List<GetSellBillHeader> getSellBillHeaderList;
	List<GetSellBillDetail> getSellBillDetailList;

	int menuId;
	private static String itemShowGlobal;
	
	
	
	

	@RequestMapping(value = "/viewBill", method = RequestMethod.GET)
	public ModelAndView viewBill(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("frSellBilling/showSellBill");
		return model;
	}

	@RequestMapping(value = "/getSellBillHeader", method = RequestMethod.GET)
	public @ResponseBody List<GetSellBillHeader> getSellBillHeader(HttpServletRequest request,
			HttpServletResponse response) {

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

			ParameterizedTypeReference<List<GetSellBillHeader>> typeRef = new ParameterizedTypeReference<List<GetSellBillHeader>>() {
			};
			ResponseEntity<List<GetSellBillHeader>> responseEntity = restTemplate
					.exchange(Constant.URL + "getSellBillHeader", HttpMethod.POST, new HttpEntity<>(map), typeRef);

			getSellBillHeaderList = responseEntity.getBody();
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}

		System.out.println("Sell Bill Header " + getSellBillHeaderList.toString());

		return getSellBillHeaderList;

	}

	@RequestMapping(value = "/viewBillDetails", method = RequestMethod.GET)
	public ModelAndView viewBillDetails(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("frSellBilling/showSellBillDetails");

		System.out.println("in method");

		String sellBill_no = request.getParameter("sellBillNo");

		String billDate = request.getParameter("billDate");

		RestTemplate restTemplate = new RestTemplate();

		MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
		int sellBillNo = Integer.parseInt(sellBill_no);
		map.add("sellBillNo", sellBillNo);

		try {

			ParameterizedTypeReference<List<GetSellBillDetail>> typeRef = new ParameterizedTypeReference<List<GetSellBillDetail>>() {
			};
			ResponseEntity<List<GetSellBillDetail>> responseEntity = restTemplate
					.exchange(Constant.URL + "getSellBillDetail", HttpMethod.POST, new HttpEntity<>(map), typeRef);

			getSellBillDetailList = responseEntity.getBody();
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
			model.addObject("getSellBillDetailList", getSellBillDetailList);
			model.addObject("sellBillNo", sellBillNo);
			model.addObject("billDate", billDate);

		}

		System.out.println("Sell Bill Detail " + getSellBillDetailList.toString());

		model.addObject("getSellBillDetailList", getSellBillDetailList);
		model.addObject("sellBillNo", sellBillNo);
		model.addObject("billDate", billDate);

		return model;
	}

	@RequestMapping(value = "/showCustomerBill1", method = RequestMethod.GET)
	public ModelAndView displayCustomerBill1(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("frSellBilling/customerBill");

		resetData1();
		resetData2();
		resetData3();
		resetData4();
		resetData5();
		resetData6();
		resetData7();

		resetDataOfStockList();
		HttpSession session = request.getSession();
		try {

			ArrayList<FrMenu> menuList = (ArrayList<FrMenu>) session.getAttribute("menuList");
			Franchisee frDetails = (Franchisee) session.getAttribute("frDetails");

			System.out.println("menuList" + menuList.toString());
			ArrayList<Integer> itemList = new ArrayList<Integer>();

			String items;
			StringBuilder builder = new StringBuilder();
			for (FrMenu frMenu : menuList) {

				if (frMenu.getMenuId() == 26 || frMenu.getMenuId() == 31 || frMenu.getMenuId() == 33
						|| frMenu.getMenuId() == 34) {

					String str = frMenu.getItemShow();
					System.out.println("getItemShow" + frMenu.getItemShow());

					builder.append("," + frMenu.getItemShow());

				}

			}
			items = builder.toString();
			items = items.substring(1, items.length());

			System.out.println("Item Show List is " + items);
			itemShowGlobal = items;

			RestTemplate restTemplate = new RestTemplate();
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("itemList", items);

			ItemResponse itemsList = restTemplate.postForObject(Constant.URL + "/getItemsById", map,
					ItemResponse.class);

			List<Item> newItemsList = itemsList.getItemList();

			customerBillItemList = new ArrayList<CustomerBillItem>();

			for (int i = 0; i < newItemsList.size(); i++) {

				Item item = newItemsList.get(i);

				CustomerBillItem customerBillItem = new CustomerBillItem();
				customerBillItem.setCatId(item.getItemGrp1());
				customerBillItem.setId(item.getId());
				customerBillItem.setItemId(item.getItemId());
				customerBillItem.setItemName(item.getItemName());
				customerBillItem.setQty(0);
				customerBillItem.setItemTax1(item.getItemTax1());
				customerBillItem.setItemTax2(item.getItemTax2());
				customerBillItem.setItemTax3(item.getItemTax3());

				if (frDetails.getFrRateCat() == 1) {
					customerBillItem.setMrp(item.getItemMrp1());
					customerBillItem.setRate(item.getItemRate1());
				} else if (frDetails.getFrRateCat() == 2) {
					customerBillItem.setMrp(item.getItemMrp2());

					customerBillItem.setRate(item.getItemRate2());

				} else if (frDetails.getFrRateCat() == 3) {
					customerBillItem.setMrp(item.getItemMrp3());

					customerBillItem.setRate(item.getItemRate3());
				}

				customerBillItemList.add(customerBillItem);

			}

			System.out.println("*********customerBillItemList***********" + customerBillItemList.toString());

			model.addObject("itemListResponse", customerBillItemList);
		} catch (Exception e) {
			System.out.println("Exception in Display Customer Bill");
			model.addObject("itemListResponse", customerBillItemList);
		}

		return model;

	}
	
	@RequestMapping(value = "/showCustomerBill", method = RequestMethod.GET)
	public ModelAndView displayCustomerBill(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("frSellBilling/customerBill");

		resetData1();
		resetData2();
		resetData3();
		resetData4();
		resetData5();
		resetData6();
		resetData7();

		resetDataOfStockList();
		HttpSession session = request.getSession();
		try {

			ArrayList<FrMenu> menuList = (ArrayList<FrMenu>) session.getAttribute("menuList");
			Franchisee frDetails = (Franchisee) session.getAttribute("frDetails");

			System.out.println("menuList" + menuList.toString());
			ArrayList<Integer> itemList = new ArrayList<Integer>();

			String items;
			StringBuilder builder = new StringBuilder();
			for (FrMenu frMenu : menuList) {

				if (frMenu.getMenuId() == 26 || frMenu.getMenuId() == 31 || frMenu.getMenuId() == 33
						|| frMenu.getMenuId() == 34) {

					String str = frMenu.getItemShow();
					System.out.println("getItemShow" + frMenu.getItemShow());

					builder.append("," + frMenu.getItemShow());

				}

			}
			items = builder.toString();
			items = items.substring(1, items.length());

			System.out.println("Item Show List is " + items);
			itemShowGlobal = items;

			RestTemplate restTemplate = new RestTemplate();
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("itemList", items);

			ItemResponse itemsList = restTemplate.postForObject(Constant.URL + "/getItemsById", map,
					ItemResponse.class);

			List<Item> newItemsList = itemsList.getItemList();

			customerBillItemList = new ArrayList<CustomerBillItem>();

			for (int i = 0; i < newItemsList.size(); i++) {

				Item item = newItemsList.get(i);

				CustomerBillItem customerBillItem = new CustomerBillItem();
				customerBillItem.setCatId(item.getItemGrp1());
				customerBillItem.setId(item.getId());
				customerBillItem.setItemId(item.getItemId());
				customerBillItem.setItemName(item.getItemName());
				customerBillItem.setQty(0);
				customerBillItem.setItemTax1(item.getItemTax1());
				customerBillItem.setItemTax2(item.getItemTax2());
				customerBillItem.setItemTax3(item.getItemTax3());

				if (frDetails.getFrRateCat() == 1) {
					customerBillItem.setMrp(item.getItemMrp1());
					customerBillItem.setRate(item.getItemRate1());
				} else if (frDetails.getFrRateCat() == 2) {
					customerBillItem.setMrp(item.getItemMrp2());

					customerBillItem.setRate(item.getItemRate2());

				} else if (frDetails.getFrRateCat() == 3) {
					customerBillItem.setMrp(item.getItemMrp3());

					customerBillItem.setRate(item.getItemRate3());
				}

				customerBillItemList.add(customerBillItem);

			}

			System.out.println("*********customerBillItemList***********" + customerBillItemList.toString());

			model.addObject("itemListResponse", customerBillItemList);
		} catch (Exception e) {
			System.out.println("Exception in Display Customer Bill");
			model.addObject("itemListResponse", customerBillItemList);
		}

		return model;

	}

	public static float roundUp(float d) {
		return BigDecimal.valueOf(d).setScale(2, BigDecimal.ROUND_HALF_UP).floatValue();
	}

	public void resetDataOfStockList() {
		currentStockDetailList = new ArrayList<GetCurrentStockDetails>();//
	}

	public void resetData1() {
		customerBillDataToken1 = new CustomerBillData();
		List<CustomerBillItem> customerBillList = new ArrayList<>();
		customerBillDataToken1.setCustomerBillList(customerBillList);

		customerBillDataToken1.setTotal(0.0);
		customerBillDataToken1.setGrandTotal(0.0);
		customerBillDataToken1.setDiscount(0.0);
	}

	public void resetData2() {
		customerBillDataToken2 = new CustomerBillData();
		List<CustomerBillItem> customerBillList = new ArrayList<>();
		customerBillDataToken2.setCustomerBillList(customerBillList);
	}

	public void resetData3() {
		customerBillDataToken3 = new CustomerBillData();
		List<CustomerBillItem> customerBillList = new ArrayList<>();
		customerBillDataToken3.setCustomerBillList(customerBillList);
	}

	public void resetData4() {
		customerBillDataToken4 = new CustomerBillData();
		List<CustomerBillItem> customerBillList = new ArrayList<>();
		customerBillDataToken4.setCustomerBillList(customerBillList);
	}

	public void resetData5() {
		customerBillDataToken5 = new CustomerBillData();
		List<CustomerBillItem> customerBillList = new ArrayList<>();
		customerBillDataToken5.setCustomerBillList(customerBillList);
	}

	public void resetData6() {
		customerBillDataToken6 = new CustomerBillData();
		List<CustomerBillItem> customerBillList = new ArrayList<>();
		customerBillDataToken6.setCustomerBillList(customerBillList);
	}

	public void resetData7() {
		customerBillDataToken7 = new CustomerBillData();
		List<CustomerBillItem> customerBillList = new ArrayList<>();
		customerBillDataToken7.setCustomerBillList(customerBillList);
	}

	// ----------------------------------------------------------------------------------------------
	@RequestMapping(value = "/generateSellBill1", method = RequestMethod.GET)
	public @ResponseBody List<CustomerBillItem> generateSellBill1(HttpServletRequest request,
			HttpServletResponse response) {

		ModelAndView model = new ModelAndView("frSellBilling/customerBill");
		String orderResponse = "";

		HttpSession session = request.getSession();

		Franchisee frDetails = (Franchisee) session.getAttribute("frDetails");
		java.sql.Date cDate = new java.sql.Date(Calendar.getInstance().getTime().getTime());

		try {

			double billGrandTotal;
			double calBillGrandTotal;
			double billTotal;
			String gstNo = "";
			String phoneNo = "";

			String custName = request.getParameter("custName");
			System.out.println("Customer Name:" + custName);

			gstNo = request.getParameter("gstNo");
			System.out.println("Gst No:" + gstNo);

			phoneNo = request.getParameter("phoneNo");
			System.out.println("phoneNo:" + phoneNo);

			float discountPer = Float.parseFloat(request.getParameter("discount"));
			System.out.println("discount:" + discountPer);

			int paymentMode = Integer.parseInt(request.getParameter("paymentMode"));
			System.out.println("paymentMode:" + paymentMode);

			float paidAmount = Float.parseFloat(request.getParameter("paidAmount"));
			System.out.println("paidAmount:" + paidAmount);

			if (discountPer != 0) {
				billTotal = customerBillDataToken1.getTotal();

				calBillGrandTotal = billTotal - (billTotal * (discountPer / 100));

			} else {

				billTotal = customerBillDataToken1.getTotal();

				calBillGrandTotal = billTotal;

			}

			DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
			LocalDate localDate = LocalDate.now();
			System.out.println(dtf.format(localDate)); // 2016/11/16

			SellBillHeader sellBillHeader = new SellBillHeader();

			sellBillHeader.setFrId(frDetails.getFrId());
			sellBillHeader.setFrCode(frDetails.getFrCode());
			sellBillHeader.setDelStatus(0);
			sellBillHeader.setUserName(custName);
			sellBillHeader.setBillDate(dtf.format(localDate));

			sellBillHeader.setInvoiceNo(0);// hardcoded
			sellBillHeader.setPaidAmt(paidAmount);
			sellBillHeader.setPaymentMode(paymentMode);
			sellBillHeader.setBillType('R');

			sellBillHeader.setSellBillNo(0);

			sellBillHeader.setUserGstNo(gstNo);

			sellBillHeader.setUserPhone(phoneNo);

			System.out.println("Sell Bill Header: " + sellBillHeader.toString());

			List<SellBillDetail> sellBillDetailList = new ArrayList<SellBillDetail>();
			List<CustomerBillItem> customerBillItemList = customerBillDataToken1.getCustomerBillList();

			float sumTaxableAmt = 0, sumTotalTax = 0, sumGrandTotal = 0;

			for (int i = 0; i < customerBillItemList.size(); i++) {

				SellBillDetail sellBillDetail = new SellBillDetail();

				Float rate = (float) customerBillItemList.get(i).getMrp();

				Float tax1 = (float) customerBillItemList.get(i).getItemTax1();
				Float tax2 = (float) customerBillItemList.get(i).getItemTax2();
				Float tax3 = (float) customerBillItemList.get(i).getItemTax3();

				int qty = customerBillItemList.get(i).getQty();

				Float mrpBaseRate = (rate * 100) / (100 + (tax1 + tax2));
				mrpBaseRate = roundUp(mrpBaseRate);

				System.out.println("Mrp: " + rate);
				System.out.println("Tax1 : " + tax1);
				System.out.println("tax2 : " + tax2);

				Float taxableAmt = (float) (mrpBaseRate * qty);
				taxableAmt = roundUp(taxableAmt);

				// -----------------------------------------

				float sgstRs = (taxableAmt * tax1) / 100;
				float cgstRs = (taxableAmt * tax2) / 100;
				float igstRs = (taxableAmt * tax3) / 100;

				sgstRs = roundUp(sgstRs);
				cgstRs = roundUp(cgstRs);
				igstRs = roundUp(igstRs);

				Float totalTax = sgstRs + cgstRs;
				totalTax = roundUp(totalTax);

				Float grandTotal = totalTax + taxableAmt;
				grandTotal = roundUp(grandTotal);

				sellBillDetail.setCatId(customerBillItemList.get(i).getCatId());
				sellBillDetail.setSgstPer(tax1);
				sellBillDetail.setSgstRs(sgstRs);
				sellBillDetail.setCgstPer(tax2);
				sellBillDetail.setCgstRs(cgstRs);
				sellBillDetail.setDelStatus(0);
				sellBillDetail.setGrandTotal(grandTotal);
				sellBillDetail.setIgstPer(tax3);
				sellBillDetail.setIgstRs(igstRs);
				sellBillDetail.setItemId(customerBillItemList.get(i).getId());
				sellBillDetail.setMrp(rate);
				sellBillDetail.setMrpBaseRate(mrpBaseRate);
				sellBillDetail.setQty(customerBillItemList.get(i).getQty());
				sellBillDetail.setRemark("");
				sellBillDetail.setSellBillDetailNo(0);
				sellBillDetail.setSellBillNo(0);

				sumTaxableAmt = sumTaxableAmt + taxableAmt;
				sumTotalTax = sumTotalTax + totalTax;
				sumGrandTotal = sumGrandTotal + grandTotal;

				sellBillDetail.setTaxableAmt(taxableAmt);
				sellBillDetail.setTotalTax(totalTax);

				sellBillDetailList.add(sellBillDetail);

			}
			sellBillHeader.setTaxableAmt(sumTaxableAmt);
			sellBillHeader.setDiscountPer(discountPer);

			float discountAmt = ((sumGrandTotal * discountPer) / 100);
			float payableAmt = (sumGrandTotal - discountAmt);
			payableAmt = roundUp(payableAmt);

			sellBillHeader.setDiscountAmt(discountAmt);
			sellBillHeader.setPayableAmt(payableAmt);

			sellBillHeader.setTotalTax(sumTotalTax);
			sellBillHeader.setGrandTotal(sumGrandTotal);

			float calRemainingTotal = (payableAmt - paidAmount);

			sellBillHeader.setRemainingAmt(calRemainingTotal);

			if (calRemainingTotal == 0) {

				sellBillHeader.setStatus(1);
			} else if (calRemainingTotal == payableAmt) {
				sellBillHeader.setStatus(2);

			} else if (payableAmt > calRemainingTotal) {
				sellBillHeader.setStatus(3);
			}

			sellBillHeader.setSellBillDetailsList(sellBillDetailList);

			System.out.println("Sell Bill Detail: " + sellBillHeader.toString());

			List<SellBillHeader> sellBillHeaderList = new ArrayList<SellBillHeader>();
			sellBillHeaderList.add(sellBillHeader);

			SellBillDataCommon sellBillDataCommon = new SellBillDataCommon();
			sellBillDataCommon.setSellBillHeaderList(sellBillHeaderList);

			RestTemplate restTemplate = new RestTemplate();

			List<SellBillHeader> sellBillHeaderRes = restTemplate.postForObject(Constant.URL + "insertSellBillData", sellBillDataCommon, List.class);

			System.out.println("info :" + sellBillHeaderRes.toString());
			if (sellBillHeaderRes!= null) {
				resetData1();

			} else {

			}
		} catch (Exception e) {

			System.out.println("Exception:" + e.getMessage());
			e.printStackTrace();

		}

		System.out.println("Order Response:" + customerBillDataToken1.getCustomerBillList());

		return customerBillDataToken1.getCustomerBillList();

	}

	
	// ---------------------------------------------------------------------------------------------------
	// ----------------------------------------------------------------------------------------------
	@RequestMapping(value = "/generateSellBill2", method = RequestMethod.GET)
	public @ResponseBody List<CustomerBillItem> generateSellBill2(HttpServletRequest request,
			HttpServletResponse response) {

		ModelAndView model = new ModelAndView("frSellBilling/customerBill");
		String orderResponse = "";

		HttpSession session = request.getSession();

		Franchisee frDetails = (Franchisee) session.getAttribute("frDetails");
		java.sql.Date cDate = new java.sql.Date(Calendar.getInstance().getTime().getTime());

		try {

			double billGrandTotal;
			double calBillGrandTotal;
			double billTotal;
			String gstNo = "";
			String phoneNo = "";

			String custName = request.getParameter("custName");
			System.out.println("Customer Name:" + custName);

			gstNo = request.getParameter("gstNo");
			System.out.println("Gst No:" + gstNo);

			phoneNo = request.getParameter("phoneNo");
			System.out.println("phoneNo:" + phoneNo);

			float discountPer = Float.parseFloat(request.getParameter("discount"));
			System.out.println("discount:" + discountPer);

			int paymentMode = Integer.parseInt(request.getParameter("paymentMode"));
			System.out.println("paymentMode:" + paymentMode);

			float paidAmount = Float.parseFloat(request.getParameter("paidAmount"));
			System.out.println("paidAmount:" + paidAmount);

			if (discountPer != 0) {
				billTotal = customerBillDataToken2.getTotal();

				calBillGrandTotal = billTotal - (billTotal * (discountPer / 100));

			} else {

				billTotal = customerBillDataToken2.getTotal();

				calBillGrandTotal = billTotal;

			}

			DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
			LocalDate localDate = LocalDate.now();
			System.out.println(dtf.format(localDate)); // 2016/11/16

			float fCalGrandTotal = (float) calBillGrandTotal;
			float fBillTotal = (float) billTotal;

			SellBillHeader sellBillHeader = new SellBillHeader();

			sellBillHeader.setFrId(frDetails.getFrId());
			sellBillHeader.setFrCode(frDetails.getFrCode());
			sellBillHeader.setDelStatus(0);
			sellBillHeader.setUserName(custName);
			sellBillHeader.setBillDate(dtf.format(localDate));

			sellBillHeader.setInvoiceNo(0);// hardcoded
			sellBillHeader.setPaidAmt(paidAmount);
			sellBillHeader.setPaymentMode(paymentMode);
			sellBillHeader.setBillType('R');

			sellBillHeader.setSellBillNo(0);

			sellBillHeader.setUserGstNo(gstNo);

			sellBillHeader.setUserPhone(phoneNo);

			System.out.println("Sell Bill Header: " + sellBillHeader.toString());

			List<SellBillDetail> sellBillDetailList = new ArrayList<SellBillDetail>();
			List<CustomerBillItem> customerBillItemList = customerBillDataToken2.getCustomerBillList();

			float sumTaxableAmt = 0, sumTotalTax = 0, sumGrandTotal = 0;

			for (int i = 0; i < customerBillItemList.size(); i++) {

				SellBillDetail sellBillDetail = new SellBillDetail();

				Float rate = (float) customerBillItemList.get(i).getMrp();

				Float tax1 = (float) customerBillItemList.get(i).getItemTax1();
				Float tax2 = (float) customerBillItemList.get(i).getItemTax2();
				Float tax3 = (float) customerBillItemList.get(i).getItemTax3();

				int qty = customerBillItemList.get(i).getQty();

				Float mrpBaseRate = (rate * 100) / (100 + (tax1 + tax2));
				mrpBaseRate = roundUp(mrpBaseRate);

				System.out.println("Mrp: " + rate);
				System.out.println("Tax1 : " + tax1);
				System.out.println("tax2 : " + tax2);

				Float taxableAmt = (float) (mrpBaseRate * qty);
				taxableAmt = roundUp(taxableAmt);

				// -----------------------------------------

				float sgstRs = (taxableAmt * tax1) / 100;
				float cgstRs = (taxableAmt * tax2) / 100;
				float igstRs = (taxableAmt * tax3) / 100;

				sgstRs = roundUp(sgstRs);
				cgstRs = roundUp(cgstRs);
				igstRs = roundUp(igstRs);

				Float totalTax = sgstRs + cgstRs;
				totalTax = roundUp(totalTax);

				Float grandTotal = totalTax + taxableAmt;
				grandTotal = roundUp(grandTotal);

				sellBillDetail.setCatId(customerBillItemList.get(i).getCatId());
				sellBillDetail.setSgstPer(tax1);
				sellBillDetail.setSgstRs(sgstRs);
				sellBillDetail.setCgstPer(tax2);
				sellBillDetail.setCgstRs(cgstRs);
				sellBillDetail.setDelStatus(0);
				sellBillDetail.setGrandTotal(grandTotal);
				sellBillDetail.setIgstPer(tax3);
				sellBillDetail.setIgstRs(igstRs);
				sellBillDetail.setItemId(customerBillItemList.get(i).getId());
				sellBillDetail.setMrp(rate);
				sellBillDetail.setMrpBaseRate(mrpBaseRate);
				sellBillDetail.setQty(customerBillItemList.get(i).getQty());
				sellBillDetail.setRemark("");
				sellBillDetail.setSellBillDetailNo(0);
				sellBillDetail.setSellBillNo(0);

				sumTaxableAmt = sumTaxableAmt + taxableAmt;
				sumTotalTax = sumTotalTax + totalTax;
				sumGrandTotal = sumGrandTotal + grandTotal;

				sellBillDetail.setTaxableAmt(taxableAmt);
				sellBillDetail.setTotalTax(totalTax);

				sellBillDetailList.add(sellBillDetail);

			}
			sellBillHeader.setTaxableAmt(sumTaxableAmt);
			sellBillHeader.setDiscountPer(discountPer);

			float discountAmt = ((sumGrandTotal * discountPer) / 100);
			float payableAmt = (sumGrandTotal - discountAmt);
			payableAmt = roundUp(payableAmt);

			sellBillHeader.setDiscountAmt(discountAmt);
			sellBillHeader.setPayableAmt(payableAmt);

			sellBillHeader.setTotalTax(sumTotalTax);
			sellBillHeader.setGrandTotal(sumGrandTotal);

			float calRemainingTotal = (payableAmt - paidAmount);

			sellBillHeader.setRemainingAmt(calRemainingTotal);

			if (calRemainingTotal == 0) {

				sellBillHeader.setStatus(1);
			} else if (calRemainingTotal == payableAmt) {
				sellBillHeader.setStatus(2);

			} else if (payableAmt > calRemainingTotal) {
				sellBillHeader.setStatus(3);
			}

			sellBillHeader.setSellBillDetailsList(sellBillDetailList);

			System.out.println("Sell Bill Detail: " + sellBillHeader.toString());

			List<SellBillHeader> sellBillHeaderList = new ArrayList<SellBillHeader>();
			sellBillHeaderList.add(sellBillHeader);

			SellBillDataCommon sellBillDataCommon = new SellBillDataCommon();
			sellBillDataCommon.setSellBillHeaderList(sellBillHeaderList);

			RestTemplate restTemplate = new RestTemplate();

			List<SellBillHeader> sellBillHeaderRes  = restTemplate.postForObject(Constant.URL + "insertSellBillData", sellBillDataCommon, List.class);

			if (sellBillHeaderRes!=null) {
				resetData2();

			} else {

			}
		} catch (Exception e) {

			System.out.println("Exception:" + e.getMessage());
			e.printStackTrace();

		}

		return customerBillDataToken2.getCustomerBillList();

	}

	// ----------------------------------------------------------------------------------------------
	// ----------------------------------------------------------------------------------------------
	@RequestMapping(value = "/generateSellBill3", method = RequestMethod.GET)
	public @ResponseBody List<CustomerBillItem> generateSellBill3(HttpServletRequest request,
			HttpServletResponse response) {

		ModelAndView model = new ModelAndView("frSellBilling/customerBill");
		String orderResponse = "";

		HttpSession session = request.getSession();

		Franchisee frDetails = (Franchisee) session.getAttribute("frDetails");
		java.sql.Date cDate = new java.sql.Date(Calendar.getInstance().getTime().getTime());

		try {

			double billGrandTotal;
			double calBillGrandTotal;
			double billTotal;
			String gstNo = "";
			String phoneNo = "";

			String custName = request.getParameter("custName");
			System.out.println("Customer Name:" + custName);

			gstNo = request.getParameter("gstNo");
			System.out.println("Gst No:" + gstNo);

			phoneNo = request.getParameter("phoneNo");
			System.out.println("phoneNo:" + phoneNo);

			float discountPer = Float.parseFloat(request.getParameter("discount"));
			System.out.println("discount:" + discountPer);

			int paymentMode = Integer.parseInt(request.getParameter("paymentMode"));
			System.out.println("paymentMode:" + paymentMode);

			float paidAmount = Float.parseFloat(request.getParameter("paidAmount"));
			System.out.println("paidAmount:" + paidAmount);

			if (discountPer != 0) {
				billTotal = customerBillDataToken3.getTotal();

				calBillGrandTotal = billTotal - (billTotal * (discountPer / 100));

			} else {

				billTotal = customerBillDataToken3.getTotal();

				calBillGrandTotal = billTotal;

			}

			DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
			LocalDate localDate = LocalDate.now();
			System.out.println(dtf.format(localDate)); // 2016/11/16

			float fCalGrandTotal = (float) calBillGrandTotal;
			float fBillTotal = (float) billTotal;

			SellBillHeader sellBillHeader = new SellBillHeader();

			sellBillHeader.setFrId(frDetails.getFrId());
			sellBillHeader.setFrCode(frDetails.getFrCode());
			sellBillHeader.setDelStatus(0);
			sellBillHeader.setUserName(custName);
			sellBillHeader.setBillDate(dtf.format(localDate));

			sellBillHeader.setInvoiceNo(0);// hardcoded
			sellBillHeader.setPaidAmt(paidAmount);
			sellBillHeader.setPaymentMode(paymentMode);
			sellBillHeader.setBillType('R');

			sellBillHeader.setSellBillNo(0);

			sellBillHeader.setUserGstNo(gstNo);

			sellBillHeader.setUserPhone(phoneNo);

			System.out.println("Sell Bill Header: " + sellBillHeader.toString());

			List<SellBillDetail> sellBillDetailList = new ArrayList<SellBillDetail>();
			List<CustomerBillItem> customerBillItemList = customerBillDataToken3.getCustomerBillList();

			float sumTaxableAmt = 0, sumTotalTax = 0, sumGrandTotal = 0;

			for (int i = 0; i < customerBillItemList.size(); i++) {

				SellBillDetail sellBillDetail = new SellBillDetail();

				Float rate = (float) customerBillItemList.get(i).getMrp();

				Float tax1 = (float) customerBillItemList.get(i).getItemTax1();
				Float tax2 = (float) customerBillItemList.get(i).getItemTax2();
				Float tax3 = (float) customerBillItemList.get(i).getItemTax3();

				int qty = customerBillItemList.get(i).getQty();

				Float mrpBaseRate = (rate * 100) / (100 + (tax1 + tax2));
				mrpBaseRate = roundUp(mrpBaseRate);

				System.out.println("Mrp: " + rate);
				System.out.println("Tax1 : " + tax1);
				System.out.println("tax2 : " + tax2);

				Float taxableAmt = (float) (mrpBaseRate * qty);
				taxableAmt = roundUp(taxableAmt);

				// -----------------------------------------

				float sgstRs = (taxableAmt * tax1) / 100;
				float cgstRs = (taxableAmt * tax2) / 100;
				float igstRs = (taxableAmt * tax3) / 100;

				sgstRs = roundUp(sgstRs);
				cgstRs = roundUp(cgstRs);
				igstRs = roundUp(igstRs);

				Float totalTax = sgstRs + cgstRs;
				totalTax = roundUp(totalTax);

				Float grandTotal = totalTax + taxableAmt;
				grandTotal = roundUp(grandTotal);

				sellBillDetail.setCatId(customerBillItemList.get(i).getCatId());
				sellBillDetail.setSgstPer(tax1);
				sellBillDetail.setSgstRs(sgstRs);
				sellBillDetail.setCgstPer(tax2);
				sellBillDetail.setCgstRs(cgstRs);
				sellBillDetail.setDelStatus(0);
				sellBillDetail.setGrandTotal(grandTotal);
				sellBillDetail.setIgstPer(tax3);
				sellBillDetail.setIgstRs(igstRs);
				sellBillDetail.setItemId(customerBillItemList.get(i).getId());
				sellBillDetail.setMrp(rate);
				sellBillDetail.setMrpBaseRate(mrpBaseRate);
				sellBillDetail.setQty(customerBillItemList.get(i).getQty());
				sellBillDetail.setRemark("");
				sellBillDetail.setSellBillDetailNo(0);
				sellBillDetail.setSellBillNo(0);

				sumTaxableAmt = sumTaxableAmt + taxableAmt;
				sumTotalTax = sumTotalTax + totalTax;
				sumGrandTotal = sumGrandTotal + grandTotal;

				sellBillDetail.setTaxableAmt(taxableAmt);
				sellBillDetail.setTotalTax(totalTax);

				sellBillDetailList.add(sellBillDetail);

			}
			sellBillHeader.setTaxableAmt(sumTaxableAmt);
			sellBillHeader.setDiscountPer(discountPer);

			float discountAmt = ((sumGrandTotal * discountPer) / 100);
			float payableAmt = (sumGrandTotal - discountAmt);
			payableAmt = roundUp(payableAmt);

			sellBillHeader.setDiscountAmt(discountAmt);
			sellBillHeader.setPayableAmt(payableAmt);

			sellBillHeader.setTotalTax(sumTotalTax);
			sellBillHeader.setGrandTotal(sumGrandTotal);

			float calRemainingTotal = (payableAmt - paidAmount);

			sellBillHeader.setRemainingAmt(calRemainingTotal);

			if (calRemainingTotal == 0) {

				sellBillHeader.setStatus(1);
			} else if (calRemainingTotal == payableAmt) {
				sellBillHeader.setStatus(2);

			} else if (payableAmt > calRemainingTotal) {
				sellBillHeader.setStatus(3);
			}

			sellBillHeader.setSellBillDetailsList(sellBillDetailList);

			System.out.println("Sell Bill Detail: " + sellBillHeader.toString());

			List<SellBillHeader> sellBillHeaderList = new ArrayList<SellBillHeader>();
			sellBillHeaderList.add(sellBillHeader);

			SellBillDataCommon sellBillDataCommon = new SellBillDataCommon();
			sellBillDataCommon.setSellBillHeaderList(sellBillHeaderList);

			RestTemplate restTemplate = new RestTemplate();

			List<SellBillHeader> sellBillHeaderRes = restTemplate.postForObject(Constant.URL + "insertSellBillData", sellBillDataCommon, List.class);

			if (sellBillHeaderRes!=null) {
				resetData3();

			} else {

			}
		} catch (Exception e) {

			System.out.println("Exception:" + e.getMessage());
			e.printStackTrace();

		}

		return customerBillDataToken3.getCustomerBillList();

	}

	// -------------------------------------------------------------------------------------------
	// ----------------------------------------------------------------------------------------------
	@RequestMapping(value = "/generateSellBill4", method = RequestMethod.GET)
	public @ResponseBody List<CustomerBillItem> generateSellBill4(HttpServletRequest request,
			HttpServletResponse response) {

		ModelAndView model = new ModelAndView("frSellBilling/customerBill");
		String orderResponse = "";

		HttpSession session = request.getSession();

		Franchisee frDetails = (Franchisee) session.getAttribute("frDetails");
		java.sql.Date cDate = new java.sql.Date(Calendar.getInstance().getTime().getTime());

		try {

			double billGrandTotal;
			double calBillGrandTotal;
			double billTotal;
			String gstNo = "";
			String phoneNo = "";

			String custName = request.getParameter("custName");
			System.out.println("Customer Name:" + custName);

			gstNo = request.getParameter("gstNo");
			System.out.println("Gst No:" + gstNo);

			phoneNo = request.getParameter("phoneNo");
			System.out.println("phoneNo:" + phoneNo);

			float discountPer = Float.parseFloat(request.getParameter("discount"));
			System.out.println("discount:" + discountPer);

			int paymentMode = Integer.parseInt(request.getParameter("paymentMode"));
			System.out.println("paymentMode:" + paymentMode);

			float paidAmount = Float.parseFloat(request.getParameter("paidAmount"));
			System.out.println("paidAmount:" + paidAmount);

			if (discountPer != 0) {
				billTotal = customerBillDataToken4.getTotal();

				calBillGrandTotal = billTotal - (billTotal * (discountPer / 100));

			} else {

				billTotal = customerBillDataToken4.getTotal();

				calBillGrandTotal = billTotal;

			}

			DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
			LocalDate localDate = LocalDate.now();
			System.out.println(dtf.format(localDate)); // 2016/11/16

			float fCalGrandTotal = (float) calBillGrandTotal;
			float fBillTotal = (float) billTotal;

			SellBillHeader sellBillHeader = new SellBillHeader();

			sellBillHeader.setFrId(frDetails.getFrId());
			sellBillHeader.setFrCode(frDetails.getFrCode());
			sellBillHeader.setDelStatus(0);
			sellBillHeader.setUserName(custName);
			sellBillHeader.setBillDate(dtf.format(localDate));

			sellBillHeader.setInvoiceNo(0);// hardcoded
			sellBillHeader.setPaidAmt(paidAmount);
			sellBillHeader.setPaymentMode(paymentMode);
			sellBillHeader.setBillType('R');

			sellBillHeader.setSellBillNo(0);

			sellBillHeader.setUserGstNo(gstNo);

			sellBillHeader.setUserPhone(phoneNo);

			System.out.println("Sell Bill Header: " + sellBillHeader.toString());

			List<SellBillDetail> sellBillDetailList = new ArrayList<SellBillDetail>();
			List<CustomerBillItem> customerBillItemList = customerBillDataToken4.getCustomerBillList();

			float sumTaxableAmt = 0, sumTotalTax = 0, sumGrandTotal = 0;

			for (int i = 0; i < customerBillItemList.size(); i++) {

				SellBillDetail sellBillDetail = new SellBillDetail();

				Float rate = (float) customerBillItemList.get(i).getMrp();

				Float tax1 = (float) customerBillItemList.get(i).getItemTax1();
				Float tax2 = (float) customerBillItemList.get(i).getItemTax2();
				Float tax3 = (float) customerBillItemList.get(i).getItemTax3();

				int qty = customerBillItemList.get(i).getQty();

				Float mrpBaseRate = (rate * 100) / (100 + (tax1 + tax2));
				mrpBaseRate = roundUp(mrpBaseRate);

				System.out.println("Mrp: " + rate);
				System.out.println("Tax1 : " + tax1);
				System.out.println("tax2 : " + tax2);

				Float taxableAmt = (float) (mrpBaseRate * qty);
				taxableAmt = roundUp(taxableAmt);

				// -----------------------------------------

				float sgstRs = (taxableAmt * tax1) / 100;
				float cgstRs = (taxableAmt * tax2) / 100;
				float igstRs = (taxableAmt * tax3) / 100;

				sgstRs = roundUp(sgstRs);
				cgstRs = roundUp(cgstRs);
				igstRs = roundUp(igstRs);

				Float totalTax = sgstRs + cgstRs;
				totalTax = roundUp(totalTax);

				Float grandTotal = totalTax + taxableAmt;
				grandTotal = roundUp(grandTotal);

				sellBillDetail.setCatId(customerBillItemList.get(i).getCatId());
				sellBillDetail.setSgstPer(tax1);
				sellBillDetail.setSgstRs(sgstRs);
				sellBillDetail.setCgstPer(tax2);
				sellBillDetail.setCgstRs(cgstRs);
				sellBillDetail.setDelStatus(0);
				sellBillDetail.setGrandTotal(grandTotal);
				sellBillDetail.setIgstPer(tax3);
				sellBillDetail.setIgstRs(igstRs);
				sellBillDetail.setItemId(customerBillItemList.get(i).getId());
				sellBillDetail.setMrp(rate);
				sellBillDetail.setMrpBaseRate(mrpBaseRate);
				sellBillDetail.setQty(customerBillItemList.get(i).getQty());
				sellBillDetail.setRemark("");
				sellBillDetail.setSellBillDetailNo(0);
				sellBillDetail.setSellBillNo(0);

				sumTaxableAmt = sumTaxableAmt + taxableAmt;
				sumTotalTax = sumTotalTax + totalTax;
				sumGrandTotal = sumGrandTotal + grandTotal;

				sellBillDetail.setTaxableAmt(taxableAmt);
				sellBillDetail.setTotalTax(totalTax);

				sellBillDetailList.add(sellBillDetail);

			}
			sellBillHeader.setTaxableAmt(sumTaxableAmt);
			sellBillHeader.setDiscountPer(discountPer);

			float discountAmt = ((sumGrandTotal * discountPer) / 100);
			float payableAmt = (sumGrandTotal - discountAmt);
			payableAmt = roundUp(payableAmt);

			sellBillHeader.setDiscountAmt(discountAmt);
			sellBillHeader.setPayableAmt(payableAmt);

			sellBillHeader.setTotalTax(sumTotalTax);
			sellBillHeader.setGrandTotal(sumGrandTotal);

			float calRemainingTotal = (payableAmt - paidAmount);

			sellBillHeader.setRemainingAmt(calRemainingTotal);

			if (calRemainingTotal == 0) {

				sellBillHeader.setStatus(1);
			} else if (calRemainingTotal == payableAmt) {
				sellBillHeader.setStatus(2);

			} else if (payableAmt > calRemainingTotal) {
				sellBillHeader.setStatus(3);
			}

			sellBillHeader.setSellBillDetailsList(sellBillDetailList);

			System.out.println("Sell Bill Detail: " + sellBillHeader.toString());

			List<SellBillHeader> sellBillHeaderList = new ArrayList<SellBillHeader>();
			sellBillHeaderList.add(sellBillHeader);

			SellBillDataCommon sellBillDataCommon = new SellBillDataCommon();
			sellBillDataCommon.setSellBillHeaderList(sellBillHeaderList);

			RestTemplate restTemplate = new RestTemplate();

			List<SellBillHeader> sellBillHeaderRes = restTemplate.postForObject(Constant.URL + "insertSellBillData", sellBillDataCommon, List.class);

			if (sellBillHeaderRes!=null) {
				resetData4();

			} else {

			}
		} catch (Exception e) {

			System.out.println("Exception:" + e.getMessage());
			e.printStackTrace();

		}

		return customerBillDataToken4.getCustomerBillList();

	}

	// ----------------------------------------------------------------------------------------------
	// ----------------------------------------------------------------------------------------------
	@RequestMapping(value = "/generateSellBill5", method = RequestMethod.GET)
	public @ResponseBody List<CustomerBillItem> generateSellBill5(HttpServletRequest request,
			HttpServletResponse response) {

		ModelAndView model = new ModelAndView("frSellBilling/customerBill");
		String orderResponse = "";

		HttpSession session = request.getSession();

		Franchisee frDetails = (Franchisee) session.getAttribute("frDetails");
		java.sql.Date cDate = new java.sql.Date(Calendar.getInstance().getTime().getTime());

		try {

			double billGrandTotal;
			double calBillGrandTotal;
			double billTotal;
			String gstNo = "";
			String phoneNo = "";

			String custName = request.getParameter("custName");
			System.out.println("Customer Name:" + custName);

			gstNo = request.getParameter("gstNo");
			System.out.println("Gst No:" + gstNo);

			phoneNo = request.getParameter("phoneNo");
			System.out.println("phoneNo:" + phoneNo);

			float discountPer = Float.parseFloat(request.getParameter("discount"));
			System.out.println("discount:" + discountPer);

			int paymentMode = Integer.parseInt(request.getParameter("paymentMode"));
			System.out.println("paymentMode:" + paymentMode);

			float paidAmount = Float.parseFloat(request.getParameter("paidAmount"));
			System.out.println("paidAmount:" + paidAmount);

			if (discountPer != 0) {
				billTotal = customerBillDataToken5.getTotal();

				calBillGrandTotal = billTotal - (billTotal * (discountPer / 100));

			} else {

				billTotal = customerBillDataToken5.getTotal();

				calBillGrandTotal = billTotal;

			}

			DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
			LocalDate localDate = LocalDate.now();
			System.out.println(dtf.format(localDate)); // 2016/11/16

			float fCalGrandTotal = (float) calBillGrandTotal;
			float fBillTotal = (float) billTotal;

			SellBillHeader sellBillHeader = new SellBillHeader();

			sellBillHeader.setFrId(frDetails.getFrId());
			sellBillHeader.setFrCode(frDetails.getFrCode());
			sellBillHeader.setDelStatus(0);
			sellBillHeader.setUserName(custName);
			sellBillHeader.setBillDate(dtf.format(localDate));

			sellBillHeader.setInvoiceNo(0);// hardcoded
			sellBillHeader.setPaidAmt(paidAmount);
			sellBillHeader.setPaymentMode(paymentMode);
			sellBillHeader.setBillType('R');

			sellBillHeader.setSellBillNo(0);

			sellBillHeader.setUserGstNo(gstNo);

			sellBillHeader.setUserPhone(phoneNo);

			System.out.println("Sell Bill Header: " + sellBillHeader.toString());

			List<SellBillDetail> sellBillDetailList = new ArrayList<SellBillDetail>();
			List<CustomerBillItem> customerBillItemList = customerBillDataToken5.getCustomerBillList();

			float sumTaxableAmt = 0, sumTotalTax = 0, sumGrandTotal = 0;

			for (int i = 0; i < customerBillItemList.size(); i++) {

				SellBillDetail sellBillDetail = new SellBillDetail();

				Float rate = (float) customerBillItemList.get(i).getMrp();

				Float tax1 = (float) customerBillItemList.get(i).getItemTax1();
				Float tax2 = (float) customerBillItemList.get(i).getItemTax2();
				Float tax3 = (float) customerBillItemList.get(i).getItemTax3();

				int qty = customerBillItemList.get(i).getQty();

				Float mrpBaseRate = (rate * 100) / (100 + (tax1 + tax2));
				mrpBaseRate = roundUp(mrpBaseRate);

				System.out.println("Mrp: " + rate);
				System.out.println("Tax1 : " + tax1);
				System.out.println("tax2 : " + tax2);

				Float taxableAmt = (float) (mrpBaseRate * qty);
				taxableAmt = roundUp(taxableAmt);

				// -----------------------------------------

				float sgstRs = (taxableAmt * tax1) / 100;
				float cgstRs = (taxableAmt * tax2) / 100;
				float igstRs = (taxableAmt * tax3) / 100;

				sgstRs = roundUp(sgstRs);
				cgstRs = roundUp(cgstRs);
				igstRs = roundUp(igstRs);

				Float totalTax = sgstRs + cgstRs;
				totalTax = roundUp(totalTax);

				Float grandTotal = totalTax + taxableAmt;
				grandTotal = roundUp(grandTotal);

				sellBillDetail.setCatId(customerBillItemList.get(i).getCatId());
				sellBillDetail.setSgstPer(tax1);
				sellBillDetail.setSgstRs(sgstRs);
				sellBillDetail.setCgstPer(tax2);
				sellBillDetail.setCgstRs(cgstRs);
				sellBillDetail.setDelStatus(0);
				sellBillDetail.setGrandTotal(grandTotal);
				sellBillDetail.setIgstPer(tax3);
				sellBillDetail.setIgstRs(igstRs);
				sellBillDetail.setItemId(customerBillItemList.get(i).getId());
				sellBillDetail.setMrp(rate);
				sellBillDetail.setMrpBaseRate(mrpBaseRate);
				sellBillDetail.setQty(customerBillItemList.get(i).getQty());
				sellBillDetail.setRemark("");
				sellBillDetail.setSellBillDetailNo(0);
				sellBillDetail.setSellBillNo(0);

				sumTaxableAmt = sumTaxableAmt + taxableAmt;
				sumTotalTax = sumTotalTax + totalTax;
				sumGrandTotal = sumGrandTotal + grandTotal;

				sellBillDetail.setTaxableAmt(taxableAmt);
				sellBillDetail.setTotalTax(totalTax);

				sellBillDetailList.add(sellBillDetail);

			}
			sellBillHeader.setTaxableAmt(sumTaxableAmt);
			sellBillHeader.setDiscountPer(discountPer);

			float discountAmt = ((sumGrandTotal * discountPer) / 100);
			float payableAmt = (sumGrandTotal - discountAmt);
			payableAmt = roundUp(payableAmt);

			sellBillHeader.setDiscountAmt(discountAmt);
			sellBillHeader.setPayableAmt(payableAmt);

			sellBillHeader.setTotalTax(sumTotalTax);
			sellBillHeader.setGrandTotal(sumGrandTotal);

			float calRemainingTotal = (payableAmt - paidAmount);

			sellBillHeader.setRemainingAmt(calRemainingTotal);

			if (calRemainingTotal == 0) {

				sellBillHeader.setStatus(1);
			} else if (calRemainingTotal == payableAmt) {
				sellBillHeader.setStatus(2);

			} else if (payableAmt > calRemainingTotal) {
				sellBillHeader.setStatus(3);
			}

			sellBillHeader.setSellBillDetailsList(sellBillDetailList);

			System.out.println("Sell Bill Detail: " + sellBillHeader.toString());

			List<SellBillHeader> sellBillHeaderList = new ArrayList<SellBillHeader>();
			sellBillHeaderList.add(sellBillHeader);

			SellBillDataCommon sellBillDataCommon = new SellBillDataCommon();
			sellBillDataCommon.setSellBillHeaderList(sellBillHeaderList);

			RestTemplate restTemplate = new RestTemplate();

			List<SellBillHeader> sellBillHeaderRes = restTemplate.postForObject(Constant.URL + "insertSellBillData", sellBillDataCommon, List.class);

			if (sellBillHeaderRes!=null) {
				resetData5();

			} else {

			}
		} catch (Exception e) {

			System.out.println("Exception:" + e.getMessage());
			e.printStackTrace();

		}

		return customerBillDataToken5.getCustomerBillList();

	}

	// -----------------------------------------------------------------------------------------------
	// ----------------------------------------------------------------------------------------------
	@RequestMapping(value = "/generateSellBill6", method = RequestMethod.GET)
	public @ResponseBody List<CustomerBillItem> generateSellBill6(HttpServletRequest request,
			HttpServletResponse response) {

		ModelAndView model = new ModelAndView("frSellBilling/customerBill");
		String orderResponse = "";

		HttpSession session = request.getSession();

		Franchisee frDetails = (Franchisee) session.getAttribute("frDetails");
		java.sql.Date cDate = new java.sql.Date(Calendar.getInstance().getTime().getTime());

		try {

			double billGrandTotal;
			double calBillGrandTotal;
			double billTotal;
			String gstNo = "";
			String phoneNo = "";

			String custName = request.getParameter("custName");
			System.out.println("Customer Name:" + custName);

			gstNo = request.getParameter("gstNo");
			System.out.println("Gst No:" + gstNo);

			phoneNo = request.getParameter("phoneNo");
			System.out.println("phoneNo:" + phoneNo);

			float discountPer = Float.parseFloat(request.getParameter("discount"));
			System.out.println("discount:" + discountPer);

			int paymentMode = Integer.parseInt(request.getParameter("paymentMode"));
			System.out.println("paymentMode:" + paymentMode);

			float paidAmount = Float.parseFloat(request.getParameter("paidAmount"));
			System.out.println("paidAmount:" + paidAmount);

			if (discountPer != 0) {
				billTotal = customerBillDataToken6.getTotal();

				calBillGrandTotal = billTotal - (billTotal * (discountPer / 100));

			} else {

				billTotal = customerBillDataToken6.getTotal();

				calBillGrandTotal = billTotal;

			}

			DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
			LocalDate localDate = LocalDate.now();
			System.out.println(dtf.format(localDate)); // 2016/11/16

			float fCalGrandTotal = (float) calBillGrandTotal;
			float fBillTotal = (float) billTotal;

			SellBillHeader sellBillHeader = new SellBillHeader();

			sellBillHeader.setFrId(frDetails.getFrId());
			sellBillHeader.setFrCode(frDetails.getFrCode());
			sellBillHeader.setDelStatus(0);
			sellBillHeader.setUserName(custName);
			sellBillHeader.setBillDate(dtf.format(localDate));

			sellBillHeader.setInvoiceNo(0);// hardcoded
			sellBillHeader.setPaidAmt(paidAmount);
			sellBillHeader.setPaymentMode(paymentMode);
			sellBillHeader.setBillType('R');

			sellBillHeader.setSellBillNo(0);

			sellBillHeader.setUserGstNo(gstNo);

			sellBillHeader.setUserPhone(phoneNo);

			System.out.println("Sell Bill Header: " + sellBillHeader.toString());

			List<SellBillDetail> sellBillDetailList = new ArrayList<SellBillDetail>();
			List<CustomerBillItem> customerBillItemList = customerBillDataToken6.getCustomerBillList();

			float sumTaxableAmt = 0, sumTotalTax = 0, sumGrandTotal = 0;

			for (int i = 0; i < customerBillItemList.size(); i++) {

				SellBillDetail sellBillDetail = new SellBillDetail();

				Float rate = (float) customerBillItemList.get(i).getMrp();

				Float tax1 = (float) customerBillItemList.get(i).getItemTax1();
				Float tax2 = (float) customerBillItemList.get(i).getItemTax2();
				Float tax3 = (float) customerBillItemList.get(i).getItemTax3();

				int qty = customerBillItemList.get(i).getQty();

				Float mrpBaseRate = (rate * 100) / (100 + (tax1 + tax2));
				mrpBaseRate = roundUp(mrpBaseRate);

				System.out.println("Mrp: " + rate);
				System.out.println("Tax1 : " + tax1);
				System.out.println("tax2 : " + tax2);

				Float taxableAmt = (float) (mrpBaseRate * qty);
				taxableAmt = roundUp(taxableAmt);

				// -----------------------------------------

				float sgstRs = (taxableAmt * tax1) / 100;
				float cgstRs = (taxableAmt * tax2) / 100;
				float igstRs = (taxableAmt * tax3) / 100;

				sgstRs = roundUp(sgstRs);
				cgstRs = roundUp(cgstRs);
				igstRs = roundUp(igstRs);

				Float totalTax = sgstRs + cgstRs;
				totalTax = roundUp(totalTax);

				Float grandTotal = totalTax + taxableAmt;
				grandTotal = roundUp(grandTotal);

				sellBillDetail.setCatId(customerBillItemList.get(i).getCatId());
				sellBillDetail.setSgstPer(tax1);
				sellBillDetail.setSgstRs(sgstRs);
				sellBillDetail.setCgstPer(tax2);
				sellBillDetail.setCgstRs(cgstRs);
				sellBillDetail.setDelStatus(0);
				sellBillDetail.setGrandTotal(grandTotal);
				sellBillDetail.setIgstPer(tax3);
				sellBillDetail.setIgstRs(igstRs);
				sellBillDetail.setItemId(customerBillItemList.get(i).getId());
				sellBillDetail.setMrp(rate);
				sellBillDetail.setMrpBaseRate(mrpBaseRate);
				sellBillDetail.setQty(customerBillItemList.get(i).getQty());
				sellBillDetail.setRemark("");
				sellBillDetail.setSellBillDetailNo(0);
				sellBillDetail.setSellBillNo(0);

				sumTaxableAmt = sumTaxableAmt + taxableAmt;
				sumTotalTax = sumTotalTax + totalTax;
				sumGrandTotal = sumGrandTotal + grandTotal;

				sellBillDetail.setTaxableAmt(taxableAmt);
				sellBillDetail.setTotalTax(totalTax);

				sellBillDetailList.add(sellBillDetail);

			}
			sellBillHeader.setTaxableAmt(sumTaxableAmt);
			sellBillHeader.setDiscountPer(discountPer);

			float discountAmt = ((sumGrandTotal * discountPer) / 100);
			float payableAmt = (sumGrandTotal - discountAmt);
			payableAmt = roundUp(payableAmt);

			sellBillHeader.setDiscountAmt(discountAmt);
			sellBillHeader.setPayableAmt(payableAmt);

			sellBillHeader.setTotalTax(sumTotalTax);
			sellBillHeader.setGrandTotal(sumGrandTotal);

			float calRemainingTotal = (payableAmt - paidAmount);

			sellBillHeader.setRemainingAmt(calRemainingTotal);

			if (calRemainingTotal == 0) {

				sellBillHeader.setStatus(1);
			} else if (calRemainingTotal == payableAmt) {
				sellBillHeader.setStatus(2);

			} else if (payableAmt > calRemainingTotal) {
				sellBillHeader.setStatus(3);
			}

			sellBillHeader.setSellBillDetailsList(sellBillDetailList);

			System.out.println("Sell Bill Detail: " + sellBillHeader.toString());

			List<SellBillHeader> sellBillHeaderList = new ArrayList<SellBillHeader>();
			sellBillHeaderList.add(sellBillHeader);

			SellBillDataCommon sellBillDataCommon = new SellBillDataCommon();
			sellBillDataCommon.setSellBillHeaderList(sellBillHeaderList);

			RestTemplate restTemplate = new RestTemplate();

			List<SellBillHeader> sellBillHeaderRes = restTemplate.postForObject(Constant.URL + "insertSellBillData", sellBillDataCommon, List.class);

			if (sellBillHeaderRes.size()!=0) {
				resetData6();

			} else {

			}
		} catch (Exception e) {

			System.out.println("Exception:" + e.getMessage());
			e.printStackTrace();

		}

		return customerBillDataToken6.getCustomerBillList();

	}

	// --------------------------------------------------------------------------------------------
	// ----------------------------------------------------------------------------------------------
	@RequestMapping(value = "/generateSellBill7", method = RequestMethod.GET)
	public @ResponseBody List<CustomerBillItem> generateSellBill7(HttpServletRequest request,
			HttpServletResponse response) {

		ModelAndView model = new ModelAndView("frSellBilling/customerBill");
		String orderResponse = "";

		HttpSession session = request.getSession();

		Franchisee frDetails = (Franchisee) session.getAttribute("frDetails");
		java.sql.Date cDate = new java.sql.Date(Calendar.getInstance().getTime().getTime());

		try {

			double billGrandTotal;
			double calBillGrandTotal;
			double billTotal;
			String gstNo = "";
			String phoneNo = "";

			String custName = request.getParameter("custName");
			System.out.println("Customer Name:" + custName);

			gstNo = request.getParameter("gstNo");
			System.out.println("Gst No:" + gstNo);

			phoneNo = request.getParameter("phoneNo");
			System.out.println("phoneNo:" + phoneNo);

			float discountPer = Float.parseFloat(request.getParameter("discount"));
			System.out.println("discount:" + discountPer);

			int paymentMode = Integer.parseInt(request.getParameter("paymentMode"));
			System.out.println("paymentMode:" + paymentMode);

			float paidAmount = Float.parseFloat(request.getParameter("paidAmount"));
			System.out.println("paidAmount:" + paidAmount);

			if (discountPer != 0) {
				billTotal = customerBillDataToken7.getTotal();

				calBillGrandTotal = billTotal - (billTotal * (discountPer / 100));

			} else {

				billTotal = customerBillDataToken7.getTotal();

				calBillGrandTotal = billTotal;

			}

			DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
			LocalDate localDate = LocalDate.now();
			System.out.println(dtf.format(localDate)); // 2016/11/16

			float fCalGrandTotal = (float) calBillGrandTotal;
			float fBillTotal = (float) billTotal;

			SellBillHeader sellBillHeader = new SellBillHeader();

			sellBillHeader.setFrId(frDetails.getFrId());
			sellBillHeader.setFrCode(frDetails.getFrCode());
			sellBillHeader.setDelStatus(0);
			sellBillHeader.setUserName(custName);
			sellBillHeader.setBillDate(dtf.format(localDate));

			sellBillHeader.setInvoiceNo(0);// hardcoded
			sellBillHeader.setPaidAmt(paidAmount);
			sellBillHeader.setPaymentMode(paymentMode);
			sellBillHeader.setBillType('R');

			sellBillHeader.setSellBillNo(0);

			sellBillHeader.setUserGstNo(gstNo);

			sellBillHeader.setUserPhone(phoneNo);

			System.out.println("Sell Bill Header: " + sellBillHeader.toString());

			List<SellBillDetail> sellBillDetailList = new ArrayList<SellBillDetail>();
			List<CustomerBillItem> customerBillItemList = customerBillDataToken7.getCustomerBillList();

			float sumTaxableAmt = 0, sumTotalTax = 0, sumGrandTotal = 0;

			for (int i = 0; i < customerBillItemList.size(); i++) {

				SellBillDetail sellBillDetail = new SellBillDetail();

				Float rate = (float) customerBillItemList.get(i).getMrp();

				Float tax1 = (float) customerBillItemList.get(i).getItemTax1();
				Float tax2 = (float) customerBillItemList.get(i).getItemTax2();
				Float tax3 = (float) customerBillItemList.get(i).getItemTax3();

				int qty = customerBillItemList.get(i).getQty();

				Float mrpBaseRate = (rate * 100) / (100 + (tax1 + tax2));
				mrpBaseRate = roundUp(mrpBaseRate);

				System.out.println("Mrp: " + rate);
				System.out.println("Tax1 : " + tax1);
				System.out.println("tax2 : " + tax2);

				Float taxableAmt = (float) (mrpBaseRate * qty);
				taxableAmt = roundUp(taxableAmt);

				// -----------------------------------------

				float sgstRs = (taxableAmt * tax1) / 100;
				float cgstRs = (taxableAmt * tax2) / 100;
				float igstRs = (taxableAmt * tax3) / 100;

				sgstRs = roundUp(sgstRs);
				cgstRs = roundUp(cgstRs);
				igstRs = roundUp(igstRs);

				Float totalTax = sgstRs + cgstRs;
				totalTax = roundUp(totalTax);

				Float grandTotal = totalTax + taxableAmt;
				grandTotal = roundUp(grandTotal);

				sellBillDetail.setCatId(customerBillItemList.get(i).getCatId());
				sellBillDetail.setSgstPer(tax1);
				sellBillDetail.setSgstRs(sgstRs);
				sellBillDetail.setCgstPer(tax2);
				sellBillDetail.setCgstRs(cgstRs);
				sellBillDetail.setDelStatus(0);
				sellBillDetail.setGrandTotal(grandTotal);
				sellBillDetail.setIgstPer(tax3);
				sellBillDetail.setIgstRs(igstRs);
				sellBillDetail.setItemId(customerBillItemList.get(i).getId());
				sellBillDetail.setMrp(rate);
				sellBillDetail.setMrpBaseRate(mrpBaseRate);
				sellBillDetail.setQty(customerBillItemList.get(i).getQty());
				sellBillDetail.setRemark("");
				sellBillDetail.setSellBillDetailNo(0);
				sellBillDetail.setSellBillNo(0);

				sumTaxableAmt = sumTaxableAmt + taxableAmt;
				sumTotalTax = sumTotalTax + totalTax;
				sumGrandTotal = sumGrandTotal + grandTotal;

				sellBillDetail.setTaxableAmt(taxableAmt);
				sellBillDetail.setTotalTax(totalTax);

				sellBillDetailList.add(sellBillDetail);

			}
			sellBillHeader.setTaxableAmt(sumTaxableAmt);
			sellBillHeader.setDiscountPer(discountPer);

			float discountAmt = ((sumGrandTotal * discountPer) / 100);
			float payableAmt = (sumGrandTotal - discountAmt);
			payableAmt = roundUp(payableAmt);

			sellBillHeader.setDiscountAmt(discountAmt);
			sellBillHeader.setPayableAmt(payableAmt);

			sellBillHeader.setTotalTax(sumTotalTax);
			sellBillHeader.setGrandTotal(sumGrandTotal);

			float calRemainingTotal = (payableAmt - paidAmount);

			sellBillHeader.setRemainingAmt(calRemainingTotal);

			if (calRemainingTotal == 0) {

				sellBillHeader.setStatus(1);
			} else if (calRemainingTotal == payableAmt) {
				sellBillHeader.setStatus(2);

			} else if (payableAmt > calRemainingTotal) {
				sellBillHeader.setStatus(3);
			}

			sellBillHeader.setSellBillDetailsList(sellBillDetailList);

			System.out.println("Sell Bill Detail: " + sellBillHeader.toString());

			List<SellBillHeader> sellBillHeaderList = new ArrayList<SellBillHeader>();
			sellBillHeaderList.add(sellBillHeader);

			SellBillDataCommon sellBillDataCommon = new SellBillDataCommon();
			sellBillDataCommon.setSellBillHeaderList(sellBillHeaderList);

			RestTemplate restTemplate = new RestTemplate();

			List<SellBillHeader> sellBillHeaderRes = restTemplate.postForObject(Constant.URL + "insertSellBillData", sellBillDataCommon, List.class);

			if (sellBillHeaderRes.size()!=0) {
				resetData7();

			} else {

			}
		} catch (Exception e) {

			System.out.println("Exception:" + e.getMessage());
			e.printStackTrace();

		}

		return customerBillDataToken7.getCustomerBillList();

	}

	// -----------------------------------------------------------------------------------------------
	@RequestMapping(value = "/getItemById", method = RequestMethod.GET)
	public @ResponseBody CustomerBillItem getItemById(@RequestParam(value = "id", required = true) int id,
			HttpServletRequest request, HttpServletResponse response) {

		System.out.println("**************GETITEMBYID**********************" + id);

		CustomerBillItem selectedItem = new CustomerBillItem();

		for (int i = 0; i < customerBillItemList.size(); i++) {

			if (id == customerBillItemList.get(i).getId()) {

				selectedItem = customerBillItemList.get(i);

			}
		}

		System.out.println("Item Selected is : " + selectedItem.toString());
		return selectedItem;

	}

	@RequestMapping(value = "/deleteCustBillItemTokenItem1", method = RequestMethod.GET)
	public @ResponseBody List<CustomerBillItem> deleteItem1(HttpServletRequest request, HttpServletResponse response) {

		System.out.println("**************deleteItem1**********************");

		int id = Integer.parseInt(request.getParameter("id"));
		System.out.println("id : " + id);
		int itemQty = Integer.parseInt(request.getParameter("qty"));
		System.out.println("itemQty : " + itemQty);

		int index = Integer.parseInt(request.getParameter("index"));
		System.out.println("index : " + index);
		
		boolean isDeleted=false;
		
		for (int j = 0; j < (customerBillDataToken1.getCustomerBillList()).size(); j++) {

			if(isDeleted==false)
			{
			if (customerBillDataToken1.getCustomerBillList().get(j).getId() == id && customerBillDataToken1.getCustomerBillList().get(j).getQty()==itemQty && j==index) {

				for (int i = 0; i < currentStockDetailList.size(); i++) {
					if (currentStockDetailList.get(i).getId() == id) {
						if (customerBillDataToken1.getCustomerBillList().get(j).getBillStockType() == 1) {

							currentStockDetailList.get(i)
									.setCurrentRegStock(currentStockDetailList.get(i).getCurrentRegStock() + itemQty);
							System.out.println("Stock List1:" + currentStockDetailList);

						} else if (customerBillDataToken1.getCustomerBillList().get(j).getBillStockType() == 2) {

							currentStockDetailList.get(i)
									.setCurrentSpStock(currentStockDetailList.get(i).getCurrentSpStock() + itemQty);

							System.out.println("Stock List2:" + currentStockDetailList);
						}

					}

				}
				isDeleted=true;
				customerBillDataToken1.getCustomerBillList().remove(j);

			}
			}

		}
		float total = 0;
		for (int j = 0; j < (customerBillDataToken1.getCustomerBillList()).size(); j++) {

			CustomerBillItem billItem = customerBillDataToken1.getCustomerBillList().get(j);

			float itemTotal = (float) (billItem.getQty() * billItem.getMrp());

			total = total + itemTotal;

		}

		customerBillDataToken1.setTotal(total);
		customerBillDataToken1.setGrandTotal(total);
		customerBillDataToken1.setRemainingAmount(total);

		System.out.println("Customer Bill Data Token1: " + customerBillDataToken1.toString());

		return customerBillDataToken1.getCustomerBillList();
	}

	@RequestMapping(value = "/deleteCustBillItemTokenItem2", method = RequestMethod.GET)
	public @ResponseBody List<CustomerBillItem> deleteItem2(HttpServletRequest request, HttpServletResponse response) {

		int id = Integer.parseInt(request.getParameter("id"));
		System.out.println("id : " + id);
		int itemQty = Integer.parseInt(request.getParameter("qty"));
		System.out.println("itemQty : " + itemQty);
		int index = Integer.parseInt(request.getParameter("index"));
		System.out.println("index : " + index);
		
		boolean isDeleted=false;
		
		for (int j = 0; j < (customerBillDataToken2.getCustomerBillList()).size(); j++) {

			if(isDeleted==false)
			{
			if (customerBillDataToken2.getCustomerBillList().get(j).getId() == id && customerBillDataToken2.getCustomerBillList().get(j).getQty()==itemQty && j==index) {

				for (int i = 0; i < currentStockDetailList.size(); i++) {
					if (currentStockDetailList.get(i).getId() == id) {
						if (customerBillDataToken2.getCustomerBillList().get(j).getBillStockType() == 1) {

							currentStockDetailList.get(i)
									.setCurrentRegStock(currentStockDetailList.get(i).getCurrentRegStock() + itemQty);
							System.out.println("Stock List1:" + currentStockDetailList);

						} else if (customerBillDataToken2.getCustomerBillList().get(j).getBillStockType() == 2) {

							currentStockDetailList.get(i)
									.setCurrentSpStock(currentStockDetailList.get(i).getCurrentSpStock() + itemQty);

							System.out.println("Stock List2:" + currentStockDetailList);
						}

					}

				}
				isDeleted=true;
				customerBillDataToken2.getCustomerBillList().remove(j);

			}
			}

		}
		float total = 0;
		for (int j = 0; j < (customerBillDataToken2.getCustomerBillList()).size(); j++) {

			CustomerBillItem billItem = customerBillDataToken2.getCustomerBillList().get(j);

			float itemTotal = (float) (billItem.getQty() * billItem.getMrp());

			total = total + itemTotal;

		}

		System.out.println("**************************deleteCALCULATED TOTAL: **********************" + total);

		customerBillDataToken2.setTotal(total);
		customerBillDataToken2.setGrandTotal(total);
		customerBillDataToken2.setRemainingAmount(total);

		System.out.println("Customer Bill Data Token2: " + customerBillDataToken2.toString());

		return customerBillDataToken2.getCustomerBillList();
	}

	@RequestMapping(value = "/deleteCustBillItemTokenItem3", method = RequestMethod.GET)
	public @ResponseBody List<CustomerBillItem> deleteItem3(HttpServletRequest request, HttpServletResponse response) {

		int id = Integer.parseInt(request.getParameter("id"));
		System.out.println("id : " + id);
		int itemQty = Integer.parseInt(request.getParameter("qty"));
		System.out.println("itemQty : " + itemQty);

		for (int j = 0; j < (customerBillDataToken3.getCustomerBillList()).size(); j++) {

			if (customerBillDataToken3.getCustomerBillList().get(j).getId() == id) {

				customerBillDataToken3.getCustomerBillList().remove(j);

			}

		}
		float total = 0;
		for (int j = 0; j < (customerBillDataToken3.getCustomerBillList()).size(); j++) {

			CustomerBillItem billItem = customerBillDataToken3.getCustomerBillList().get(j);

			float itemTotal = (float) (billItem.getQty() * billItem.getMrp());

			total = total + itemTotal;

		}

		System.out.println("**************************deleteCALCULATED TOTAL: **********************" + total);

		customerBillDataToken3.setTotal(total);
		customerBillDataToken3.setGrandTotal(total);
		customerBillDataToken3.setRemainingAmount(total);

		System.out.println("Customer Bill Data Token3: " + customerBillDataToken3.toString());

		return customerBillDataToken3.getCustomerBillList();
	}

	@RequestMapping(value = "/deleteCustBillItemTokenItem4", method = RequestMethod.GET)
	public @ResponseBody List<CustomerBillItem> deleteItem4(HttpServletRequest request, HttpServletResponse response) {

		int id = Integer.parseInt(request.getParameter("id"));
		System.out.println("id : " + id);
		int itemQty = Integer.parseInt(request.getParameter("qty"));
		System.out.println("itemQty : " + itemQty);

		for (int j = 0; j < (customerBillDataToken4.getCustomerBillList()).size(); j++) {

			if (customerBillDataToken4.getCustomerBillList().get(j).getId() == id) {

				customerBillDataToken4.getCustomerBillList().remove(j);

			}

		}
		float total = 0;
		for (int j = 0; j < (customerBillDataToken4.getCustomerBillList()).size(); j++) {

			CustomerBillItem billItem = customerBillDataToken4.getCustomerBillList().get(j);

			float itemTotal = (float) (billItem.getQty() * billItem.getMrp());

			total = total + itemTotal;

		}

		System.out.println("**************************deleteCALCULATED TOTAL: **********************" + total);

		customerBillDataToken4.setTotal(total);
		customerBillDataToken4.setGrandTotal(total);
		customerBillDataToken4.setRemainingAmount(total);

		System.out.println("Customer Bill Data Token4: " + customerBillDataToken4.toString());

		return customerBillDataToken4.getCustomerBillList();
	}

	@RequestMapping(value = "/deleteCustBillItemTokenItem5", method = RequestMethod.GET)
	public @ResponseBody List<CustomerBillItem> deleteItem5(HttpServletRequest request, HttpServletResponse response) {

		int id = Integer.parseInt(request.getParameter("id"));
		System.out.println("id : " + id);
		int itemQty = Integer.parseInt(request.getParameter("qty"));
		System.out.println("itemQty : " + itemQty);

		for (int j = 0; j < (customerBillDataToken5.getCustomerBillList()).size(); j++) {

			if (customerBillDataToken5.getCustomerBillList().get(j).getId() == id) {

				customerBillDataToken5.getCustomerBillList().remove(j);

			}

		}
		float total = 0;
		for (int j = 0; j < (customerBillDataToken5.getCustomerBillList()).size(); j++) {

			CustomerBillItem billItem = customerBillDataToken5.getCustomerBillList().get(j);

			float itemTotal = (float) (billItem.getQty() * billItem.getMrp());

			total = total + itemTotal;

		}

		System.out.println("**************************deleteCALCULATED TOTAL: **********************" + total);

		customerBillDataToken5.setTotal(total);
		customerBillDataToken5.setGrandTotal(total);
		customerBillDataToken5.setRemainingAmount(total);

		System.out.println("Customer Bill Data Token5: " + customerBillDataToken5.toString());

		return customerBillDataToken5.getCustomerBillList();
	}

	@RequestMapping(value = "/deleteCustBillItemTokenItem6", method = RequestMethod.GET)
	public @ResponseBody List<CustomerBillItem> deleteItem6(HttpServletRequest request, HttpServletResponse response) {

		int id = Integer.parseInt(request.getParameter("id"));
		System.out.println("id : " + id);
		int itemQty = Integer.parseInt(request.getParameter("qty"));
		System.out.println("itemQty : " + itemQty);

		for (int j = 0; j < (customerBillDataToken6.getCustomerBillList()).size(); j++) {

			if (customerBillDataToken6.getCustomerBillList().get(j).getId() == id) {

				customerBillDataToken6.getCustomerBillList().remove(j);

			}

		}
		float total = 0;
		for (int j = 0; j < (customerBillDataToken6.getCustomerBillList()).size(); j++) {

			CustomerBillItem billItem = customerBillDataToken6.getCustomerBillList().get(j);

			float itemTotal = (float) (billItem.getQty() * billItem.getMrp());

			total = total + itemTotal;

		}

		System.out.println("**************************deleteCALCULATED TOTAL: **********************" + total);

		customerBillDataToken6.setTotal(total);
		customerBillDataToken6.setGrandTotal(total);
		customerBillDataToken6.setRemainingAmount(total);

		System.out.println("Customer Bill Data Token6: " + customerBillDataToken6.toString());

		return customerBillDataToken6.getCustomerBillList();
	}

	@RequestMapping(value = "/deleteCustBillItemTokenItem7", method = RequestMethod.GET)
	public @ResponseBody List<CustomerBillItem> deleteItem7(HttpServletRequest request, HttpServletResponse response) {

		int id = Integer.parseInt(request.getParameter("id"));
		System.out.println("id : " + id);
		int itemQty = Integer.parseInt(request.getParameter("qty"));
		System.out.println("itemQty : " + itemQty);

		for (int j = 0; j < (customerBillDataToken7.getCustomerBillList()).size(); j++) {

			if (customerBillDataToken7.getCustomerBillList().get(j).getId() == id) {

				customerBillDataToken7.getCustomerBillList().remove(j);

			}

		}
		float total = 0;
		for (int j = 0; j < (customerBillDataToken7.getCustomerBillList()).size(); j++) {

			CustomerBillItem billItem = customerBillDataToken7.getCustomerBillList().get(j);

			float itemTotal = (float) (billItem.getQty() * billItem.getMrp());

			total = total + itemTotal;

		}

		System.out.println("**************************deleteCALCULATED TOTAL: **********************" + total);

		customerBillDataToken7.setTotal(total);
		customerBillDataToken7.setGrandTotal(total);
		customerBillDataToken7.setRemainingAmount(total);

		System.out.println("Customer Bill Data Token7: " + customerBillDataToken7.toString());
		return customerBillDataToken7.getCustomerBillList();

	}

	@RequestMapping(value = "/updateCustBillItemTokenItem1", method = RequestMethod.GET)
	public @ResponseBody List<CustomerBillItem> updateItem1(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("**************deleteItem1**********************");

		int id = Integer.parseInt(request.getParameter("id"));
		System.out.println("id : " + id);
		int itemQty = Integer.parseInt(request.getParameter("qty"));
		System.out.println("itemQty : " + itemQty);
		int index = Integer.parseInt(request.getParameter("index"));
		System.out.println("index : " + index);
		
		boolean isUpdated=false;
		for (int i = 0; i <= currentStockDetailList.size(); i++) {

		
		for (int j = 0; j < (customerBillDataToken1.getCustomerBillList()).size(); j++) {

			if(isUpdated==false)
			{
				System.out.println("isUpdated=false"+j);
		
			if (customerBillDataToken1.getCustomerBillList().get(j).getId() == id && j==index) 
			{
				

				int prevItemQty = customerBillDataToken1.getCustomerBillList().get(j).getQty();
				
				System.out.println("prevItemQty"+prevItemQty);
				if (prevItemQty > itemQty) {
				

					
					if (currentStockDetailList.get(i).getId() == id) {
						
						if (customerBillDataToken1.getCustomerBillList().get(j).getBillStockType() == 1) {
							 
							currentStockDetailList.get(i).setCurrentRegStock(currentStockDetailList.get(i).getCurrentRegStock() + prevItemQty);
							
							int regAvailItemQty = currentStockDetailList.get(i).getCurrentRegStock();
							
							if (regAvailItemQty < itemQty) {
								
								//prompt
                                System.out.println("Promt1");
						          customerBillDataToken1.getCustomerBillList().get(j).setQty(currentStockDetailList.get(i).getCurrentRegStock());

								
							} else {
								// currentStockDetailList.get(i).setRegOpeningStock(currentStockDetailList.get(i).getRegOpeningStock()-itemQty);
								currentStockDetailList.get(i).setCurrentRegStock(currentStockDetailList.get(i).getCurrentRegStock() - itemQty);
						          customerBillDataToken1.getCustomerBillList().get(j).setQty(itemQty);

							}
					
						}
						else if(customerBillDataToken1.getCustomerBillList().get(j).getBillStockType() == 2)
						{
	                       currentStockDetailList.get(i).setCurrentSpStock(currentStockDetailList.get(i).getCurrentSpStock() + prevItemQty);
							
							int regAvailItemQty = currentStockDetailList.get(i).getCurrentSpStock();
							
	                        if (regAvailItemQty < itemQty) {
								
								//prompt
                                  System.out.println("Promt2");
						          customerBillDataToken1.getCustomerBillList().get(j).setQty(currentStockDetailList.get(i).getCurrentSpStock());

							} else {
								// currentStockDetailList.get(i).setRegOpeningStock(currentStockDetailList.get(i).getRegOpeningStock()-itemQty);
								currentStockDetailList.get(i).setCurrentSpStock(currentStockDetailList.get(i).getCurrentSpStock() - itemQty);
						          customerBillDataToken1.getCustomerBillList().get(j).setQty(itemQty);

							}
					
						}
					}
			//
				
				}
				 else if (prevItemQty < itemQty) {

						


							if (currentStockDetailList.get(i).getId() == id) {
								
								if (customerBillDataToken1.getCustomerBillList().get(j).getBillStockType() == 1) {
									
									currentStockDetailList.get(i).setCurrentRegStock(currentStockDetailList.get(i).getCurrentRegStock() + prevItemQty);
									
									int regAvailItemQty = currentStockDetailList.get(i).getCurrentRegStock();
									
									if (regAvailItemQty < itemQty) {
										
										//prompt
		                                  System.out.println("Promt3");
								          customerBillDataToken1.getCustomerBillList().get(j).setQty(currentStockDetailList.get(i).getCurrentRegStock());

										
									} else {
										// currentStockDetailList.get(i).setRegOpeningStock(currentStockDetailList.get(i).getRegOpeningStock()-itemQty);
										currentStockDetailList.get(i).setCurrentRegStock(currentStockDetailList.get(i).getCurrentRegStock() - itemQty);
                                         System.out.println("currentStockDetailList"+currentStockDetailList.toString());
       						          customerBillDataToken1.getCustomerBillList().get(j).setQty(itemQty);

									}
							
								}
								else if(customerBillDataToken1.getCustomerBillList().get(j).getBillStockType() == 2)
								{
									 currentStockDetailList.get(i).setCurrentSpStock(currentStockDetailList.get(i).getCurrentSpStock() + prevItemQty);
										
										int regAvailItemQty = currentStockDetailList.get(i).getCurrentSpStock();
										System.out.println("currentStockDetailList"+currentStockDetailList.toString());
										System.out.println("regAvailItemQty"+regAvailItemQty);
				                        if (regAvailItemQty < itemQty) {
											
											//prompt
			                                  System.out.println("Promt4");
									          customerBillDataToken1.getCustomerBillList().get(j).setQty(currentStockDetailList.get(i).getCurrentSpStock());

											
										} else {
											// currentStockDetailList.get(i).setRegOpeningStock(currentStockDetailList.get(i).getRegOpeningStock()-itemQty);
											currentStockDetailList.get(i).setCurrentSpStock(currentStockDetailList.get(i).getCurrentSpStock() - itemQty);
	                                         System.out.println("currentStockDetailList"+currentStockDetailList.toString());
	   							          customerBillDataToken1.getCustomerBillList().get(j).setQty(itemQty);

										}
								
								}
								
							}
						//
					}
				isUpdated=true;

			}
			}
			System.out.println("isUpdated"+isUpdated);

		}
		}
		float total = 0;
		for (int j = 0; j < (customerBillDataToken1.getCustomerBillList()).size(); j++) {

			CustomerBillItem billItem = customerBillDataToken1.getCustomerBillList().get(j);

			float itemTotal = (float) (billItem.getQty() * billItem.getMrp());

			total = total + itemTotal;

		}
		System.out.println("**************************editCALCULATED TOTAL: **********************" + total);

		customerBillDataToken1.setTotal(total);
		customerBillDataToken1.setGrandTotal(total);
		customerBillDataToken1.setRemainingAmount(total);

		System.out.println("Customer Bill Data Token1: " + customerBillDataToken1.toString());

		return customerBillDataToken1.getCustomerBillList();
	}

	@RequestMapping(value = "/updateCustBillItemTokenItem2", method = RequestMethod.GET)
	public @ResponseBody List<CustomerBillItem> updateItem2(HttpServletRequest request, HttpServletResponse response) {

		int id = Integer.parseInt(request.getParameter("id"));
		System.out.println("id : " + id);
		int itemQty = Integer.parseInt(request.getParameter("qty"));
		System.out.println("itemQty : " + itemQty);
		int index = Integer.parseInt(request.getParameter("index"));
		System.out.println("index : " + index);

		boolean isUpdated=false;
		for (int i = 0; i <= currentStockDetailList.size(); i++) {

		
		for (int j = 0; j < (customerBillDataToken2.getCustomerBillList()).size(); j++) {

			if(isUpdated==false)
			{
				System.out.println("isUpdated=false"+j);
		
			if (customerBillDataToken2.getCustomerBillList().get(j).getId() == id && j==index) 
			{
				

				int prevItemQty = customerBillDataToken2.getCustomerBillList().get(j).getQty();
				
				System.out.println("prevItemQty"+prevItemQty);
				if (prevItemQty > itemQty) {
				

					
					if (currentStockDetailList.get(i).getId() == id) {
						
						if (customerBillDataToken2.getCustomerBillList().get(j).getBillStockType() == 1) {
							 
							currentStockDetailList.get(i).setCurrentRegStock(currentStockDetailList.get(i).getCurrentRegStock() + prevItemQty);
							
							int regAvailItemQty = currentStockDetailList.get(i).getCurrentRegStock();
							
							if (regAvailItemQty < itemQty) {
								
								//prompt
                                System.out.println("Promt1");
						          customerBillDataToken2.getCustomerBillList().get(j).setQty(currentStockDetailList.get(i).getCurrentRegStock());

								
							} else {
								// currentStockDetailList.get(i).setRegOpeningStock(currentStockDetailList.get(i).getRegOpeningStock()-itemQty);
								currentStockDetailList.get(i).setCurrentRegStock(currentStockDetailList.get(i).getCurrentRegStock() - itemQty);
						          customerBillDataToken2.getCustomerBillList().get(j).setQty(itemQty);

							}
					
						}
						else if(customerBillDataToken2.getCustomerBillList().get(j).getBillStockType() == 2)
						{
	                       currentStockDetailList.get(i).setCurrentSpStock(currentStockDetailList.get(i).getCurrentSpStock() + prevItemQty);
							
							int regAvailItemQty = currentStockDetailList.get(i).getCurrentSpStock();
							
	                        if (regAvailItemQty < itemQty) {
								
								//prompt
                                  System.out.println("Promt2");
						          customerBillDataToken2.getCustomerBillList().get(j).setQty(currentStockDetailList.get(i).getCurrentSpStock());

							} else {
								// currentStockDetailList.get(i).setRegOpeningStock(currentStockDetailList.get(i).getRegOpeningStock()-itemQty);
								currentStockDetailList.get(i).setCurrentSpStock(currentStockDetailList.get(i).getCurrentSpStock() - itemQty);
						          customerBillDataToken2.getCustomerBillList().get(j).setQty(itemQty);

							}
					
						}
					}
			//
				
				}
				 else if (prevItemQty < itemQty) {

						


							if (currentStockDetailList.get(i).getId() == id) {
								
								if (customerBillDataToken2.getCustomerBillList().get(j).getBillStockType() == 1) {
									
									currentStockDetailList.get(i).setCurrentRegStock(currentStockDetailList.get(i).getCurrentRegStock() + prevItemQty);
									
									int regAvailItemQty = currentStockDetailList.get(i).getCurrentRegStock();
									
									if (regAvailItemQty < itemQty) {
										
										//prompt
		                                  System.out.println("Promt3");
								          customerBillDataToken2.getCustomerBillList().get(j).setQty(currentStockDetailList.get(i).getCurrentRegStock());

										
									} else {
										// currentStockDetailList.get(i).setRegOpeningStock(currentStockDetailList.get(i).getRegOpeningStock()-itemQty);
										currentStockDetailList.get(i).setCurrentRegStock(currentStockDetailList.get(i).getCurrentRegStock() - itemQty);
                                         System.out.println("currentStockDetailList"+currentStockDetailList.toString());
       						          customerBillDataToken2.getCustomerBillList().get(j).setQty(itemQty);

									}
							
								}
								else if(customerBillDataToken2.getCustomerBillList().get(j).getBillStockType() == 2)
								{
									 currentStockDetailList.get(i).setCurrentSpStock(currentStockDetailList.get(i).getCurrentSpStock() + prevItemQty);
										
										int regAvailItemQty = currentStockDetailList.get(i).getCurrentSpStock();
										System.out.println("currentStockDetailList"+currentStockDetailList.toString());
										System.out.println("regAvailItemQty"+regAvailItemQty);
				                        if (regAvailItemQty < itemQty) {
											
											//prompt
			                                  System.out.println("Promt4");
									          customerBillDataToken2.getCustomerBillList().get(j).setQty(currentStockDetailList.get(i).getCurrentSpStock());

											
										} else {
											// currentStockDetailList.get(i).setRegOpeningStock(currentStockDetailList.get(i).getRegOpeningStock()-itemQty);
											currentStockDetailList.get(i).setCurrentSpStock(currentStockDetailList.get(i).getCurrentSpStock() - itemQty);
	                                         System.out.println("currentStockDetailList"+currentStockDetailList.toString());
	   							          customerBillDataToken2.getCustomerBillList().get(j).setQty(itemQty);

										}
								
								}
								
							}
						//
					}
				isUpdated=true;

			}
			}
			System.out.println("isUpdated"+isUpdated);

		}
		}
		float total = 0;
		for (int j = 0; j < (customerBillDataToken2.getCustomerBillList()).size(); j++) {

			CustomerBillItem billItem = customerBillDataToken2.getCustomerBillList().get(j);

			float itemTotal = (float) (billItem.getQty() * billItem.getMrp());

			total = total + itemTotal;

		}
		System.out.println("**************************editCALCULATED TOTAL: **********************" + total);

		customerBillDataToken2.setTotal(total);
		customerBillDataToken2.setGrandTotal(total);
		customerBillDataToken2.setRemainingAmount(total);

		System.out.println("Customer Bill Data Token2: " + customerBillDataToken2.toString());

		return customerBillDataToken2.getCustomerBillList();
	}

	@RequestMapping(value = "/updateCustBillItemTokenItem3", method = RequestMethod.GET)
	public @ResponseBody List<CustomerBillItem> updateItem3(HttpServletRequest request, HttpServletResponse response) {

		int id = Integer.parseInt(request.getParameter("id"));
		System.out.println("id : " + id);
		int itemQty = Integer.parseInt(request.getParameter("qty"));
		System.out.println("itemQty : " + itemQty);

		for (int j = 0; j < (customerBillDataToken3.getCustomerBillList()).size(); j++) {

			if (customerBillDataToken3.getCustomerBillList().get(j).getId() == id) {

				customerBillDataToken3.getCustomerBillList().get(j).setQty(itemQty);

			}

		}

		float total = 0;
		for (int j = 0; j < (customerBillDataToken3.getCustomerBillList()).size(); j++) {

			CustomerBillItem billItem = customerBillDataToken3.getCustomerBillList().get(j);

			float itemTotal = (float) (billItem.getQty() * billItem.getMrp());

			total = total + itemTotal;

		}
		System.out.println("**************************editCALCULATED TOTAL: **********************" + total);

		customerBillDataToken3.setTotal(total);
		customerBillDataToken3.setGrandTotal(total);
		customerBillDataToken3.setRemainingAmount(total);

		System.out.println("Customer Bill Data Token3: " + customerBillDataToken3.toString());

		return customerBillDataToken3.getCustomerBillList();
	}

	@RequestMapping(value = "/updateCustBillItemTokenItem4", method = RequestMethod.GET)
	public @ResponseBody List<CustomerBillItem> updateItem4(HttpServletRequest request, HttpServletResponse response) {

		int id = Integer.parseInt(request.getParameter("id"));
		System.out.println("id : " + id);
		int itemQty = Integer.parseInt(request.getParameter("qty"));
		System.out.println("itemQty : " + itemQty);

		for (int j = 0; j < (customerBillDataToken4.getCustomerBillList()).size(); j++) {

			if (customerBillDataToken4.getCustomerBillList().get(j).getId() == id) {

				customerBillDataToken4.getCustomerBillList().get(j).setQty(itemQty);

				System.out.println("Customer Bill Data Token4: " + customerBillDataToken4.toString());
			}

		}

		float total = 0;
		for (int j = 0; j < (customerBillDataToken4.getCustomerBillList()).size(); j++) {

			CustomerBillItem billItem = customerBillDataToken4.getCustomerBillList().get(j);

			float itemTotal = (float) (billItem.getQty() * billItem.getMrp());

			total = total + itemTotal;

		}
		System.out.println("**************************editCALCULATED TOTAL: **********************" + total);

		customerBillDataToken4.setTotal(total);
		customerBillDataToken4.setGrandTotal(total);
		customerBillDataToken4.setRemainingAmount(total);

		System.out.println("Customer Bill Data Token4: " + customerBillDataToken4.toString());

		return customerBillDataToken4.getCustomerBillList();
	}

	@RequestMapping(value = "/updateCustBillItemTokenItem5", method = RequestMethod.GET)
	public @ResponseBody List<CustomerBillItem> updateItem5(HttpServletRequest request, HttpServletResponse response) {

		int id = Integer.parseInt(request.getParameter("id"));
		System.out.println("id : " + id);
		int itemQty = Integer.parseInt(request.getParameter("qty"));
		System.out.println("itemQty : " + itemQty);

		for (int j = 0; j < (customerBillDataToken5.getCustomerBillList()).size(); j++) {

			if (customerBillDataToken5.getCustomerBillList().get(j).getId() == id) {

				customerBillDataToken5.getCustomerBillList().get(j).setQty(itemQty);

			}

		}

		float total = 0;
		for (int j = 0; j < (customerBillDataToken5.getCustomerBillList()).size(); j++) {

			CustomerBillItem billItem = customerBillDataToken5.getCustomerBillList().get(j);

			float itemTotal = (float) (billItem.getQty() * billItem.getMrp());

			total = total + itemTotal;

		}
		System.out.println("**************************editCALCULATED TOTAL: **********************" + total);

		customerBillDataToken5.setTotal(total);
		customerBillDataToken5.setGrandTotal(total);
		customerBillDataToken5.setRemainingAmount(total);

		System.out.println("Customer Bill Data Token5: " + customerBillDataToken5.toString());

		return customerBillDataToken5.getCustomerBillList();
	}

	@RequestMapping(value = "/updateCustBillItemTokenItem6", method = RequestMethod.GET)
	public @ResponseBody List<CustomerBillItem> updateItem6(HttpServletRequest request, HttpServletResponse response) {

		int id = Integer.parseInt(request.getParameter("id"));
		System.out.println("id : " + id);
		int itemQty = Integer.parseInt(request.getParameter("qty"));
		System.out.println("itemQty : " + itemQty);

		for (int j = 0; j < (customerBillDataToken6.getCustomerBillList()).size(); j++) {

			if (customerBillDataToken6.getCustomerBillList().get(j).getId() == id) {

				customerBillDataToken6.getCustomerBillList().get(j).setQty(itemQty);

			}

		}
		float total = 0;
		for (int j = 0; j < (customerBillDataToken6.getCustomerBillList()).size(); j++) {

			CustomerBillItem billItem = customerBillDataToken6.getCustomerBillList().get(j);

			float itemTotal = (float) (billItem.getQty() * billItem.getMrp());

			total = total + itemTotal;

		}
		System.out.println("**************************editCALCULATED TOTAL: **********************" + total);

		customerBillDataToken6.setTotal(total);
		customerBillDataToken6.setGrandTotal(total);
		customerBillDataToken6.setRemainingAmount(total);

		System.out.println("Customer Bill Data Token6: " + customerBillDataToken6.toString());

		return customerBillDataToken6.getCustomerBillList();
	}

	@RequestMapping(value = "/updateCustBillItemTokenItem7", method = RequestMethod.GET)
	public @ResponseBody List<CustomerBillItem> updateItem7(HttpServletRequest request, HttpServletResponse response) {

		int id = Integer.parseInt(request.getParameter("id"));
		System.out.println("id : " + id);
		int itemQty = Integer.parseInt(request.getParameter("qty"));
		System.out.println("itemQty : " + itemQty);

		for (int j = 0; j < (customerBillDataToken7.getCustomerBillList()).size(); j++) {

			if (customerBillDataToken7.getCustomerBillList().get(j).getId() == id) {

				customerBillDataToken7.getCustomerBillList().get(j).setQty(itemQty);

			}

		}
		float total = 0;
		for (int j = 0; j < (customerBillDataToken7.getCustomerBillList()).size(); j++) {

			CustomerBillItem billItem = customerBillDataToken7.getCustomerBillList().get(j);

			float itemTotal = (float) (billItem.getQty() * billItem.getMrp());

			total = total + itemTotal;

		}
		System.out.println("**************************editCALCULATED TOTAL: **********************" + total);

		customerBillDataToken7.setTotal(total);
		customerBillDataToken7.setGrandTotal(total);
		customerBillDataToken7.setRemainingAmount(total);

		System.out.println("Customer Bill Data Token7: " + customerBillDataToken7.toString());

		return customerBillDataToken7.getCustomerBillList();
	}

	@RequestMapping(value = "/addNewCustBillItemToken1", method = RequestMethod.GET)
	public @ResponseBody List<CustomerBillItem> getAllAddedItem1(HttpServletRequest request,
			HttpServletResponse response) {

		HttpSession ses = request.getSession();
		Franchisee frDetails = (Franchisee) ses.getAttribute("frDetails");

		System.out.println("**************getAllAddedItem1*******************");

		int prevQty = 0;

		int id = Integer.parseInt(request.getParameter("id"));
		System.out.println("id : " + id);

		int itemQty = Integer.parseInt(request.getParameter("qty"));
		System.out.println("itemQty : " + itemQty);
		List<CustomerBillItem> prevCustomerBillItemList = customerBillDataToken1.getCustomerBillList();

		try {

			//CustomerBillItem currentNewItem = new CustomerBillItem();

			for (int i = 0; i < customerBillItemList.size(); i++) {

				if (customerBillItemList.get(i).getId() == id) {
					System.out.println("Data Matched : " + customerBillItemList.get(i).getId());

					// currentNewItem= customerBillItemList.get(i);

					//currentNewItem1 = customerBillItemList.get(i);
					
					
					currentNewItem1=new CustomerBillItem();
					
					currentNewItem1.setBillStockType(customerBillItemList.get(i).getBillStockType());
					currentNewItem1.setCatId(customerBillItemList.get(i).getCatId());
					currentNewItem1.setId(customerBillItemList.get(i).getId());
					currentNewItem1.setItemId(customerBillItemList.get(i).getItemId());
					currentNewItem1.setItemName(customerBillItemList.get(i).getItemName());
					currentNewItem1.setItemTax1(customerBillItemList.get(i).getItemTax1());
					currentNewItem1.setItemTax2(customerBillItemList.get(i).getItemTax2());
					currentNewItem1.setItemTax3(customerBillItemList.get(i).getItemTax3());
					currentNewItem1.setMrp(customerBillItemList.get(i).getMrp());
					currentNewItem1.setQty(customerBillItemList.get(i).getQty());
					currentNewItem1.setRate(customerBillItemList.get(i).getRate());
					currentNewItem1.setRegOpStockGretor(customerBillItemList.get(i).isRegOpStockGretor());
					currentNewItem1.setRegOpStockLess(customerBillItemList.get(i).isRegOpStockLess());
					currentNewItem1.setSpStockGretor(customerBillItemList.get(i).isSpStockGretor());
					currentNewItem1.setSpStockLessthanQty(customerBillItemList.get(i).isSpStockLessthanQty());
					
					currentNewItem2.setCurrentStockOver(customerBillItemList.get(i).isCurrentStockOver());
					currentNewItem2.setTotalRegStock(customerBillItemList.get(i).getTotalRegStock());
					currentNewItem2.setTotalSpStock(customerBillItemList.get(i).getTotalSpStock());
					
					currentNewItem1.setQty(itemQty);

					// prevQty=customerBillItemList.get(i).getQty();
					// currentNewItem.setQty(itemQty);


					System.out.println("currentNewItem1" + currentNewItem1.toString());
				}

			}
			
			
			
			
			// ------------------------------------------------------------------------------------------
			if (currentStockDetailList.size() == 0) {

				stockCalc(currentNewItem1, frDetails);// stock calculation

				                   System.out.println("****1)currentStockDetailList[token1]****:" + currentStockDetailList.toString());

				for (int i = 0; i <= currentStockDetailList.size(); i++) {
					
					GetCurrentStockDetails getCurrentStockDetails = currentStockDetailList.get(i);
				
					               System.out.println("****2)getCurrentStockDetails[token1]****:" + getCurrentStockDetails.toString());

					if (currentNewItem1.getId() == getCurrentStockDetails.getId()) {
						
						           System.out.println("****3)Id Matched:****" + currentNewItem1.getId());

						if (getCurrentStockDetails.getCurrentSpStock() > 0) {
							
							
							        // prompt1(Are use WANT TO USE SpOpeningStock)if yes,
							        // bill stock type =2
							currentNewItem1.setSpStockGretor(true);//current Sp Stock
							currentNewItem1.setBillStockType(2);
							
							currentNewItem1.setTotalSpStock(getCurrentStockDetails.getCurrentSpStock());//
							currentNewItem1.setTotalRegStock(getCurrentStockDetails.getCurrentRegStock());//

							
						           	System.out.println("**** CurrentNewItem:  ****:" + currentNewItem1.toString());

							prevCustomerBillItemList.add(currentNewItem1);
							customerBillDataToken1.setCustomerBillList(prevCustomerBillItemList);
			                   System.out.println("****Token1.0****:" + customerBillDataToken2.toString());

							return customerBillDataToken1.getCustomerBillList();

						} else if (getCurrentStockDetails.getCurrentRegStock() > 0) {// prompt2 NO & prompt1 NO

							               System.out.println("**------if Stock List is Empty--------[inner for[inner else if]**");

							if (itemQty <= getCurrentStockDetails.getCurrentRegStock()) {

								

								currentStockDetailList.get(i).setCurrentRegStock(currentStockDetailList.get(i).getCurrentRegStock() - itemQty);
								           System.out.println("currentStockDetailList: " + currentStockDetailList.toString());
											
								 currentNewItem1.setBillStockType(1);

								currentNewItem1.setRegOpStockLess(false);
								currentNewItem1.setTotalRegStock(currentStockDetailList.get(i).getCurrentRegStock());
								
								prevCustomerBillItemList.add(currentNewItem1);
				                   
								//-------------------------------------Total Calculation--------------------------------------

								float total = 0;
								for (int j = 0; j < customerBillDataToken1.getCustomerBillList().size(); j++) {

									CustomerBillItem billItem =customerBillDataToken1.getCustomerBillList().get(j);

									float itemTotal = (float) (billItem.getQty() * billItem.getMrp());

									total = total + itemTotal;
								}

								System.out.println("**************************CALCULATED TOTAL: **********************" + total);

								customerBillDataToken1.setTotal(total);
								customerBillDataToken1.setGrandTotal(total);
								customerBillDataToken1.setRemainingAmount(total);
								
								//----------------------------------------END-------------------------------------------------
								System.out.println("****Token1.1****:" + customerBillDataToken1.toString());

								customerBillDataToken1.setCustomerBillList(prevCustomerBillItemList);

								return customerBillDataToken1.getCustomerBillList();
							} else {
								// Prompt3 ,item qty is less than entered qty, still you want to use avail qty"
								// if yes",subtract(avail Reg opening stock-entered qty),& reg op stk=0,"if
								// no",dont add to table and
								// and show alert1 your qty is over
								System.out.println("**if Stock List is Empty[for[else if[if[else]]]**");
								System.out.println("itemQty is gretor than reg stock qty !!");
								System.out.println("currentStockDetailList: " + currentStockDetailList.toString());

								currentNewItem1.setRegOpStockLess(true);
								currentNewItem1.setTotalRegStock(currentStockDetailList.get(i).getCurrentRegStock());
								
								prevCustomerBillItemList.add(currentNewItem1);
								customerBillDataToken1.setCustomerBillList(prevCustomerBillItemList);
				                   System.out.println("****Token1.2****:" + customerBillDataToken1.toString());

								return customerBillDataToken1.getCustomerBillList();

							}

						}
						else
						{
							//Current Regular Stock And Special Stock is over!!
							
							
							
							
							
						}
					}

				}

			} else {// if stock list is not empty.

				boolean isPrevItem = false;

				                      System.out.println("**-----Stock List is not Empty--------[--ELSE Loop]**");

				                      System.out.println("Customertoken1 list  ****:" + customerBillDataToken1.toString());

				for (int i = 0; i < currentStockDetailList.size(); i++) {

					GetCurrentStockDetails getCurrentStockDetails = currentStockDetailList.get(i);
					                  System.out.println("**----Stock List is not Empty---[ELSE Loop[for]]:" + currentNewItem1.getItemId()
							+ "liststock" + getCurrentStockDetails.getItemId());

					if (currentNewItem1.getId() == getCurrentStockDetails.getId()) {
						             // *****************************************************************************//

						if (getCurrentStockDetails.getCurrentSpStock() > 0) {
							        // prompt1(Are use WANT TO USE SpOpeningStock)if yes,
							        // bill stock type =2
							currentNewItem1.setSpStockGretor(true);
							currentNewItem1.setRegOpStockLess(false);
							currentNewItem1.setRegOpStockGretor(false);
							currentNewItem1.setSpStockLessthanQty(false);

							currentNewItem1.setBillStockType(2);
							currentNewItem1.setTotalSpStock(getCurrentStockDetails.getCurrentSpStock());
							          System.out.println("Spstock is greater: CurrentNewItem:  ****:" + currentNewItem1.toString());

							prevCustomerBillItemList.add(currentNewItem1);
							customerBillDataToken1.setCustomerBillList(prevCustomerBillItemList);
			                  
							          System.out.println("****Token1.3****:" + customerBillDataToken1.toString());

							          System.out.println("Return list  ****:" + customerBillDataToken1.toString());

							return customerBillDataToken1.getCustomerBillList();

						} else if (getCurrentStockDetails.getCurrentRegStock() > 0) {// prompt1 NO & prompt1 NO

							          System.out.println("**------if Stock List is Empty--------[inner for[inner else if]**");

							if (itemQty <= getCurrentStockDetails.getCurrentRegStock()) {

								      System.out.println("**------if Stock List is Empty-----[inner for[inner else if[inner if]]**");

								      // Add item to table and substract, (regOpStock-entered qty)
								      System.out.println("itemQty is less than or equal to reg stock qty !!");

								currentStockDetailList.get(i).setCurrentRegStock(currentStockDetailList.get(i).getCurrentRegStock() - itemQty);
								      System.out.println("currentStockDetailList: " + currentStockDetailList.toString());

								currentNewItem1.setBillStockType(1);   
								currentNewItem1.setRegOpStockLess(false);
								currentNewItem1.setTotalRegStock(currentStockDetailList.get(i).getCurrentRegStock() );
								
								prevCustomerBillItemList.add(currentNewItem1);
								//-------------------------------------Total Calculation--------------------------------------

								float total = 0;
								for (int j = 0; j < customerBillDataToken1.getCustomerBillList().size(); j++) {

									CustomerBillItem billItem =customerBillDataToken1.getCustomerBillList().get(j);

									float itemTotal = (float) (billItem.getQty() * billItem.getMrp());

									total = total + itemTotal;
								}

								System.out.println("**************************CALCULATED TOTAL: **********************" + total);

								customerBillDataToken1.setTotal(total);
								customerBillDataToken1.setGrandTotal(total);
								customerBillDataToken1.setRemainingAmount(total);
								
								//----------------------------------------END-------------------------------------------------
								
				                   System.out.println("****Token1.4****:" + customerBillDataToken1.toString());

								customerBillDataToken1.setCustomerBillList(prevCustomerBillItemList);

								return customerBillDataToken1.getCustomerBillList();
							} else {
								        // Prompt3 ,item qty is less than entered qty, still you want to use avail qty"
								        // if yes",substract(avail Reg opening stock-entered qty),& reg op stk=0,"if
								        // no",dont add to table and
								        // and show alert1 your qty is over
								          System.out.println("**if Stock List is Empty[for[else if[if[else]]]**");
								          System.out.println("itemQty is gretor than reg stock qty !!");
								          System.out.println("currentStockDetailList: " + currentStockDetailList.toString());

								currentNewItem1.setRegOpStockLess(true);
								currentNewItem1.setTotalRegStock(currentStockDetailList.get(i).getCurrentRegStock() );
								
								prevCustomerBillItemList.add(currentNewItem1);
								customerBillDataToken1.setCustomerBillList(prevCustomerBillItemList);
				                   System.out.println("****Token1.5****:" + customerBillDataToken1.toString());

								return customerBillDataToken1.getCustomerBillList();

							}

						}
						else
						{
							//Current Regular Stock And Special Stock is over!!
							
							/*currentNewItem2.setCurrentStockOver(true);
							prevCustomerBillItemList.add(currentNewItem2);
							customerBillDataToken1.setCustomerBillList(prevCustomerBillItemList);
*/							isPrevItem=true;
							
							
							
						}
						// *****************************************************************************//
					}

				}

				// ------------------------------------------------------------------------------
				if (!isPrevItem) {

					System.out.println("!isPrevItem"+"currentStockDetailList"+currentStockDetailList.size());
					
					      stockCalc(currentNewItem1, frDetails);
					
					for (int i = 0; i < currentStockDetailList.size(); i++) {

						GetCurrentStockDetails getCurrentStockDetails = currentStockDetailList.get(i);

						if (currentNewItem1.getId() == getCurrentStockDetails.getId()) {
							                System.out.println("**! isPrevItem [if[for[if]]]**");
							                // *****************************************************************************//

							if (getCurrentStockDetails.getCurrentSpStock() > 0) {
								            // prompt1(Are use WANT TO USE SpOpeningStock)if yes,
								            // bill stock type =2
								System.out.println("currentStockDetailList.get(i).getCurrentSpStock()"+currentStockDetailList.get(i).getCurrentSpStock());
								
								currentNewItem1.setSpStockGretor(true);
								currentNewItem1.setBillStockType(2);

								System.out.println("**** CurrentNewItem:  ****:" + currentNewItem1.toString());
								currentNewItem1.setTotalSpStock(currentStockDetailList.get(i).getCurrentSpStock() );

								prevCustomerBillItemList.add(currentNewItem1);
								customerBillDataToken1.setCustomerBillList(prevCustomerBillItemList);
				                   System.out.println("****Token1.6****:" + customerBillDataToken1.toString());

								return customerBillDataToken1.getCustomerBillList();

							} else if (getCurrentStockDetails.getCurrentRegStock() > 0) {// prompt1 NO & prompt1 NO

								System.out.println("**------if Stock List is Empty--------[inner for[inner else if]**");

								if (itemQty <= getCurrentStockDetails.getCurrentRegStock()) {

								      	      System.out.println(
											        "**------if Stock List is Empty-----[inner for[inner else if[inner if]]**");

									            // Add item to table and substract, (regOpStock-entered qty)
									            System.out.println("itemQty is less than or equal to reg stock qty !!");

									currentStockDetailList.get(i).setCurrentRegStock(
											currentStockDetailList.get(i).getCurrentRegStock() - itemQty);
									                 
									            System.out.println("currentStockDetailList: " + currentStockDetailList.toString());
												
									currentNewItem1.setBillStockType(1);

									currentNewItem1.setRegOpStockLess(false);
									currentNewItem1.setTotalRegStock(currentStockDetailList.get(i).getCurrentRegStock());
									
									prevCustomerBillItemList.add(currentNewItem1);

									customerBillDataToken1.setCustomerBillList(prevCustomerBillItemList);
									//-------------------------------------Total Calculation--------------------------------------

									float total = 0;
									for (int j = 0; j < customerBillDataToken1.getCustomerBillList().size(); j++) {

										CustomerBillItem billItem =customerBillDataToken1.getCustomerBillList().get(j);

										float itemTotal = (float) (billItem.getQty() * billItem.getMrp());

										total = total + itemTotal;
									}

									System.out.println("**************************CALCULATED TOTAL: **********************" + total);

									customerBillDataToken1.setTotal(total);
									customerBillDataToken1.setGrandTotal(total);
									customerBillDataToken1.setRemainingAmount(total);
									
									//----------------------------------------END-------------------------------------------------
					                   System.out.println("****Token1.6****:" + customerBillDataToken1.toString());

									return customerBillDataToken1.getCustomerBillList();
								} else {
									// Prompt3 ,item qty is less than entered qty, still you want to use avail qty"
									// if yes",substract(avail Reg opening stock-entered qty),& reg op stk=0,"if
									// no",dont add to table and
									// and show alert1 your qty is over
									System.out.println("**if Stock List is Empty[for[else if[if[else]]]**");
									System.out.println("itemQty is gretor than reg stock qty !!");
									System.out.println("currentStockDetailList: " + currentStockDetailList.toString());

									currentNewItem1.setRegOpStockLess(true);
									currentNewItem1.setTotalRegStock(currentStockDetailList.get(i).getCurrentRegStock());
									prevCustomerBillItemList.add(currentNewItem1);
									customerBillDataToken1.setCustomerBillList(prevCustomerBillItemList);
					                   System.out.println("****Token1.7****:" + customerBillDataToken1.toString());

									return customerBillDataToken1.getCustomerBillList();

								}

							}
							else
							{
								//Current Regular Stock And Special Stock is over!!
								
								
								
								
								
								
							}
							// *****************************************************************************//

						}

					}
				} else {
					// stock is over
					System.out.println("Else  ...........");

				}
			}
			float total = 0;
			for (int i = 0; i < prevCustomerBillItemList.size(); i++) {

				CustomerBillItem billItem = prevCustomerBillItemList.get(i);

				float itemTotal = (float) (billItem.getQty() * billItem.getMrp());

				total = total + itemTotal;
			}

			System.out.println("**************************CALCULATED TOTAL: **********************" + total);

			customerBillDataToken1.setCustomerBillList(prevCustomerBillItemList);
			customerBillDataToken1.setTotal(total);
			customerBillDataToken1.setGrandTotal(total);
			customerBillDataToken1.setRemainingAmount(total);

			System.out.println("Customer Bill Data Token1: " + customerBillDataToken1.toString());

		} catch (Exception e) {
			System.out.println("Exception adding item: " + e.getMessage());
			e.printStackTrace();

		}

		System.out.println("Customer Bill Data " + customerBillDataToken1.getCustomerBillList().toString());

		return customerBillDataToken1.getCustomerBillList();
	}
	

	
	// -------------------------------------------------------------------------------------------------------------------------------
	public void stockCalc(CustomerBillItem currentNewItem, Franchisee frDetails) {
		
	
		Integer runningMonth = 0;

		PostFrItemStockHeader frItemStockHeader;
		// -------------------------------------Stock---------------------------------------
		RestTemplate restTemplate = new RestTemplate();

		DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
		DateFormat yearFormat = new SimpleDateFormat("yyyy");

		try {
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("frId", frDetails.getFrId());

			frItemStockHeader = restTemplate.postForObject(Constant.URL + "getRunningMonth", map,
					PostFrItemStockHeader.class);
			runningMonth = frItemStockHeader.getMonth();

		} catch (Exception e) {
			System.out.println("Exception in runningMonth" + e.getMessage());
			e.printStackTrace();

		}

		Date todaysDate = new Date();
		System.out.println(dateFormat.format(todaysDate));

		Calendar cal = Calendar.getInstance();
		cal.setTime(todaysDate);

		cal.set(Calendar.DAY_OF_MONTH, 1);

		Date firstDay = cal.getTime();

		System.out.println("First Day of month " + firstDay);

		String strFirstDay = dateFormat.format(firstDay);

		System.out.println("Year " + yearFormat.format(todaysDate));

		MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
		map.add("frId", frDetails.getFrId());
		map.add("fromDate", dateFormat.format(firstDay));
		map.add("toDate", dateFormat.format(todaysDate));
		map.add("currentMonth", String.valueOf(runningMonth));
		map.add("year", yearFormat.format(todaysDate));
		System.out.println("currentNewItem catId:" + currentNewItem.getCatId());
		map.add("catId", currentNewItem.getCatId());
		map.add("itemIdList", currentNewItem.getId());

		ParameterizedTypeReference<List<GetCurrentStockDetails>> typeRef = new ParameterizedTypeReference<List<GetCurrentStockDetails>>() {
		};
		ResponseEntity<List<GetCurrentStockDetails>> responseEntity = restTemplate
				.exchange(Constant.URL + "getCurrentStock", HttpMethod.POST, new HttpEntity<>(map), typeRef);

		currentStockDetailList.addAll(responseEntity.getBody());
		System.out.println("Current Stock Details : " + currentStockDetailList.toString());
		// -----------------------------------------------------------------------------------
		
	}
	@RequestMapping(value = "/useFromSpecialOpStockFun11", method = RequestMethod.GET)
	public @ResponseBody List<CustomerBillItem> useFromSpecialOpStockFun11(
			@RequestParam(value = "index", required = true) int index) {

		CustomerBillItem currentNewItem = currentNewItem1;

		for (int i = 0; i < currentStockDetailList.size(); i++) {

			GetCurrentStockDetails getCurrentStockDetails = currentStockDetailList.get(i);
			                              System.out.println("**StockListIsNotEmpty[token1]*for*:" + currentNewItem.getItemId() + "liststock"
					                      + getCurrentStockDetails.getItemId());

			if (currentNewItem.getId() == getCurrentStockDetails.getId()) {

				if (currentNewItem.getQty() <= getCurrentStockDetails.getCurrentSpStock()) {
					// SUBSTRACT SP STOCK QTY(STOCK 2)
					currentStockDetailList.get(i).setCurrentSpStock(
							currentStockDetailList.get(i).getCurrentSpStock() - currentNewItem.getQty());

					customerBillDataToken1.getCustomerBillList().get(index).setBillStockType(2);// setting bill Stock
					customerBillDataToken1.getCustomerBillList().get(index).setTotalSpStock(currentStockDetailList.get(i).getCurrentSpStock());													// type

					customerBillDataToken1.getCustomerBillList().get(index).setRegOpStockGretor(false);
					customerBillDataToken1.getCustomerBillList().get(index).setRegOpStockLess(false);
					customerBillDataToken1.getCustomerBillList().get(index).setSpStockGretor(false);
					customerBillDataToken1.getCustomerBillList().get(index).setSpStockLessthanQty(false);
					System.out.println("currentStockDetailList: " + currentStockDetailList.toString());

					System.out.println("**** CurrentNewItem:  ****:" + currentNewItem1.toString());
					
					//-------------------------------------Total Calculation--------------------------------------

					float total = 0;
					for (int j = 0; j < customerBillDataToken1.getCustomerBillList().size(); j++) {

						CustomerBillItem billItem =customerBillDataToken1.getCustomerBillList().get(j);

						float itemTotal = (float) (billItem.getQty() * billItem.getMrp());

						total = total + itemTotal;
					}

					System.out.println("**************************CALCULATED TOTAL: **********************" + total);

					customerBillDataToken1.setTotal(total);
					customerBillDataToken1.setGrandTotal(total);
					customerBillDataToken1.setRemainingAmount(total);
					
					//----------------------------------------END-------------------------------------------------
	                   System.out.println("****Token1.7****:" + customerBillDataToken1.toString());

					return customerBillDataToken1.getCustomerBillList();

				} else {
					System.out.println("**** CurrentNewItem:  ****:" + currentNewItem1.toString());

					customerBillDataToken1.getCustomerBillList().get(index).setSpStockLessthanQty(true);
					customerBillDataToken1.getCustomerBillList().get(index).setTotalSpStock(currentStockDetailList.get(i).getCurrentSpStock());
					return customerBillDataToken1.getCustomerBillList();

				}
			}
		}

		return customerBillDataToken1.getCustomerBillList();

	}

	@RequestMapping(value = "/useFromSpecialOpStockFun21", method = RequestMethod.GET)
	public @ResponseBody List<CustomerBillItem> useFromSpecialOpStockFun21(
			@RequestParam(value = "index", required = true) int index) {

		CustomerBillItem currentNewItem = currentNewItem1;

		for (int i = 0; i < currentStockDetailList.size(); i++) {

			GetCurrentStockDetails getCurrentStockDetails = currentStockDetailList.get(i);
			System.out.println("***currentitem stk:[token1]" + currentNewItem.getItemId() + "liststock2"
					+ getCurrentStockDetails.getItemId());

			if (currentNewItem.getId() == getCurrentStockDetails.getId()) {
				System.out.println("currentStockDetailList.get(i).getCurrentSpStock()"
						+ currentStockDetailList.get(i).getCurrentSpStock());

				customerBillDataToken1.getCustomerBillList().get(index)
						.setQty(currentStockDetailList.get(i).getCurrentSpStock());// qty changes to show on jsp

				// SUBSTRACT SP STOCK QTY(STOCK 2)
				currentStockDetailList.get(i).setCurrentSpStock(currentStockDetailList.get(i).getCurrentSpStock()
						- currentStockDetailList.get(i).getCurrentSpStock());// 0 qty

				customerBillDataToken1.getCustomerBillList().get(index).setBillStockType(2);// setting bill Stock type
				customerBillDataToken1.getCustomerBillList().get(index).setRegOpStockGretor(false);
				customerBillDataToken1.getCustomerBillList().get(index).setRegOpStockLess(false);
				customerBillDataToken1.getCustomerBillList().get(index).setSpStockGretor(false);
				customerBillDataToken1.getCustomerBillList().get(index).setSpStockLessthanQty(false);
				customerBillDataToken1.getCustomerBillList().get(index).setTotalSpStock(currentStockDetailList.get(i).getCurrentSpStock());
				
				System.out.println("currentStockDetailList: " + currentStockDetailList.toString());
				System.out.println("**** CurrentNewItem:  ****:" + currentNewItem1.toString());
				//-------------------------------------Total Calculation--------------------------------------

				float total = 0;
				for (int j = 0; j < customerBillDataToken1.getCustomerBillList().size(); j++) {

					CustomerBillItem billItem =customerBillDataToken1.getCustomerBillList().get(j);

					float itemTotal = (float) (billItem.getQty() * billItem.getMrp());

					total = total + itemTotal;
				}

				System.out.println("**************************CALCULATED TOTAL: **********************" + total);

				customerBillDataToken1.setTotal(total);
				customerBillDataToken1.setGrandTotal(total);
				customerBillDataToken1.setRemainingAmount(total);
				
				//----------------------------------------END-------------------------------------------------
				
                System.out.println("****Token1.8****:" + customerBillDataToken1.toString());

				return customerBillDataToken1.getCustomerBillList();

			}
		}

		return customerBillDataToken1.getCustomerBillList();

	}

	@RequestMapping(value = "/useFromRegOpeningStockFun31", method = RequestMethod.GET)
	public @ResponseBody List<CustomerBillItem> useFromRegOpeningStockFun31(
			@RequestParam(value = "index", required = true) int index) {
		
		
		
		System.out.println("IN  /useFromRegOpeningStockFun31");

		CustomerBillItem currentNewItem = currentNewItem1;

		for (int i = 0; i < currentStockDetailList.size(); i++) {

			GetCurrentStockDetails getCurrentStockDetails = currentStockDetailList.get(i);
			System.out.println(
					"currentitem stk:" + currentNewItem.getId() + "liststock" + getCurrentStockDetails.getId());

			if (currentNewItem.getId() == getCurrentStockDetails.getId()) {

				if (currentNewItem.getQty() <= getCurrentStockDetails.getCurrentRegStock()) {
					// SUBSTRACT SP STOCK QTY(STOCK 2)
					currentStockDetailList.get(i).setCurrentRegStock(
							currentStockDetailList.get(i).getCurrentRegStock() - currentNewItem.getQty());

					customerBillDataToken1.getCustomerBillList().get(index).setBillStockType(1);// setting bill Stock
																								// type
					customerBillDataToken1.getCustomerBillList().get(index).setRegOpStockGretor(false);
					customerBillDataToken1.getCustomerBillList().get(index).setRegOpStockLess(false);
					customerBillDataToken1.getCustomerBillList().get(index).setSpStockGretor(false);
					customerBillDataToken1.getCustomerBillList().get(index).setSpStockLessthanQty(false);
					customerBillDataToken1.getCustomerBillList().get(index).setTotalRegStock(currentStockDetailList.get(i).getCurrentRegStock());
					
					System.out.println("currentStockDetailList:" + currentStockDetailList.toString());
					System.out.println("**** CurrentNewItem:  ****:" + currentNewItem1.toString());
					
					//-------------------------------------Total Calculation--------------------------------------

					float total = 0;
					for (int j = 0; j < customerBillDataToken1.getCustomerBillList().size(); j++) {

						CustomerBillItem billItem =customerBillDataToken1.getCustomerBillList().get(j);

						float itemTotal = (float) (billItem.getQty() * billItem.getMrp());

						total = total + itemTotal;
					}

					System.out.println("**************************CALCULATED TOTAL: **********************" + total);

					customerBillDataToken1.setTotal(total);
					customerBillDataToken1.setGrandTotal(total);
					customerBillDataToken1.setRemainingAmount(total);
					
					//----------------------------------------END-------------------------------------------------
	                   System.out.println("****Token1.9****:" + customerBillDataToken1.toString());

					return customerBillDataToken1.getCustomerBillList();

				} else {
					System.out.println("currentStockDetailList: " + currentStockDetailList.toString());

					System.out.println("**** CurrentNewItem:  ****:" + currentNewItem1.toString());

					customerBillDataToken1.getCustomerBillList().get(index).setRegOpStockLess(true);
					customerBillDataToken1.getCustomerBillList().get(index).setTotalRegStock(currentStockDetailList.get(i).getCurrentRegStock());
					return customerBillDataToken1.getCustomerBillList();

				}
			}
		}

		return customerBillDataToken1.getCustomerBillList();

	}

	@RequestMapping(value = "/useFromRegOpeningStockFun41", method = RequestMethod.GET)
	public @ResponseBody List<CustomerBillItem> useFromRegOpeningStockFun41(
			@RequestParam(value = "index", required = true) int index) {

		System.out.println("IN  /useFromRegOpeningStockFun41");

		CustomerBillItem currentNewItem = currentNewItem1;

		for (int i = 0; i < currentStockDetailList.size(); i++) {

			GetCurrentStockDetails getCurrentStockDetails = currentStockDetailList.get(i);
			System.out.println(
					"currentitem stk:" + currentNewItem.getId() + "liststock" + getCurrentStockDetails.getId());

			if (currentNewItem.getId() == getCurrentStockDetails.getId()) {

				customerBillDataToken1.getCustomerBillList().get(index)
						.setQty(currentStockDetailList.get(i).getCurrentRegStock());// qty changes

				currentStockDetailList.get(i).setCurrentRegStock(currentStockDetailList.get(i).getCurrentRegStock()
						- currentStockDetailList.get(i).getCurrentRegStock());

				customerBillDataToken1.getCustomerBillList().get(index).setBillStockType(1);// setting bill Stock type
				customerBillDataToken1.getCustomerBillList().get(index).setRegOpStockGretor(false);
				customerBillDataToken1.getCustomerBillList().get(index).setRegOpStockLess(false);
				customerBillDataToken1.getCustomerBillList().get(index).setSpStockGretor(false);
				customerBillDataToken1.getCustomerBillList().get(index).setSpStockLessthanQty(false);
				customerBillDataToken1.getCustomerBillList().get(index).setTotalRegStock(currentStockDetailList.get(i).getCurrentRegStock());

				
				System.out.println("currentStockDetailList:" + currentStockDetailList.toString());
				System.out.println("**** CurrentNewItem:  ****:" + currentNewItem1.toString());
				//-------------------------------------Total Calculation--------------------------------------

				float total = 0;
				for (int j = 0; j < customerBillDataToken1.getCustomerBillList().size(); j++) {

					CustomerBillItem billItem =customerBillDataToken1.getCustomerBillList().get(j);

					float itemTotal = (float) (billItem.getQty() * billItem.getMrp());

					total = total + itemTotal;
				}

				System.out.println("**************************CALCULATED TOTAL: **********************" + total);

				customerBillDataToken1.setTotal(total);
				customerBillDataToken1.setGrandTotal(total);
				customerBillDataToken1.setRemainingAmount(total);
				
				//----------------------------------------END-------------------------------------------------
                System.out.println("****Token1.0.1****:" + customerBillDataToken1.toString());

				return customerBillDataToken1.getCustomerBillList();

			}
		}

		return customerBillDataToken1.getCustomerBillList();

	}



	// -------------------------------------------------------------------------------------------------------------------
	@RequestMapping(value = "/addNewCustBillItemToken2", method = RequestMethod.GET)
	public @ResponseBody List<CustomerBillItem> getAllAddedItem2(HttpServletRequest request,
			HttpServletResponse response) {
		System.out.println("**************GETITEMBYID*******************");

		int prevQty = 0;

		int id = Integer.parseInt(request.getParameter("id"));
		System.out.println("id : " + id);

		int itemQty = Integer.parseInt(request.getParameter("qty"));
		System.out.println("itemQty : " + itemQty);
	
		try {
			
			HttpSession ses = request.getSession();
			Franchisee frDetails = (Franchisee) ses.getAttribute("frDetails");

			List<CustomerBillItem> prevCustomerBillItemList = customerBillDataToken2.getCustomerBillList();
			
			// CustomerBillItem currentNewItem=new CustomerBillItem();

			for (int i = 0; i < customerBillItemList.size(); i++) {

				if (customerBillItemList.get(i).getId() == id) {
					
					System.out.println("Data Matched : " + customerBillItemList.get(i).getId());
					
					
					
				//	currentNewItem2 = customerBillItemList.get(i);
					
					currentNewItem2=new CustomerBillItem();
					
					currentNewItem2.setBillStockType(customerBillItemList.get(i).getBillStockType());
					currentNewItem2.setCatId(customerBillItemList.get(i).getCatId());
					currentNewItem2.setId(customerBillItemList.get(i).getId());
					currentNewItem2.setItemId(customerBillItemList.get(i).getItemId());
					currentNewItem2.setItemName(customerBillItemList.get(i).getItemName());
					currentNewItem2.setItemTax1(customerBillItemList.get(i).getItemTax1());
					currentNewItem2.setItemTax2(customerBillItemList.get(i).getItemTax2());
					currentNewItem2.setItemTax3(customerBillItemList.get(i).getItemTax3());
					currentNewItem2.setMrp(customerBillItemList.get(i).getMrp());
					currentNewItem2.setQty(customerBillItemList.get(i).getQty());
					currentNewItem2.setRate(customerBillItemList.get(i).getRate());
					currentNewItem2.setRegOpStockGretor(customerBillItemList.get(i).isRegOpStockGretor());
					currentNewItem2.setRegOpStockLess(customerBillItemList.get(i).isRegOpStockLess());
					currentNewItem2.setSpStockGretor(customerBillItemList.get(i).isSpStockGretor());
					currentNewItem2.setSpStockLessthanQty(customerBillItemList.get(i).isSpStockLessthanQty());
					
					currentNewItem2.setCurrentStockOver(customerBillItemList.get(i).isCurrentStockOver());
					currentNewItem2.setTotalRegStock(customerBillItemList.get(i).getTotalRegStock());
					currentNewItem2.setTotalSpStock(customerBillItemList.get(i).getTotalSpStock());
					
					prevQty = customerBillItemList.get(i).getQty();
					currentNewItem2.setQty(itemQty);

				}

			}
			if (currentStockDetailList.size() == 0) {

				stockCalc(currentNewItem2, frDetails);// stock calculation

				                   System.out.println("****1)currentStockDetailList[token2]****:" + currentStockDetailList.toString());

				for (int i = 0; i <= currentStockDetailList.size(); i++) {
					
					GetCurrentStockDetails getCurrentStockDetails = currentStockDetailList.get(i);
				
					               System.out.println("****2)getCurrentStockDetails[token2]****:" + getCurrentStockDetails.toString());

					if (currentNewItem2.getId() == getCurrentStockDetails.getId()) {
						
						           System.out.println("****3)Id Matched:****" + currentNewItem2.getId());

						if (getCurrentStockDetails.getCurrentSpStock() > 0) {
							
							
							        // prompt1(Are use WANT TO USE SpOpeningStock)if yes,
							        // bill stock type =2
							currentNewItem2.setSpStockGretor(true);//current Sp Stock
							currentNewItem2.setBillStockType(2);
							
							currentNewItem2.setTotalSpStock(getCurrentStockDetails.getCurrentSpStock());//
							currentNewItem2.setTotalRegStock(getCurrentStockDetails.getCurrentRegStock());//

							
						           	System.out.println("**** CurrentNewItem:  ****:" + currentNewItem2.toString());

							prevCustomerBillItemList.add(currentNewItem2);
							customerBillDataToken2.setCustomerBillList(prevCustomerBillItemList);
			                   System.out.println("****Token2.0****:" + customerBillDataToken2.toString());

							return customerBillDataToken2.getCustomerBillList();

						} else if (getCurrentStockDetails.getCurrentRegStock() > 0) {// prompt2 NO & prompt1 NO

							               System.out.println("**------if Stock List is Empty--------[inner for[inner else if]**");

							if (itemQty <= getCurrentStockDetails.getCurrentRegStock()) {

								

								currentStockDetailList.get(i).setCurrentRegStock(currentStockDetailList.get(i).getCurrentRegStock() - itemQty);
								           System.out.println("currentStockDetailList: " + currentStockDetailList.toString());
											
								 currentNewItem2.setBillStockType(1);

								currentNewItem2.setRegOpStockLess(false);
								currentNewItem2.setTotalRegStock(currentStockDetailList.get(i).getCurrentRegStock());
								
								prevCustomerBillItemList.add(currentNewItem2);
				                   
								//-------------------------------------Total Calculation--------------------------------------

								float total = 0;
								for (int j = 0; j < customerBillDataToken2.getCustomerBillList().size(); j++) {

									CustomerBillItem billItem =customerBillDataToken2.getCustomerBillList().get(j);

									float itemTotal = (float) (billItem.getQty() * billItem.getMrp());

									total = total + itemTotal;
								}

								System.out.println("**************************CALCULATED TOTAL: **********************" + total);

								customerBillDataToken2.setTotal(total);
								customerBillDataToken2.setGrandTotal(total);
								customerBillDataToken2.setRemainingAmount(total);
								
								//----------------------------------------END-------------------------------------------------
								System.out.println("****Token2.1****:" + customerBillDataToken2.toString());

								customerBillDataToken2.setCustomerBillList(prevCustomerBillItemList);

								return customerBillDataToken2.getCustomerBillList();
							} else {
								// Prompt3 ,item qty is less than entered qty, still you want to use avail qty"
								// if yes",subtract(avail Reg opening stock-entered qty),& reg op stk=0,"if
								// no",dont add to table and
								// and show alert1 your qty is over
								System.out.println("**if Stock List is Empty[for[else if[if[else]]]**");
								System.out.println("itemQty is gretor than reg stock qty !!");
								System.out.println("currentStockDetailList: " + currentStockDetailList.toString());

								currentNewItem2.setRegOpStockLess(true);
								currentNewItem2.setTotalRegStock(currentStockDetailList.get(i).getCurrentRegStock());
								
								prevCustomerBillItemList.add(currentNewItem2);
								customerBillDataToken2.setCustomerBillList(prevCustomerBillItemList);
				                   System.out.println("****Token2.2****:" + customerBillDataToken2.toString());

								return customerBillDataToken2.getCustomerBillList();

							}

						}
						else
						{
							//Current Regular Stock And Special Stock is over!!
							
							
							
							
							
						}
					}

				}

			} else {// if stock list is not empty.

				boolean isPrevItem = false;

				                      System.out.println("**-----Stock List is not Empty--------[--ELSE Loop]**");

				                      System.out.println("Customertoken2 list  ****:" + customerBillDataToken2.toString());

				for (int i = 0; i < currentStockDetailList.size(); i++) {

					GetCurrentStockDetails getCurrentStockDetails = currentStockDetailList.get(i);
					                  System.out.println("**----Stock List is not Empty---[ELSE Loop[for]]:" + currentNewItem2.getItemId()
							+ "liststock" + getCurrentStockDetails.getItemId());

					if (currentNewItem2.getId() == getCurrentStockDetails.getId()) {
						             // *****************************************************************************//

						if (getCurrentStockDetails.getCurrentSpStock() > 0) {
							        // prompt1(Are use WANT TO USE SpOpeningStock)if yes,
							        // bill stock type =2
							currentNewItem2.setSpStockGretor(true);
							currentNewItem2.setRegOpStockLess(false);
							currentNewItem2.setRegOpStockGretor(false);
							currentNewItem2.setSpStockLessthanQty(false);

							currentNewItem2.setBillStockType(2);
							currentNewItem2.setTotalSpStock(getCurrentStockDetails.getCurrentSpStock());
							          System.out.println("Spstock is greater: CurrentNewItem:  ****:" + currentNewItem2.toString());

							prevCustomerBillItemList.add(currentNewItem2);
							customerBillDataToken2.setCustomerBillList(prevCustomerBillItemList);
			                  
							          System.out.println("****Token2.3****:" + customerBillDataToken2.toString());

							          System.out.println("Return list  ****:" + customerBillDataToken2.toString());

							return customerBillDataToken2.getCustomerBillList();

						} else if (getCurrentStockDetails.getCurrentRegStock() > 0) {// prompt2 NO & prompt1 NO

							          System.out.println("**------if Stock List is Empty--------[inner for[inner else if]**");

							if (itemQty <= getCurrentStockDetails.getCurrentRegStock()) {

								      System.out.println("**------if Stock List is Empty-----[inner for[inner else if[inner if]]**");

								      // Add item to table and substract, (regOpStock-entered qty)
								      System.out.println("itemQty is less than or equal to reg stock qty !!");

								currentStockDetailList.get(i).setCurrentRegStock(currentStockDetailList.get(i).getCurrentRegStock() - itemQty);
								      System.out.println("currentStockDetailList: " + currentStockDetailList.toString());

								currentNewItem2.setBillStockType(1);   
								currentNewItem2.setRegOpStockLess(false);
								currentNewItem2.setTotalRegStock(currentStockDetailList.get(i).getCurrentRegStock() );
								
								prevCustomerBillItemList.add(currentNewItem2);
								//-------------------------------------Total Calculation--------------------------------------

								float total = 0;
								for (int j = 0; j < customerBillDataToken2.getCustomerBillList().size(); j++) {

									CustomerBillItem billItem =customerBillDataToken2.getCustomerBillList().get(j);

									float itemTotal = (float) (billItem.getQty() * billItem.getMrp());

									total = total + itemTotal;
								}

								System.out.println("**************************CALCULATED TOTAL: **********************" + total);

								customerBillDataToken2.setTotal(total);
								customerBillDataToken2.setGrandTotal(total);
								customerBillDataToken2.setRemainingAmount(total);
								
								//----------------------------------------END-------------------------------------------------
								
				                   System.out.println("****Token2.4****:" + customerBillDataToken2.toString());

								customerBillDataToken2.setCustomerBillList(prevCustomerBillItemList);

								return customerBillDataToken2.getCustomerBillList();
							} else {
								        // Prompt3 ,item qty is less than entered qty, still you want to use avail qty"
								        // if yes",substract(avail Reg opening stock-entered qty),& reg op stk=0,"if
								        // no",dont add to table and
								        // and show alert1 your qty is over
								          System.out.println("**if Stock List is Empty[for[else if[if[else]]]**");
								          System.out.println("itemQty is gretor than reg stock qty !!");
								          System.out.println("currentStockDetailList: " + currentStockDetailList.toString());

								currentNewItem2.setRegOpStockLess(true);
								currentNewItem2.setTotalRegStock(currentStockDetailList.get(i).getCurrentRegStock() );
								
								prevCustomerBillItemList.add(currentNewItem2);
								customerBillDataToken2.setCustomerBillList(prevCustomerBillItemList);
				                   System.out.println("****Token2.5****:" + customerBillDataToken2.toString());

								return customerBillDataToken2.getCustomerBillList();

							}

						}
						else
						{
							//Current Regular Stock And Special Stock is over!!
							
							/*currentNewItem2.setCurrentStockOver(true);
							prevCustomerBillItemList.add(currentNewItem2);
							customerBillDataToken2.setCustomerBillList(prevCustomerBillItemList);
*/							isPrevItem=true;
							
							
							
						}
						// *****************************************************************************//
					}

				}

				// ------------------------------------------------------------------------------
				if (!isPrevItem) {

					System.out.println("!isPrevItem"+"currentStockDetailList"+currentStockDetailList.size());
					
					      stockCalc(currentNewItem2, frDetails);
					
					for (int i = 0; i < currentStockDetailList.size(); i++) {

						GetCurrentStockDetails getCurrentStockDetails = currentStockDetailList.get(i);

						if (currentNewItem2.getId() == getCurrentStockDetails.getId()) {
							                System.out.println("**! isPrevItem [if[for[if]]]**");
							                // *****************************************************************************//

							if (getCurrentStockDetails.getCurrentSpStock() > 0) {
								            // prompt1(Are use WANT TO USE SpOpeningStock)if yes,
								            // bill stock type =2
								System.out.println("currentStockDetailList.get(i).getCurrentSpStock()"+currentStockDetailList.get(i).getCurrentSpStock());
								
								currentNewItem2.setSpStockGretor(true);
								currentNewItem2.setBillStockType(2);

								System.out.println("**** CurrentNewItem:  ****:" + currentNewItem2.toString());
								currentNewItem2.setTotalSpStock(currentStockDetailList.get(i).getCurrentSpStock() );

								prevCustomerBillItemList.add(currentNewItem2);
								customerBillDataToken2.setCustomerBillList(prevCustomerBillItemList);
				                   System.out.println("****Token2.6****:" + customerBillDataToken2.toString());

								return customerBillDataToken2.getCustomerBillList();

							} else if (getCurrentStockDetails.getCurrentRegStock() > 0) {// prompt2 NO & prompt1 NO

								System.out.println("**------if Stock List is Empty--------[inner for[inner else if]**");

								if (itemQty <= getCurrentStockDetails.getCurrentRegStock()) {

								      	      System.out.println(
											        "**------if Stock List is Empty-----[inner for[inner else if[inner if]]**");

									            // Add item to table and substract, (regOpStock-entered qty)
									            System.out.println("itemQty is less than or equal to reg stock qty !!");

									currentStockDetailList.get(i).setCurrentRegStock(
											currentStockDetailList.get(i).getCurrentRegStock() - itemQty);
									                 
									            System.out.println("currentStockDetailList: " + currentStockDetailList.toString());
												
									currentNewItem2.setBillStockType(1);

									currentNewItem2.setRegOpStockLess(false);
									currentNewItem2.setTotalRegStock(currentStockDetailList.get(i).getCurrentRegStock());
									
									prevCustomerBillItemList.add(currentNewItem2);

									customerBillDataToken2.setCustomerBillList(prevCustomerBillItemList);
									//-------------------------------------Total Calculation--------------------------------------

									float total = 0;
									for (int j = 0; j < customerBillDataToken2.getCustomerBillList().size(); j++) {

										CustomerBillItem billItem =customerBillDataToken2.getCustomerBillList().get(j);

										float itemTotal = (float) (billItem.getQty() * billItem.getMrp());

										total = total + itemTotal;
									}

									System.out.println("**************************CALCULATED TOTAL: **********************" + total);

									customerBillDataToken2.setTotal(total);
									customerBillDataToken2.setGrandTotal(total);
									customerBillDataToken2.setRemainingAmount(total);
									
									//----------------------------------------END-------------------------------------------------
					                   System.out.println("****Token2.6****:" + customerBillDataToken2.toString());

									return customerBillDataToken2.getCustomerBillList();
								} else {
									// Prompt3 ,item qty is less than entered qty, still you want to use avail qty"
									// if yes",substract(avail Reg opening stock-entered qty),& reg op stk=0,"if
									// no",dont add to table and
									// and show alert1 your qty is over
									System.out.println("**if Stock List is Empty[for[else if[if[else]]]**");
									System.out.println("itemQty is gretor than reg stock qty !!");
									System.out.println("currentStockDetailList: " + currentStockDetailList.toString());

									currentNewItem2.setRegOpStockLess(true);
									currentNewItem2.setTotalRegStock(currentStockDetailList.get(i).getCurrentRegStock());
									prevCustomerBillItemList.add(currentNewItem2);
									customerBillDataToken2.setCustomerBillList(prevCustomerBillItemList);
					                   System.out.println("****Token2.7****:" + customerBillDataToken2.toString());

									return customerBillDataToken2.getCustomerBillList();

								}

							}
							else
							{
								//Current Regular Stock And Special Stock is over!!
								
								
								
								
								
								
							}
							// *****************************************************************************//

						}

					}
				} else {
					// stock is over
					System.out.println("Else  ...........");

				}
			}

	
			float total = 0;
			for (int i = 0; i < prevCustomerBillItemList.size(); i++) {

				CustomerBillItem billItem = prevCustomerBillItemList.get(i);

				float itemTotal = (float) (billItem.getQty() * billItem.getMrp());

				total = total + itemTotal;
			}

			System.out.println("**************************CALCULATED TOTAL: **********************" + total);

			customerBillDataToken2.setCustomerBillList(prevCustomerBillItemList);
			customerBillDataToken2.setTotal(total);
			customerBillDataToken2.setGrandTotal(total);
			customerBillDataToken2.setRemainingAmount(total);

			System.out.println("Customer Bill Data Token2: " + customerBillDataToken2.toString());

		} catch (Exception e) {
			System.out.println("Exception adding item: " + e.getMessage());
			e.printStackTrace();

		}

		System.out.println("Customer Bill Data2 " + customerBillDataToken2.getCustomerBillList().toString());

		return customerBillDataToken2.getCustomerBillList();
	}

	@RequestMapping(value = "/useFromSpecialOpStockFun1", method = RequestMethod.GET)
	public @ResponseBody List<CustomerBillItem> useFromSpecialOpStockFun1(
			@RequestParam(value = "index", required = true) int index) {

		CustomerBillItem currentNewItem = currentNewItem2;

		for (int i = 0; i < currentStockDetailList.size(); i++) {

			GetCurrentStockDetails getCurrentStockDetails = currentStockDetailList.get(i);
			                              System.out.println("**StockListIsNotEmpty[token2]*for*:" + currentNewItem.getItemId() + "liststock"
					                      + getCurrentStockDetails.getItemId());

			if (currentNewItem.getId() == getCurrentStockDetails.getId()) {

				if (currentNewItem.getQty() <= getCurrentStockDetails.getCurrentSpStock()) {
					// SUBSTRACT SP STOCK QTY(STOCK 2)
					currentStockDetailList.get(i).setCurrentSpStock(
							currentStockDetailList.get(i).getCurrentSpStock() - currentNewItem.getQty());

					customerBillDataToken2.getCustomerBillList().get(index).setBillStockType(2);// setting bill Stock
					customerBillDataToken2.getCustomerBillList().get(index).setTotalSpStock(currentStockDetailList.get(i).getCurrentSpStock());													// type

					customerBillDataToken2.getCustomerBillList().get(index).setRegOpStockGretor(false);
					customerBillDataToken2.getCustomerBillList().get(index).setRegOpStockLess(false);
					customerBillDataToken2.getCustomerBillList().get(index).setSpStockGretor(false);
					customerBillDataToken2.getCustomerBillList().get(index).setSpStockLessthanQty(false);
					System.out.println("currentStockDetailList: " + currentStockDetailList.toString());

					System.out.println("**** CurrentNewItem:  ****:" + currentNewItem2.toString());
					
					//-------------------------------------Total Calculation--------------------------------------

					float total = 0;
					for (int j = 0; j < customerBillDataToken2.getCustomerBillList().size(); j++) {

						CustomerBillItem billItem =customerBillDataToken2.getCustomerBillList().get(j);

						float itemTotal = (float) (billItem.getQty() * billItem.getMrp());

						total = total + itemTotal;
					}

					System.out.println("**************************CALCULATED TOTAL: **********************" + total);

					customerBillDataToken2.setTotal(total);
					customerBillDataToken2.setGrandTotal(total);
					customerBillDataToken2.setRemainingAmount(total);
					
					//----------------------------------------END-------------------------------------------------
	                   System.out.println("****Token2.7****:" + customerBillDataToken2.toString());

					return customerBillDataToken2.getCustomerBillList();

				} else {
					System.out.println("**** CurrentNewItem:  ****:" + currentNewItem2.toString());

					customerBillDataToken2.getCustomerBillList().get(index).setSpStockLessthanQty(true);
					customerBillDataToken2.getCustomerBillList().get(index).setTotalSpStock(currentStockDetailList.get(i).getCurrentSpStock());
					return customerBillDataToken2.getCustomerBillList();

				}
			}
		}

		return customerBillDataToken2.getCustomerBillList();

	}

	@RequestMapping(value = "/useFromSpecialOpStockFun2", method = RequestMethod.GET)
	public @ResponseBody List<CustomerBillItem> useFromSpecialOpStockFun2(
			@RequestParam(value = "index", required = true) int index) {

		CustomerBillItem currentNewItem = currentNewItem2;

		for (int i = 0; i < currentStockDetailList.size(); i++) {

			GetCurrentStockDetails getCurrentStockDetails = currentStockDetailList.get(i);
			System.out.println("***currentitem stk:[token2]" + currentNewItem.getItemId() + "liststock2"
					+ getCurrentStockDetails.getItemId());

			if (currentNewItem.getId() == getCurrentStockDetails.getId()) {
				System.out.println("currentStockDetailList.get(i).getCurrentSpStock()"
						+ currentStockDetailList.get(i).getCurrentSpStock());

				customerBillDataToken2.getCustomerBillList().get(index)
						.setQty(currentStockDetailList.get(i).getCurrentSpStock());// qty changes to show on jsp

				// SUBSTRACT SP STOCK QTY(STOCK 2)
				currentStockDetailList.get(i).setCurrentSpStock(currentStockDetailList.get(i).getCurrentSpStock()
						- currentStockDetailList.get(i).getCurrentSpStock());// 0 qty

				customerBillDataToken2.getCustomerBillList().get(index).setBillStockType(2);// setting bill Stock type
				customerBillDataToken2.getCustomerBillList().get(index).setRegOpStockGretor(false);
				customerBillDataToken2.getCustomerBillList().get(index).setRegOpStockLess(false);
				customerBillDataToken2.getCustomerBillList().get(index).setSpStockGretor(false);
				customerBillDataToken2.getCustomerBillList().get(index).setSpStockLessthanQty(false);
				customerBillDataToken2.getCustomerBillList().get(index).setTotalSpStock(currentStockDetailList.get(i).getCurrentSpStock());
				
				System.out.println("currentStockDetailList: " + currentStockDetailList.toString());
				System.out.println("**** CurrentNewItem:  ****:" + currentNewItem2.toString());
				//-------------------------------------Total Calculation--------------------------------------

				float total = 0;
				for (int j = 0; j < customerBillDataToken2.getCustomerBillList().size(); j++) {

					CustomerBillItem billItem =customerBillDataToken2.getCustomerBillList().get(j);

					float itemTotal = (float) (billItem.getQty() * billItem.getMrp());

					total = total + itemTotal;
				}

				System.out.println("**************************CALCULATED TOTAL: **********************" + total);

				customerBillDataToken2.setTotal(total);
				customerBillDataToken2.setGrandTotal(total);
				customerBillDataToken2.setRemainingAmount(total);
				
				//----------------------------------------END-------------------------------------------------
				
                System.out.println("****Token2.8****:" + customerBillDataToken2.toString());

				return customerBillDataToken2.getCustomerBillList();

			}
		}

		return customerBillDataToken2.getCustomerBillList();

	}

	@RequestMapping(value = "/useFromRegOpeningStockFun3", method = RequestMethod.GET)
	public @ResponseBody List<CustomerBillItem> useFromRegOpeningStockFun3(
			@RequestParam(value = "index", required = true) int index) {
		
		
		
		System.out.println("IN  /useFromRegOpeningStockFun3");

		CustomerBillItem currentNewItem = currentNewItem2;

		for (int i = 0; i < currentStockDetailList.size(); i++) {

			GetCurrentStockDetails getCurrentStockDetails = currentStockDetailList.get(i);
			System.out.println(
					"currentitem stk:" + currentNewItem.getId() + "liststock" + getCurrentStockDetails.getId());

			if (currentNewItem.getId() == getCurrentStockDetails.getId()) {

				if (currentNewItem.getQty() <= getCurrentStockDetails.getCurrentRegStock()) {
					// SUBSTRACT SP STOCK QTY(STOCK 2)
					currentStockDetailList.get(i).setCurrentRegStock(
							currentStockDetailList.get(i).getCurrentRegStock() - currentNewItem.getQty());

					customerBillDataToken2.getCustomerBillList().get(index).setBillStockType(1);// setting bill Stock
																								// type
					customerBillDataToken2.getCustomerBillList().get(index).setRegOpStockGretor(false);
					customerBillDataToken2.getCustomerBillList().get(index).setRegOpStockLess(false);
					customerBillDataToken2.getCustomerBillList().get(index).setSpStockGretor(false);
					customerBillDataToken2.getCustomerBillList().get(index).setSpStockLessthanQty(false);
					customerBillDataToken2.getCustomerBillList().get(index).setTotalRegStock(currentStockDetailList.get(i).getCurrentRegStock());
					
					System.out.println("currentStockDetailList:" + currentStockDetailList.toString());
					System.out.println("**** CurrentNewItem:  ****:" + currentNewItem2.toString());
					
					//-------------------------------------Total Calculation--------------------------------------

					float total = 0;
					for (int j = 0; j < customerBillDataToken2.getCustomerBillList().size(); j++) {

						CustomerBillItem billItem =customerBillDataToken2.getCustomerBillList().get(j);

						float itemTotal = (float) (billItem.getQty() * billItem.getMrp());

						total = total + itemTotal;
					}

					System.out.println("**************************CALCULATED TOTAL: **********************" + total);

					customerBillDataToken2.setTotal(total);
					customerBillDataToken2.setGrandTotal(total);
					customerBillDataToken2.setRemainingAmount(total);
					
					//----------------------------------------END-------------------------------------------------
	                   System.out.println("****Token2.9****:" + customerBillDataToken2.toString());

					return customerBillDataToken2.getCustomerBillList();

				} else {
					System.out.println("currentStockDetailList: " + currentStockDetailList.toString());

					System.out.println("**** CurrentNewItem:  ****:" + currentNewItem2.toString());

					customerBillDataToken2.getCustomerBillList().get(index).setRegOpStockLess(true);
					customerBillDataToken2.getCustomerBillList().get(index).setTotalRegStock(currentStockDetailList.get(i).getCurrentRegStock());
					return customerBillDataToken2.getCustomerBillList();

				}
			}
		}

		return customerBillDataToken2.getCustomerBillList();

	}

	@RequestMapping(value = "/useFromRegOpeningStockFun4", method = RequestMethod.GET)
	public @ResponseBody List<CustomerBillItem> useFromRegOpeningStockFun4(
			@RequestParam(value = "index", required = true) int index) {

		System.out.println("IN  /useFromRegOpeningStockFun4");

		CustomerBillItem currentNewItem = currentNewItem2;

		for (int i = 0; i < currentStockDetailList.size(); i++) {

			GetCurrentStockDetails getCurrentStockDetails = currentStockDetailList.get(i);
			System.out.println(
					"currentitem stk:" + currentNewItem.getId() + "liststock" + getCurrentStockDetails.getId());

			if (currentNewItem.getId() == getCurrentStockDetails.getId()) {

				customerBillDataToken2.getCustomerBillList().get(index)
						.setQty(currentStockDetailList.get(i).getCurrentRegStock());// qty changes

				currentStockDetailList.get(i).setCurrentRegStock(currentStockDetailList.get(i).getCurrentRegStock()
						- currentStockDetailList.get(i).getCurrentRegStock());

				customerBillDataToken2.getCustomerBillList().get(index).setBillStockType(1);// setting bill Stock type
				customerBillDataToken2.getCustomerBillList().get(index).setRegOpStockGretor(false);
				customerBillDataToken2.getCustomerBillList().get(index).setRegOpStockLess(false);
				customerBillDataToken2.getCustomerBillList().get(index).setSpStockGretor(false);
				customerBillDataToken2.getCustomerBillList().get(index).setSpStockLessthanQty(false);
				customerBillDataToken2.getCustomerBillList().get(index).setTotalRegStock(currentStockDetailList.get(i).getCurrentRegStock());

				
				System.out.println("currentStockDetailList:" + currentStockDetailList.toString());
				System.out.println("**** CurrentNewItem:  ****:" + currentNewItem2.toString());
				//-------------------------------------Total Calculation--------------------------------------

				float total = 0;
				for (int j = 0; j < customerBillDataToken2.getCustomerBillList().size(); j++) {

					CustomerBillItem billItem =customerBillDataToken2.getCustomerBillList().get(j);

					float itemTotal = (float) (billItem.getQty() * billItem.getMrp());

					total = total + itemTotal;
				}

				System.out.println("**************************CALCULATED TOTAL: **********************" + total);

				customerBillDataToken2.setTotal(total);
				customerBillDataToken2.setGrandTotal(total);
				customerBillDataToken2.setRemainingAmount(total);
				
				//----------------------------------------END-------------------------------------------------
                System.out.println("****Token2.0.1****:" + customerBillDataToken2.toString());

				return customerBillDataToken2.getCustomerBillList();

			}
		}

		return customerBillDataToken2.getCustomerBillList();

	}

	@RequestMapping(value = "/addNewCustBillItemToken3", method = RequestMethod.GET)
	public @ResponseBody List<CustomerBillItem> getAllAddedItem3(HttpServletRequest request,
			HttpServletResponse response) {
		System.out.println("**************GETITEMBYID*******************");
		HttpSession ses = request.getSession();
		Franchisee frDetails = (Franchisee) ses.getAttribute("frDetails");
		
		int prevQty = 0;

		int id = Integer.parseInt(request.getParameter("id"));
		System.out.println("id : " + id);

		int itemQty = Integer.parseInt(request.getParameter("qty"));
		System.out.println("itemQty : " + itemQty);
		try {

			List<CustomerBillItem> prevCustomerBillItemList = customerBillDataToken3.getCustomerBillList();
			//CustomerBillItem currentNewItem = new CustomerBillItem();

			for (int i = 0; i < customerBillItemList.size(); i++) {

				if (customerBillItemList.get(i).getId() == id) {
					System.out.println("Data Matched : " + customerBillItemList.get(i).getId());

					//currentNewItem = customerBillItemList.get(i);
					
                    currentNewItem3=new CustomerBillItem();
					
					currentNewItem3.setBillStockType(customerBillItemList.get(i).getBillStockType());
					currentNewItem3.setCatId(customerBillItemList.get(i).getCatId());
					currentNewItem3.setId(customerBillItemList.get(i).getId());
					currentNewItem3.setItemId(customerBillItemList.get(i).getItemId());
					currentNewItem3.setItemName(customerBillItemList.get(i).getItemName());
					currentNewItem3.setItemTax1(customerBillItemList.get(i).getItemTax1());
					currentNewItem3.setItemTax2(customerBillItemList.get(i).getItemTax2());
					currentNewItem3.setItemTax3(customerBillItemList.get(i).getItemTax3());
					currentNewItem3.setMrp(customerBillItemList.get(i).getMrp());
					currentNewItem3.setQty(customerBillItemList.get(i).getQty());
					currentNewItem3.setRate(customerBillItemList.get(i).getRate());
					currentNewItem3.setRegOpStockGretor(customerBillItemList.get(i).isRegOpStockGretor());
					currentNewItem3.setRegOpStockLess(customerBillItemList.get(i).isRegOpStockLess());
					currentNewItem3.setSpStockGretor(customerBillItemList.get(i).isSpStockGretor());
					currentNewItem3.setSpStockLessthanQty(customerBillItemList.get(i).isSpStockLessthanQty());
					
					currentNewItem3.setCurrentStockOver(customerBillItemList.get(i).isCurrentStockOver());
					currentNewItem3.setTotalRegStock(customerBillItemList.get(i).getTotalRegStock());
					currentNewItem3.setTotalSpStock(customerBillItemList.get(i).getTotalSpStock());

					prevQty = customerBillItemList.get(i).getQty();
					currentNewItem3.setQty(itemQty);

				}

			}
			if (currentStockDetailList.size() == 0) {

				stockCalc(currentNewItem3, frDetails);// stock calculation

				                   System.out.println("****1)currentStockDetailList[token3]****:" + currentStockDetailList.toString());

				for (int i = 0; i <= currentStockDetailList.size(); i++) {
					
					GetCurrentStockDetails getCurrentStockDetails = currentStockDetailList.get(i);
				
					               System.out.println("****2)getCurrentStockDetails[token3]****:" + getCurrentStockDetails.toString());

					if (currentNewItem3.getId() == getCurrentStockDetails.getId()) {
						
						           System.out.println("****3)Id Matched:****" + currentNewItem3.getId());

						if (getCurrentStockDetails.getCurrentSpStock() > 0) {
							
							
							        // prompt1(Are use WANT TO USE SpOpeningStock)if yes,
							        // bill stock type =2
							currentNewItem3.setSpStockGretor(true);//current Sp Stock
							currentNewItem3.setBillStockType(2);
							
							currentNewItem3.setTotalSpStock(getCurrentStockDetails.getCurrentSpStock());//
							currentNewItem3.setTotalRegStock(getCurrentStockDetails.getCurrentRegStock());//

							
						           	System.out.println("**** CurrentNewItem:  ****:" + currentNewItem3.toString());

							prevCustomerBillItemList.add(currentNewItem3);
							customerBillDataToken3.setCustomerBillList(prevCustomerBillItemList);
			                   System.out.println("****Token3.0****:" + customerBillDataToken3.toString());

							return customerBillDataToken3.getCustomerBillList();

						} else if (getCurrentStockDetails.getCurrentRegStock() > 0) {// prompt2 NO & prompt1 NO

							               System.out.println("**------if Stock List is Empty--------[inner for[inner else if]**");

							if (itemQty <= getCurrentStockDetails.getCurrentRegStock()) {

								

								currentStockDetailList.get(i).setCurrentRegStock(currentStockDetailList.get(i).getCurrentRegStock() - itemQty);
								           System.out.println("currentStockDetailList: " + currentStockDetailList.toString());
											
								 currentNewItem3.setBillStockType(1);

								currentNewItem3.setRegOpStockLess(false);
								currentNewItem3.setTotalRegStock(currentStockDetailList.get(i).getCurrentRegStock());
								
								prevCustomerBillItemList.add(currentNewItem3);
				                   
								//-------------------------------------Total Calculation--------------------------------------

								float total = 0;
								for (int j = 0; j < customerBillDataToken3.getCustomerBillList().size(); j++) {

									CustomerBillItem billItem =customerBillDataToken3.getCustomerBillList().get(j);

									float itemTotal = (float) (billItem.getQty() * billItem.getMrp());

									total = total + itemTotal;
								}

								System.out.println("**************************CALCULATED TOTAL: **********************" + total);

								customerBillDataToken3.setTotal(total);
								customerBillDataToken3.setGrandTotal(total);
								customerBillDataToken3.setRemainingAmount(total);
								
								//----------------------------------------END-------------------------------------------------
								System.out.println("****Token3.1****:" + customerBillDataToken3.toString());

								customerBillDataToken3.setCustomerBillList(prevCustomerBillItemList);

								return customerBillDataToken3.getCustomerBillList();
							} else {
								// Prompt3 ,item qty is less than entered qty, still you want to use avail qty"
								// if yes",subtract(avail Reg opening stock-entered qty),& reg op stk=0,"if
								// no",dont add to table and
								// and show alert1 your qty is over
								System.out.println("**if Stock List is Empty[for[else if[if[else]]]**");
								System.out.println("itemQty is gretor than reg stock qty !!");
								System.out.println("currentStockDetailList: " + currentStockDetailList.toString());

								currentNewItem3.setRegOpStockLess(true);
								currentNewItem3.setTotalRegStock(currentStockDetailList.get(i).getCurrentRegStock());
								
								prevCustomerBillItemList.add(currentNewItem3);
								customerBillDataToken3.setCustomerBillList(prevCustomerBillItemList);
				                   System.out.println("****Token3.2****:" + customerBillDataToken3.toString());

								return customerBillDataToken3.getCustomerBillList();

							}

						}
						else
						{
							//Current Regular Stock And Special Stock is over!!
							
							
							
							
							
						}
					}

				}

			} else {// if stock list is not empty.

				boolean isPrevItem = false;

				                      System.out.println("**-----Stock List is not Empty--------[--ELSE Loop]**");

				                      System.out.println("Customertoken3 list  ****:" + customerBillDataToken3.toString());

				for (int i = 0; i < currentStockDetailList.size(); i++) {

					GetCurrentStockDetails getCurrentStockDetails = currentStockDetailList.get(i);
					                  System.out.println("**----Stock List is not Empty---[ELSE Loop[for]]:" + currentNewItem3.getItemId()
							+ "liststock" + getCurrentStockDetails.getItemId());

					if (currentNewItem3.getId() == getCurrentStockDetails.getId()) {
						             // *****************************************************************************//

						if (getCurrentStockDetails.getCurrentSpStock() > 0) {
							        // prompt1(Are use WANT TO USE SpOpeningStock)if yes,
							        // bill stock type =2
							currentNewItem3.setSpStockGretor(true);
							currentNewItem3.setRegOpStockLess(false);
							currentNewItem3.setRegOpStockGretor(false);
							currentNewItem3.setSpStockLessthanQty(false);

							currentNewItem3.setBillStockType(2);
							currentNewItem3.setTotalSpStock(getCurrentStockDetails.getCurrentSpStock());
							          System.out.println("Spstock is greater: CurrentNewItem:  ****:" + currentNewItem3.toString());

							prevCustomerBillItemList.add(currentNewItem3);
							customerBillDataToken3.setCustomerBillList(prevCustomerBillItemList);
			                  
							          System.out.println("****Token3.3****:" + customerBillDataToken3.toString());

							          System.out.println("Return list  ****:" + customerBillDataToken3.toString());

							return customerBillDataToken3.getCustomerBillList();

						} else if (getCurrentStockDetails.getCurrentRegStock() > 0) {// prompt2 NO & prompt1 NO

							          System.out.println("**------if Stock List is Empty--------[inner for[inner else if]**");

							if (itemQty <= getCurrentStockDetails.getCurrentRegStock()) {

								      System.out.println("**------if Stock List is Empty-----[inner for[inner else if[inner if]]**");

								      // Add item to table and substract, (regOpStock-entered qty)
								      System.out.println("itemQty is less than or equal to reg stock qty !!");

								currentStockDetailList.get(i).setCurrentRegStock(currentStockDetailList.get(i).getCurrentRegStock() - itemQty);
								      System.out.println("currentStockDetailList: " + currentStockDetailList.toString());

								currentNewItem3.setBillStockType(1);   
								currentNewItem3.setRegOpStockLess(false);
								currentNewItem3.setTotalRegStock(currentStockDetailList.get(i).getCurrentRegStock() );
								
								prevCustomerBillItemList.add(currentNewItem2);
								//-------------------------------------Total Calculation--------------------------------------

								float total = 0;
								for (int j = 0; j < customerBillDataToken3.getCustomerBillList().size(); j++) {

									CustomerBillItem billItem =customerBillDataToken3.getCustomerBillList().get(j);

									float itemTotal = (float) (billItem.getQty() * billItem.getMrp());

									total = total + itemTotal;
								}

								System.out.println("**************************CALCULATED TOTAL: **********************" + total);

								customerBillDataToken3.setTotal(total);
								customerBillDataToken3.setGrandTotal(total);
								customerBillDataToken3.setRemainingAmount(total);
								
								//----------------------------------------END-------------------------------------------------
								
				                   System.out.println("****Token3.4****:" + customerBillDataToken3.toString());

								customerBillDataToken3.setCustomerBillList(prevCustomerBillItemList);

								return customerBillDataToken3.getCustomerBillList();
							} else {
								        // Prompt3 ,item qty is less than entered qty, still you want to use avail qty"
								        // if yes",substract(avail Reg opening stock-entered qty),& reg op stk=0,"if
								        // no",dont add to table and
								        // and show alert1 your qty is over
								          System.out.println("**if Stock List is Empty[for[else if[if[else]]]**");
								          System.out.println("itemQty is gretor than reg stock qty !!");
								          System.out.println("currentStockDetailList: " + currentStockDetailList.toString());

								currentNewItem3.setRegOpStockLess(true);
								currentNewItem3.setTotalRegStock(currentStockDetailList.get(i).getCurrentRegStock() );
								
								prevCustomerBillItemList.add(currentNewItem3);
								customerBillDataToken3.setCustomerBillList(prevCustomerBillItemList);
				                   System.out.println("****Token3.5****:" + customerBillDataToken3.toString());

								return customerBillDataToken3.getCustomerBillList();

							}

						}
						else
						{
							//Current Regular Stock And Special Stock is over!!
							
							/*currentNewItem2.setCurrentStockOver(true);
							prevCustomerBillItemList.add(currentNewItem2);
							customerBillDataToken2.setCustomerBillList(prevCustomerBillItemList);
*/							isPrevItem=true;
							
							
							
						}
						// *****************************************************************************//
					}

				}

				// ------------------------------------------------------------------------------
				if (!isPrevItem) {

					System.out.println("!isPrevItem"+"currentStockDetailList"+currentStockDetailList.size());
					
					      stockCalc(currentNewItem3, frDetails);
					
					for (int i = 0; i < currentStockDetailList.size(); i++) {

						GetCurrentStockDetails getCurrentStockDetails = currentStockDetailList.get(i);

						if (currentNewItem3.getId() == getCurrentStockDetails.getId()) {
							                System.out.println("**! isPrevItem [if[for[if]]]**");
							                // *****************************************************************************//

							if (getCurrentStockDetails.getCurrentSpStock() > 0) {
								            // prompt1(Are use WANT TO USE SpOpeningStock)if yes,
								            // bill stock type =2
								System.out.println("currentStockDetailList.get(i).getCurrentSpStock()"+currentStockDetailList.get(i).getCurrentSpStock());
								
								currentNewItem3.setSpStockGretor(true);
								currentNewItem3.setBillStockType(2);

								System.out.println("**** CurrentNewItem:  ****:" + currentNewItem3.toString());
								currentNewItem3.setTotalSpStock(currentStockDetailList.get(i).getCurrentSpStock() );

								prevCustomerBillItemList.add(currentNewItem3);
								customerBillDataToken3.setCustomerBillList(prevCustomerBillItemList);
				                   System.out.println("****Token3.6****:" + customerBillDataToken3.toString());

								return customerBillDataToken3.getCustomerBillList();

							} else if (getCurrentStockDetails.getCurrentRegStock() > 0) {// prompt2 NO & prompt1 NO

								System.out.println("**------if Stock List is Empty--------[inner for[inner else if]**");

								if (itemQty <= getCurrentStockDetails.getCurrentRegStock()) {

								      	      System.out.println(
											        "**------if Stock List is Empty-----[inner for[inner else if[inner if]]**");

									            // Add item to table and substract, (regOpStock-entered qty)
									            System.out.println("itemQty is less than or equal to reg stock qty !!");

									currentStockDetailList.get(i).setCurrentRegStock(
											currentStockDetailList.get(i).getCurrentRegStock() - itemQty);
									                 
									            System.out.println("currentStockDetailList: " + currentStockDetailList.toString());
												
									currentNewItem3.setBillStockType(1);

									currentNewItem3.setRegOpStockLess(false);
									currentNewItem3.setTotalRegStock(currentStockDetailList.get(i).getCurrentRegStock());
									
									prevCustomerBillItemList.add(currentNewItem2);

									customerBillDataToken3.setCustomerBillList(prevCustomerBillItemList);
									//-------------------------------------Total Calculation--------------------------------------

									float total = 0;
									for (int j = 0; j < customerBillDataToken3.getCustomerBillList().size(); j++) {

										CustomerBillItem billItem =customerBillDataToken3.getCustomerBillList().get(j);

										float itemTotal = (float) (billItem.getQty() * billItem.getMrp());

										total = total + itemTotal;
									}

									System.out.println("**************************CALCULATED TOTAL: **********************" + total);

									customerBillDataToken3.setTotal(total);
									customerBillDataToken3.setGrandTotal(total);
									customerBillDataToken3.setRemainingAmount(total);
									
									//----------------------------------------END-------------------------------------------------
					                   System.out.println("****Token3.6****:" + customerBillDataToken3.toString());

									return customerBillDataToken3.getCustomerBillList();
								} else {
									// Prompt3 ,item qty is less than entered qty, still you want to use avail qty"
									// if yes",substract(avail Reg opening stock-entered qty),& reg op stk=0,"if
									// no",dont add to table and
									// and show alert1 your qty is over
									System.out.println("**if Stock List is Empty[for[else if[if[else]]]**");
									System.out.println("itemQty is gretor than reg stock qty !!");
									System.out.println("currentStockDetailList: " + currentStockDetailList.toString());

									currentNewItem3.setRegOpStockLess(true);
									currentNewItem3.setTotalRegStock(currentStockDetailList.get(i).getCurrentRegStock());
									prevCustomerBillItemList.add(currentNewItem3);
									customerBillDataToken3.setCustomerBillList(prevCustomerBillItemList);
					                   System.out.println("****Token3.7****:" + customerBillDataToken3.toString());

									return customerBillDataToken3.getCustomerBillList();

								}

							}
							else
							{
								//Current Regular Stock And Special Stock is over!!
								
								
								
								
								
								
							}
							// *****************************************************************************//

						}

					}
				} else {
					// stock is over
					System.out.println("Else  ...........");

				}
			}

			

			float total = 0;
			for (int i = 0; i < prevCustomerBillItemList.size(); i++) {

				CustomerBillItem billItem = prevCustomerBillItemList.get(i);

				float itemTotal = (float) (billItem.getQty() * billItem.getMrp());

				total = total + itemTotal;
			}

			System.out.println("**************************CALCULATED TOTAL: **********************" + total);

			customerBillDataToken3.setCustomerBillList(prevCustomerBillItemList);
			customerBillDataToken3.setTotal(total);
			customerBillDataToken3.setGrandTotal(total);
			customerBillDataToken3.setRemainingAmount(total);

			System.out.println("Customer Bill Data Token3: " + customerBillDataToken3.toString());

		} catch (Exception e) {
			System.out.println("Exception adding item: " + e.getMessage());
			e.printStackTrace();

		}

		System.out.println("Customer Bill Data 3" + customerBillDataToken3.getCustomerBillList().toString());

		return customerBillDataToken3.getCustomerBillList();
	}
	@RequestMapping(value = "/useFromCStockFun11", method = RequestMethod.GET)
	public @ResponseBody List<CustomerBillItem> useFromCurrentSpStockFun11(
			@RequestParam(value = "index", required = true) int index) {

		CustomerBillItem currentNewItem = currentNewItem3;

		for (int i = 0; i < currentStockDetailList.size(); i++) {

			GetCurrentStockDetails getCurrentStockDetails = currentStockDetailList.get(i);
			                              System.out.println("**StockListIsNotEmpty[token3]*for*:" + currentNewItem.getItemId() + "liststock"
					                      + getCurrentStockDetails.getItemId());

			if (currentNewItem.getId() == getCurrentStockDetails.getId()) {

				if (currentNewItem.getQty() <= getCurrentStockDetails.getCurrentSpStock()) {
					// SUBSTRACT SP STOCK QTY(STOCK 2)
					currentStockDetailList.get(i).setCurrentSpStock(
							currentStockDetailList.get(i).getCurrentSpStock() - currentNewItem.getQty());

					customerBillDataToken3.getCustomerBillList().get(index).setBillStockType(2);// setting bill Stock
					customerBillDataToken3.getCustomerBillList().get(index).setTotalSpStock(currentStockDetailList.get(i).getCurrentSpStock());													// type

					customerBillDataToken3.getCustomerBillList().get(index).setRegOpStockGretor(false);
					customerBillDataToken3.getCustomerBillList().get(index).setRegOpStockLess(false);
					customerBillDataToken3.getCustomerBillList().get(index).setSpStockGretor(false);
					customerBillDataToken3.getCustomerBillList().get(index).setSpStockLessthanQty(false);
					System.out.println("currentStockDetailList: " + currentStockDetailList.toString());

					System.out.println("**** CurrentNewItem:  ****:" + currentNewItem3.toString());
					
					//-------------------------------------Total Calculation--------------------------------------

					float total = 0;
					for (int j = 0; j < customerBillDataToken3.getCustomerBillList().size(); j++) {

						CustomerBillItem billItem =customerBillDataToken3.getCustomerBillList().get(j);

						float itemTotal = (float) (billItem.getQty() * billItem.getMrp());

						total = total + itemTotal;
					}

					System.out.println("**************************CALCULATED TOTAL: **********************" + total);

					customerBillDataToken3.setTotal(total);
					customerBillDataToken3.setGrandTotal(total);
					customerBillDataToken3.setRemainingAmount(total);
					
					//----------------------------------------END-------------------------------------------------
	                   System.out.println("****Token3.7****:" + customerBillDataToken3.toString());

					return customerBillDataToken3.getCustomerBillList();

				} else {
					System.out.println("**** CurrentNewItem:  ****:" + currentNewItem3.toString());

					customerBillDataToken3.getCustomerBillList().get(index).setSpStockLessthanQty(true);
					customerBillDataToken3.getCustomerBillList().get(index).setTotalSpStock(currentStockDetailList.get(i).getCurrentSpStock());
					return customerBillDataToken3.getCustomerBillList();

				}
			}
		}

		return customerBillDataToken3.getCustomerBillList();

	}

	@RequestMapping(value = "/useFromCStockFun21", method = RequestMethod.GET)
	public @ResponseBody List<CustomerBillItem> useFromCurrentSpStockFun21(
			@RequestParam(value = "index", required = true) int index) {

		CustomerBillItem currentNewItem = currentNewItem3;

		for (int i = 0; i < currentStockDetailList.size(); i++) {

			GetCurrentStockDetails getCurrentStockDetails = currentStockDetailList.get(i);
			System.out.println("***currentitem stk:[token3]" + currentNewItem.getItemId() + "liststock2"
					+ getCurrentStockDetails.getItemId());

			if (currentNewItem.getId() == getCurrentStockDetails.getId()) {
				System.out.println("currentStockDetailList.get(i).getCurrentSpStock()"
						+ currentStockDetailList.get(i).getCurrentSpStock());

				customerBillDataToken3.getCustomerBillList().get(index)
						.setQty(currentStockDetailList.get(i).getCurrentSpStock());// qty changes to show on jsp

				// SUBSTRACT SP STOCK QTY(STOCK 2)
				currentStockDetailList.get(i).setCurrentSpStock(currentStockDetailList.get(i).getCurrentSpStock()
						- currentStockDetailList.get(i).getCurrentSpStock());// 0 qty

				customerBillDataToken3.getCustomerBillList().get(index).setBillStockType(2);// setting bill Stock type
				customerBillDataToken3.getCustomerBillList().get(index).setRegOpStockGretor(false);
				customerBillDataToken3.getCustomerBillList().get(index).setRegOpStockLess(false);
				customerBillDataToken3.getCustomerBillList().get(index).setSpStockGretor(false);
				customerBillDataToken3.getCustomerBillList().get(index).setSpStockLessthanQty(false);
				customerBillDataToken3.getCustomerBillList().get(index).setTotalSpStock(currentStockDetailList.get(i).getCurrentSpStock());
				
				System.out.println("currentStockDetailList: " + currentStockDetailList.toString());
				System.out.println("**** CurrentNewItem:  ****:" + currentNewItem3.toString());
				//-------------------------------------Total Calculation--------------------------------------

				float total = 0;
				for (int j = 0; j < customerBillDataToken3.getCustomerBillList().size(); j++) {

					CustomerBillItem billItem =customerBillDataToken3.getCustomerBillList().get(j);

					float itemTotal = (float) (billItem.getQty() * billItem.getMrp());

					total = total + itemTotal;
				}

				System.out.println("**************************CALCULATED TOTAL: **********************" + total);

				customerBillDataToken3.setTotal(total);
				customerBillDataToken3.setGrandTotal(total);
				customerBillDataToken3.setRemainingAmount(total);
				
				//----------------------------------------END-------------------------------------------------
				
                System.out.println("****Token3.8****:" + customerBillDataToken3.toString());

				return customerBillDataToken3.getCustomerBillList();

			}
		}

		return customerBillDataToken2.getCustomerBillList();

	}

	@RequestMapping(value = "/useFromCStockFun31", method = RequestMethod.GET)
	public @ResponseBody List<CustomerBillItem> useFromCurrentSpStockFun31(
			@RequestParam(value = "index", required = true) int index) {
		
		
		
		System.out.println("IN  /useFromRegOpeningStockFun3");

		CustomerBillItem currentNewItem = currentNewItem2;

		for (int i = 0; i < currentStockDetailList.size(); i++) {

			GetCurrentStockDetails getCurrentStockDetails = currentStockDetailList.get(i);
			System.out.println(
					"currentitem stk:" + currentNewItem.getId() + "liststock" + getCurrentStockDetails.getId());

			if (currentNewItem.getId() == getCurrentStockDetails.getId()) {

				if (currentNewItem.getQty() <= getCurrentStockDetails.getCurrentRegStock()) {
					// SUBSTRACT SP STOCK QTY(STOCK 2)
					currentStockDetailList.get(i).setCurrentRegStock(
							currentStockDetailList.get(i).getCurrentRegStock() - currentNewItem.getQty());

					customerBillDataToken3.getCustomerBillList().get(index).setBillStockType(1);// setting bill Stock
																								// type
					customerBillDataToken3.getCustomerBillList().get(index).setRegOpStockGretor(false);
					customerBillDataToken3.getCustomerBillList().get(index).setRegOpStockLess(false);
					customerBillDataToken3.getCustomerBillList().get(index).setSpStockGretor(false);
					customerBillDataToken3.getCustomerBillList().get(index).setSpStockLessthanQty(false);
					customerBillDataToken3.getCustomerBillList().get(index).setTotalRegStock(currentStockDetailList.get(i).getCurrentRegStock());
					
					System.out.println("currentStockDetailList:" + currentStockDetailList.toString());
					System.out.println("**** CurrentNewItem:  ****:" + currentNewItem3.toString());
					
					//-------------------------------------Total Calculation--------------------------------------

					float total = 0;
					for (int j = 0; j < customerBillDataToken3.getCustomerBillList().size(); j++) {

						CustomerBillItem billItem =customerBillDataToken3.getCustomerBillList().get(j);

						float itemTotal = (float) (billItem.getQty() * billItem.getMrp());

						total = total + itemTotal;
					}

					System.out.println("**************************CALCULATED TOTAL: **********************" + total);

					customerBillDataToken3.setTotal(total);
					customerBillDataToken3.setGrandTotal(total);
					customerBillDataToken3.setRemainingAmount(total);
					
					//----------------------------------------END-------------------------------------------------
	                   System.out.println("****Token3.9****:" + customerBillDataToken3.toString());

					return customerBillDataToken3.getCustomerBillList();

				} else {
					System.out.println("currentStockDetailList: " + currentStockDetailList.toString());

					System.out.println("**** CurrentNewItem:  ****:" + currentNewItem3.toString());

					customerBillDataToken3.getCustomerBillList().get(index).setRegOpStockLess(true);
					customerBillDataToken3.getCustomerBillList().get(index).setTotalRegStock(currentStockDetailList.get(i).getCurrentRegStock());
					return customerBillDataToken3.getCustomerBillList();

				}
			}
		}

		return customerBillDataToken3.getCustomerBillList();

	}

	@RequestMapping(value = "/useFromCStockFun41", method = RequestMethod.GET)
	public @ResponseBody List<CustomerBillItem> useFromCurrentSpStockFun41(
			@RequestParam(value = "index", required = true) int index) {

		System.out.println("IN  /useFromCurrentSpStockFun4");

		CustomerBillItem currentNewItem = currentNewItem3;

		for (int i = 0; i < currentStockDetailList.size(); i++) {

			GetCurrentStockDetails getCurrentStockDetails = currentStockDetailList.get(i);
			System.out.println(
					"currentitem stk:" + currentNewItem.getId() + "liststock" + getCurrentStockDetails.getId());

			if (currentNewItem.getId() == getCurrentStockDetails.getId()) {

				customerBillDataToken3.getCustomerBillList().get(index)
						.setQty(currentStockDetailList.get(i).getCurrentRegStock());// qty changes

				currentStockDetailList.get(i).setCurrentRegStock(currentStockDetailList.get(i).getCurrentRegStock()
						- currentStockDetailList.get(i).getCurrentRegStock());

				customerBillDataToken3.getCustomerBillList().get(index).setBillStockType(1);// setting bill Stock type
				customerBillDataToken3.getCustomerBillList().get(index).setRegOpStockGretor(false);
				customerBillDataToken3.getCustomerBillList().get(index).setRegOpStockLess(false);
				customerBillDataToken3.getCustomerBillList().get(index).setSpStockGretor(false);
				customerBillDataToken3.getCustomerBillList().get(index).setSpStockLessthanQty(false);
				customerBillDataToken3.getCustomerBillList().get(index).setTotalRegStock(currentStockDetailList.get(i).getCurrentRegStock());

				
				System.out.println("currentStockDetailList:" + currentStockDetailList.toString());
				System.out.println("**** CurrentNewItem:  ****:" + currentNewItem3.toString());
				//-------------------------------------Total Calculation--------------------------------------

				float total = 0;
				for (int j = 0; j < customerBillDataToken3.getCustomerBillList().size(); j++) {

					CustomerBillItem billItem =customerBillDataToken3.getCustomerBillList().get(j);

					float itemTotal = (float) (billItem.getQty() * billItem.getMrp());

					total = total + itemTotal;
				}

				System.out.println("**************************CALCULATED TOTAL: **********************" + total);

				customerBillDataToken3.setTotal(total);
				customerBillDataToken3.setGrandTotal(total);
				customerBillDataToken3.setRemainingAmount(total);
				
				//----------------------------------------END-------------------------------------------------
                System.out.println("****Token3.0.1****:" + customerBillDataToken3.toString());

				return customerBillDataToken3.getCustomerBillList();

			}
		}

		return customerBillDataToken3.getCustomerBillList();

	}
	@RequestMapping(value = "/addNewCustBillItemToken4", method = RequestMethod.GET)
	public @ResponseBody List<CustomerBillItem> getAllAddedItem4(HttpServletRequest request,
			HttpServletResponse response) {
		System.out.println("**************GETITEMBYID*******************");

		int prevQty = 0;

		int id = Integer.parseInt(request.getParameter("id"));
		System.out.println("id : " + id);

		int itemQty = Integer.parseInt(request.getParameter("qty"));
		System.out.println("itemQty : " + itemQty);
		try {

			List<CustomerBillItem> prevCustomerBillItemList = customerBillDataToken4.getCustomerBillList();
			CustomerBillItem currentNewItem = new CustomerBillItem();

			for (int i = 0; i < customerBillItemList.size(); i++) {

				if (customerBillItemList.get(i).getId() == id) {
					System.out.println("Data Matched : " + customerBillItemList.get(i).getId());

					currentNewItem = customerBillItemList.get(i);

					prevQty = customerBillItemList.get(i).getQty();
					currentNewItem.setQty(itemQty);

				}

			}

			boolean isOldItem = false;

			for (int j = 0; j < prevCustomerBillItemList.size(); j++) {

				if (prevCustomerBillItemList.get(j).getId() == currentNewItem.getId()) {
					prevCustomerBillItemList.get(j).setQty(prevQty);

					isOldItem = true;
					System.out.println("old" + isOldItem);
				}

			}

			if (!isOldItem) {
				System.out.println("not old" + isOldItem);
				prevCustomerBillItemList.add(currentNewItem);

			}

			float total = 0;
			for (int i = 0; i < prevCustomerBillItemList.size(); i++) {

				CustomerBillItem billItem = prevCustomerBillItemList.get(i);

				float itemTotal = (float) (billItem.getQty() * billItem.getMrp());

				total = total + itemTotal;
			}

			System.out.println("**************************CALCULATED TOTAL: **********************" + total);

			customerBillDataToken4.setCustomerBillList(prevCustomerBillItemList);
			customerBillDataToken4.setTotal(total);
			customerBillDataToken4.setGrandTotal(total);
			customerBillDataToken4.setRemainingAmount(total);

			System.out.println("Customer Bill Data Token4: " + customerBillDataToken4.toString());

		} catch (Exception e) {
			System.out.println("Exception adding item: " + e.getMessage());
			e.printStackTrace();

		}

		System.out.println("Customer Bill Data4 " + customerBillDataToken4.getCustomerBillList().toString());

		return customerBillDataToken4.getCustomerBillList();
	}

	@RequestMapping(value = "/addNewCustBillItemToken5", method = RequestMethod.GET)
	public @ResponseBody List<CustomerBillItem> getAllAddedItem5(HttpServletRequest request,
			HttpServletResponse response) {
		System.out.println("**************GETITEMBYID*******************");

		int prevQty = 0;

		int id = Integer.parseInt(request.getParameter("id"));
		System.out.println("id : " + id);

		int itemQty = Integer.parseInt(request.getParameter("qty"));
		System.out.println("itemQty : " + itemQty);
		try {

			List<CustomerBillItem> prevCustomerBillItemList = customerBillDataToken5.getCustomerBillList();
			CustomerBillItem currentNewItem = new CustomerBillItem();

			for (int i = 0; i < customerBillItemList.size(); i++) {

				if (customerBillItemList.get(i).getId() == id) {
					System.out.println("Data Matched : " + customerBillItemList.get(i).getId());

					currentNewItem = customerBillItemList.get(i);

					prevQty = customerBillItemList.get(i).getQty();
					currentNewItem.setQty(itemQty);

				}

			}

			boolean isOldItem = false;

			for (int j = 0; j < prevCustomerBillItemList.size(); j++) {

				if (prevCustomerBillItemList.get(j).getId() == currentNewItem.getId()) {
					prevCustomerBillItemList.get(j).setQty(prevQty);

					isOldItem = true;
					System.out.println("old" + isOldItem);
				}

			}

			if (!isOldItem) {
				System.out.println("not old" + isOldItem);
				prevCustomerBillItemList.add(currentNewItem);

			}

			float total = 0;
			for (int i = 0; i < prevCustomerBillItemList.size(); i++) {

				CustomerBillItem billItem = prevCustomerBillItemList.get(i);

				float itemTotal = (float) (billItem.getQty() * billItem.getMrp());

				total = total + itemTotal;
			}

			System.out.println("**************************CALCULATED TOTAL: **********************" + total);

			customerBillDataToken5.setCustomerBillList(prevCustomerBillItemList);
			customerBillDataToken5.setTotal(total);
			customerBillDataToken5.setGrandTotal(total);
			customerBillDataToken5.setRemainingAmount(total);

			System.out.println("Customer Bill Data Token5: " + customerBillDataToken5.toString());

		} catch (Exception e) {
			System.out.println("Exception adding item: " + e.getMessage());
			e.printStackTrace();

		}

		System.out.println("Customer Bill Data5 " + customerBillDataToken5.getCustomerBillList().toString());

		return customerBillDataToken5.getCustomerBillList();
	}

	@RequestMapping(value = "/addNewCustBillItemToken6", method = RequestMethod.GET)
	public @ResponseBody List<CustomerBillItem> getAllAddedItem6(HttpServletRequest request,
			HttpServletResponse response) {
		System.out.println("**************GETITEMBYID*******************");

		int prevQty = 0;

		int id = Integer.parseInt(request.getParameter("id"));
		System.out.println("id : " + id);

		int itemQty = Integer.parseInt(request.getParameter("qty"));
		System.out.println("itemQty : " + itemQty);
		try {

			List<CustomerBillItem> prevCustomerBillItemList = customerBillDataToken6.getCustomerBillList();
			CustomerBillItem currentNewItem = new CustomerBillItem();

			for (int i = 0; i < customerBillItemList.size(); i++) {

				if (customerBillItemList.get(i).getId() == id) {
					System.out.println("Data Matched : " + customerBillItemList.get(i).getId());

					currentNewItem = customerBillItemList.get(i);

					prevQty = customerBillItemList.get(i).getQty();
					currentNewItem.setQty(itemQty);

				}

			}

			boolean isOldItem = false;

			for (int j = 0; j < prevCustomerBillItemList.size(); j++) {

				if (prevCustomerBillItemList.get(j).getId() == currentNewItem.getId()) {
					prevCustomerBillItemList.get(j).setQty(prevQty);

					isOldItem = true;
					System.out.println("old" + isOldItem);
				}

			}

			if (!isOldItem) {
				System.out.println("not old" + isOldItem);
				prevCustomerBillItemList.add(currentNewItem);

			}

			float total = 0;
			for (int i = 0; i < prevCustomerBillItemList.size(); i++) {

				CustomerBillItem billItem = prevCustomerBillItemList.get(i);

				float itemTotal = (float) (billItem.getQty() * billItem.getMrp());

				total = total + itemTotal;
			}

			System.out.println("**************************CALCULATED TOTAL: **********************" + total);

			customerBillDataToken6.setCustomerBillList(prevCustomerBillItemList);
			customerBillDataToken6.setTotal(total);
			customerBillDataToken6.setGrandTotal(total);
			customerBillDataToken6.setRemainingAmount(total);

			System.out.println("Customer Bill Data Token6: " + customerBillDataToken6.toString());

		} catch (Exception e) {
			System.out.println("Exception adding item: " + e.getMessage());
			e.printStackTrace();

		}

		System.out.println("Customer Bill Data6 " + customerBillDataToken6.getCustomerBillList().toString());

		return customerBillDataToken6.getCustomerBillList();
	}

	@RequestMapping(value = "/addNewCustBillItemToken7", method = RequestMethod.GET)
	public @ResponseBody List<CustomerBillItem> getAllAddedItem7(HttpServletRequest request,
			HttpServletResponse response) {
		System.out.println("**************GETITEMBYID*******************");

		int prevQty = 0;

		int id = Integer.parseInt(request.getParameter("id"));
		System.out.println("id : " + id);

		int itemQty = Integer.parseInt(request.getParameter("qty"));
		System.out.println("itemQty : " + itemQty);
		try {

			List<CustomerBillItem> prevCustomerBillItemList = customerBillDataToken7.getCustomerBillList();
			CustomerBillItem currentNewItem = new CustomerBillItem();

			for (int i = 0; i < customerBillItemList.size(); i++) {

				if (customerBillItemList.get(i).getId() == id) {
					System.out.println("Data Matched : " + customerBillItemList.get(i).getId());

					currentNewItem = customerBillItemList.get(i);

					prevQty = customerBillItemList.get(i).getQty();
					currentNewItem.setQty(itemQty);

				}

			}

			boolean isOldItem = false;

			for (int j = 0; j < prevCustomerBillItemList.size(); j++) {

				if (prevCustomerBillItemList.get(j).getId() == currentNewItem.getId()) {
					prevCustomerBillItemList.get(j).setQty(prevQty);

					isOldItem = true;
					System.out.println("old" + isOldItem);
				}

			}

			if (!isOldItem) {
				System.out.println("not old" + isOldItem);
				prevCustomerBillItemList.add(currentNewItem);

			}

			float total = 0;
			for (int i = 0; i < prevCustomerBillItemList.size(); i++) {

				CustomerBillItem billItem = prevCustomerBillItemList.get(i);

				float itemTotal = (float) (billItem.getQty() * billItem.getMrp());

				total = total + itemTotal;
			}

			System.out.println("**************************CALCULATED TOTAL: **********************" + total);

			customerBillDataToken7.setCustomerBillList(prevCustomerBillItemList);
			customerBillDataToken7.setTotal(total);
			customerBillDataToken7.setGrandTotal(total);
			customerBillDataToken7.setRemainingAmount(total);

			System.out.println("Customer Bill Data Token7: " + customerBillDataToken7.toString());

		} catch (Exception e) {
			System.out.println("Exception adding item7: " + e.getMessage());
			e.printStackTrace();

		}

		System.out.println("Customer Bill Data7 " + customerBillDataToken7.getCustomerBillList().toString());

		return customerBillDataToken7.getCustomerBillList();
	}
}