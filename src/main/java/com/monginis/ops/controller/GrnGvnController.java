package com.monginis.ops.controller;

import static org.hamcrest.CoreMatchers.is;

import java.math.BigDecimal;
import java.sql.Date;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.GregorianCalendar;
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
import com.monginis.ops.model.GetCurrentStockDetails;
import com.monginis.ops.model.PostFrItemStockHeader;
import com.monginis.ops.model.grngvn.GetBillsForFr;
import com.monginis.ops.model.grngvn.GetBillsForFrList;
import com.monginis.ops.model.grngvn.GetGrnConfResponse;
import com.monginis.ops.model.grngvn.GetGrnGvnConfResponse;
import com.monginis.ops.model.grngvn.GetGrnGvnDetails;
import com.monginis.ops.model.grngvn.GetGrnGvnDetailsList;
import com.monginis.ops.model.grngvn.GetGrnItemConfig;
import com.monginis.ops.model.grngvn.GrnGvn;
import com.monginis.ops.model.grngvn.PostGrnGvnList;
import com.monginis.ops.model.grngvn.ShowGrnBean;
import com.monginis.ops.model.grngvn.StockForAutoGrnGvn;
import com.monginis.ops.model.remarks.GetAllRemarks;
import com.monginis.ops.model.remarks.GetAllRemarksList;
import com.monginis.ops.util.ImageS3Util;

@Controller
public class GrnGvnController {

