package com.monginis.ops.controller;

import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import com.amazonaws.Request;
import com.monginis.ops.billing.SellBillDataCommon;
import com.monginis.ops.billing.SellBillDetail;
import com.monginis.ops.billing.SellBillHeader;
import com.monginis.ops.constant.Constant;
import com.monginis.ops.model.CustomerBillItem;
import com.monginis.ops.model.FrMenu;
import com.monginis.ops.model.Franchisee;
import com.monginis.ops.model.GetCurrentStockDetails;
import com.monginis.ops.model.GetItemHsnCode;
import com.monginis.ops.model.Info;
import com.monginis.ops.model.Item;
import com.monginis.ops.model.ItemResponse;
import com.monginis.ops.model.PostFrItemStockHeader;
import com.monginis.ops.model.SellBillDetailList;
import com.sun.org.apache.regexp.internal.RE;



@Controller
public class ExpressBillController {
	
	public static List<GetCurrentStockDetails> currentStockDetailList=new ArrayList<GetCurrentStockDetails>();

	public static List<CustomerBillItem> customerBillItemList=new ArrayList<CustomerBillItem>();
    public static SellBillHeader sellBillHeaderGlobal=new SellBillHeader();
    SellBillDetail	sellBillDetailRes;
   // SellBillDetailList sellBillDetailList;
    List<SellBillDetail> selectedSellBillDetailList;
    List<SellBillDetail>  BillDetailList=new ArrayList<SellBillDetail>();
	
