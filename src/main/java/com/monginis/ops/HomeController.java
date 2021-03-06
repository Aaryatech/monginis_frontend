package com.monginis.ops;

import java.io.FileOutputStream;
import java.io.Serializable;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.TimeZone;
import java.util.stream.Collectors;

import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.monginis.ops.common.Common;
import com.monginis.ops.constant.Constant;
import com.monginis.ops.model.ConfiguredSpDayCkResponse;
import com.monginis.ops.model.DummyItems;
import com.monginis.ops.model.FrItemList;
import com.monginis.ops.model.FrLoginResponse;
import com.monginis.ops.model.FrMenu;
import com.monginis.ops.model.FrPurchaseDash;
import com.monginis.ops.model.FrTotalSale;
import com.monginis.ops.model.Franchisee;
import com.monginis.ops.model.GetConfiguredSpDayCk;
import com.monginis.ops.model.GetFrItem;
import com.monginis.ops.model.GetFrMenus;
import com.monginis.ops.model.LatestNewsResponse;
import com.monginis.ops.model.Menu;
import com.monginis.ops.model.Message;
import com.monginis.ops.model.MessageListResponse;
import com.monginis.ops.model.SchedulerList;

import java.io.BufferedOutputStream;
import java.io.File;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	private static final String UPLOAD_DIRECTORY = "/icons";

	/**
	 * Simply selects the home view to render by returning its name.
	 */
	RestTemplate restTemplate = new RestTemplate();

	@RequestMapping(value = "/time", method = RequestMethod.GET)
	public ModelAndView time() {

		FrPurchaseDash frData = null;
		RestTemplate restTemplate = new RestTemplate();
		ModelAndView model1 = new ModelAndView("homeold");
		try {
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM");
			Date date = new Date();
			System.out.println(dateFormat.format(date));

			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.MONTH, -1);
			System.out.println(dateFormat.format(cal.getTime()));

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("preMonth", dateFormat.format(date));
			map.add("curMonth", dateFormat.format(cal.getTime()));
			map.add("frId", 1);

			frData = restTemplate.postForObject(Constant.URL + "/getFrPurchaseReport", map, FrPurchaseDash.class);
			System.out.println("frDatafrDatafrDatafrDatafrDatafrData" + frData.toString());
			model1.addObject("frData", frData);
		} catch (Exception e3) {
			// TODO Auto-generated catch block
			e3.printStackTrace();
		}

		return model1;
	}

	@RequestMapping(value = "/showDashboardFranchisee", method = RequestMethod.GET)
	public ModelAndView showDashboardFranchisee(HttpServletRequest request, HttpServletResponse response) {

		FrPurchaseDash frData = null;
		RestTemplate restTemplate = new RestTemplate();
		ModelAndView model1 = new ModelAndView("homeold");
		try {

			Calendar now = Calendar.getInstance();
			HttpSession ses = request.getSession();
			Franchisee frDetails = (Franchisee) ses.getAttribute("frDetails");
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM");
			Date date = new Date();
			System.out.println(dateFormat.format(date));

			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.MONTH, -1);
			System.out.println(dateFormat.format(cal.getTime()));

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

			map.add("preMonth", dateFormat.format(cal.getTime()));
			map.add("curMonth", dateFormat.format(date));

			map.add("frId", frDetails.getFrId());

			frData = restTemplate.postForObject(Constant.URL + "/getFrPurchaseReport", map, FrPurchaseDash.class);

			DateFormat dateFormat1 = new SimpleDateFormat("MM-yyyy");

			model1.addObject("frommonth", dateFormat1.format(cal.getTime()));
			model1.addObject("tomonth", dateFormat1.format(date));
			model1.addObject("frId", frDetails.getFrId());

			/*
			 * float grnPrevTotal = 0; grnPrevTotal = frData.getPrevGrnTotal() * 100 / 75;
			 * 
			 * frData.setPrevGrnTotal(grnPrevTotal); float prevCompanyGrnContri = (float)
			 * (grnPrevTotal * (0.75)); float prevFrGrnContri = (float) (grnPrevTotal *
			 * (0.25)); frData.setPrevCompanyGrnContri(prevCompanyGrnContri);
			 * frData.setPrevFrGrnContribution(prevFrGrnContri);
			 * 
			 * float grnCurrTotal = 0; grnCurrTotal = frData.getCurGrnTotal() * 100 / 75;
			 * 
			 * System.out.println("grnCurrTotal" + grnCurrTotal);
			 * 
			 * frData.setCurGrnTotal(grnCurrTotal); float curCompanyGrnContri = (float)
			 * (grnCurrTotal * (0.75)); float curFrGrnContri = (float) (grnCurrTotal *
			 * (0.25)); frData.setCurFrGrnContribution(curFrGrnContri);
			 * frData.setCurCompanyGrnContri(curCompanyGrnContri);
			 * 
			 * float preActualTotal = 0; preActualTotal = (float)
			 * ((frData.getPrevPurchaseTotal() - frData.getPrevGrnTotal() -
			 * frData.getPrevGvnTotal()));
			 * 
			 * float currActualTotal = 0; currActualTotal = (float)
			 * ((frData.getCurPurchaseTotal() - frData.getCurGrnTotal() -
			 * frData.getCurGvnTotal()));
			 * 
			 * frData.setPrevActualTotal(preActualTotal);
			 * frData.setCurActualTotal(currActualTotal);
			 * 
			 * float expectedPrevActualTotal = 0; expectedPrevActualTotal = (preActualTotal
			 * * Constant.sale_per);
			 * 
			 * float expectedCurActualTotal = 0; expectedCurActualTotal = (currActualTotal *
			 * Constant.sale_per);
			 * 
			 * frData.setCurCompanyGvnContri(frData.getCurGvnTotal());
			 * frData.setPrevCompanyGvnContri(frData.getPrevGvnTotal());
			 * 
			 * frData.setExpectedPrevActualTotal(expectedPrevActualTotal);
			 * frData.setExpectedCurActualTotal(expectedCurActualTotal);
			 * 
			 * if (frData.getPrevPurchaseTotal() == 0) { frData.setPrevReturnPerGrn(0); }
			 * else {
			 * 
			 * frData.setPrevReturnPerGrn((prevFrGrnContri * 100) / preActualTotal); }
			 * 
			 * if (frData.getCurPurchaseTotal() == 0) { frData.setCurReturnPerGrn(0); } else
			 * {
			 * 
			 * frData.setCurReturnPerGrn((curFrGrnContri * 100) / currActualTotal); }
			 * 
			 * float calPre = (float) ((frData.getPrevActualTotal()) +
			 * frData.getPreSaleSpGrandTotal()); float calCur = (float)
			 * ((frData.getCurActualTotal()) + frData.getCurSaleSpGrandTotal());
			 * 
			 * frData.setCalPreSaleSpGrandTotal(calPre);
			 * frData.setCalCurSaleSpGrandTotal(calCur);
			 * 
			 * System.out.println("frDatafrDatafrDatafrDatafrDatafrData" +
			 * frData.toString()); model1.addObject("frData", frData);
			 */

		} catch (Exception e3) {
			// TODO Auto-generated catch block
			e3.printStackTrace();
		}

		return model1;
	}

	@RequestMapping(value = "/getDashboardCount", method = RequestMethod.GET)
	public @ResponseBody FrPurchaseDash getDashboardCount(HttpServletRequest request, HttpServletResponse response) {
		FrPurchaseDash frData = null;
		try {

			String preMonth = request.getParameter("fromDate");
			String curMonth = request.getParameter("toDate");

			Calendar now = Calendar.getInstance();
			HttpSession ses = request.getSession();
			Franchisee frDetails = (Franchisee) ses.getAttribute("frDetails");
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM");
			DateFormat dateFormat1 = new SimpleDateFormat("MM-yyyy");
			Date date = new Date();
			System.out.println(dateFormat.format(date));

			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.MONTH, -1);
			System.out.println(dateFormat.format(cal.getTime()));
			String forPreMonth = null;
			String forCurMonth = null;
			try {
				Date formattedPreMonth = dateFormat1.parse(preMonth);
				Date formattedCurMonth = dateFormat1.parse(curMonth);

				forPreMonth = dateFormat.format(formattedPreMonth);

				forCurMonth = dateFormat.format(formattedCurMonth);

			} catch (Exception e) {
				e.printStackTrace();
				// TODO: handle exception
			}

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("preMonth", forPreMonth);
			map.add("curMonth", forCurMonth);
			map.add("frId", frDetails.getFrId());

			frData = restTemplate.postForObject(Constant.URL + "/getFrPurchaseReport", map, FrPurchaseDash.class);

			float grnPrevTotal = 0;
			grnPrevTotal = frData.getPrevGrnTotal() * 100 / 75;

			frData.setPrevGrnTotal(grnPrevTotal);
			float prevCompanyGrnContri = (float) (grnPrevTotal * (0.75));
			float prevFrGrnContri = (float) (grnPrevTotal * (0.25));
			frData.setPrevCompanyGrnContri(prevCompanyGrnContri);
			frData.setPrevFrGrnContribution(prevFrGrnContri);

			float grnCurrTotal = 0;
			grnCurrTotal = frData.getCurGrnTotal() * 100 / 75;

			System.out.println("grnCurrTotal" + grnCurrTotal);

			frData.setCurGrnTotal(grnCurrTotal);
			float curCompanyGrnContri = (float) (grnCurrTotal * (0.75));
			float curFrGrnContri = (float) (grnCurrTotal * (0.25));
			frData.setCurFrGrnContribution(curFrGrnContri);
			frData.setCurCompanyGrnContri(curCompanyGrnContri);

			float preActualTotal = 0;
			preActualTotal = (float) ((frData.getPrevPurchaseTotal() - frData.getPrevGrnTotal()
					- frData.getPrevGvnTotal()));

			float currActualTotal = 0;
			currActualTotal = (float) ((frData.getCurPurchaseTotal() - frData.getCurGrnTotal()
					- frData.getCurGvnTotal()));

			frData.setPrevActualTotal(preActualTotal);
			frData.setCurActualTotal(currActualTotal);

			float expectedPrevActualTotal = 0;
			expectedPrevActualTotal = (preActualTotal * Constant.sale_per);

			float expectedCurActualTotal = 0;
			expectedCurActualTotal = (currActualTotal * Constant.sale_per);

			frData.setCurCompanyGvnContri(frData.getCurGvnTotal());
			frData.setPrevCompanyGvnContri(frData.getPrevGvnTotal());

			frData.setExpectedPrevActualTotal(expectedPrevActualTotal);
			frData.setExpectedCurActualTotal(expectedCurActualTotal);

			if (frData.getPrevPurchaseTotal() == 0) {
				frData.setPrevReturnPerGrn(0);
			} else {

				frData.setPrevReturnPerGrn((prevFrGrnContri * 100) / preActualTotal);
			}

			if (frData.getCurPurchaseTotal() == 0) {
				frData.setCurReturnPerGrn(0);
			} else {

				frData.setCurReturnPerGrn((curFrGrnContri * 100) / currActualTotal);
			}

			float calPre = (float) ((frData.getPrevActualTotal()) + frData.getPreSaleSpGrandTotal());
			float calCur = (float) ((frData.getCurActualTotal()) + frData.getCurSaleSpGrandTotal());

			frData.setCalPreSaleSpGrandTotal(calPre);
			frData.setCalCurSaleSpGrandTotal(calCur);

			System.out.println("ajaxxxxxxxxxx" + frData.toString());

			SimpleDateFormat parser = new SimpleDateFormat("MM-yyyy");

			SimpleDateFormat formatter = new SimpleDateFormat("MMM-yyyy");

			try {
				String fromMonth = formatter.format(parser.parse(preMonth));

				String toMonth = formatter.format(parser.parse(curMonth));
				frData.setCurMonthName(toMonth);
				frData.setPrevMonthName(fromMonth);
			} catch (ParseException e) {

				e.printStackTrace();
			}

			System.out.println("In AJAXXXXXXXXXXXXXXXXXXXXXXXXXX" + frData.toString());

		} catch (Exception e) {
			// TODO: handle exception
		}

		return frData;
	}

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView displayLogin(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("login");

		logger.info("/login request mapping.");

		return model;

	}

	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public ModelAndView displayHome(HttpServletRequest request, HttpServletResponse response) throws ParseException {

		ModelAndView model = new ModelAndView("home");
		HttpSession session = request.getSession();
		RestTemplate restTemplate = new RestTemplate();
		try {
			ArrayList<SchedulerList> schedulerLists = (ArrayList<SchedulerList>) session.getAttribute("schedulerLists");
			ArrayList<Message> msgList = (ArrayList<Message>) session.getAttribute("msgList");
			int frId = (Integer) session.getAttribute("frId");

			System.out.println("***************Schedular List*****************" + schedulerLists);
			System.out.println("***************msgList*****************" + msgList);
			System.out.println("***************frId*****************" + frId);

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

			map.add("frId", frId);

			ConfiguredSpDayCkResponse configuredSpDayCkRes = restTemplate
					.postForObject(Constant.URL + "/getSpDayCkList", map, ConfiguredSpDayCkResponse.class);

			List<GetConfiguredSpDayCk> configureSpDayFrList = new ArrayList<GetConfiguredSpDayCk>();

			configureSpDayFrList = configuredSpDayCkRes.getConfiguredSpDayCkList();

			List<GetConfiguredSpDayCk> configureSpDayCk = new ArrayList<GetConfiguredSpDayCk>();

			boolean flag = false, spDayShow = false;
			int count = 0;

			for (GetConfiguredSpDayCk getConfSpDayCk : configureSpDayFrList) {

				DateFormat dmyFormat = new SimpleDateFormat("dd-MM-yyyy");
				Date startDate;

				startDate = dmyFormat.parse(getConfSpDayCk.getOrderFromDate());
				System.out.println("startDate" + startDate);

				Date endDate = dmyFormat.parse(getConfSpDayCk.getOrderToDate());
				System.out.println("endDate" + endDate);

				String todaysDate = LocalDateTime.now().format(DateTimeFormatter.ofPattern("dd-MM-yyyy"));
				Date dateToCheck = dmyFormat.parse(todaysDate);

				System.out.println("dateToCheck" + dateToCheck);

				flag = checkBetween(dateToCheck, startDate, endDate);
				System.out.println("ShowSpDayCk:" + flag);

				if (flag == true) {
					count = count + 1;
					configureSpDayCk.add(getConfSpDayCk);
					System.out.println("Configure SpDay Cake To And From Date: " + configureSpDayCk.toString());
				}

			}

			if (count > 0) {
				spDayShow = true;
			}
			session.setAttribute("isSpDayShow", spDayShow);
			System.out.println("isSpDayShow" + spDayShow);

			model.addObject("configureSpDayFrList", configureSpDayCk);

			model.addObject("schedulerLists", schedulerLists);
			model.addObject("msgList", msgList);
			model.addObject("url", Constant.MESSAGE_IMAGE_URL);
			model.addObject("isSpDayShow", spDayShow);

			logger.info("/login request mapping.");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return model;

	}

	private boolean checkBetween(Date dateToCheck, Date startDate, Date endDate) {
		return dateToCheck.compareTo(startDate) >= 0 && dateToCheck.compareTo(endDate) <= 0;

	}

	@RequestMapping(value = "/showforgotpassword", method = RequestMethod.GET)
	public ModelAndView displayForgotPassword(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("forgotpassword");

		logger.info("/forgot Password request mapping.");

		return model;

	}

	@RequestMapping(value = "savefile", method = RequestMethod.POST)
	public ModelAndView saveimage(@RequestParam CommonsMultipartFile file, HttpSession session) throws Exception {
		try {
			ServletContext context = session.getServletContext();
			String path = context.getRealPath(UPLOAD_DIRECTORY);
			String filename = file.getOriginalFilename();

			System.out.println(path + " " + filename);

			byte[] bytes = file.getBytes();
			BufferedOutputStream stream = new BufferedOutputStream(
					new FileOutputStream(new File(path + File.separator + filename)));
			stream.write(bytes);
			stream.flush();
			stream.close();

		} catch (Exception e) {
			System.out.println("File uplaod exception " + e.getMessage());
		}

		return new ModelAndView("uploadform", "filesuccess", "File successfully saved!");
	}

	@RequestMapping(value = "/loginProcess", method = RequestMethod.POST)
	public ModelAndView displayHomePage(HttpSession ses, HttpServletRequest request, HttpServletResponse response)
			throws ParseException {

		logger.info("/loginProcess request mapping.");

		ModelAndView model = new ModelAndView("login");

		HttpSession session = request.getSession();

		String frCode = request.getParameter("username");
		String frPassword = request.getParameter("password");

		// fr login
		MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
		map.add("frCode", frCode);
		map.add("frPasswordKey", frPassword);

		RestTemplate restTemplate = new RestTemplate();

		FrLoginResponse loginResponse = restTemplate.postForObject(Constant.URL + "/loginFr", map,
				FrLoginResponse.class);

		System.out.println("Login Response " + loginResponse.toString());

		if (loginResponse.getLoginInfo().isError()) {

			model.addObject("message", loginResponse.getLoginInfo().getMessage());

		} else {

			// getting fr menus
			MultiValueMap<String, Object> menuMap = new LinkedMultiValueMap<String, Object>();
			menuMap.add("frId", loginResponse.getFranchisee().getFrId());

			GetFrMenus getFrMenus = restTemplate.postForObject(Constant.URL + "/getFrConfigMenus", menuMap,
					GetFrMenus.class);

			System.out.println("Get Fr Menus Response " + getFrMenus.toString());

			// filter fr menus

			List<FrMenu> frMenuList = getFrMenus.getFrMenus();
			List<FrMenu> filteredFrMenuList = new ArrayList<>();

			Calendar calendar = Calendar.getInstance(TimeZone.getTimeZone("Asia/Calcutta"));
			Date date = calendar.getTime();
			DateFormat df = new SimpleDateFormat("dd-MM-yyyy");
			String currentDate = df.format(date);
			int dayOfWeek = calendar.get(Calendar.DAY_OF_WEEK);

			System.out.println("Today date " + currentDate);
			System.out.println("Day of week " + dayOfWeek);

			for (int i = 0; i < frMenuList.size(); i++) {

				FrMenu frMenu = frMenuList.get(i);

				if (frMenu.getSettingType() == 3) { // day basis
					List<String> dayList = Arrays.asList(frMenu.getDay().split(","));

					List<Integer> newDayList = dayList.stream().map(s -> Integer.parseInt(s))
							.collect(Collectors.toList());

					for (int k = 0; k < newDayList.size(); k++) {
						if (newDayList.get(k) == dayOfWeek) {

							filteredFrMenuList.add(frMenu);

						}
					}

				} else if (frMenu.getSettingType() == 2) { // date basis

					List<String> dateList = Arrays.asList(frMenu.getDate().split(","));
					List<Integer> newDateList = dateList.stream().map(s -> Integer.parseInt(s))
							.collect(Collectors.toList());

					for (int k = 0; k < newDateList.size(); k++) {
						if (newDateList.get(k) == calendar.get(Calendar.DAY_OF_MONTH)) {

							filteredFrMenuList.add(frMenu);

						}
					}
				} else if (frMenu.getSettingType() == 1) { // daily basis

					filteredFrMenuList.add(frMenu);

				}

			}

			System.out.println("Fr is: " + loginResponse.getFranchisee().toString());

			System.out.println("filteredFrMenuList is: " + filteredFrMenuList.toString());

			// Getting news and messages

			LatestNewsResponse latestNewsResponse = restTemplate.getForObject(Constant.URL + "/showLatestNews",
					LatestNewsResponse.class);
			List<SchedulerList> schedulerLists = new ArrayList<SchedulerList>();
			schedulerLists = latestNewsResponse.getSchedulerList();
			System.out.println("latest news  list " + schedulerLists.toString());

			// sachin 9 sept showFrontEndMessage

			MessageListResponse messageListResponse = restTemplate.getForObject(Constant.URL + "/showFrontEndMessage",
					MessageListResponse.class);
			List<Message> msgList = new ArrayList<Message>();
			msgList = messageListResponse.getMessage();
			System.out.println("messages are " + msgList.toString());

			// Managing session
			session.setAttribute("menuList", filteredFrMenuList);
			session.setAttribute("allMenuList", frMenuList);

			session.setAttribute("frDetails", loginResponse.getFranchisee());
			session.setAttribute("loginInfo", loginResponse.getLoginInfo());
			session.setAttribute("msgList", msgList);
			session.setAttribute("schedulerLists", schedulerLists);
			session.setAttribute("frId", loginResponse.getFranchisee().getFrId());
			session.setAttribute("info", loginResponse.getLoginInfo());
			session.setAttribute("frImage", loginResponse.getFranchisee().getFrImage());
			loginResponse.getFranchisee()
					.setFrImage(Constant.FR_IMAGE_URL + loginResponse.getFranchisee().getFrImage());

			// ---------------------------------Special Day Show Button
			// Logic-------------------------------------------

			MultiValueMap<String, Object> mvm = new LinkedMultiValueMap<String, Object>();

			map.add("frId", loginResponse.getFranchisee().getFrId());

			ConfiguredSpDayCkResponse configuredSpDayCkRes = restTemplate
					.postForObject(Constant.URL + "/getSpDayCkList", map, ConfiguredSpDayCkResponse.class);

			List<GetConfiguredSpDayCk> configureSpDayFrList = new ArrayList<GetConfiguredSpDayCk>();

			configureSpDayFrList = configuredSpDayCkRes.getConfiguredSpDayCkList();

			boolean flag = false, spDayShow = false;
			int count = 0;

			for (GetConfiguredSpDayCk getConfSpDayCk : configureSpDayFrList) {

				DateFormat dmyFormat = new SimpleDateFormat("dd-MM-yyyy");
				Date startDate;

				startDate = dmyFormat.parse(getConfSpDayCk.getOrderFromDate());
				System.out.println("startDate" + startDate);

				Date endDate = dmyFormat.parse(getConfSpDayCk.getOrderToDate());
				System.out.println("endDate" + endDate);

				String todaysDate = LocalDateTime.now().format(DateTimeFormatter.ofPattern("dd-MM-yyyy"));
				Date dateToCheck = dmyFormat.parse(todaysDate);

				System.out.println("dateToCheck" + dateToCheck);

				flag = checkBetween(dateToCheck, startDate, endDate);
				System.out.println("ShowSpDayCk:" + flag);

				if (flag == true) {
					count = count + 1;
				}

			}

			if (count > 0) {
				spDayShow = true;
			}
			// -------------------------------------------------------------------------------------------

			session.setAttribute("isSpDayShow", spDayShow);

			map = new LinkedMultiValueMap<String, Object>();
			map.add("frId", loginResponse.getFranchisee().getFrId());
			int month = calendar.get(Calendar.MONTH) + 1;
			map.add("month", month);
			System.out.println("Curr Month " + month);
			map.add("year", calendar.get(Calendar.YEAR));
			System.out.println("Curr Year" + calendar.get(Calendar.YEAR));
			FrTotalSale frTotalSale = restTemplate.postForObject(Constant.URL + "/getFrTotalSale", map,
					FrTotalSale.class);
			System.out.println("Get Fr Total Sale  " + frTotalSale.toString());
			float achievedTarget = 0;

			if (frTotalSale != null) {
				achievedTarget = frTotalSale.getTotalSale();
			}
			session.setAttribute("achievedTarget", achievedTarget);
			session.setAttribute("fraTarget", frTotalSale.getTargetAmt());

			model = new ModelAndView("home");
			System.out.println("fr Image URL " + loginResponse.getFranchisee().getFrImage());
			model.addObject("schedulerLists", schedulerLists);
			model.addObject("msgList", msgList);
			model.addObject("isSpDayShow", spDayShow);
			model.addObject("menuList", filteredFrMenuList);
			model.addObject("frDetails", loginResponse.getFranchisee());
			model.addObject("url", Constant.MESSAGE_IMAGE_URL);
			model.addObject("info", loginResponse.getLoginInfo());
		}
		return model;

	}

	@RequestMapping(value = "/logout")
	public ModelAndView logout(HttpSession session, HttpServletRequest req, HttpServletResponse res) {
		System.out.println("Logout Controller User Logout");
		ModelAndView model = new ModelAndView("login");
		HttpServletResponse response = (HttpServletResponse) res;

		response.setHeader("Cache-Control", "no-cache");
		response.setHeader("Pragma", "no-cache");
		response.setDateHeader("Expires", -1);

		session.removeAttribute("frId");

		session.removeAttribute("frDetails");
		session.invalidate();
		session.setMaxInactiveInterval(0);

		System.out.println("session ID  after expire " + session.getId());

		// session.invalidate();

		return model;
		// return "redirect:/";
	}

}
