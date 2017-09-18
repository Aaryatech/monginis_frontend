package com.monginis.ops;

import java.io.FileOutputStream;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.ServletContext;
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
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.monginis.ops.common.Common;
import com.monginis.ops.constant.Constant;
import com.monginis.ops.model.DummyItems;
import com.monginis.ops.model.FrItemList;
import com.monginis.ops.model.FrLoginResponse;
import com.monginis.ops.model.FrMenu;
import com.monginis.ops.model.GetFrItem;
import com.monginis.ops.model.GetFrMenus;
import com.monginis.ops.model.LatestNewsResponse;
import com.monginis.ops.model.Menu;
import com.monginis.ops.model.Message;
import com.monginis.ops.model.MessageListResponse;
import com.monginis.ops.model.SchedulerList;

import java.io.BufferedOutputStream;
import java.io.File;
import java.time.LocalTime;
import java.time.ZoneId;

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
	@RequestMapping(value = "/time", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);

		String StartTimes = "10:00";
		String EndTimes = "12:00";
		
		String startTimeParse[] = StartTimes.split(":");
		String endTimeParse[] = EndTimes.split(":");
		
		int firstHour = Integer.parseInt(startTimeParse[0]);
		int firstMinute = Integer.parseInt(startTimeParse[1]);
		int secondHour = Integer.parseInt(endTimeParse[0]);
		int secondMinute = Integer.parseInt(endTimeParse[1]);
		int durattionHour = secondHour - firstHour;
		int durattionMinutes = secondMinute - firstMinute;
		
		System.out.println("Duration : " + durattionHour + ":" + durattionMinutes);

		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);

		String formattedDate = dateFormat.format(date);

		model.addAttribute("serverTime", formattedDate);

		return "homeold";
	}

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView displayLogin(HttpServletRequest request, HttpServletResponse response) {
		
		ModelAndView model = new ModelAndView("login");
		
		logger.info("/login request mapping.");

		return model;

	}
	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public ModelAndView displayHome(HttpServletRequest request, HttpServletResponse response) {
		
		ModelAndView model = new ModelAndView("home");
		
		logger.info("/login request mapping.");

		return model;

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
	public ModelAndView displayHomePage(HttpServletRequest request, HttpServletResponse response) {
	
		logger.info("/loginProcess request mapping.");

		ModelAndView model = new ModelAndView("login");

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

		if (loginResponse.getErrorMessage().getError()) {

			model.addObject("message", loginResponse.getErrorMessage().getMessage());

		} else {
	

			// getting fr menus
			MultiValueMap<String, Object> menuMap = new LinkedMultiValueMap<String, Object>();
			menuMap.add("frId", loginResponse.getFranchisee().getFrId());

			GetFrMenus getFrMenus = restTemplate.postForObject(Constant.URL + "/getFrConfigMenus", menuMap,
					GetFrMenus.class);

			System.out.println("Get Fr Menus Response " + getFrMenus.toString());

			// converting 24 hr time to 12 hr
			for (int i = 0; i < getFrMenus.getFrMenus().size(); i++) {
				final String time = getFrMenus.getFrMenus().get(i).getToTime();

				try {
					final SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss a");
					final Date dateObj = sdf.parse(time + " PM");

					String strTime = new SimpleDateFormat("K:mm a").format(dateObj);

					System.out.println(dateObj);
					System.out.println(strTime);
					
					getFrMenus.getFrMenus().get(i).setTime(strTime);

				} catch (final ParseException e) {
					e.printStackTrace();
				}

			}
			
			
			// Getting news and messages
		
			 LatestNewsResponse latestNewsResponse=restTemplate.getForObject( Constant.URL+"/showLatestNews",LatestNewsResponse.class);
		        List<SchedulerList> schedulerLists=new ArrayList<SchedulerList>();
		        schedulerLists=latestNewsResponse.getSchedulerList();
		        System.out.println("latest news  list "+schedulerLists.toString());
		        
		        //sachin 9 sept showFrontEndMessage
		        
		        MessageListResponse messageListResponse=restTemplate.getForObject( Constant.URL+"/showFrontEndMessage", 
		                MessageListResponse.class);
		        List<Message> msgList=new ArrayList<Message>();
		        msgList=messageListResponse.getMessage();
		        System.out.println("messages are " +msgList.toString());
		        
			

			// Managing session
			HttpSession session = request.getSession();
			session.setAttribute("menuList", getFrMenus.getFrMenus());
			session.setAttribute("frDetails", loginResponse.getFranchisee());
			
			model = new ModelAndView("home");

	        model.addObject("schedulerLists",schedulerLists);
			model.addObject("msgList",msgList);
			model.addObject("menuList", getFrMenus.getFrMenus());
			model.addObject("frDetails", loginResponse.getFranchisee());	
			model.addObject("url",Constant.MESSAGE_IMAGE_URL);
		}
		return model;

	}
	

	@RequestMapping(value = "/logout")
	  public String logout(HttpSession session) {
		  System.out.println("Logout Controller User Logout");
	    session.invalidate();
	    return "redirect:/";
	  }
	

}