	@RequestMapping(value = "/showExpressBill", method = RequestMethod.GET)
	public ModelAndView showExpressBill(HttpServletRequest request, HttpServletResponse response)
	{
		ModelAndView model = new ModelAndView("expressBill/expressBill");
		int count = 0;
		
		HttpSession session = request.getSession();

 	   ArrayList<FrMenu> menuList = (ArrayList<FrMenu>) session.getAttribute("menuList");
		   Franchisee frDetails = (Franchisee) session.getAttribute("frDetails");
		
		try
		{
			System.out.println("menuList"+menuList.toString());
	   		ArrayList<Integer> itemList=new ArrayList<Integer>();
	   	
	          String items;
	   		StringBuilder  builder=new StringBuilder();
	   		for (FrMenu frMenu :menuList) {
	   			
	   		    if (frMenu.getMenuId()==26||frMenu.getMenuId()==31||frMenu.getMenuId()==33||frMenu.getMenuId()==34) {
	   		       
	   		               String str=frMenu.getItemShow();	
	   		       		   System.out.println("getItemShow"+frMenu.getItemShow());

	   		       		builder.append(","+frMenu.getItemShow());
	   			       		
	   		       }
	   		
	   		}
	   		items=builder.toString();
	   	    items=items.substring(1, items.length());
	   		
	   		System.out.println("Item Show List is "+items);
	   		
	   		
	   		
	   		RestTemplate restTemplate = new RestTemplate();
	   		MultiValueMap<String, Object> mvm = new LinkedMultiValueMap<String, Object>();
	   		
	   		mvm.add("itemList",items );
	   		

	   		ItemResponse itemsList = restTemplate.postForObject(Constant.URL + "/getItemsById",
	   				mvm,ItemResponse.class);
	   	
	   		List<Item>  newItemsList=itemsList.getItemList();
	   		
	   		
	          customerBillItemList=new ArrayList<CustomerBillItem>();

			
			  for(int i=0;i<newItemsList.size();i++) {
				
				Item item=newItemsList.get(i);
				
				CustomerBillItem customerBillItem = new CustomerBillItem();
				customerBillItem.setCatId(item.getItemGrp1());
				customerBillItem.setId(item.getId());
				customerBillItem.setItemId(item.getItemId());
				customerBillItem.setItemName(item.getItemName());
				customerBillItem.setQty(0);
				customerBillItem.setItemTax1(item.getItemTax1());
				customerBillItem.setItemTax2(item.getItemTax2());
				customerBillItem.setItemTax3(item.getItemTax3());
				
				if(frDetails.getFrRateCat()==1)
				{
					customerBillItem.setMrp(item.getItemMrp1());
					customerBillItem.setRate(item.getItemRate1());
				}
				else if(frDetails.getFrRateCat()==2)
				{
					customerBillItem.setMrp(item.getItemMrp2());
				 
				    customerBillItem.setRate(item.getItemRate2());
				
			    }else if(frDetails.getFrRateCat()==3)
			    {
			    	customerBillItem.setMrp(item.getItemMrp3());
					 
				    customerBillItem.setRate(item.getItemRate3());
			    }

				customerBillItemList.add(customerBillItem);
			
			}
			
			System.out.println("*********customerBillItemList***********"+customerBillItemList.toString());
	   		
	   		model.addObject("itemsList",customerBillItemList);
	   		//model.addObject("count", count);
        //----------------------------------------------------------------------------
			
		RestTemplate rest=new RestTemplate();
		MultiValueMap<String, Object> mav = new LinkedMultiValueMap<String, Object>();
		
		mav.add("frId",frDetails.getFrId());
		
		
		SellBillDataCommon sellBillResponse=rest.postForObject(Constant.URL+"/showNotDayClosedRecord",
			mav,SellBillDataCommon.class);
		
		List<SellBillHeader> sellBillHeaderList=sellBillResponse.getSellBillHeaderList();
		
		 count=sellBillHeaderList.size();
		SellBillHeader sellBillHeader=sellBillResponse.getSellBillHeaderList().get(0);
		
		//-------------------------------------------------
		sellBillHeaderGlobal=sellBillHeader;
		//--------------------------------------------------
		
		Date billDate=new SimpleDateFormat("yyyy-MM-dd").parse(sellBillHeader.getBillDate());  
	//1	Date dmyBillDate=new SimpleDateFormat("dd-MM-yyyy").parse(sellBillHeader.getBillDate());  
	    //------------Todays Date-----------
		Date date = new Date();
		String todaysDate= new SimpleDateFormat("yyyy-MM-dd").format(date);
		          
		System.out.println("Todays Date: "+todaysDate);
	    //-------------------------------------
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date currentDate = sdf.parse(todaysDate);
	    //-------------------------------------
       if(count!=0)
       {        
		if(billDate.equals(currentDate))
		{
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			
			map.add("billNo", sellBillHeader.getSellBillNo());
			
			SellBillDetailList sellBillDetailList = rest.postForObject(Constant.URL + "/getSellBillDetails",
					map, SellBillDetailList.class);
			
			List<SellBillDetail> sellBillDetails=sellBillDetailList.getSellBillDetailList();
			selectedSellBillDetailList=sellBillDetails;
			System.out.println("selectedSellBillDetailList  "+selectedSellBillDetailList.toString());
			model.addObject("sellBillDetails", sellBillDetails);
	   		model.addObject("count",2);
	   		
	   		model.addObject("sellBillHeader",sellBillHeader);

		}
		else if(billDate.before(currentDate))
		{
            MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			
			map.add("billNo", sellBillHeader.getSellBillNo());
			
			SellBillDetailList  sellBillDetailList = rest.postForObject(Constant.URL + "/getSellBillDetails",
					map, SellBillDetailList.class);
					
			List<SellBillDetail> sellBillDetails=sellBillDetailList.getSellBillDetailList();
			selectedSellBillDetailList=sellBillDetails;
			System.out.println("selectedSellBillDetailList  "+selectedSellBillDetailList.toString());
			model.addObject("sellBillDetails", sellBillDetails);
	   		model.addObject("count", 3);
	   		model.addObject("sellBillHeader",sellBillHeader);
		}
       }
       else
       {
	   		model.addObject("count", count);

       }
   		
        
		}
		catch(Exception e)
		{		
			    model.addObject("count", 0);
			    
	        	model.addObject("itemsList",customerBillItemList);
	        	
			System.out.println("Exception In ExpressBillController View Page");
		}
		return model;
	}
	