	public String incrementDate(String date, int day) {

		SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
		
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
	
	
	GetAllRemarksList allRemarksList;
	List<GetAllRemarks> getAllRemarks;
	

	public GetGrnGvnConfResponse grnGvnConfResponse;
	public List<GetGrnItemConfig> grnConfList;
	public List<GetGrnGvnDetails> grnGvnDetailsList;
	GetGrnGvnDetailsList getGrnGvnDetailsList;
	PostFrItemStockHeader frItemStockHeader;
	Integer runningMonth = 0;

	List<GetBillsForFr> frBillList;
	
	List<ShowGrnBean> objShowGrnList;
	
	List<ShowGrnBean> objShowGvnList;

	List<StockForAutoGrnGvn> stockForAutoGrn = new ArrayList<StockForAutoGrnGvn>();

	List<GetCurrentStockDetails> currentStockDetailList = new ArrayList<GetCurrentStockDetails>();

	public static float roundUp(float d) {
		return BigDecimal.valueOf(d).setScale(2, BigDecimal.ROUND_HALF_UP).floatValue();
	}

	@RequestMapping(value = "/showGrn", method = RequestMethod.GET)
	public ModelAndView showBill(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("show Grn displayed");
		ModelAndView modelAndView = new ModelAndView("grngvn/showgrn");
		
		int month=0;
		try {

			HttpSession session = request.getSession();
			Franchisee frDetails = (Franchisee) session.getAttribute("frDetails");
			RestTemplate restTemplate = new RestTemplate();

			// getRunniugMonth
			try {
				MultiValueMap<String, Object> mapForRunningMonth = new LinkedMultiValueMap<String, Object>();
				mapForRunningMonth.add("frId", frDetails.getFrId());

				frItemStockHeader = restTemplate.postForObject(Constant.URL + "getRunningMonth", mapForRunningMonth,
						PostFrItemStockHeader.class);
				runningMonth = frItemStockHeader.getMonth();
				System.out.println("Runnign Month= " + runningMonth);

				java.sql.Date currentDate = new java.sql.Date(Calendar.getInstance().getTime().getTime());
				
				month = currentDate.getMonth() + 1;

				System.out.println(" Month= " + month);

			} catch (Exception e) {

				System.out.println("Exception in runningMonth" + e.getMessage());
				e.printStackTrace();

			}
			// end of get Running month

			/*
			 * ZoneId zoneId = ZoneId.of( "Asia/Calcutta" ); ZonedDateTime zdt =
			 * ZonedDateTime.now( zoneId ); System.out.println("time =="+zdt.format(null));
			 * 
			 */

			
			allRemarksList = restTemplate.getForObject(Constant.URL + "getAllRemarks", GetAllRemarksList.class);

			getAllRemarks = allRemarksList.getGetAllRemarks();

			System.out.println("remark list " + getAllRemarks.toString());

			modelAndView.addObject("remarkList", getAllRemarks);

			
			if(runningMonth!=month) {
				
				String msg="Please Close Your Month First";
				modelAndView.addObject("alert",msg);
				
			}
			
			
			//RestTemplate restTemplate = new RestTemplate();

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

				int frId = frDetails.getFrId();

				map.add("frId", frId);

				System.out.println("fr Id = " + frDetails.getFrId());
				grnGvnConfResponse = restTemplate.postForObject(Constant.URL + "getGrnItemConfig", map,
						GetGrnGvnConfResponse.class);

				grnConfList = grnGvnConfResponse.getGetGrnItemConfigs();

				System.out.println("bill table data " + grnConfList.toString());


			//new web service autogrnQty atul Sir
			
			java.sql.Date currentDate = new java.sql.Date(Calendar.getInstance().getTime().getTime());

			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			DateFormat yearFormat = new SimpleDateFormat("yyyy");

			java.util.Date todaysDate = new java.util.Date();

			Calendar cal = Calendar.getInstance();
			cal.set(Calendar.DAY_OF_MONTH, 1);
			java.util.Date firstDay = cal.getTime();

			System.out.println("First Day of month " + firstDay);

			System.out.println("Year " + yearFormat.format(todaysDate));

			Calendar calendar = Calendar.getInstance();
			// subtracting a day
			calendar.add(Calendar.DATE, -1);
			todaysDate = calendar.getTime();

			MultiValueMap<String, Object> stockMap = new LinkedMultiValueMap<String, Object>();

			List<StockForAutoGrnGvn> templList = new ArrayList<>();
			
			DateFormat dateFmt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Calendar cale = Calendar.getInstance();
			System.out.println("************* Date Time " + dateFmt.format(cale.getTime()));
			

			for (int i = 0; i < grnConfList.size(); i++) {

				stockMap = new LinkedMultiValueMap<String, Object>();
/*
				java.util.Date billDate = grnConfList.get(i).getBillDate();
				Calendar cal3 = Calendar.getInstance();
				cal3.setTime(billDate);
				cal3.add(Calendar.DATE, -1);*/

				stockMap.add("frId", frDetails.getFrId());
				stockMap.add("fromDate", dateFormat.format(grnConfList.get(i).getBillDate()));
				stockMap.add("fromDateTime", grnConfList.get(i).getBillDateTime());
				stockMap.add("toDateTime",dateFmt.format(cale.getTime()));

				stockMap.add("currentMonth", currentDate.getMonth() + 1);
				stockMap.add("year", yearFormat.format(todaysDate));
				stockMap.add("catId", grnConfList.get(i).getCatId());
				stockMap.add("itemIdList", grnConfList.get(i).getItemId());

				ParameterizedTypeReference<List<StockForAutoGrnGvn>> typeRef = new ParameterizedTypeReference<List<StockForAutoGrnGvn>>() {
				};
				ResponseEntity<List<StockForAutoGrnGvn>> responseEntity = restTemplate.exchange(
						Constant.URL + "getStockForAutoGrnGvn", HttpMethod.POST, new HttpEntity<>(stockMap), typeRef);

				
				templList = responseEntity.getBody();
				stockForAutoGrn.add(templList.get(0));

			}

			
			System.out.println(" stockForAutoGrn Details : " + stockForAutoGrn.toString());

			
			//end new web service
			
			// calculate autogrnQty
			for (int i = 0; i < grnConfList.size(); i++) {

				for (int j = 0; j < stockForAutoGrn.size(); j++) {

					

						if (grnConfList.get(i).getItemId() == stockForAutoGrn.get(j).getId()) {

							if (grnConfList.get(i).getGrnType() != 4) {

								int autoGrnQty = (stockForAutoGrn.get(j).getRegCurrentStock()
										+ grnConfList.get(i).getBillQty())
										- (stockForAutoGrn.get(j).getRegSellQty()
												+ stockForAutoGrn.get(j).getGrnGvnQty());

								
									System.out.println("item Id= "+grnConfList.get(i).getItemId());
									System.out.println("bill date ="+grnConfList.get(i).getBillDate());
									System.out.println("cur reg stock =  "+stockForAutoGrn.get(j).getRegCurrentStock());
								
									System.out.println( " bill qty = "+ grnConfList.get(i).getBillQty() );
									System.out.println("tot sell = "+stockForAutoGrn.get(j).getRegSellQty());
									System.out.println("grn = "+stockForAutoGrn.get(j).getGrnGvnQty());
								
									System.out.println(
										"auto Grn Qty " + autoGrnQty + "for item id " + grnConfList.get(i).getItemId());
									
						grnConfList.get(i).setAutoGrnQty(autoGrnQty);

							}//end of inner if
							else {
								System.out.println("");
								//calculate autoGrnQty for pushed item 
								boolean isSameItem=false;
								for(int a=1;a<grnConfList.size();a++) {
									
									if((grnConfList.get(i).getItemId()==grnConfList.get(a).getItemId())&& (grnConfList.get(a).getGrnType()!=4)) {
										
										isSameItem=true;
										System.out.println("inside a for loop "+grnConfList.get(a).getItemId());
										int tempGrnQty = (stockForAutoGrn.get(j).getRegCurrentStock()
												+ grnConfList.get(a).getBillQty())
												- (stockForAutoGrn.get(j).getRegSellQty()
														+ stockForAutoGrn.get(j).getGrnGvnQty());
										int autoGrnQty=0;
										if(tempGrnQty>0)
										{
											System.out.println("inside tempGrnQty >0 "+grnConfList.get(a).getItemId());
											autoGrnQty = ((stockForAutoGrn.get(j).getRegCurrentStock()
													+ grnConfList.get(i).getBillQty()+grnConfList.get(a).getBillQty())
													- (stockForAutoGrn.get(j).getRegSellQty()
															+ stockForAutoGrn.get(j).getGrnGvnQty()))-tempGrnQty;
											
										}else {
											
											autoGrnQty = (stockForAutoGrn.get(j).getRegCurrentStock()
													+ grnConfList.get(i).getBillQty()+grnConfList.get(a).getBillQty())
													- (stockForAutoGrn.get(j).getRegSellQty()
															+ stockForAutoGrn.get(j).getGrnGvnQty());
											
										}
										

										grnConfList.get(i).setAutoGrnQty(autoGrnQty);
										
										System.out.println("item Id "+grnConfList.get(a).getItemId());
										System.out.println("auto grn for pushed Item " +grnConfList.get(a).getAutoGrnQty());
										
									}
								}
								
								if(!isSameItem) {
									System.out.println("inside isSameItem = false "+grnConfList.get(i).getItemId());
									
									int autoGrnQty = (stockForAutoGrn.get(j).getRegCurrentStock()
											+ grnConfList.get(i).getBillQty())
											- (stockForAutoGrn.get(j).getRegSellQty()
													+ stockForAutoGrn.get(j).getGrnGvnQty());
									grnConfList.get(i).setAutoGrnQty(autoGrnQty);
								}

							}//end of else
						}//end of outer if
					
				}
			} // end of calc autogrnQty

			
			objShowGrnList = new ArrayList<>();

			ShowGrnBean objShowGrn = null;

			for (int i = 0; i < grnConfList.size(); i++) {
				
				if(!(grnConfList.get(i).getAutoGrnQty()<=0)) {

				objShowGrn = new ShowGrnBean();

				objShowGrn.setBillDate(grnConfList.get(i).getBillDate());
				objShowGrn.setBillDetailNo(grnConfList.get(i).getBillDetailNo());
				objShowGrn.setBillNo(grnConfList.get(i).getBillNo());
				objShowGrn.setBillQty(grnConfList.get(i).getBillQty());

				objShowGrn.setCgstPer(grnConfList.get(i).getCgstPer());
				objShowGrn.setFrId(grnConfList.get(i).getFrId());
				objShowGrn.setGrnType(grnConfList.get(i).getGrnType());
				objShowGrn.setIgstPer(grnConfList.get(i).getIgstPer());
				objShowGrn.setItemId(grnConfList.get(i).getItemId());
				objShowGrn.setItemName(grnConfList.get(i).getItemName());
				objShowGrn.setMrp(grnConfList.get(i).getMrp());
				objShowGrn.setRate(grnConfList.get(i).getRate());
				objShowGrn.setSgstPer(grnConfList.get(i).getSgstPer());

				float calcBaseRate = grnConfList.get(i).getRate() * 100
						/ (grnConfList.get(i).getSgstPer() + grnConfList.get(i).getCgstPer() + 100);

				objShowGrn.setCalcBaseRate(roundUp(calcBaseRate));

				objShowGrn.setAutoGrnQty(grnConfList.get(i).getAutoGrnQty());


				float baseRate = objShowGrn.getRate() * 100 / (objShowGrn.getSgstPer() + objShowGrn.getCgstPer() + 100);

				float grnBaseRate = 0.0f;

				float grnRate = 0.0f;

				if (objShowGrn.getGrnType() == 0) {
					grnBaseRate = baseRate * 75 / 100;

					grnRate = (objShowGrn.getRate() * 75) / 100;
				}

				if (objShowGrn.getGrnType() == 1) {
					grnBaseRate = baseRate * 90 / 100;
					grnRate = (objShowGrn.getRate() * 90) / 100;
				}

				if (objShowGrn.getGrnType() == 2 || objShowGrn.getGrnType() == 4) {

					grnBaseRate = baseRate;
					grnRate = objShowGrn.getRate();
				}

				float taxableAmt = grnBaseRate * objShowGrn.getAutoGrnQty();

				float totalTax = (taxableAmt * (objShowGrn.getSgstPer() + objShowGrn.getCgstPer())) / 100;

				float grandTotal = taxableAmt + totalTax;

				float finalAmt = grnRate * objShowGrn.getAutoGrnQty();

				objShowGrn.setGrnAmt(roundUp(grandTotal));

				float taxPer = objShowGrn.getSgstPer() + objShowGrn.getCgstPer();
				
				objShowGrn.setTaxPer(taxPer);
				
				objShowGrn.setMenuId(grnConfList.get(i).getMenuId());
				objShowGrn.setCatId(grnConfList.get(i).getCatId());
				objShowGrn.setInvoiceNo(grnConfList.get(i).getInvoiceNo());
				objShowGrn.setBillDateTime(grnConfList.get(i).getBillDateTime());
				

				objShowGrnList.add(objShowGrn);
				
				}//end of if
			
			} // End of For Loop

			System.out.println("bean new " + objShowGrnList.toString());

			modelAndView.addObject("grnConfList", objShowGrnList);
			
		} catch (Exception e) {
			e.printStackTrace();

			System.out.println("Error in getting grn Item config " + e.getMessage());
		}

		return modelAndView;
		
	}
	
	

	@RequestMapping(value = "/insertGrnProcess", method = RequestMethod.POST)
	public ModelAndView insertGrnProcess(HttpServletRequest request, HttpServletResponse response) {
		
		ModelAndView modelAndView = new ModelAndView("grngvn/showgrn");
		
		HttpSession session = request.getSession();

		Franchisee frDetails = (Franchisee) session.getAttribute("frDetails");

		try {
			

			java.sql.Date grnGvnDate = new java.sql.Date(Calendar.getInstance().getTime().getTime());


			RestTemplate restTemplate = new RestTemplate();

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

			List<GrnGvn> postGrnGvnList = new ArrayList<GrnGvn>();

			PostGrnGvnList postGrnList = new PostGrnGvnList();

			grnConfList = grnGvnConfResponse.getGetGrnItemConfigs();

			for (int i = 0; i < objShowGrnList.size(); i++) {

				DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				Calendar cal = Calendar.getInstance();
				DateFormat dateFormatDate = new SimpleDateFormat("yyyy-MM-dd");
				Calendar calDate = Calendar.getInstance();
				
				GrnGvn postGrnGvn = new GrnGvn();
				
				String tempGrnQtyAuto= request.getParameter("grnqtyauto"+objShowGrnList.get(i).getItemId()+"");
				
				String tempGrnQty= request.getParameter("grnqty"+objShowGrnList.get(i).getItemId()+"");

				System.out.println("tempGrnQty ==="+tempGrnQty);


				System.out.println("tempGrnQtyAuto ==="+tempGrnQtyAuto);

				
				int grnQty=Integer.parseInt(tempGrnQtyAuto);	
				int fixedGrnQty=Integer.parseInt(tempGrnQty);
				int isEdit=0;
				if(grnQty!=fixedGrnQty) {
					isEdit=1;	
					
				}else {
					isEdit=0;
				}
					
				
				String frGrnRemark = request.getParameter("grn_remark" + objShowGrnList.get(i).getItemId());



				if (frGrnRemark == null || frGrnRemark == "") {
					frGrnRemark = "no remark entered";

				}
				


				float baseRate = objShowGrnList.get(i).getRate() * 100
						/ (objShowGrnList.get(i).getSgstPer() + objShowGrnList.get(i).getCgstPer() + 100);

				float grnBaseRate = 0.0f;

				float grnRate = 0.0f;

				if (objShowGrnList.get(i).getGrnType() == 0) {
					grnBaseRate = baseRate * 75 / 100;

					grnRate = (objShowGrnList.get(i).getRate() * 75) / 100;
					// postGrnGvn.setGrnGvnAmt(roundUp(grnAmt));
				}

				if (objShowGrnList.get(i).getGrnType() == 1) {
					grnBaseRate = baseRate * 90 / 100;
					grnRate = (objShowGrnList.get(i).getRate() * 90) / 100;
					// postGrnGvn.setGrnGvnAmt(roundUp(grnAmt));
				}

				if (objShowGrnList.get(i).getGrnType() == 2 || objShowGrnList.get(i).getGrnType() == 4 ) {
					// postGrnGvn.setGrnGvnAmt(roundUp(grnAmt));

					grnBaseRate = baseRate;
					grnRate = objShowGrnList.get(i).getRate();
				}

				float taxableAmt = grnBaseRate * grnQty;

				float totalTax = (taxableAmt * (objShowGrnList.get(i).getSgstPer() + objShowGrnList.get(i).getCgstPer()))
						/ 100;

				float grandTotal = taxableAmt + totalTax;

				float finalAmt = grnRate * grnQty;

				postGrnGvn.setGrnGvnAmt(roundUp(grandTotal));
				float roundUpAmt = finalAmt - grandTotal;

				/*
				 * if(frDetails.getFrGstType()==0) { grnAmt = grnQty *
				 * grnConfList.get(i).getRate(); grnAmt = roundUp(grnAmt);
				 * 
				 * } else {
				 * 
				 * float baseRate= grnConfList.get(i).getRate()*100/
				 * (grnConfList.get(i).getSgstPer() + grnConfList.get(i).getCgstPer()+100);
				 * grnAmt=grnQty*baseRate;
				 * 
				 * }
				 */

				if (grnQty > 0) {
					postGrnGvn.setGrnGvnDate(grnGvnDate);
					
					postGrnGvn.setBillNo(objShowGrnList.get(i).getBillNo());
					postGrnGvn.setFrId(frDetails.getFrId());
					postGrnGvn.setItemId(objShowGrnList.get(i).getItemId());
					postGrnGvn.setItemRate(objShowGrnList.get(i).getRate());
					postGrnGvn.setItemMrp(objShowGrnList.get(i).getMrp());
					postGrnGvn.setGrnGvnQty(grnQty);
					postGrnGvn.setGrnType(objShowGrnList.get(i).getGrnType());
					postGrnGvn.setIsGrn(1);
					postGrnGvn.setIsGrnEdit(isEdit);
					postGrnGvn.setGrnGvnEntryDateTime(dateFormat.format(cal.getTime()));
					postGrnGvn.setFrGrnGvnRemark(frGrnRemark);
					postGrnGvn.setGvnPhotoUpload1("grn:no photo");
					postGrnGvn.setGvnPhotoUpload2("grn:no photo");
					postGrnGvn.setGrnGvnStatus(1);
					postGrnGvn.setApprovedLoginGate(0);
					postGrnGvn.setApproveimedDateTimeGate("0000-00-00 00:00:00");
					postGrnGvn.setApprovedRemarkGate(" ");

					postGrnGvn.setApprovedLoginStore(0);
					postGrnGvn.setApprovedDateTimeStore("0000-00-00 00:00:00");
					postGrnGvn.setApprovedRemarkStore(" ");
					postGrnGvn.setApprovedLoginAcc(0);
					postGrnGvn.setGrnApprovedDateTimeAcc("0000-00-00 00:00:00");
					postGrnGvn.setApprovedRemarkAcc(" ");

					postGrnGvn.setDelStatus(0);
					postGrnGvn.setGrnGvnQtyAuto(grnQty);

					// newly added

					postGrnGvn.setIsTallySync(0);
					postGrnGvn.setBaseRate(roundUp(baseRate));
					postGrnGvn.setSgstPer(objShowGrnList.get(i).getSgstPer());
					postGrnGvn.setCgstPer(objShowGrnList.get(i).getCgstPer());
					postGrnGvn.setIgstPer(objShowGrnList.get(i).getIgstPer());

					postGrnGvn.setTaxableAmt(taxableAmt);
					postGrnGvn.setTotalTax(totalTax);
					postGrnGvn.setFinalAmt(finalAmt);
					postGrnGvn.setRoundUpAmt(roundUpAmt);

					postGrnGvn.setIsCreditNote(0);

					postGrnGvn.setCatId(objShowGrnList.get(i).getCatId());
					postGrnGvn.setMenuId(objShowGrnList.get(i).getMenuId());

					postGrnGvn.setRefInvoiceDate(objShowGrnList.get(i).getBillDate());
					postGrnGvn.setInvoiceNo(objShowGrnList.get(i).getInvoiceNo());

					System.out.println("post grn ref inv date " + postGrnGvn.getRefInvoiceDate());

					postGrnGvnList.add(postGrnGvn);

				} // end of if checking for grnQty
			} // end of for

			modelAndView.addObject("grnConfList", objShowGrnList);
			System.out.println("postGrnGvnList************----- " + postGrnGvnList.toString());

			System.out.println("****postGrnGvnList size*******-- " + postGrnGvnList.size());

			postGrnList.setGrnGvn(postGrnGvnList);

			System.out.println("post grn for rest----- " + postGrnList.toString());
			System.out.println("post grn for rest size " + postGrnList.getGrnGvn().size());

			Info insertGrn = restTemplate.postForObject(Constant.URL + "insertGrnGvn", postGrnList, Info.class);

		} catch (Exception e) {

			System.out.println("exce in grn insert " + e.getMessage());
			e.printStackTrace();

		}
		
		ModelAndView modelAndView2 = new ModelAndView("grngvn/displaygrn");

		try {

		RestTemplate restTemplate = new RestTemplate();

		MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
		int frId = frDetails.getFrId();

		java.util.Date grnDate = new java.sql.Date(Calendar.getInstance().getTime().getTime());

		DateFormat sdFormat = new SimpleDateFormat("dd-MM-yyyy");

		String cDate = sdFormat.format(grnDate);

		map.add("frId", frId);
		map.add("fromDate", cDate);
		map.add("toDate", cDate);

		GetGrnGvnDetailsList grnListResponse = null;
		// getFrGrnDetail
		

			grnListResponse = restTemplate.postForObject(Constant.URL + "getFrGrnDetails", map,
					GetGrnGvnDetailsList.class);
			System.out.println("inside try " + grnListResponse.toString());

		
		grnGvnDetailsList = new ArrayList<>();

		grnGvnDetailsList = grnListResponse.getGrnGvnDetails();


		modelAndView2.addObject("grnList", grnGvnDetailsList);

		modelAndView2.addObject("cDate", cDate);
		} catch (Exception e) {

			e.printStackTrace();
			System.out.println(e.getMessage());

		}
		
		return modelAndView2;

	}

	@RequestMapping(value = "/showGvn", method = RequestMethod.GET)
	public ModelAndView showGvnProcess(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView modelAndView = new ModelAndView("grngvn/showgvn");

		HttpSession session = request.getSession();
		Franchisee frDetails = (Franchisee) session.getAttribute("frDetails");

		RestTemplate restTemplate = new RestTemplate();
		
		try {
			
		MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

		int frId = frDetails.getFrId();
			
			map.add("frId", frId);

			GetBillsForFrList billsForFr = restTemplate.postForObject(Constant.URL + "getBillsForFr", map,
					GetBillsForFrList.class);

			frBillList = billsForFr.getGetBillsForFr();

			modelAndView.addObject("frBillList", frBillList);


		} catch (Exception e) {
			
			System.out.println("ex in get Bills For Fr gvn " + e.getMessage());
			
			e.printStackTrace();
		}

		return modelAndView;
	}
	@RequestMapping(value = "/getGvnBillDetails", method = RequestMethod.GET)
	public ModelAndView getGvnBillDetails(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView modelAndView = new ModelAndView("grngvn/showgvn");
		

		try {

		 int billNo = Integer.parseInt(request.getParameter("bill_no"));
		System.out.println("selected bill no " + billNo);

		RestTemplate restTemplate = new RestTemplate();

		MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

		map.add("billNo", billNo);

		grnGvnConfResponse = restTemplate.postForObject(Constant.URL + "getGvnItemConfig", map,
				GetGrnGvnConfResponse.class);

		grnConfList = new ArrayList<>();

		grnConfList = grnGvnConfResponse.getGetGrnItemConfigs();
		System.out.println("gvn conf list " + grnConfList.toString());


		modelAndView.addObject("frBillList", frBillList);


			objShowGvnList = new ArrayList<>();

			ShowGrnBean objShowGvn = null;

			for (int i = 0; i < grnConfList.size(); i++) {

				objShowGvn = new ShowGrnBean();

				objShowGvn.setBillDate(grnConfList.get(i).getBillDate());
				objShowGvn.setBillDetailNo(grnConfList.get(i).getBillDetailNo());
				objShowGvn.setBillNo(grnConfList.get(i).getBillNo());
				objShowGvn.setBillQty(grnConfList.get(i).getBillQty());

				objShowGvn.setCgstPer(grnConfList.get(i).getCgstPer());
				objShowGvn.setFrId(grnConfList.get(i).getFrId());
				objShowGvn.setGrnType(grnConfList.get(i).getGrnType());
				objShowGvn.setIgstPer(grnConfList.get(i).getIgstPer());
				objShowGvn.setItemId(grnConfList.get(i).getItemId());
				objShowGvn.setItemName(grnConfList.get(i).getItemName());
				objShowGvn.setMrp(grnConfList.get(i).getMrp());
				objShowGvn.setRate(grnConfList.get(i).getRate());
				objShowGvn.setSgstPer(grnConfList.get(i).getSgstPer());
				
				float calcBaseRate = grnConfList.get(i).getRate() * 100
						/ (grnConfList.get(i).getSgstPer() + grnConfList.get(i).getCgstPer() + 100);

				objShowGvn.setCalcBaseRate(roundUp(calcBaseRate));

				objShowGvnList.add(objShowGvn);

			}
			
			modelAndView.addObject("gvnConfList", objShowGvnList);
			modelAndView.addObject("billNo",billNo);

		} catch (Exception e) {
			System.out.println("show gvn error " + e.getMessage());
			e.printStackTrace();
		}


		return modelAndView;

	}

	@RequestMapping(value = "/addGvnProcess", method = RequestMethod.POST)
	public ModelAndView addGvnProcess(@RequestParam("gvn_photo1") MultipartFile[] photo1,
			@RequestParam("gvn_photo2") MultipartFile[] photo2, HttpServletRequest request,
			HttpServletResponse response) {
		ModelAndView modelAndView = new ModelAndView("grngvn/showgvn");
		
		ModelAndView model =null;

	try {

		RestTemplate restTemplate = new RestTemplate();
		grnConfList = grnGvnConfResponse.getGetGrnItemConfigs();

		HttpSession session = request.getSession();
		Franchisee frDetails = (Franchisee) session.getAttribute("frDetails");

		List<GrnGvn> postGrnGvnList = new ArrayList<GrnGvn>();

		

		PostGrnGvnList postGrnList = new PostGrnGvnList();
		
		for (int i = 0; i < grnConfList.size(); i++) {
			
			String strGvnQty = request.getParameter("gvn_qty" + grnConfList.get(i).getItemId());
			int gvnQty = Integer.parseInt(strGvnQty);


			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Calendar cal = Calendar.getInstance();

			DateFormat dateFormatDate = new SimpleDateFormat("yyyy-MM-dd");
			Calendar calDate = Calendar.getInstance();


			String frGvnRemark = request.getParameter("gvn_remark" + grnConfList.get(i).getItemId());

			if (frGvnRemark == null || frGvnRemark.equals("")) {
				frGvnRemark = "no remark from franchisee";

			}

			if (gvnQty > 0) {

				GrnGvn postGrnGvn = new GrnGvn();

				java.sql.Date grnGvnDate = new java.sql.Date(Calendar.getInstance().getTime().getTime());

				float baseRate = grnConfList.get(i).getRate() * 100
						/ (grnConfList.get(i).getSgstPer() + grnConfList.get(i).getCgstPer() + 100);

				float gvnAmt = gvnQty * baseRate;

				float taxableAmt = baseRate * gvnQty;

				float totalTax = (taxableAmt * (grnConfList.get(i).getSgstPer() + grnConfList.get(i).getCgstPer()))
						/ 100;

				float grandTotal = taxableAmt + totalTax;

				

				float finalAmt = grnConfList.get(i).getRate() * gvnQty;

				float roundUpAmt = finalAmt - grandTotal;

				gvnAmt = roundUp(gvnAmt);

				postGrnGvn.setGrnGvnAmt(grandTotal);
				postGrnGvn.setGrnGvnDate(grnGvnDate);// 1

				postGrnGvn.setBillNo(grnConfList.get(i).getBillNo());// 2
				postGrnGvn.setFrId(frDetails.getFrId());// 3
				postGrnGvn.setItemId(grnConfList.get(i).getItemId());// 4
				postGrnGvn.setItemRate(grnConfList.get(i).getRate());// 5
				postGrnGvn.setItemMrp(grnConfList.get(i).getMrp());// 6
				postGrnGvn.setGrnGvnQty(gvnQty);// 7
				postGrnGvn.setGrnType(4);// 9
				postGrnGvn.setIsGrn(0);// 10
				postGrnGvn.setIsGrnEdit(0);// 11
				postGrnGvn.setGrnGvnEntryDateTime(dateFormat.format(cal.getTime()));// 12
				postGrnGvn.setFrGrnGvnRemark(frGvnRemark);// 13
				postGrnGvn.setGrnGvnStatus(1);// 16
				postGrnGvn.setApprovedLoginGate(0);// 17
				postGrnGvn.setApproveimedDateTimeGate("");// 18
				postGrnGvn.setApprovedRemarkGate("");// 19

				postGrnGvn.setApprovedLoginStore(0);// 20
				postGrnGvn.setApprovedDateTimeStore(" ");// 21
				postGrnGvn.setApprovedRemarkStore(" ");// 22
				postGrnGvn.setApprovedLoginAcc(0);// 23
				postGrnGvn.setGrnApprovedDateTimeAcc(" ");// 24
				postGrnGvn.setApprovedRemarkAcc(" ");// 25

				postGrnGvn.setDelStatus(0);// 26
				postGrnGvn.setGrnGvnQtyAuto(gvnQty);// 27

				String gvnPhoto1 = ImageS3Util.uploadSpCakeImage(photo1[i]);
				postGrnGvn.setGvnPhotoUpload1(gvnPhoto1);
				String gvnPhoto2 = ImageS3Util.uploadSpCakeImage(photo2[i]);

				postGrnGvn.setGvnPhotoUpload2(gvnPhoto2);

				// new fields
				postGrnGvn.setGrnGvnAmt(roundUp(grandTotal));

				postGrnGvn.setIsTallySync(0);
				postGrnGvn.setBaseRate(roundUp(baseRate));
				postGrnGvn.setSgstPer(grnConfList.get(i).getSgstPer());
				postGrnGvn.setCgstPer(grnConfList.get(i).getCgstPer());
				postGrnGvn.setIgstPer(grnConfList.get(i).getIgstPer());

				postGrnGvn.setTaxableAmt(taxableAmt);
				postGrnGvn.setTotalTax(totalTax);
				postGrnGvn.setFinalAmt(finalAmt);
				postGrnGvn.setRoundUpAmt(roundUpAmt);

				postGrnGvn.setIsCreditNote(0);

				postGrnGvn.setCatId(grnConfList.get(i).getCatId());
				postGrnGvn.setMenuId(grnConfList.get(i).getMenuId());

				postGrnGvn.setRefInvoiceDate(grnConfList.get(i).getBillDate());
				postGrnGvn.setInvoiceNo(grnConfList.get(i).getInvoiceNo());

				postGrnGvnList.add(postGrnGvn);

			} // end of if

		} // end of for

		postGrnList.setGrnGvn(postGrnGvnList);

		System.out.println("post grn for rest----- " + postGrnList.toString());
		System.out.println("post grn for rest size " + postGrnList.getGrnGvn().size());

		Info insertGvn = restTemplate.postForObject(Constant.URL + "insertGrnGvn", postGrnList, Info.class);

		// Redirect to Gvn List after insert

		model = new ModelAndView("grngvn/displaygvn");

		MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
		int frId = frDetails.getFrId();

		java.util.Date grnDate = new java.sql.Date(Calendar.getInstance().getTime().getTime());

		DateFormat sdFormat = new SimpleDateFormat("dd-MM-yyyy");

		String cDate = sdFormat.format(grnDate);

		map.add("frId", frId);
		map.add("fromDate", cDate);
		map.add("toDate", cDate);

		GetGrnGvnDetailsList grnListResponse = null;
		// getFrGvnDetail
		try {

			grnListResponse = restTemplate.postForObject(Constant.URL + "getFrGvnDetails", map,
					GetGrnGvnDetailsList.class);

		} catch (Exception e) {

			e.printStackTrace();
			System.out.println(e.getMessage());

		}
		grnGvnDetailsList = new ArrayList<>();

		grnGvnDetailsList = grnListResponse.getGrnGvnDetails();

		model.addObject("gvnList", grnGvnDetailsList);

		model.addObject("url", Constant.SPCAKE_IMAGE_URL);
		model.addObject("cDate", cDate);
	}catch (Exception e) {
		
		System.out.println("failed to insert Gvn "+e.getMessage());
		e.printStackTrace();
	}
		return model;
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
		
		return grnGvnDetailsList;

	}

}