	@RequestMapping(value = "/calcStock", method = RequestMethod.GET)
	public @ResponseBody int getStock(HttpServletRequest request, HttpServletResponse response,@RequestParam(value = "itemId", required = true) String itemId)
	{
		HttpSession session = request.getSession();

			   Franchisee frDetails = (Franchisee) session.getAttribute("frDetails");
			
			   
			   
		int curStock=0;
		try {
		boolean isPrevItem=false;
		
		
		int catId=0;
		int id=0;
		
		for(CustomerBillItem item:customerBillItemList)
		{
			if(item.getItemId().equalsIgnoreCase(itemId))
			{		
				id=item.getId();
				catId=item.getCatId();
				
			}
		}
		
        
        // ------------------------------------------------------------------------------------------
        if (currentStockDetailList!=null) {
            for (int i = 0; i < currentStockDetailList.size(); i++) {
                
                if (id == currentStockDetailList.get(i).getId()) {
                    isPrevItem=true;
                }
            }
        }
          if(currentStockDetailList==null || !isPrevItem)
        {
        	  
        	 
            System.out.println("If current Detail List is NULL for item Id "+ id);
            currentStockDetailList= getStockFromServer(id,catId, frDetails);// stock calculation
        }
            
          for (int i = 0; i < currentStockDetailList.size(); i++) {
              if (id == currentStockDetailList.get(i).getId()) {
                    isPrevItem=true;
                    
                    curStock=(currentStockDetailList.get(i).getCurrentRegStock());
              }        
        }
		 } catch (Exception e) {
             System.out.println("Exception in cal Stock " + e.getMessage());
             e.printStackTrace();

         }

		 return curStock;
	}
	
	
	  public List<GetCurrentStockDetails> getStockFromServer(int currentNewItem,int catId, Franchisee frDetails) {
          System.out.println("Input para ");
          System.out.println("item ID "+currentNewItem);
          System.out.println("cat ID "+catId);
          System.out.println("Fr ID "+frDetails.getFrId());
          
          

	        
          Integer runningMonth = 0;

          PostFrItemStockHeader frItemStockHeader;
          // -------------------------------------Stock---------------------------------------
          RestTemplate restTemplate = new RestTemplate();

          DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
          DateFormat yearFormat = new SimpleDateFormat("yyyy");

          try {
              MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
              map.add("frId", frDetails.getFrId());

              frItemStockHeader = restTemplate.postForObject(Constant.URL + "getRunningMonth", map,
                      PostFrItemStockHeader.class);
              runningMonth = frItemStockHeader.getMonth();

         
          Date todaysDate = new Date();
          System.out.println(dateFormat.format(todaysDate));

          Calendar cal = Calendar.getInstance();
          cal.setTime(todaysDate);

          cal.set(Calendar.DAY_OF_MONTH, 1);

          Date firstDay = cal.getTime();

          System.out.println("First Day of month " + firstDay);

          String strFirstDay = dateFormat.format(firstDay);

          System.out.println("Year " + yearFormat.format(todaysDate));

          map = new LinkedMultiValueMap<String, Object>();
          map.add("frId", frDetails.getFrId());
          map.add("fromDate", dateFormat.format(firstDay));
          map.add("toDate", dateFormat.format(todaysDate));
          map.add("currentMonth", String.valueOf(runningMonth));
          map.add("year", yearFormat.format(todaysDate));
          map.add("catId", catId);
          map.add("itemIdList", currentNewItem);
    
          
          List<GetCurrentStockDetails> getCurrentStockDetailsList=new ArrayList<>();
          
          ParameterizedTypeReference<List<GetCurrentStockDetails>> typeRef = new ParameterizedTypeReference<List<GetCurrentStockDetails>>() {
          };
          ResponseEntity<List<GetCurrentStockDetails>> responseEntity = restTemplate
                  .exchange(Constant.URL + "getCurrentStock", HttpMethod.POST, new HttpEntity<>(map), typeRef);

            //getCurrentStockDetailsList.addAll(responseEntity.getBody());
          
          getCurrentStockDetailsList=responseEntity.getBody();
            
            System.out.println("get Cur Stock De List "+getCurrentStockDetailsList.toString());
          //System.out.println("Current Stock Details : " + currentStockDetailList.toString());
            
            if(!getCurrentStockDetailsList.isEmpty()) {
         
            	for(int i=0;i<getCurrentStockDetailsList.size();i++)
            	{
            		currentStockDetailList.add(getCurrentStockDetailsList.get(i));
            	}
            }
          
          } catch (Exception e) {
        	  
        	  System.out.println("cure Sto de li "+currentStockDetailList.toString());
              System.out.println("Exception in stock web Service " + e.getMessage());
              e.printStackTrace();

          }
        
          System.out.println("cure Sto de li "+currentStockDetailList.toString());
          
          return currentStockDetailList;
          
        
      }
	
	   
	
	
	@RequestMapping(value = "/insertItem", method = RequestMethod.GET)
	public @ResponseBody List<SellBillDetail>  insertItem(HttpServletRequest request, HttpServletResponse response,@RequestParam(value = "itemId", required = true) String itemId,@RequestParam(value = "qty", required = true) int qty)
	{
		System.out.println("********ItemId********"+itemId);
		RestTemplate restTemplate = new RestTemplate();
		
	
	
		
		float sumTaxableAmt = 0, sumTotalTax = 0, sumGrandTotal = 0;
		for(CustomerBillItem item:customerBillItemList)
		{
			if(item.getItemId().equalsIgnoreCase(itemId))
			{		

				SellBillDetail sellBillDetail=new SellBillDetail();
				
				Float rate = (float)  item.getMrp();

				Float tax1 = (float) item.getItemTax1();
				Float tax2 = (float) item.getItemTax2();
				Float tax3 = (float) item.getItemTax3();
				
				
				
				Float mrpBaseRate = (rate * 100) / (100 + (tax1 + tax2));
				mrpBaseRate=roundUp(mrpBaseRate);
				
				System.out.println("Mrp: "+rate);
				System.out.println("Tax1 : "+tax1);
				System.out.println("tax2 : "+tax2);
				
				Float taxableAmt = (float) (mrpBaseRate * qty);
				taxableAmt=roundUp(taxableAmt);
				
				//-----------------------------------------


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
			 
				sellBillDetail.setCatId(item.getCatId());
				sellBillDetail.setSgstPer(tax1);
				sellBillDetail.setSgstRs(sgstRs);
				sellBillDetail.setCgstPer(tax2);
				sellBillDetail.setCgstRs(cgstRs);
				sellBillDetail.setDelStatus(0);
				sellBillDetail.setGrandTotal(grandTotal);
				sellBillDetail.setIgstPer(tax3);
				sellBillDetail.setIgstRs(igstRs);
				sellBillDetail.setItemId(item.getId());
				sellBillDetail.setMrp(rate);
				sellBillDetail.setMrpBaseRate(mrpBaseRate);
				sellBillDetail.setQty(qty);
				sellBillDetail.setRemark("");
				sellBillDetail.setSellBillDetailNo(0);
				sellBillDetail.setSellBillNo(sellBillHeaderGlobal.getSellBillNo());
				sellBillDetail.setBillStockType(1);
				
				sumTaxableAmt=sumTaxableAmt+taxableAmt;
				sumTotalTax=sumTotalTax+totalTax;
				sumGrandTotal=sumGrandTotal+grandTotal;
				
				sellBillDetail.setTaxableAmt(taxableAmt);
				sellBillDetail.setTotalTax(totalTax);
				System.out.println("**SellBillDetail Response:** "+sellBillDetail.toString()+"GlobalBillNo."+sellBillHeaderGlobal.getSellBillNo());

				   	sellBillDetailRes=restTemplate.postForObject(Constant.URL + "saveSellBillDetail", sellBillDetail,
						SellBillDetail.class);
				System.out.println("After Insert Item  "+sellBillDetailRes.toString());
				if(sellBillDetailRes!=null) {
					
					for(int i=0;i<currentStockDetailList.size();i++) {
						
						if(currentStockDetailList.get(i).getId()==item.getId()) {
							
							currentStockDetailList.get(i).setCurrentRegStock(currentStockDetailList.get(i).getCurrentRegStock()-(qty));
							
							
						}
						
						
					}//end of For 
					
					
				}
				
				System.out.println("**SellBillDetail Response:** "+sellBillDetail.toString());
			}
			else
			{
				System.out.println("********elseItemId********"+item.getItemId().toString());
			}
		}
		
		MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
		
		map.add("billNo", sellBillHeaderGlobal.getSellBillNo());
		
		SellBillDetailList sellBillDetailList = restTemplate.postForObject(Constant.URL + "/getSellBillDetails",
				map, SellBillDetailList.class);
		
		List<SellBillDetail> sellBillDetails=sellBillDetailList.getSellBillDetailList();
		selectedSellBillDetailList=sellBillDetails;
		
		return sellBillDetails;
	}
	
	//----------------------------roundUp()---------------------------------------------
	
	public static float roundUp(float d) {
		
		return BigDecimal.valueOf(d).setScale(2, BigDecimal.ROUND_HALF_UP).floatValue();
		
	}
	
	//-----------------------------------------------------------------------------------
	
	@RequestMapping(value = "/insertHeader", method = RequestMethod.GET)
	public @ResponseBody SellBillHeader  insertHeader(HttpServletRequest request, HttpServletResponse response)
	{
		CustomerBillItem customerBillItem=new CustomerBillItem();
		HttpSession session = request.getSession();

		Franchisee frDetails = (Franchisee) session.getAttribute("frDetails");
     
		
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		LocalDate localDate = LocalDate.now();
		System.out.println(dtf.format(localDate)); //2016/11/16
        
		
		
        SellBillHeader sellBillHeader=new SellBillHeader();
		
		sellBillHeader.setFrId(frDetails.getFrId());
		sellBillHeader.setFrCode(frDetails.getFrCode());
		sellBillHeader.setDelStatus(0);
		sellBillHeader.setUserName(frDetails.getFrName());
		sellBillHeader.setBillDate(dtf.format(localDate));
	
		sellBillHeader.setInvoiceNo(0);//hardcoded
		sellBillHeader.setPaidAmt(0);//hardcoded
		sellBillHeader.setPaymentMode(0);//hardcoded
		
		sellBillHeader.setSellBillNo(0);//hardcoded
	
		
		sellBillHeader.setUserGstNo(frDetails.getFrGstNo());
		
		sellBillHeader.setUserPhone(frDetails.getFrMob());
		
		sellBillHeader.setTaxableAmt(0);//hardcoded
		sellBillHeader.setDiscountPer(0);//hardcoded
		
		
		sellBillHeader.setDiscountAmt(0);//hardcoded
		sellBillHeader.setPayableAmt(0);//hardcoded
		
		sellBillHeader.setTotalTax(0);//hardcoded
		sellBillHeader.setGrandTotal(0);//hardcoded
		
		sellBillHeader.setRemainingAmt(0);//hardcoded
		
		sellBillHeader.setStatus(1);
		sellBillHeader.setBillType('E');
		
		
		RestTemplate restTemplate = new RestTemplate();
		
		sellBillHeader=restTemplate.postForObject(Constant.URL + "saveSellBillHeader", sellBillHeader,
				SellBillHeader.class);
	
		return sellBillHeader;
	}	
	
	@RequestMapping(value = "/findItemDetails", method = RequestMethod.GET)
	public @ResponseBody CustomerBillItem  getBillDetails(@RequestParam(value = "itemId", required = true) String itemId)
	{
		System.out.println("********ItemId********"+itemId);
		String stringItemId = itemId.replace("\"", "");
		System.out.println("********ItemIdstring********"+stringItemId);


		
		CustomerBillItem resItem=new CustomerBillItem();
		
		for(CustomerBillItem item:customerBillItemList)
		{
			if(item.getItemId().equalsIgnoreCase(stringItemId))
			{		

				resItem=item;
			}
			else
			{
				System.out.println("********elseItemId********"+item.getItemId().toString());
			}
		}
		System.out.println("**Selected Item**:"+resItem.toString());
		return resItem;
	}
	
	
	
	
	@RequestMapping(value = "/dayClose", method = RequestMethod.GET)
	public @ResponseBody ModelAndView dayClose(HttpServletRequest request, HttpServletResponse response)
	{
   		RestTemplate restTemplate = new RestTemplate();
   		System.out.println("inside day close ");

		 MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			
			map.add("billNo", sellBillHeaderGlobal.getSellBillNo());
			
			SellBillDetailList sellBillDetailList = restTemplate.postForObject(Constant.URL + "/getSellBillDetails",
					map, SellBillDetailList.class);
					
			List<SellBillDetail> sellBillDetails=sellBillDetailList.getSellBillDetailList();
			
			
			System.out.println("sellBillDetails "+sellBillDetails.toString());
			
			map = new LinkedMultiValueMap<String, Object>();
	
			map.add("sellBillNo", sellBillHeaderGlobal.getSellBillNo());
			
			System.out.println("sellBillHeaderGlobal.getSellBillNo()" +sellBillHeaderGlobal.getSellBillNo());
			SellBillHeader  billHeader =restTemplate.postForObject(Constant.URL + "/getSellBillHeaderForDayClose",
					map, SellBillHeader.class);
			
			System.out.println("billHeader "+billHeader.toString());
			
			
			for(int x=0;x<sellBillDetails.size();x++) {
				
				
				billHeader.setTaxableAmt(billHeader.getTaxableAmt()+sellBillDetails.get(x).getTaxableAmt());
				
				billHeader.setTotalTax(billHeader.getTotalTax()+sellBillDetails.get(x).getTotalTax());
				billHeader.setGrandTotal(sellBillDetails.get(x).getGrandTotal()+billHeader.getGrandTotal());
				
				//billHeader.setBillDate(billHeader.getBillDate());
				
				billHeader.setDiscountPer(billHeader.getDiscountPer());
				
			}
			
			System.out.println("billHeader new "+billHeader.toString());
			
			
			billHeader=restTemplate.postForObject(Constant.URL + "saveSellBillHeader", billHeader,
					SellBillHeader.class);
		
			ModelAndView model = new ModelAndView("expressBill/expressBill");
			
			System.out.println("redirecting to model ex bill ");
			
		return model;
	}

	
	
	// /deleteItem request Maoping 
	
	
	
	@RequestMapping(value = "/deleteItem", method = RequestMethod.GET)
	public @ResponseBody List<SellBillDetail>   deleteItem(@RequestParam(value = "sellBillDetailNo", required = true) int sellBillDetailNo)
	{
		System.out.println("********ItemId********"+sellBillDetailNo);
		
		
		System.out.println("********inside Delete********"+sellBillDetailNo);
		//
		
		RestTemplate restTemplate = new RestTemplate();

		 MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			
			map.add("delStatus",Constant.DEL_STATUS);
			map.add("sellBillDetailNo", sellBillDetailNo);
			
			Info info = restTemplate.postForObject(Constant.URL + "/deleteSellBillDetail",
					map, Info.class);
				
			System.out.println("Info.to "+info.toString());
			
			map = new LinkedMultiValueMap<String, Object>();
			
			
			map.add("billNo", sellBillHeaderGlobal.getSellBillNo());
			
			SellBillDetailList sellBillDetailList = restTemplate.postForObject(Constant.URL + "/getSellBillDetails",
					map, SellBillDetailList.class);
					
			List<SellBillDetail> sellBillDetails=sellBillDetailList.getSellBillDetailList();
			
		
		return sellBillDetails;
	
	}
	
	

	@RequestMapping(value = "/printExBill", method = RequestMethod.GET)
	public ModelAndView showExpressBillPrint(HttpServletRequest request, HttpServletResponse response)
	{
		ModelAndView model = new ModelAndView("expressBill/frExBillPrint");
		
		 MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			System.out.println("Item Id "  +sellBillDetailRes.getItemId());
			map.add("itemId",sellBillDetailRes.getItemId());
		GetItemHsnCode  getItemHsnCode=new RestTemplate().postForObject(Constant.URL + "/getItemHsnCode",
					map, GetItemHsnCode.class);
		//System.out.println("HSN CODE "+getItemHsnCode.toString());
		
		model.addObject("exBill",sellBillDetailRes);
		if(getItemHsnCode!=null) {
		model.addObject("itemName", getItemHsnCode.getItemName());
		model.addObject("itemHsn", getItemHsnCode.getHsncd());
		}
		model.addObject("date",new SimpleDateFormat("dd-MM-yyyy").format(new Date()));
		System.out.println("After print ");
		
		return model;
	}
	
	@RequestMapping(value = "/getSelectedIdForPrint", method = RequestMethod.GET)
	public void getSelectedIdForPrint(HttpServletRequest request, HttpServletResponse response)
	{
		
		System.out.println("IN Metjod");
		
		BillDetailList=new ArrayList<SellBillDetail>();
		String selectedId = request.getParameter("id");
		selectedId=selectedId.substring(1, selectedId.length()-1);
		selectedId=selectedId.replaceAll("\"", "");
	
		 
		 System.out.println("selectedId  "+selectedId);
		 
		List<String> selectedIdList = new ArrayList<>();
		System.out.println("sellBillDetailList  "+selectedSellBillDetailList.toString());
		selectedIdList=Arrays.asList(selectedId.split(","));
		for(int i=0;i<selectedSellBillDetailList.size();i++)
		{
			for(int j=0;j<selectedIdList.size();j++)
			{
				if(Integer.parseInt(selectedIdList.get(j))==selectedSellBillDetailList.get(i).getSellBillDetailNo())
				{
					System.out.println(i);
					BillDetailList.add(selectedSellBillDetailList.get(i));
				}
		}
		}
		
	}
	@RequestMapping(value = "/printSelectedOrder", method = RequestMethod.GET)
	public ModelAndView printSelectedOrder(HttpServletRequest request, HttpServletResponse response)
	{
		ModelAndView model = new ModelAndView("expressBill/frSelectedExBillPrint");
		System.out.println("IN Print Selected Order");
		 
		System.out.println("Selected List "+BillDetailList.toString());
		model.addObject("exBill",BillDetailList);
		 
		model.addObject("date",new SimpleDateFormat("dd-MM-yyyy").format(new Date()));
		System.out.println("After print ");
		
		return model;
	}
}
