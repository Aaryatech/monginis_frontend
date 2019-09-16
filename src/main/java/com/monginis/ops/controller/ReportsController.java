package com.monginis.ops.controller;

import java.awt.Dimension;

import java.awt.Insets;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.math.BigDecimal;
import java.net.URLConnection;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.YearMonth;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.annotation.Scope;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;
import org.zefer.pd4ml.PD4Constants;
import org.zefer.pd4ml.PD4ML;
import org.zefer.pd4ml.PD4PageMark;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.Font.FontFamily;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import com.monginis.ops.common.DateConvertor;
import com.monginis.ops.constant.Constant;
import com.monginis.ops.model.BillWisePurchaseList;
import com.monginis.ops.model.BillWisePurchaseReport;
import com.monginis.ops.model.BillWiseTaxReport;
import com.monginis.ops.model.BillWiseTaxReportList;
import com.monginis.ops.model.CategoryList;
import com.monginis.ops.model.ExportToExcel;
import com.monginis.ops.model.Franchisee;

import com.monginis.ops.model.GetRepFrDatewiseSellResponse;
import com.monginis.ops.model.GetRepFrItemwiseSellResponse;
import com.monginis.ops.model.GetRepMenuwiseSellResponse;
import com.monginis.ops.model.GetRepTaxSell;
import com.monginis.ops.model.GetSellBillHeader;
import com.monginis.ops.model.ItemWiseDetail;
import com.monginis.ops.model.ItemWiseDetailList;
import com.monginis.ops.model.ItemWiseReport;
import com.monginis.ops.model.ItemWiseReportList;
import com.monginis.ops.model.MCategory;
import com.monginis.ops.model.Main;
import com.monginis.ops.model.MonthWiseReport;
import com.monginis.ops.model.MonthWiseReportList;
import com.monginis.ops.model.Tax1Report;
import com.monginis.ops.model.grngvn.GrnGvnHeader;
import com.monginis.ops.model.reportv2.CrNoteRegItem;
import com.monginis.ops.model.reportv2.CrNoteRegSp;
import com.monginis.ops.model.reportv2.CrNoteRegisterList;
import com.monginis.ops.model.spadvreport.GetSpAdvTaxReport;
import com.monginis.ops.model.spadvreport.GetSpAdvTaxReportList;
import com.monginis.ops.model.spadvreport.GetSpAdvanceReport;
import com.monginis.ops.model.spadvreport.GetSpAdvanceReportList;
import com.monginis.ops.model.spadvreport.RegCakeAsSpOrderReport;
import com.monginis.ops.util.ItextPageEvent;

@Controller
@Scope("session")
public class ReportsController {
	public static float roundUp(float d) {
		return BigDecimal.valueOf(d).setScale(2, BigDecimal.ROUND_HALF_UP).floatValue();
	}

	public List<GetRepTaxSell> getRepTaxSell;
	public List<GetRepFrDatewiseSellResponse> getRepFrDatewiseSellResponse;
	public List<GetSellBillHeader> getSellBillHeaderList;
	// List<GetRepFrDatewiseSellResponse> getRepFrDatewiseSellResponse;
	public List<GetRepMenuwiseSellResponse> getRepFrMenuwiseSellResponseList;
	public List<GetRepFrItemwiseSellResponse> getRepFrItemwiseSellResponseList;
	// List<GetRepFrItemwiseSellResponse> getRepFrItemwiseSellResponseList;
	// List<GetRepFrItemwiseSellResponse> getRepFrItemwiseSellResponseList;
	public List<BillWisePurchaseReport> billWisePurchaseReportList;
	public List<ItemWiseDetail> itemWiseDetailReportList;
	public List<ItemWiseReport> itemWiseReportList;
	public List<BillWiseTaxReport> billWiseTaxReport;
	public List<MonthWiseReport> monthWiseReportList;
	public int frGstType = 0;

	// 28 May Reg cake As sp Order report:
	@RequestMapping(value = "/showRegCakeAsSpOrRep", method = RequestMethod.GET)
	public ModelAndView showRegCakeAsSpOrRep(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("report/regcakeassp");
		try {
			HttpSession ses = request.getSession();
			Franchisee frDetails = (Franchisee) ses.getAttribute("frDetails");
			model.addObject("frId", frDetails.getFrId());
		} catch (Exception e) {
			e.printStackTrace();

		}
		return model;
	}

	List<RegCakeAsSpOrderReport> regCakeSpList;

	@RequestMapping(value = "/getRegCakeAsSpOrder", method = RequestMethod.GET)
	public @ResponseBody List<RegCakeAsSpOrderReport> getRegCakeAsSpOrder(HttpServletRequest request,
			HttpServletResponse response) {
		// ModelAndView modelAndView = new ModelAndView("grngvn/displaygrn");
		advList = new ArrayList<>();
		try {
			System.out.println("in method /getRegCakeAsSpOrder");
			String fromDate = request.getParameter("fromDate");
			String toDate = request.getParameter("toDate");
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
			HttpSession ses = request.getSession();
			Franchisee frDetails = (Franchisee) ses.getAttribute("frDetails");
			RestTemplate restTemplate = new RestTemplate();
			System.err.println("from " + fromDate + "toDate " + toDate);

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			int frId = frDetails.getFrId();
			map.add("fromDate", DateConvertor.convertToYMD(fromDate));

			map.add("toDate", DateConvertor.convertToYMD(toDate));

			map.add("frId", frId);

			RegCakeAsSpOrderReport[] regCakesSp = restTemplate
					.postForObject(Constant.URL + "/getRegCakeAsSpOrderReport", map, RegCakeAsSpOrderReport[].class);
			regCakeSpList = new ArrayList<>(Arrays.asList(regCakesSp));

			System.err.println("regCakesSp List " + regCakesSp.toString());

		} catch (Exception e) {

			System.err.println("Ex in gettting regCakesSp list " + e.getMessage());

			e.printStackTrace();

		}
		return regCakeSpList;

	}

	@RequestMapping(value = "/getRegCakeAsSpOrderPdf", method = RequestMethod.GET)
	public void getRegCakeAsSpOrderPdf(HttpServletRequest request, HttpServletResponse response) {

		BufferedOutputStream outStream = null;
		System.out.println("Inside Pdf prod From Order Or Plan");

		// regCakeSpList = pdfTypeList;
		Document document = new Document(PageSize.A4, 20, 20, 150, 30);
		// ByteArrayOutputStream out = new ByteArrayOutputStream();

		DateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
		Calendar cal = Calendar.getInstance();

		System.out.println("time in getRegCakeAsSpOrderPdf PDF ==" + dateFormat.format(cal.getTime()));
		String timeStamp = dateFormat.format(cal.getTime());
		String FILE_PATH = Constant.REPORT_SAVE;
		File file = new File(FILE_PATH);

		PdfWriter writer = null;

		FileOutputStream out = null;
		try {
			out = new FileOutputStream(FILE_PATH);
		} catch (FileNotFoundException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}
		try {

			HttpSession ses = request.getSession();
			Franchisee frDetails = (Franchisee) ses.getAttribute("frDetails");

			String header = frDetails.getFrName();

			String title = "Report-For Special Cake As Regular Order ";

			DateFormat DF = new SimpleDateFormat("dd-MM-yyyy");
			String reportDate = DF.format(new java.util.Date());

			writer = PdfWriter.getInstance(document, out);

			ItextPageEvent event = new ItextPageEvent(header, title, reportDate);

			writer.setPageEvent(event);

		} catch (DocumentException e) {

			e.printStackTrace();
		}

		PdfPTable table = new PdfPTable(7);
		try {
			System.out.println("Inside PDF Table try /getRegCakeAsSpOrderPdf");
			table.setWidthPercentage(100);
			table.setWidths(new float[] { 0.4f, 1.7f, 0.9f, 1.0f, 0.9f, 0.9f, 0.9f });
			Font headFont = new Font(FontFamily.TIMES_ROMAN, 12, Font.NORMAL, BaseColor.BLACK);
			Font headFont1 = new Font(FontFamily.HELVETICA, 10, Font.BOLD, BaseColor.BLACK);
			Font f = new Font(FontFamily.TIMES_ROMAN, 12.0f, Font.UNDERLINE, BaseColor.BLUE);

			PdfPCell hcell = new PdfPCell();
			hcell.setBackgroundColor(BaseColor.LIGHT_GRAY);
			hcell.setPadding(4);
			hcell = new PdfPCell(new Phrase("Sr No", headFont1));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Item  Name", headFont1));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("SubCategory", headFont1));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Mrp", headFont1));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Quantity", headFont1));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Sub Total", headFont1));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Customer", headFont1));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(hcell);

			int index = 0;
			for (RegCakeAsSpOrderReport regCakeSp : regCakeSpList) {
				index++;
				PdfPCell cell;

				cell = new PdfPCell(new Phrase(String.valueOf(index), headFont));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_CENTER);
				cell.setPadding(4);
				table.addCell(cell);

				cell = new PdfPCell(new Phrase(regCakeSp.getItemName(), headFont));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);
				cell.setPaddingRight(2);
				cell.setPadding(4);
				table.addCell(cell);

				cell = new PdfPCell(new Phrase(regCakeSp.getSubCatName(), headFont));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_CENTER);
				cell.setPaddingRight(2);
				cell.setPadding(4);
				table.addCell(cell);

				cell = new PdfPCell(new Phrase(String.valueOf(regCakeSp.getMrp()), headFont));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_CENTER);
				cell.setPaddingRight(2);
				cell.setPadding(4);
				table.addCell(cell);

				cell = new PdfPCell(new Phrase(String.valueOf(regCakeSp.getQty()), headFont));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_CENTER);
				cell.setPaddingRight(2);
				cell.setPadding(4);
				table.addCell(cell);

				cell = new PdfPCell(new Phrase(String.valueOf(regCakeSp.getRspSubTotal()), headFont));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_CENTER);
				cell.setPaddingRight(2);
				cell.setPadding(4);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + regCakeSp.getRspCustName(), headFont));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_CENTER);
				cell.setPaddingRight(2);
				cell.setPadding(4);
				table.addCell(cell);
				// FooterTable footerEvent = new FooterTable(table);
				// writer.setPageEvent(footerEvent);
			}
			document.open();
			document.add(table);
			document.close();

			if (file != null) {

				String mimeType = URLConnection.guessContentTypeFromName(file.getName());

				if (mimeType == null) {

					mimeType = "application/pdf";

				}

				response.setContentType(mimeType);

				response.addHeader("content-disposition", String.format("inline; filename=\"%s\"", file.getName()));

				response.setContentLength((int) file.length());

				InputStream inputStream = null;
				try {
					inputStream = new BufferedInputStream(new FileInputStream(file));
				} catch (FileNotFoundException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}

				try {
					FileCopyUtils.copy(inputStream, response.getOutputStream());
				} catch (IOException e) {
					System.out.println("Excep in Opening a Pdf File");
					e.printStackTrace();
				}
			}

		} catch (DocumentException ex) {

			System.out.println("Pdf Generation Error: BOm Prod  View Prod" + ex.getMessage());

			ex.printStackTrace();

		}
	}

	@RequestMapping(value = "/showSpAdvanceReport", method = RequestMethod.GET)
	public ModelAndView showSpAdvanceReport(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("report/spadvance");
		try {
			HttpSession ses = request.getSession();
			Franchisee frDetails = (Franchisee) ses.getAttribute("frDetails");
			model.addObject("frId", frDetails.getFrId());
		} catch (Exception e) {
			e.printStackTrace();

		}
		return model;
	}

	List<GetSpAdvanceReport> advList = new ArrayList<>();

	@RequestMapping(value = "/getSpAdvance", method = RequestMethod.GET)
	public @ResponseBody List<GetSpAdvanceReport> getGvnHeaderList(HttpServletRequest request,
			HttpServletResponse response) {
		// ModelAndView modelAndView = new ModelAndView("grngvn/displaygrn");
		advList = new ArrayList<>();
		try {
			System.out.println("in method /getSpAdvance");
			String fromDate = request.getParameter("fromDate");
			String toDate = request.getParameter("toDate");
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
			HttpSession ses = request.getSession();
			Franchisee frDetails = (Franchisee) ses.getAttribute("frDetails");
			RestTemplate restTemplate = new RestTemplate();
			System.err.println("from " + fromDate + "toDate " + toDate);

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			int frId = frDetails.getFrId();
			map.add("fromDate", DateConvertor.convertToYMD(fromDate));

			map.add("toDate", DateConvertor.convertToYMD(toDate));

			map.add("frId", frId);

			GetSpAdvanceReportList spAdv = restTemplate.postForObject(Constant.URL + "spProduction/getSpAdvanceReport",
					map, GetSpAdvanceReportList.class);
			advList = spAdv.getSpAdvanceReport();

			System.err.println("Adv List " + spAdv.toString());
		} catch (Exception e) {
			System.err.println("Ex in gettting sp adv list " + e.getMessage());
			e.printStackTrace();
		}
		return advList;

	}

	@RequestMapping(value = "/getSpAdvPdf", method = RequestMethod.GET)
	public void advList(HttpServletRequest request, HttpServletResponse response) {

		Document doc = new Document();

		String FILE_PATH = Constant.REPORT_SAVE;
		File file = new File(FILE_PATH);

		PdfWriter writer = null;

		FileOutputStream out = null;
		try {
			out = new FileOutputStream(FILE_PATH);
		} catch (FileNotFoundException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		try {
			writer = PdfWriter.getInstance(doc, out);
		} catch (DocumentException e) {

			e.printStackTrace();
		}

		PdfPTable table = new PdfPTable(6);
		try {
			System.out.println("Inside PDF Table try");
			table.setWidthPercentage(100);
			table.setWidths(new float[] { 0.5f, 1.8f, 1.8f, 1.2f, 1.0f, 1.2f });
			Font headFont = new Font(FontFamily.HELVETICA, 8, Font.NORMAL, BaseColor.BLACK);
			Font headFont1 = new Font(FontFamily.HELVETICA, 8, Font.BOLD, BaseColor.BLACK);
			Font f = new Font(FontFamily.TIMES_ROMAN, 12.0f, Font.UNDERLINE, BaseColor.BLUE);

			PdfPCell hcell;
			hcell = new PdfPCell(new Phrase("Sr.No.", headFont1));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Customer Name", headFont1));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Item Name", headFont1));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Order Date", headFont1));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Mrp", headFont1));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Advance Amt", headFont1));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(hcell);

			int index = 0;

			float advAmt = 0;
			
			System.err.println("ADV SP -------------------------- "+advList);
			
			for (GetSpAdvanceReport advance : advList) {
				index++;
				PdfPCell cell;

				cell = new PdfPCell(new Phrase(String.valueOf(index), headFont));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_CENTER);
				table.addCell(cell);

				cell = new PdfPCell(new Phrase(advance.getCustName(), headFont));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);
				cell.setPaddingRight(5);
				table.addCell(cell);

				cell = new PdfPCell(new Phrase(String.valueOf(advance.getItemName()), headFont));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);
				cell.setPaddingRight(5);
				table.addCell(cell);

				cell = new PdfPCell(new Phrase(String.valueOf(advance.getOrderDate()), headFont));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_CENTER);
				cell.setPaddingRight(5);
				table.addCell(cell);

				cell = new PdfPCell(new Phrase(String.valueOf(advance.getTotalMrp()), headFont));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
				cell.setPaddingRight(5);
				table.addCell(cell);

				cell = new PdfPCell(new Phrase(String.valueOf(advance.getAdvAmt()), headFont));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
				cell.setPaddingRight(5);
				table.addCell(cell);

				advAmt = advAmt + advance.getAdvAmt();
			}

			doc.open();

			Paragraph heading = new Paragraph("Report-Sp Cake Advance");
			heading.setAlignment(Element.ALIGN_CENTER);
			doc.add(heading);
			DateFormat DF = new SimpleDateFormat("dd-MM-yyyy");
			String reportDate = DF.format(new java.util.Date());

			doc.add(new Paragraph("" + reportDate));
			doc.add(new Paragraph("\n"));

			doc.add(table);

			Paragraph totalAdv = new Paragraph("Total Advance " + advAmt);
			totalAdv.setAlignment(Element.ALIGN_RIGHT);
			doc.add(totalAdv);

			doc.close();

			// Atul Sir code to open a Pdf File
			if (file != null) {

				String mimeType = URLConnection.guessContentTypeFromName(file.getName());

				if (mimeType == null) {

					mimeType = "application/pdf";

				}

				response.setContentType(mimeType);

				response.addHeader("content-disposition", String.format("inline; filename=\"%s\"", file.getName()));

				// response.setHeader("Content-Disposition", String.format("attachment;
				// filename=\"%s\"", file.getName()));

				response.setContentLength((int) file.length());

				InputStream inputStream = null;
				try {
					inputStream = new BufferedInputStream(new FileInputStream(file));
				} catch (FileNotFoundException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}

				try {
					FileCopyUtils.copy(inputStream, response.getOutputStream());
				} catch (IOException e) {
					System.out.println("Excep in Opening a Pdf File for Mixing");
					e.printStackTrace();
				}
			}

		} catch (DocumentException ex) {

			System.out.println("Pdf Generation Error: Prod From Orders" + ex.getMessage());

			ex.printStackTrace();

		}

	}

//sp tax advance report using delivery date
	@RequestMapping(value = "/showSpAdvTaxReport", method = RequestMethod.GET)
	public ModelAndView showSpAdvTaxReport(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("report/spAdvTaxReport");
		try {
			HttpSession ses = request.getSession();
			Franchisee frDetails = (Franchisee) ses.getAttribute("frDetails");
			model.addObject("frId", frDetails.getFrId());
		} catch (Exception e) {
			e.printStackTrace();

		}
		return model;
	}

	List<GetSpAdvTaxReport> spAdvTaxList = new ArrayList<>();

	String fd, tD, frName;

	// getSpAdvTaxReport ajax
	@RequestMapping(value = "/getSpAdvTaxReport", method = RequestMethod.GET)
	public @ResponseBody List<GetSpAdvTaxReport> getSpAdvTaxReport(HttpServletRequest request,
			HttpServletResponse response) {
		// ModelAndView modelAndView = new ModelAndView("grngvn/displaygrn");
		spAdvTaxList = new ArrayList<>();
		try {
			System.out.println("in method /getSpAdvTaxReport");
			String fromDate = request.getParameter("fromDate");
			String toDate = request.getParameter("toDate");
			fd = fromDate;
			tD = toDate;
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
			HttpSession ses = request.getSession();
			Franchisee frDetails = (Franchisee) ses.getAttribute("frDetails");
			RestTemplate restTemplate = new RestTemplate();
			System.err.println("from " + fromDate + "toDate " + toDate);
			frName = frDetails.getFrName();

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			int frId = frDetails.getFrId();
			map.add("fromDate", DateConvertor.convertToYMD(fromDate));

			map.add("toDate", DateConvertor.convertToYMD(toDate));

			map.add("frId", frId);

			GetSpAdvTaxReportList spTaxAdv = restTemplate.postForObject(Constant.URL + "spProduction/getSpAdvTaxRepor",
					map, GetSpAdvTaxReportList.class);
			spAdvTaxList = spTaxAdv.getSpAdvTaxReport();

			System.err.println("Sp tax List List " + spTaxAdv.toString());
		} catch (Exception e) {
			System.err.println("Ex in gettting sp tax list " + e.getMessage());
			e.printStackTrace();
		}
		return spAdvTaxList;

	}
	// getSpAdvTaxPdf

	@RequestMapping(value = "/getSpAdvTaxPdf", method = RequestMethod.GET)
	public void getSpAdvTaxPdf(HttpServletRequest request, HttpServletResponse response) {

		Document doc = new Document();

		String FILE_PATH = Constant.REPORT_SAVE;
		File file = new File(FILE_PATH);

		PdfWriter writer = null;

		FileOutputStream out = null;
		try {
			out = new FileOutputStream(FILE_PATH);
		} catch (FileNotFoundException e1) {

			System.err.println("File not found Exception" + e1.getMessage());
			e1.printStackTrace();
		}
		try {
			writer = PdfWriter.getInstance(doc, out);
		} catch (DocumentException e) {
			System.err.println("DocumentException Exception" + e.getMessage());

			e.printStackTrace();
		}

		PdfPTable table = new PdfPTable(13);
		try {
			System.out.println("Inside PDF Table try /getSpAdvTaxPdf");
			table.setWidthPercentage(100);
			table.setWidths(
					new float[] { 0.4f, 1.4f, 1.5f, 1.4f, 1.5f, 1.6f, 0.8f, 0.8f, 1.2f, 1.3f, 1.2f, 1.3f, 1.4f });
			Font headFont = new Font(FontFamily.HELVETICA, 7, Font.NORMAL, BaseColor.BLACK);
			Font headFont1 = new Font(FontFamily.HELVETICA, 8, Font.BOLD, BaseColor.BLUE);
			Font f = new Font(FontFamily.TIMES_ROMAN, 12.0f, Font.UNDERLINE, BaseColor.BLUE);

			PdfPCell hcell;
			hcell = new PdfPCell(new Phrase("No", headFont1));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Invoice No", headFont1));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Item Name", headFont1));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Hsn Code", headFont1));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Delivery Date", headFont1));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Base Mrp", headFont1));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("CGST %", headFont1));
			hcell.setHorizontalAlignment(Element.ALIGN_LEFT);
			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("SGST %", headFont1));
			hcell.setHorizontalAlignment(Element.ALIGN_LEFT);
			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("CGST Rs", headFont1));
			hcell.setHorizontalAlignment(Element.ALIGN_LEFT);
			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("SGST Rs", headFont1));
			hcell.setHorizontalAlignment(Element.ALIGN_LEFT);
			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Total", headFont1));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Advance", headFont1));
			hcell.setHorizontalAlignment(Element.ALIGN_LEFT);
			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Remaining", headFont1));
			hcell.setHorizontalAlignment(Element.ALIGN_LEFT);
			table.addCell(hcell);

			PdfPTable summaryTable = new PdfPTable(5);
			summaryTable.setWidthPercentage(100);
			hcell = new PdfPCell(new Phrase("CGST Rs", headFont1));
			hcell.setHorizontalAlignment(Element.ALIGN_LEFT);
			summaryTable.addCell(hcell);

			hcell = new PdfPCell(new Phrase("SGST Rs", headFont1));
			hcell.setHorizontalAlignment(Element.ALIGN_LEFT);
			summaryTable.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Total", headFont1));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			summaryTable.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Advance", headFont1));
			hcell.setHorizontalAlignment(Element.ALIGN_LEFT);
			summaryTable.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Remaining", headFont1));
			hcell.setHorizontalAlignment(Element.ALIGN_LEFT);
			summaryTable.addCell(hcell);

			int index = 0;
			float cgstSum = 0, sgstSum = 0, totalSum = 0, advSum = 0, remainingSum = 0;

			for (GetSpAdvTaxReport spTax : spAdvTaxList) {
				index++;
				PdfPCell cell;

				cgstSum = cgstSum + spTax.getTax1Amt();
				sgstSum = sgstSum + spTax.getTax2Amt();
				totalSum = totalSum + spTax.getTotal();
				advSum = advSum + spTax.getSpAdvance();
				remainingSum = remainingSum + spTax.getRmAmount();

				cell = new PdfPCell(new Phrase(String.valueOf(index), headFont));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_CENTER);
				table.addCell(cell);

				cell = new PdfPCell(new Phrase(spTax.getInvoiceNo(), headFont));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);
				cell.setPaddingRight(12);
				table.addCell(cell);

				cell = new PdfPCell(new Phrase(String.valueOf(spTax.getSpName()), headFont));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);
				cell.setPaddingRight(12);
				table.addCell(cell);

				cell = new PdfPCell(new Phrase(String.valueOf(spTax.getSpHsncd()), headFont));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);
				cell.setPaddingRight(12);
				table.addCell(cell);

				cell = new PdfPCell(new Phrase(String.valueOf(spTax.getDelDate()), headFont));
				cell.setVerticalAlignment(Element.ALIGN_LEFT);
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);
				cell.setPaddingRight(12);
				table.addCell(cell);

				cell = new PdfPCell(new Phrase(String.valueOf(roundUp(spTax.getBaseMrp())), headFont));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
				cell.setPaddingRight(12);
				table.addCell(cell);

				cell = new PdfPCell(new Phrase(String.valueOf(spTax.getTax1()), headFont));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_CENTER);
				cell.setPaddingRight(12);
				table.addCell(cell);

				cell = new PdfPCell(new Phrase(String.valueOf(spTax.getTax2()), headFont));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_CENTER);
				cell.setPaddingRight(12);
				table.addCell(cell);

				cell = new PdfPCell(new Phrase(String.valueOf(spTax.getTax1Amt()), headFont));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
				cell.setPaddingRight(12);
				table.addCell(cell);

				cell = new PdfPCell(new Phrase(String.valueOf(spTax.getTax2Amt()), headFont));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
				cell.setPaddingRight(12);
				table.addCell(cell);

				cell = new PdfPCell(new Phrase(String.valueOf(spTax.getTotal()), headFont));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
				cell.setPaddingRight(12);
				table.addCell(cell);

				cell = new PdfPCell(new Phrase(String.valueOf(spTax.getSpAdvance()), headFont));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);
				cell.setPaddingRight(12);
				table.addCell(cell);

				cell = new PdfPCell(new Phrase(String.valueOf(spTax.getRmAmount()), headFont));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);
				cell.setPaddingRight(12);
				table.addCell(cell);

			}
			doc.open();
			PdfPCell cell;

			cell = new PdfPCell(new Phrase(String.valueOf(cgstSum), headFont));
			cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
			cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
			cell.setPaddingRight(12);
			summaryTable.addCell(cell);

			cell = new PdfPCell(new Phrase(String.valueOf(sgstSum), headFont));
			cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
			cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
			cell.setPaddingRight(12);
			summaryTable.addCell(cell);

			cell = new PdfPCell(new Phrase(String.valueOf(totalSum), headFont));
			cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
			cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
			cell.setPaddingRight(12);
			summaryTable.addCell(cell);

			cell = new PdfPCell(new Phrase(String.valueOf(advSum), headFont));
			cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
			cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
			cell.setPaddingRight(12);
			summaryTable.addCell(cell);

			cell = new PdfPCell(new Phrase(String.valueOf(remainingSum), headFont));
			cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
			cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
			cell.setPaddingRight(12);
			summaryTable.addCell(cell);

			Paragraph heading = new Paragraph("Report-Sp Cake Tax ");
			heading.setAlignment(Element.ALIGN_CENTER);
			doc.add(heading);
			DateFormat DF = new SimpleDateFormat("dd-MM-yyyy");
			String reportDate = DF.format(new java.util.Date());

			doc.add(new Paragraph("" + reportDate));
			doc.add(new Paragraph(frName + " From " + fd + " To " + tD));
			doc.add(new Paragraph("\n "));
			doc.add(table);
			doc.add(new Paragraph("\n "));

			doc.add(new Paragraph("Summary "));
			doc.add(new Paragraph("\n "));

			doc.add(summaryTable);

			doc.close();

			// Atul Sir code to open a Pdf File
			if (file != null) {

				String mimeType = URLConnection.guessContentTypeFromName(file.getName());

				if (mimeType == null) {

					mimeType = "application/pdf";

				}

				response.setContentType(mimeType);

				response.addHeader("content-disposition", String.format("inline; filename=\"%s\"", file.getName()));

				// response.setHeader("Content-Disposition", String.format("attachment;
				// filename=\"%s\"", file.getName()));

				response.setContentLength((int) file.length());

				InputStream inputStream = null;
				try {
					inputStream = new BufferedInputStream(new FileInputStream(file));
				} catch (FileNotFoundException e1) {

					e1.printStackTrace();
				}

				try {
					FileCopyUtils.copy(inputStream, response.getOutputStream());
				} catch (IOException e) {
					System.out.println("Excep in Opening a Pdf File for Mixing");
					e.printStackTrace();
				}
			}

		} catch (DocumentException ex) {

			System.out.println("Pdf Generation Error: Prod From Orders" + ex.getMessage());

			ex.printStackTrace();

		}
		fd = null;
		tD = null;
		frName = null;
	}

	@RequestMapping(value = "/viewBillWisePurchaseReport", method = RequestMethod.GET)
	public ModelAndView viewBill(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("report/purchaseReport/billWisePurchaseReport");
		try {
			HttpSession ses = request.getSession();
			Franchisee frDetails = (Franchisee) ses.getAttribute("frDetails");
			model.addObject("frId", frDetails.getFrId());
		} catch (Exception e) {
			e.printStackTrace();

		}
		return model;
	}

	@RequestMapping(value = "/viewBillTaxPurchaseReport", method = RequestMethod.GET)
	public ModelAndView billTaxReport(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("report/purchaseReport/billWiseTaxReport");
		try {
			HttpSession ses = request.getSession();
			Franchisee frDetails = (Franchisee) ses.getAttribute("frDetails");
			model.addObject("frId", frDetails.getFrId());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return model;
	}

	@RequestMapping(value = "/viewItemWiseDetailReport", method = RequestMethod.GET)
	public ModelAndView itemWiseDetailReport(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("report/purchaseReport/itemWiseDetail");
		try {
			RestTemplate restTemplate = new RestTemplate();

			CategoryList allCategoryResponse = restTemplate.getForObject(Constant.URL + "showAllCategory",
					CategoryList.class);

			List<MCategory> catList = allCategoryResponse.getmCategoryList();

			System.out.println("catList :" + catList.toString());
			model.addObject("catList", catList);
			HttpSession ses = request.getSession();
			Franchisee frDetails = (Franchisee) ses.getAttribute("frDetails");
			model.addObject("frId", frDetails.getFrId());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return model;
	}

	@RequestMapping(value = "/viewItemWiseReport", method = RequestMethod.GET)
	public ModelAndView itemWiseReport(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("report/purchaseReport/itemWiseReport");
		try {
			RestTemplate restTemplate = new RestTemplate();

			CategoryList allCategoryResponse = restTemplate.getForObject(Constant.URL + "showAllCategory",
					CategoryList.class);

			List<MCategory> catList = allCategoryResponse.getmCategoryList();

			System.out.println("catList :" + catList.toString());
			model.addObject("catList", catList);
			HttpSession ses = request.getSession();
			Franchisee frDetails = (Franchisee) ses.getAttribute("frDetails");
			model.addObject("frId", frDetails.getFrId());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return model;
	}

	@RequestMapping(value = "/viewMonthWisePurchaseReport", method = RequestMethod.GET)
	public ModelAndView monthWisePurchaseReport(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("report/purchaseReport/monthWisePurchase");
		try {
			HttpSession ses = request.getSession();
			Franchisee frDetails = (Franchisee) ses.getAttribute("frDetails");
			model.addObject("frId", frDetails.getFrId());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return model;
	}

	// ----------------------------------Bill Wise Purchase
	// Report---------------------------------------------
	@RequestMapping(value = "/findBillWisePurchase", method = RequestMethod.GET)
	public @ResponseBody List<BillWisePurchaseReport> getBillWisePurchase(HttpServletRequest request,
			HttpServletResponse response) {

		try {
			System.out.println("in method");
			String fromDate = request.getParameter("fromDate");
			System.out.println("fromDate" + fromDate);

			String toDate = request.getParameter("toDate");
			System.out.println("toDate" + toDate);

			HttpSession ses = request.getSession();
			Franchisee frDetails = (Franchisee) ses.getAttribute("frDetails");

			RestTemplate restTemplate = new RestTemplate();

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			int frId = frDetails.getFrId();
			frGstType = frDetails.getFrGstType();
			System.out.println("frId" + frId);

			map.add("frId", frId);
			map.add("fromDate", Main.formatDate(fromDate));
			map.add("toDate", Main.formatDate(toDate));

			billWisePurchaseReportList = new ArrayList<BillWisePurchaseReport>();

			BillWisePurchaseList billWisePurchaseList = restTemplate
					.postForObject(Constant.URL + "/showBillWisePurchaseReport", map, BillWisePurchaseList.class);

			billWisePurchaseReportList = billWisePurchaseList.getBillWisePurchaseList();

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}

		System.out.println("BillReportBillWise: " + billWisePurchaseReportList.toString());

		// export to excel

		List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

		ExportToExcel expoExcel = new ExportToExcel();
		List<String> rowData = new ArrayList<String>();

		rowData.add("Purchase Bill No");
		rowData.add("Invoice No.");
		rowData.add("Bill Date");
		rowData.add("Taxable Amount");
		rowData.add("CGST Amt");
		rowData.add("SGST Amt");
		rowData.add("IGST Amt");
		rowData.add("Round Off");
		rowData.add("Grand Total");
		expoExcel.setRowData(rowData);

		exportToExcelList.add(expoExcel);

		for (int i = 0; i < billWisePurchaseReportList.size(); i++) {
			expoExcel = new ExportToExcel();
			rowData = new ArrayList<String>();

			rowData.add("" + billWisePurchaseReportList.get(i).getBillNo());
			rowData.add("" + billWisePurchaseReportList.get(i).getInvoiceNo());
			rowData.add("" + billWisePurchaseReportList.get(i).getBillDate());
			rowData.add("" + billWisePurchaseReportList.get(i).getTaxableAmt());

			rowData.add("" + billWisePurchaseReportList.get(i).getCgstRs());
			rowData.add("" + billWisePurchaseReportList.get(i).getSgstRs());
			rowData.add("" + billWisePurchaseReportList.get(i).getIgstRs());
			rowData.add("" + billWisePurchaseReportList.get(i).getRoundOff());

			rowData.add("" + billWisePurchaseReportList.get(i).getGrandTotal());

			expoExcel.setRowData(rowData);
			exportToExcelList.add(expoExcel);

		}

		HttpSession session = request.getSession();
		session.setAttribute("exportExcelList", exportToExcelList);
		session.setAttribute("excelName", "BillWisePurchaseReport");

		return billWisePurchaseReportList;

	}

	// ---------------------------------------------------------------------------------------------------------------------

	// ----------------------------------Item Wise Detail
	// Report---------------------------------------------
	@RequestMapping(value = "/findItemWiseDetailReport", method = RequestMethod.GET)
	public @ResponseBody List<ItemWiseDetail> findItemWiseDetailReport(HttpServletRequest request,
			HttpServletResponse response) {

		try {
			System.out.println("in method");
			String fromDate = request.getParameter("fromDate");
			System.out.println("fromDate" + fromDate);

			String toDate = request.getParameter("toDate");
			System.out.println("toDate" + toDate);

			int catId = Integer.parseInt(request.getParameter("catId"));

			HttpSession ses = request.getSession();
			Franchisee frDetails = (Franchisee) ses.getAttribute("frDetails");

			RestTemplate restTemplate = new RestTemplate();

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			int frId = frDetails.getFrId();
			System.out.println("frId" + frId);

			map.add("frId", frId);
			map.add("fromDate", Main.formatDate(fromDate));
			map.add("toDate", Main.formatDate(toDate));
			map.add("catId", catId);

			itemWiseDetailReportList = new ArrayList<ItemWiseDetail>();

			ItemWiseDetailList itemWiseDetailList = restTemplate
					.postForObject(Constant.URL + "/showItemWiseDetailsReport", map, ItemWiseDetailList.class);

			itemWiseDetailReportList = itemWiseDetailList.getItemWiseDetailList();

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}

		System.out.println("ItemWiseDetailReport: " + itemWiseDetailReportList.toString());

		// export to excel

		List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

		ExportToExcel expoExcel = new ExportToExcel();
		List<String> rowData = new ArrayList<String>();

		rowData.add("Date");
		rowData.add("Purchase Bill No");

		rowData.add("Item Id");

		rowData.add("Item Name");
		rowData.add("Rate");

		rowData.add("Quantity");

		rowData.add("Total Amount");
		rowData.add("Grn type");

		expoExcel.setRowData(rowData);
		exportToExcelList.add(expoExcel);
		for (int i = 0; i < itemWiseDetailReportList.size(); i++) {
			expoExcel = new ExportToExcel();
			rowData = new ArrayList<String>();

			rowData.add("" + itemWiseDetailReportList.get(i).getBillDate());
			rowData.add("" + itemWiseDetailReportList.get(i).getBillNo());

			rowData.add("" + itemWiseDetailReportList.get(i).getItemId());
			rowData.add("" + itemWiseDetailReportList.get(i).getItemName());
			rowData.add("" + itemWiseDetailReportList.get(i).getRate());

			rowData.add("" + itemWiseDetailReportList.get(i).getQty());
			rowData.add("" + itemWiseDetailReportList.get(i).getTotal());
			if (itemWiseDetailReportList.get(i).getGrnType() == 0) {
				rowData.add("GRN 1");
			} else if (itemWiseDetailReportList.get(i).getGrnType() == 1) {
				rowData.add("GRN 2");
			} else if (itemWiseDetailReportList.get(i).getGrnType() == 2) {
				rowData.add("GRN 3");
			} else if (itemWiseDetailReportList.get(i).getGrnType() == 3) {
				rowData.add("No GRN");
			} else if (itemWiseDetailReportList.get(i).getGrnType() == 4) {
				rowData.add("GRN 4");
			}

			expoExcel.setRowData(rowData);
			exportToExcelList.add(expoExcel);

		}

		HttpSession session = request.getSession();
		session.setAttribute("exportExcelList", exportToExcelList);
		session.setAttribute("excelName", "ItemWiseDetailPurchaseReport");

		return itemWiseDetailReportList;

	}

	// ---------------------------------------------------------------------------------------------------------------------
	// ----------------------------------Item Wise Detail
	// Report---------------------------------------------
	@RequestMapping(value = "/findItemWiseReport", method = RequestMethod.GET)
	public @ResponseBody List<ItemWiseReport> findItemWiseReport(HttpServletRequest request,
			HttpServletResponse response) {

		try {
			System.out.println("in method");
			String fromDate = request.getParameter("fromDate");
			System.out.println("fromDate" + fromDate);

			String toDate = request.getParameter("toDate");
			System.out.println("toDate" + toDate);

			int catId = Integer.parseInt(request.getParameter("catId"));

			HttpSession ses = request.getSession();
			Franchisee frDetails = (Franchisee) ses.getAttribute("frDetails");

			RestTemplate restTemplate = new RestTemplate();

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			int frId = frDetails.getFrId();
			System.out.println("frId" + frId);

			map.add("frId", frId);
			map.add("fromDate", Main.formatDate(fromDate));
			map.add("toDate", Main.formatDate(toDate));
			map.add("catId", catId);

			itemWiseReportList = new ArrayList<ItemWiseReport>();

			ItemWiseReportList itemWiseList = restTemplate.postForObject(Constant.URL + "/showItemWiseReport", map,
					ItemWiseReportList.class);

			itemWiseReportList = itemWiseList.getItemWiseReportList();

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}

		System.out.println("ItemWiseDetailReport: " + itemWiseReportList.toString());

		// export to excel

		List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

		ExportToExcel expoExcel = new ExportToExcel();
		List<String> rowData = new ArrayList<String>();

		rowData.add("Purchase Bill Detail No");

		rowData.add("Item Id");

		rowData.add("Item Name");
		rowData.add("Rate");

		rowData.add("Quantity");

		rowData.add("Total Amount");

		expoExcel.setRowData(rowData);
		exportToExcelList.add(expoExcel);
		for (int i = 0; i < itemWiseReportList.size(); i++) {
			expoExcel = new ExportToExcel();
			rowData = new ArrayList<String>();

			rowData.add("" + itemWiseReportList.get(i).getBillDetailNo());

			rowData.add("" + itemWiseReportList.get(i).getItemId());
			rowData.add("" + itemWiseReportList.get(i).getItemName());
			rowData.add("" + itemWiseReportList.get(i).getRate());

			rowData.add("" + itemWiseReportList.get(i).getQty());

			rowData.add("" + itemWiseReportList.get(i).getTotal());

			expoExcel.setRowData(rowData);
			exportToExcelList.add(expoExcel);

		}

		HttpSession session = request.getSession();
		session.setAttribute("exportExcelList", exportToExcelList);
		session.setAttribute("excelName", "ItemWisePurchaseReport");

		return itemWiseReportList;

	}

	// ---------------------------------------------------------------------------------------------------------------------

	// ----------------------------------Bill Wise Tax
	// Report---------------------------------------------
	@RequestMapping(value = "/findBillWiseTaxReport", method = RequestMethod.GET)
	public @ResponseBody List<BillWiseTaxReport> getBillWiseTaxReport(HttpServletRequest request,
			HttpServletResponse response) {

		try {
			System.out.println("in method");
			String fromDate = request.getParameter("fromDate");
			System.out.println("fromDate" + fromDate);

			String toDate = request.getParameter("toDate");
			System.out.println("toDate" + toDate);

			HttpSession ses = request.getSession();
			Franchisee frDetails = (Franchisee) ses.getAttribute("frDetails");

			RestTemplate restTemplate = new RestTemplate();

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			int frId = frDetails.getFrId();
			System.out.println("frId" + frId);

			map.add("frId", frId);
			map.add("fromDate", Main.formatDate(fromDate));
			map.add("toDate", Main.formatDate(toDate));

			billWiseTaxReport = new ArrayList<BillWiseTaxReport>();

			BillWiseTaxReportList billWiseTaxReportList = restTemplate
					.postForObject(Constant.URL + "/showBillWiseTaxReport", map, BillWiseTaxReportList.class);

			billWiseTaxReport = billWiseTaxReportList.getBillWiseTaxReportList();

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}

		System.out.println("billWiseTaxReport: " + billWiseTaxReport.toString());

		// export to excel

		List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

		ExportToExcel expoExcel = new ExportToExcel();
		List<String> rowData = new ArrayList<String>();

		rowData.add("Purchase Bill No");
		rowData.add("Bill Date");
		rowData.add("Tax Rate");
		rowData.add("cgst");

		rowData.add("sgst");
		rowData.add("igst");

		rowData.add("cess");

		rowData.add("Grand Amount");
		rowData.add("Taxable Amount");

		expoExcel.setRowData(rowData);
		exportToExcelList.add(expoExcel);
		for (int i = 0; i < billWiseTaxReport.size(); i++) {
			expoExcel = new ExportToExcel();
			rowData = new ArrayList<String>();

			rowData.add("" + billWiseTaxReport.get(i).getBillNo());
			rowData.add("" + DateConvertor.convertToDMY(billWiseTaxReport.get(i).getBillDate()));
			rowData.add("" + billWiseTaxReport.get(i).getTaxRate());
			rowData.add("" + billWiseTaxReport.get(i).getCgstRs());
			rowData.add("" + billWiseTaxReport.get(i).getSgstRs());

			rowData.add("" + billWiseTaxReport.get(i).getIgstRs());

			rowData.add("" + billWiseTaxReport.get(i).getCess());
			rowData.add("" + billWiseTaxReport.get(i).getGrandTotal());

			rowData.add("" + billWiseTaxReport.get(i).getTaxableAmt());

			expoExcel.setRowData(rowData);
			exportToExcelList.add(expoExcel);

		}

		HttpSession session = request.getSession();
		session.setAttribute("exportExcelList", exportToExcelList);
		session.setAttribute("excelName", "BillWiseTaxPurchaseReport");

		return billWiseTaxReport;

	}

	// ---------------------------------------------------------------------------------------------------------------------
	// ----------------------------------Bill Wise Tax
	// Report---------------------------------------------
	@RequestMapping(value = "/getMonthWisePurchaseReport", method = RequestMethod.GET)
	public @ResponseBody List<MonthWiseReport> getMonthWiseReport(HttpServletRequest request,
			HttpServletResponse response) {
		String frName = "";
		try {
			System.out.println("in method");
			String fromDate = request.getParameter("fromDate");
			System.out.println("fromDate" + fromDate);

			String toDate = request.getParameter("toDate");
			System.out.println("toDate" + toDate);

			DateTimeFormatter f = DateTimeFormatter.ofPattern("MM-uuuu");
			YearMonth ym = YearMonth.parse(fromDate, f);

			LocalDate fDate = ym.atDay(1);
			System.out.println("fdate" + fDate);

			YearMonth ym1 = YearMonth.parse(toDate, f);
			LocalDate tDate = ym1.atEndOfMonth();
			System.out.println("tdate" + tDate);

			HttpSession ses = request.getSession();
			Franchisee frDetails = (Franchisee) ses.getAttribute("frDetails");

			RestTemplate restTemplate = new RestTemplate();

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			int frId = frDetails.getFrId();
			frName = frDetails.getFrName();
			System.out.println("frId" + frId);

			map.add("frId", frId);
			map.add("fromDate", "" + fDate);
			map.add("toDate", "" + tDate);

			monthWiseReportList = new ArrayList<MonthWiseReport>();

			MonthWiseReportList monthWiseReportListBean = restTemplate
					.postForObject(Constant.URL + "/showMonthWiseReport", map, MonthWiseReportList.class);

			monthWiseReportList = monthWiseReportListBean.getMonthWiseReportList();

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}

		System.out.println("monthWiseReportList: " + monthWiseReportList.toString());

		// export to excel

		List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

		ExportToExcel expoExcel = new ExportToExcel();
		List<String> rowData = new ArrayList<String>();

		rowData.add("Purchase Bill No");
		rowData.add("Month");
		rowData.add("Franchisee Name");
		rowData.add("Taxable Amount");
		rowData.add("cgst");

		rowData.add("sgst");
		rowData.add("igst");

		rowData.add("cess");
		rowData.add("Round Off");
		rowData.add("Grand Amount");

		String[] monthNames = { "0", "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov",
				"Dec" };

		expoExcel.setRowData(rowData);
		exportToExcelList.add(expoExcel);
		for (int i = 0; i < monthWiseReportList.size(); i++) {
			expoExcel = new ExportToExcel();
			rowData = new ArrayList<String>();

			rowData.add("" + monthWiseReportList.get(i).getBillNo());

			rowData.add("" + monthNames[monthWiseReportList.get(i).getMonth()]);
			rowData.add("" + frName);
			rowData.add("" + monthWiseReportList.get(i).getTaxableAmt());
			rowData.add("" + monthWiseReportList.get(i).getCgstRs());
			rowData.add("" + monthWiseReportList.get(i).getSgstRs());

			rowData.add("" + monthWiseReportList.get(i).getIgstRs());

			rowData.add("" + monthWiseReportList.get(i).getSess());

			rowData.add("" + monthWiseReportList.get(i).getRoundOff());

			rowData.add("" + monthWiseReportList.get(i).getGrandTotal());

			expoExcel.setRowData(rowData);
			exportToExcelList.add(expoExcel);

		}

		HttpSession session = request.getSession();
		session.setAttribute("exportExcelList", exportToExcelList);
		session.setAttribute("excelName", "MonthWiseTaxPurchaseReport");

		return monthWiseReportList;

	}

	// ---------------------------------------------------------------------------------------------------------------------
	// Sell Report Start

	@RequestMapping(value = "/viewBillwiseSell", method = RequestMethod.GET)
	public ModelAndView viewBillwiseSell(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("report/sellReport/repFrSellBillwiseSell");
		try {
			HttpSession ses = request.getSession();
			Franchisee frDetails = (Franchisee) ses.getAttribute("frDetails");
			model.addObject("frId", frDetails.getFrId());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return model;
	}

	@RequestMapping(value = "/getBilwiselReport", method = RequestMethod.GET)
	public @ResponseBody List<GetSellBillHeader> getSellBillHeader(HttpServletRequest request,
			HttpServletResponse response) {

		try {
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

			getSellBillHeaderList = new ArrayList<GetSellBillHeader>();

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

		// export to excel

		List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

		ExportToExcel expoExcel = new ExportToExcel();
		List<String> rowData = new ArrayList<String>();

		rowData.add("Sell Bill No");
		rowData.add("Invoice No");
		rowData.add("Franchisee Name");
		rowData.add("Bill Date");
		rowData.add("Discount Per");
		rowData.add("Taxable Amt");
		rowData.add("Total Tax");
		rowData.add("Grand Total");
		rowData.add("Payable Amt");
		rowData.add("Paid Amt");
		rowData.add("Remaining Amt");

		rowData.add("Payment Mode");

		expoExcel.setRowData(rowData);
		exportToExcelList.add(expoExcel);
		for (int i = 0; i < getSellBillHeaderList.size(); i++) {
			expoExcel = new ExportToExcel();
			rowData = new ArrayList<String>();

			rowData.add("" + getSellBillHeaderList.get(i).getSellBillNo());
			rowData.add("" + getSellBillHeaderList.get(i).getInvoiceNo());
			rowData.add("" + getSellBillHeaderList.get(i).getFrName());
			rowData.add("" + getSellBillHeaderList.get(i).getBillDate());
			rowData.add("" + getSellBillHeaderList.get(i).getDiscountPer());
			rowData.add("" + getSellBillHeaderList.get(i).getTaxableAmt());
			rowData.add("" + getSellBillHeaderList.get(i).getTotalTax());
			rowData.add("" + getSellBillHeaderList.get(i).getGrandTotal());
			rowData.add("" + getSellBillHeaderList.get(i).getPayableAmt());
			rowData.add("" + getSellBillHeaderList.get(i).getPaidAmt());
			rowData.add("" + getSellBillHeaderList.get(i).getRemainingAmt());

			if (getSellBillHeaderList.get(i).getPaymentMode() == 1) {
				rowData.add("Cash");

			} else if (getSellBillHeaderList.get(i).getPaymentMode() == 2) {
				rowData.add("Card");

			} else if (getSellBillHeaderList.get(i).getPaymentMode() == 3) {
				rowData.add("other");
			}

			expoExcel.setRowData(rowData);
			exportToExcelList.add(expoExcel);

		}

		HttpSession session = request.getSession();
		session.setAttribute("exportExcelList", exportToExcelList);
		session.setAttribute("excelName", "BillWiseSell");

		return getSellBillHeaderList;

	}

	@RequestMapping(value = "/viewDatewiseSellBill", method = RequestMethod.GET)
	public ModelAndView viewDatewiseSellBill(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("report/sellReport/repFrSelldatewise");

		try {
			HttpSession ses = request.getSession();
			Franchisee frDetails = (Franchisee) ses.getAttribute("frDetails");
			model.addObject("frId", frDetails.getFrId());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return model;
	}

	@RequestMapping(value = "/getDatewiselReport", method = RequestMethod.GET)
	public @ResponseBody List<GetRepFrDatewiseSellResponse> getDatewiseSellBill(HttpServletRequest request,
			HttpServletResponse response) {
		System.out.println("in method");
		try {
			System.out.println("in method");
			String fromDate = request.getParameter("fromDate");
			String toDate = request.getParameter("toDate");
			System.out.println("toDate" + toDate);

			HttpSession ses = request.getSession();
			Franchisee frDetails = (Franchisee) ses.getAttribute("frDetails");

			RestTemplate restTemplate = new RestTemplate();

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			int frId = frDetails.getFrId();
			map.add("frId", frId);
			map.add("fromDate", fromDate);
			map.add("toDate", toDate);

			getRepFrDatewiseSellResponse = new ArrayList<GetRepFrDatewiseSellResponse>();

			ParameterizedTypeReference<List<GetRepFrDatewiseSellResponse>> typeRef = new ParameterizedTypeReference<List<GetRepFrDatewiseSellResponse>>() {
			};
			ResponseEntity<List<GetRepFrDatewiseSellResponse>> responseEntity = restTemplate
					.exchange(Constant.URL + "getRepDatewiseSell", HttpMethod.POST, new HttpEntity<>(map), typeRef);

			getRepFrDatewiseSellResponse = responseEntity.getBody();
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}

		System.out.println("Sell Bill Header " + getRepFrDatewiseSellResponse.toString());

		// export to excel

		List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

		ExportToExcel expoExcel = new ExportToExcel();
		List<String> rowData = new ArrayList<String>();

		/*
		 * rowData.add("Sell Bill No"); rowData.add("Franchise Id");
		 */
		rowData.add("Franchise Name");
		rowData.add("Day");
		rowData.add("Bill Date");
		rowData.add("Total Day Sale");
		rowData.add("Cash");
		rowData.add("Card");
		/* rowData.add("Other"); */

		expoExcel.setRowData(rowData);
		exportToExcelList.add(expoExcel);
		for (int i = 0; i < getRepFrDatewiseSellResponse.size(); i++) {
			expoExcel = new ExportToExcel();
			rowData = new ArrayList<String>();

			/*
			 * rowData.add(""+getRepFrDatewiseSellResponse.get(i).getSellBillNo());
			 * rowData.add(""+getRepFrDatewiseSellResponse.get(i).getFrId());
			 */
			rowData.add("" + getRepFrDatewiseSellResponse.get(i).getFrName());

			rowData.add("" + getRepFrDatewiseSellResponse.get(i).getDay());
			rowData.add("" + getRepFrDatewiseSellResponse.get(i).getBillDate());
			float totalAmt = getRepFrDatewiseSellResponse.get(i).getCash()
					+ getRepFrDatewiseSellResponse.get(i).getCard() + getRepFrDatewiseSellResponse.get(i).getOther();
			rowData.add("" + totalAmt);
			rowData.add("" + getRepFrDatewiseSellResponse.get(i).getCash());
			rowData.add("" + getRepFrDatewiseSellResponse.get(i).getCard());
			/* rowData.add(""+getRepFrDatewiseSellResponse.get(i).getOther()); */

			expoExcel.setRowData(rowData);
			exportToExcelList.add(expoExcel);

		}

		HttpSession session = request.getSession();
		session.setAttribute("exportExcelList", exportToExcelList);
		session.setAttribute("excelName", "DateWiseSell");

		return getRepFrDatewiseSellResponse;

	}

	@RequestMapping(value = "/viewMonthwiseSellBill", method = RequestMethod.GET)
	public ModelAndView viewMonthwiseSellBill(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("report/sellReport/repFrMonthwiseSell");
		try {
			Calendar now = Calendar.getInstance();
			HttpSession ses = request.getSession();
			Franchisee frDetails = (Franchisee) ses.getAttribute("frDetails");
			String toyear = "2018";
			String fromyear = "2018";

			if ((now.get(Calendar.MONTH) + 1) > 3) {
				fromyear = "" + (now.get(Calendar.YEAR));
				toyear = "" + (now.get(Calendar.YEAR) + 1);

			} else {
				fromyear = "" + (now.get(Calendar.YEAR) - 1);
				toyear = "" + (now.get(Calendar.YEAR));
			}

			model.addObject("frommonth", "03-" + fromyear);
			model.addObject("tomonth", "04-" + toyear);
			model.addObject("frId", frDetails.getFrId());

		} catch (Exception e) {
			e.printStackTrace();
		}
		return model;
	}

	@RequestMapping(value = "/getMonthwiselReport", method = RequestMethod.GET)
	public @ResponseBody List<GetRepFrDatewiseSellResponse> getMonthwiseSellBill(HttpServletRequest request,
			HttpServletResponse response) {

		try {
			System.out.println("in method");
			String fromDate = request.getParameter("fromDate");
			String toDate = request.getParameter("toDate");

			DateTimeFormatter f = DateTimeFormatter.ofPattern("MM-uuuu");
			YearMonth ym = YearMonth.parse(fromDate, f);

			LocalDate fDate = ym.atDay(1);
			System.out.println("fdate" + fDate);

			YearMonth ym1 = YearMonth.parse(toDate, f);
			LocalDate tDate = ym1.atEndOfMonth();
			System.out.println("tdate" + tDate);

			HttpSession ses = request.getSession();
			Franchisee frDetails = (Franchisee) ses.getAttribute("frDetails");

			RestTemplate restTemplate = new RestTemplate();

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			int frId = frDetails.getFrId();
			map.add("frId", frId);

			map.add("fromDate", "" + fDate);
			map.add("toDate", "" + tDate);

			getRepFrDatewiseSellResponse = new ArrayList<GetRepFrDatewiseSellResponse>();

			ParameterizedTypeReference<List<GetRepFrDatewiseSellResponse>> typeRef = new ParameterizedTypeReference<List<GetRepFrDatewiseSellResponse>>() {
			};
			ResponseEntity<List<GetRepFrDatewiseSellResponse>> responseEntity = restTemplate
					.exchange(Constant.URL + "getRepMonthwiseSell", HttpMethod.POST, new HttpEntity<>(map), typeRef);

			getRepFrDatewiseSellResponse = responseEntity.getBody();
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}

		System.out.println("Sell Bill Header " + getRepFrDatewiseSellResponse.toString());

		// export to excel

		List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

		ExportToExcel expoExcel = new ExportToExcel();
		List<String> rowData = new ArrayList<String>();

		rowData.add("Sale Bill No");
		rowData.add("Franchise Id");
		rowData.add("Franchise Name");

		rowData.add("Month");
		rowData.add("Total Month Sale");
		rowData.add("Cash");
		rowData.add("Card");
		rowData.add("Other");

		String[] monthNames = { "0", "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov",
				"Dec" };

		expoExcel.setRowData(rowData);
		exportToExcelList.add(expoExcel);
		for (int i = 0; i < getRepFrDatewiseSellResponse.size(); i++) {
			expoExcel = new ExportToExcel();
			rowData = new ArrayList<String>();

			rowData.add("" + getRepFrDatewiseSellResponse.get(i).getSellBillNo());
			rowData.add("" + getRepFrDatewiseSellResponse.get(i).getFrId());
			rowData.add("" + getRepFrDatewiseSellResponse.get(i).getFrName());

			rowData.add("" + monthNames[getRepFrDatewiseSellResponse.get(i).getMonth()]);
			float totalAmt = getRepFrDatewiseSellResponse.get(i).getCash()
					+ getRepFrDatewiseSellResponse.get(i).getCard() + getRepFrDatewiseSellResponse.get(i).getOther();
			rowData.add("" + totalAmt);
			rowData.add("" + getRepFrDatewiseSellResponse.get(i).getCash());
			rowData.add("" + getRepFrDatewiseSellResponse.get(i).getCard());
			rowData.add("" + getRepFrDatewiseSellResponse.get(i).getOther());

			expoExcel.setRowData(rowData);
			exportToExcelList.add(expoExcel);

		}

		HttpSession session = request.getSession();
		session.setAttribute("exportExcelList", exportToExcelList);
		session.setAttribute("excelName", "MonthWiseSell");

		return getRepFrDatewiseSellResponse;

	}

	@RequestMapping(value = "/viewItemwiseSellBill", method = RequestMethod.GET)
	// @RequestMapping(value = "/viewChart", method = RequestMethod.GET)
	public ModelAndView viewItemwiseSellBill(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("report/sellReport/repFrItemwiseSell");
		HttpSession ses = request.getSession();
		Franchisee frDetails = (Franchisee) ses.getAttribute("frDetails");
		model.addObject("frId", frDetails.getFrId());
		/*
		 * List<MCategory> mCategoryList; RestTemplate restTemplate = new
		 * RestTemplate();
		 * 
		 * CategoryList categoryList = restTemplate.getForObject(Constant.URL +
		 * "showAllCategory", CategoryList.class);
		 * 
		 * mCategoryList = categoryList.getmCategoryList();
		 * 
		 * System.out.println("Category list  " +mCategoryList); List<MCategory>
		 * newMcategoryList=new ArrayList<MCategory>(); for(int
		 * i=0;i<mCategoryList.size();i++) { if(mCategoryList.get(i).getCatId()!=5) {
		 * newMcategoryList.add(mCategoryList.get(i)); } }
		 * System.out.println("New Category list  " +newMcategoryList);
		 * model.addObject("unSelectedCatList", newMcategoryList);
		 */
		return model;
	}

	@RequestMapping(value = "/getMenuwiselReport", method = RequestMethod.GET)
	public @ResponseBody List<GetRepMenuwiseSellResponse> getMenuwisellReport(HttpServletRequest request,
			HttpServletResponse response) {

		try {
			System.out.println("in method");
			String fromDate = request.getParameter("fromDate");
			String toDate = request.getParameter("toDate");
			// String catId=request.getParameter("category");

			/*
			 * catId = catId.substring(1, catId.length() - 1); catId =
			 * catId.replaceAll("\"", "");
			 */

			HttpSession ses = request.getSession();
			Franchisee frDetails = (Franchisee) ses.getAttribute("frDetails");

			RestTemplate restTemplate = new RestTemplate();

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			int frId = frDetails.getFrId();
			map.add("frId", frId);
			map.add("fromDate", fromDate);
			map.add("toDate", toDate);

			getRepFrMenuwiseSellResponseList = new ArrayList<GetRepMenuwiseSellResponse>();

			ParameterizedTypeReference<List<GetRepMenuwiseSellResponse>> typeRef = new ParameterizedTypeReference<List<GetRepMenuwiseSellResponse>>() {
			};
			ResponseEntity<List<GetRepMenuwiseSellResponse>> responseEntity = restTemplate
					.exchange(Constant.URL + "getRepMenuwiseSell", HttpMethod.POST, new HttpEntity<>(map), typeRef);

			getRepFrMenuwiseSellResponseList = responseEntity.getBody();
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}

		System.out.println("Sell Bill Header " + getRepFrMenuwiseSellResponseList.toString());

		// export to excel

		List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

		ExportToExcel expoExcel = new ExportToExcel();
		List<String> rowData = new ArrayList<String>();

		rowData.add("Franchise Id");
		rowData.add("Franchise Name");
		rowData.add("Cat Id");

		rowData.add("Cat Name");
		rowData.add("Quantity");
		rowData.add("Amount");

		expoExcel.setRowData(rowData);
		exportToExcelList.add(expoExcel);
		for (int i = 0; i < getRepFrMenuwiseSellResponseList.size(); i++) {
			expoExcel = new ExportToExcel();
			rowData = new ArrayList<String>();

			rowData.add("" + getRepFrMenuwiseSellResponseList.get(i).getFrId());
			rowData.add("" + getRepFrMenuwiseSellResponseList.get(i).getFrName());

			rowData.add("" + getRepFrMenuwiseSellResponseList.get(i).getCatId());
			rowData.add("" + getRepFrMenuwiseSellResponseList.get(i).getCatName());
			rowData.add("" + getRepFrMenuwiseSellResponseList.get(i).getQty());
			rowData.add("" + getRepFrMenuwiseSellResponseList.get(i).getAmount());

			expoExcel.setRowData(rowData);
			exportToExcelList.add(expoExcel);

		}

		HttpSession session = request.getSession();
		session.setAttribute("exportExcelList", exportToExcelList);
		session.setAttribute("excelName", "MenuWiseSummarySell");

		return getRepFrMenuwiseSellResponseList;

	}

	@RequestMapping(value = "/getItemwiselReport", method = RequestMethod.GET)
	public @ResponseBody List<GetRepFrItemwiseSellResponse> getItemwisellReport(HttpServletRequest request,
			HttpServletResponse response) {

		try {
			System.out.println("in method");
			String fromDate = request.getParameter("fromDate");
			String toDate = request.getParameter("toDate");
			String catId = request.getParameter("category");

			/*
			 * catId = catId.substring(1, catId.length() - 1); catId =
			 * catId.replaceAll("\"", "");
			 */

			HttpSession ses = request.getSession();
			Franchisee frDetails = (Franchisee) ses.getAttribute("frDetails");

			RestTemplate restTemplate = new RestTemplate();

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			int frId = frDetails.getFrId();
			map.add("frId", frId);
			map.add("fromDate", fromDate);
			map.add("toDate", toDate);
			map.add("catId", catId);
			System.out.println(catId);
			getRepFrItemwiseSellResponseList = new ArrayList<GetRepFrItemwiseSellResponse>();

			ParameterizedTypeReference<List<GetRepFrItemwiseSellResponse>> typeRef = new ParameterizedTypeReference<List<GetRepFrItemwiseSellResponse>>() {
			};
			ResponseEntity<List<GetRepFrItemwiseSellResponse>> responseEntity = restTemplate
					.exchange(Constant.URL + "getRepItemwiseSell", HttpMethod.POST, new HttpEntity<>(map), typeRef);

			getRepFrItemwiseSellResponseList = responseEntity.getBody();
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}

		System.out.println("Sell Bill Header " + getRepFrItemwiseSellResponseList.toString());

		// export to excel

		List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

		ExportToExcel expoExcel = new ExportToExcel();
		List<String> rowData = new ArrayList<String>();

		rowData.add("Sell Bill No");
		rowData.add("Franchise Id");
		rowData.add("Franchise Name");
		rowData.add("Bill Date");
		rowData.add("Item Id");

		rowData.add("Item Name");

		rowData.add("Cat Id");

		rowData.add("Cat Name");
		rowData.add("Quantity");
		rowData.add("Amount");

		expoExcel.setRowData(rowData);
		exportToExcelList.add(expoExcel);
		for (int i = 0; i < getRepFrMenuwiseSellResponseList.size(); i++) {
			expoExcel = new ExportToExcel();
			rowData = new ArrayList<String>();

			rowData.add("" + getRepFrItemwiseSellResponseList.get(i).getSellBillNo());
			rowData.add("" + getRepFrItemwiseSellResponseList.get(i).getFrId());
			rowData.add("" + getRepFrItemwiseSellResponseList.get(i).getFrName());
			rowData.add("" + getRepFrItemwiseSellResponseList.get(i).getBillDate());

			rowData.add("" + getRepFrItemwiseSellResponseList.get(i).getItemId());
			rowData.add("" + getRepFrItemwiseSellResponseList.get(i).getItemName());
			rowData.add("" + getRepFrItemwiseSellResponseList.get(i).getCatId());
			rowData.add("" + getRepFrItemwiseSellResponseList.get(i).getCatName());
			rowData.add("" + getRepFrItemwiseSellResponseList.get(i).getQty());
			rowData.add("" + getRepFrItemwiseSellResponseList.get(i).getAmount());

			expoExcel.setRowData(rowData);
			exportToExcelList.add(expoExcel);

		}

		HttpSession session = request.getSession();
		session.setAttribute("exportExcelList", exportToExcelList);
		session.setAttribute("excelName", "ItemWiseSummarySell");

		return getRepFrItemwiseSellResponseList;

	}

	@RequestMapping(value = "/viewDateItemwiseSellBill", method = RequestMethod.GET)
	public ModelAndView viewDateItemwiseSellBill(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("report/sellReport/repFrDateItemwiseSell");
		try {
			List<MCategory> mCategoryList;
			RestTemplate restTemplate = new RestTemplate();

			CategoryList categoryList = restTemplate.getForObject(Constant.URL + "showAllCategory", CategoryList.class);

			mCategoryList = categoryList.getmCategoryList();

			System.out.println("Category list  " + mCategoryList);
			List<MCategory> newMcategoryList = new ArrayList<MCategory>();
			for (int i = 0; i < mCategoryList.size(); i++) {
				if (mCategoryList.get(i).getCatId() != 5) {
					newMcategoryList.add(mCategoryList.get(i));
				}
			}
			HttpSession ses = request.getSession();
			Franchisee frDetails = (Franchisee) ses.getAttribute("frDetails");
			model.addObject("frId", frDetails.getFrId());
			System.out.println("New Category list  " + newMcategoryList);
			model.addObject("unSelectedCatList", newMcategoryList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return model;
	}

	@RequestMapping(value = "/getDateItemwiselReport", method = RequestMethod.GET)
	public @ResponseBody List<GetRepFrItemwiseSellResponse> getDateItemwiselReport(HttpServletRequest request,
			HttpServletResponse response) {

		try {
			System.out.println("in method");
			String fromDate = request.getParameter("fromDate");
			String toDate = request.getParameter("toDate");
			String catId = request.getParameter("category");

			/*
			 * catId = catId.substring(1, catId.length() - 1); catId =
			 * catId.replaceAll("\"", "");
			 */

			HttpSession ses = request.getSession();
			Franchisee frDetails = (Franchisee) ses.getAttribute("frDetails");

			RestTemplate restTemplate = new RestTemplate();

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			int frId = frDetails.getFrId();
			map.add("frId", frId);
			map.add("fromDate", fromDate);
			map.add("toDate", toDate);
			map.add("catId", catId);
			System.out.println(catId);
			getRepFrItemwiseSellResponseList = new ArrayList<GetRepFrItemwiseSellResponse>();

			ParameterizedTypeReference<List<GetRepFrItemwiseSellResponse>> typeRef = new ParameterizedTypeReference<List<GetRepFrItemwiseSellResponse>>() {
			};
			ResponseEntity<List<GetRepFrItemwiseSellResponse>> responseEntity = restTemplate
					.exchange(Constant.URL + "getRepDateItemwiseSell", HttpMethod.POST, new HttpEntity<>(map), typeRef);

			getRepFrItemwiseSellResponseList = responseEntity.getBody();
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}

		System.out.println("Sell Bill Header " + getRepFrItemwiseSellResponseList.toString());

		// export to excel

		List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

		ExportToExcel expoExcel = new ExportToExcel();
		List<String> rowData = new ArrayList<String>();

		/* rowData.add("Sell Bill No"); */
		rowData.add("Franchise Id");
		rowData.add("Franchise Name");
		/* rowData.add("Bill Date"); */
		rowData.add("Item Id");

		rowData.add("Item Name");

		/* rowData.add("Cat Id"); */

		rowData.add("Cat Name");
		rowData.add("Quantity");
		rowData.add("Amount");

		expoExcel.setRowData(rowData);
		exportToExcelList.add(expoExcel);
		for (int i = 0; i < getRepFrItemwiseSellResponseList.size(); i++) {
			expoExcel = new ExportToExcel();
			rowData = new ArrayList<String>();

			/* rowData.add(""+getRepFrItemwiseSellResponseList.get(i).getSellBillNo()); */
			rowData.add("" + getRepFrItemwiseSellResponseList.get(i).getFrId());
			rowData.add("" + getRepFrItemwiseSellResponseList.get(i).getFrName());
			/* rowData.add(""+getRepFrItemwiseSellResponseList.get(i).getBillDate()); */

			rowData.add("" + getRepFrItemwiseSellResponseList.get(i).getItemId());
			rowData.add("" + getRepFrItemwiseSellResponseList.get(i).getItemName());
			/* rowData.add(""+getRepFrItemwiseSellResponseList.get(i).getCatId()); */
			rowData.add("" + getRepFrItemwiseSellResponseList.get(i).getCatName());
			rowData.add("" + getRepFrItemwiseSellResponseList.get(i).getQty());
			rowData.add("" + getRepFrItemwiseSellResponseList.get(i).getAmount());

			expoExcel.setRowData(rowData);
			exportToExcelList.add(expoExcel);

		}

		HttpSession session = request.getSession();
		session.setAttribute("exportExcelList", exportToExcelList);
		session.setAttribute("excelName", "ItemWiseReportSell");

		return getRepFrItemwiseSellResponseList;

	}

	@RequestMapping(value = "/getDateCatwisellReport", method = RequestMethod.GET)
	public @ResponseBody List<GetRepFrItemwiseSellResponse> getDateCatwiselReport(HttpServletRequest request,
			HttpServletResponse response) {

		try {
			System.out.println("in method");
			String fromDate = request.getParameter("fromDate");
			String toDate = request.getParameter("toDate");
			String catId = request.getParameter("category");

			/*
			 * catId = catId.substring(1, catId.length() - 1); catId =
			 * catId.replaceAll("\"", "");
			 */

			HttpSession ses = request.getSession();
			Franchisee frDetails = (Franchisee) ses.getAttribute("frDetails");

			RestTemplate restTemplate = new RestTemplate();

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			int frId = frDetails.getFrId();
			map.add("frId", frId);
			map.add("fromDate", fromDate);
			map.add("toDate", toDate);
			map.add("catId", catId);
			System.out.println(catId);
			getRepFrItemwiseSellResponseList = new ArrayList<GetRepFrItemwiseSellResponse>();

			ParameterizedTypeReference<List<GetRepFrItemwiseSellResponse>> typeRef = new ParameterizedTypeReference<List<GetRepFrItemwiseSellResponse>>() {
			};
			ResponseEntity<List<GetRepFrItemwiseSellResponse>> responseEntity = restTemplate
					.exchange(Constant.URL + "getRepDateCatwiseSell", HttpMethod.POST, new HttpEntity<>(map), typeRef);

			getRepFrItemwiseSellResponseList = responseEntity.getBody();
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}

		System.out.println("Sell Bill Header " + getRepFrItemwiseSellResponseList.toString());

		// export to excel

		List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

		ExportToExcel expoExcel = new ExportToExcel();
		List<String> rowData = new ArrayList<String>();

		rowData.add("Sell Bill No");
		rowData.add("Franchise Id");
		rowData.add("Franchise Name");
		rowData.add("Bill Date");
		rowData.add("Item Id");

		rowData.add("Item Name");

		rowData.add("Cat Id");

		rowData.add("Cat Name");
		rowData.add("Quantity");
		rowData.add("Amount");

		expoExcel.setRowData(rowData);
		exportToExcelList.add(expoExcel);
		for (int i = 0; i < getRepFrItemwiseSellResponseList.size(); i++) {
			expoExcel = new ExportToExcel();
			rowData = new ArrayList<String>();

			rowData.add("" + getRepFrItemwiseSellResponseList.get(i).getSellBillNo());
			rowData.add("" + getRepFrItemwiseSellResponseList.get(i).getFrId());
			rowData.add("" + getRepFrItemwiseSellResponseList.get(i).getFrName());
			rowData.add("" + getRepFrItemwiseSellResponseList.get(i).getBillDate());

			rowData.add("" + getRepFrItemwiseSellResponseList.get(i).getItemId());
			rowData.add("" + getRepFrItemwiseSellResponseList.get(i).getItemName());
			rowData.add("" + getRepFrItemwiseSellResponseList.get(i).getCatId());
			rowData.add("" + getRepFrItemwiseSellResponseList.get(i).getCatName());
			rowData.add("" + getRepFrItemwiseSellResponseList.get(i).getQty());
			rowData.add("" + getRepFrItemwiseSellResponseList.get(i).getAmount());

			expoExcel.setRowData(rowData);
			exportToExcelList.add(expoExcel);

		}

		HttpSession session = request.getSession();
		session.setAttribute("exportExcelList", exportToExcelList);
		session.setAttribute("excelName", "ItemWiseReportSell");

		return getRepFrItemwiseSellResponseList;

	}

	@RequestMapping(value = "/viewFrTaxSellBill", method = RequestMethod.GET)
	public ModelAndView viewFrTaxSellBill(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("report/sellReport/repFrTaxSell");
		try {
			HttpSession ses = request.getSession();
			Franchisee frDetails = (Franchisee) ses.getAttribute("frDetails");
			model.addObject("frId", frDetails.getFrId());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return model;
	}

	@RequestMapping(value = "/getTaxSellReport", method = RequestMethod.GET)
	public @ResponseBody List<GetRepTaxSell> getFrTaxSellBill(HttpServletRequest request,
			HttpServletResponse response) {

		try {
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
			getRepTaxSell = new ArrayList<GetRepTaxSell>();
			getRepTaxSell = new ArrayList<GetRepTaxSell>();

			ParameterizedTypeReference<List<GetRepTaxSell>> typeRef = new ParameterizedTypeReference<List<GetRepTaxSell>>() {
			};
			ResponseEntity<List<GetRepTaxSell>> responseEntity = restTemplate.exchange(Constant.URL + "getRepTaxSell",
					HttpMethod.POST, new HttpEntity<>(map), typeRef);

			getRepTaxSell = responseEntity.getBody();
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}

		System.out.println("Sell Bill Header " + getRepTaxSell.toString());

		// export to excel

		List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

		ExportToExcel expoExcel = new ExportToExcel();
		List<String> rowData = new ArrayList<String>();

		rowData.add("Sell Bill No");
		rowData.add("Franchise Id");
		rowData.add("Franchise Name");
		rowData.add("Bill Date");
		rowData.add("Tax %");
		rowData.add("cgst");
		rowData.add("sgst");

		rowData.add("igst");

		rowData.add("cess");
		rowData.add("Gst");
		rowData.add("Tax Amount");
		rowData.add("Bill Amount");

		expoExcel.setRowData(rowData);
		exportToExcelList.add(expoExcel);
		for (int i = 0; i < getRepTaxSell.size(); i++) {
			expoExcel = new ExportToExcel();
			rowData = new ArrayList<String>();

			rowData.add("" + getRepTaxSell.get(i).getSellBillNo());
			rowData.add("" + getRepTaxSell.get(i).getFrId());
			rowData.add("" + getRepTaxSell.get(i).getFrName());
			rowData.add("" + getRepTaxSell.get(i).getBillDate());

			rowData.add("" + getRepTaxSell.get(i).getTax_per());
			rowData.add("" + getRepTaxSell.get(i).getCgst());
			rowData.add("" + getRepTaxSell.get(i).getSgst());
			rowData.add("" + getRepTaxSell.get(i).getIgst());
			rowData.add("" + getRepTaxSell.get(i).getCess());
			rowData.add("" + getRepTaxSell.get(i).getGstn());
			rowData.add("" + getRepTaxSell.get(i).getTax_amount());
			rowData.add("" + getRepTaxSell.get(i).getBill_amount());

			expoExcel.setRowData(rowData);
			exportToExcelList.add(expoExcel);

		}

		HttpSession session = request.getSession();
		session.setAttribute("exportExcelList", exportToExcelList);
		session.setAttribute("excelName", "TaxReportSell");

		return getRepTaxSell;

	}

	@RequestMapping(value = "/viewFrBillwiseTaxSellBill", method = RequestMethod.GET)
	public ModelAndView viewFrBillwiseTaxSellBill(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("report/sellReport/repFrBillwiseTaxSell");
		try {
			HttpSession ses = request.getSession();
			Franchisee frDetails = (Franchisee) ses.getAttribute("frDetails");
			model.addObject("frId", frDetails.getFrId());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return model;
	}

	@RequestMapping(value = "/getBillwiseTaxSellReport", method = RequestMethod.GET)
	public @ResponseBody List<GetRepTaxSell> getFrBillwiseTaxSellBill(HttpServletRequest request,
			HttpServletResponse response) {

		try {
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
			System.out.println(frId + fromDate + toDate);
			getRepTaxSell = new ArrayList<GetRepTaxSell>();

			ParameterizedTypeReference<List<GetRepTaxSell>> typeRef = new ParameterizedTypeReference<List<GetRepTaxSell>>() {
			};
			ResponseEntity<List<GetRepTaxSell>> responseEntity = restTemplate
					.exchange(Constant.URL + "getRepBillwiseTaxSell", HttpMethod.POST, new HttpEntity<>(map), typeRef);

			getRepTaxSell = responseEntity.getBody();
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}

		System.out.println("Sell Bill Header " + getRepTaxSell.toString());

		// export to excel

		List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

		ExportToExcel expoExcel = new ExportToExcel();
		List<String> rowData = new ArrayList<String>();

		rowData.add("Sell Bill No");
		rowData.add("Franchise Id");
		rowData.add("Franchise Name");
		rowData.add("Bill Date");
		rowData.add("Tax %");
		rowData.add("cgst");
		rowData.add("sgst");

		rowData.add("igst");

		rowData.add("cess");
		rowData.add("Gst");
		rowData.add("Tax Amount");
		rowData.add("Bill Amount");

		expoExcel.setRowData(rowData);
		exportToExcelList.add(expoExcel);
		for (int i = 0; i < getRepTaxSell.size(); i++) {
			expoExcel = new ExportToExcel();
			rowData = new ArrayList<String>();

			rowData.add("" + getRepTaxSell.get(i).getSellBillNo());
			rowData.add("" + getRepTaxSell.get(i).getFrId());
			rowData.add("" + getRepTaxSell.get(i).getFrName());
			rowData.add("" + getRepTaxSell.get(i).getBillDate());

			rowData.add("" + getRepTaxSell.get(i).getTax_per());
			rowData.add("" + getRepTaxSell.get(i).getCgst());
			rowData.add("" + getRepTaxSell.get(i).getSgst());
			rowData.add("" + getRepTaxSell.get(i).getIgst());
			rowData.add("" + getRepTaxSell.get(i).getCess());
			rowData.add("" + getRepTaxSell.get(i).getGstn());
			rowData.add("" + getRepTaxSell.get(i).getTax_amount());
			rowData.add("" + getRepTaxSell.get(i).getBill_amount());

			expoExcel.setRowData(rowData);
			exportToExcelList.add(expoExcel);

		}

		HttpSession session = request.getSession();
		session.setAttribute("exportExcelList", exportToExcelList);
		session.setAttribute("excelName", "BillWiseSellTaxReport");

		return getRepTaxSell;

	}

	@RequestMapping(value = "/viewFrDatewiseTaxSellBill", method = RequestMethod.GET)
	public ModelAndView viewFrDatewiseTaxSellBill(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("report/sellReport/repFrDatewiseTaxSell");
		try {
			HttpSession ses = request.getSession();
			Franchisee frDetails = (Franchisee) ses.getAttribute("frDetails");
			model.addObject("frId", frDetails.getFrId());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return model;
	}

	@RequestMapping(value = "/getDatewiseTaxSellReport", method = RequestMethod.GET)
	public @ResponseBody List<GetRepTaxSell> getFrDatewiseTaxSellBill(HttpServletRequest request,
			HttpServletResponse response) {

		try {
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
			getRepTaxSell = new ArrayList<GetRepTaxSell>();

			ParameterizedTypeReference<List<GetRepTaxSell>> typeRef = new ParameterizedTypeReference<List<GetRepTaxSell>>() {
			};
			ResponseEntity<List<GetRepTaxSell>> responseEntity = restTemplate
					.exchange(Constant.URL + "getRepDatewiseTaxSell", HttpMethod.POST, new HttpEntity<>(map), typeRef);

			getRepTaxSell = responseEntity.getBody();
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}

		System.out.println("Sell Bill Header " + getRepTaxSell.toString());

		// export to excel

		List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

		ExportToExcel expoExcel = new ExportToExcel();
		List<String> rowData = new ArrayList<String>();

		rowData.add("Sell Bill No");
		rowData.add("Franchise Id");
		rowData.add("Franchise Name");
		rowData.add("Bill Date");
		rowData.add("Tax %");
		rowData.add("cgst");
		rowData.add("sgst");

		rowData.add("igst");

		rowData.add("cess");
		rowData.add("Gst");
		rowData.add("Tax Amount");
		rowData.add("Bill Amount");

		expoExcel.setRowData(rowData);
		exportToExcelList.add(expoExcel);
		for (int i = 0; i < getRepTaxSell.size(); i++) {
			expoExcel = new ExportToExcel();
			rowData = new ArrayList<String>();

			rowData.add("" + getRepTaxSell.get(i).getSellBillNo());
			rowData.add("" + getRepTaxSell.get(i).getFrId());
			rowData.add("" + getRepTaxSell.get(i).getFrName());
			rowData.add("" + getRepTaxSell.get(i).getBillDate());

			rowData.add("" + getRepTaxSell.get(i).getTax_per());
			rowData.add("" + getRepTaxSell.get(i).getCgst());
			rowData.add("" + getRepTaxSell.get(i).getSgst());
			rowData.add("" + getRepTaxSell.get(i).getIgst());
			rowData.add("" + getRepTaxSell.get(i).getCess());
			rowData.add("" + getRepTaxSell.get(i).getGstn());
			rowData.add("" + getRepTaxSell.get(i).getTax_amount());
			rowData.add("" + getRepTaxSell.get(i).getBill_amount());

			expoExcel.setRowData(rowData);
			exportToExcelList.add(expoExcel);

		}

		HttpSession session = request.getSession();
		session.setAttribute("exportExcelList", exportToExcelList);
		session.setAttribute("excelName", "DateWiseSellTaxReport");

		return getRepTaxSell;

	}

	// Sell report End
	/*
	 * @RequestMapping(value = "/view1Chart", method = RequestMethod.GET) public
	 * ModelAndView viewChart(HttpServletRequest request, HttpServletResponse
	 * response) {
	 * 
	 * ModelAndView model = new ModelAndView("report/sellReport/datewiseChart");
	 * model.addObject("msg", "hhhh"); return model; }
	 */

	// Report PDF Begins

	@RequestMapping(value = "pdf/showSellDatewiseReportpPdf/{fromDate}/{toDate}/{frId}", method = RequestMethod.GET)
	public ModelAndView showSellDatewiseReportpPdf(@PathVariable String fromDate, @PathVariable String toDate,
			@PathVariable int frId, HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("report/sellReport/sellReportPdf/repFrSellDatewisePdf");
		RestTemplate restTemplate = new RestTemplate();
		try {
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("frId", frId);
			map.add("fromDate", fromDate);
			map.add("toDate", toDate);

			getRepFrDatewiseSellResponse = new ArrayList<GetRepFrDatewiseSellResponse>();

			ParameterizedTypeReference<List<GetRepFrDatewiseSellResponse>> typeRef = new ParameterizedTypeReference<List<GetRepFrDatewiseSellResponse>>() {
			};
			ResponseEntity<List<GetRepFrDatewiseSellResponse>> responseEntity = restTemplate
					.exchange(Constant.URL + "getRepDatewiseSell", HttpMethod.POST, new HttpEntity<>(map), typeRef);

			getRepFrDatewiseSellResponse = responseEntity.getBody();

			map = new LinkedMultiValueMap<String, Object>();

			map.add("frId", frId);
			Franchisee franchisee = restTemplate.getForObject(Constant.URL + "getFranchisee?frId={frId}",
					Franchisee.class, frId);
			model.addObject("frName", franchisee.getFrName());
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}
		model.addObject("fromDate", fromDate);
		model.addObject("toDate", toDate);

		model.addObject("reportList", getRepFrDatewiseSellResponse);
		return model;
	}

	@RequestMapping(value = "pdf/showSellMonthwiseReportpPdf/{fromDate}/{toDate}/{frId}", method = RequestMethod.GET)
	public ModelAndView showSellMonthwiseReportpPdf(@PathVariable String fromDate, @PathVariable String toDate,
			@PathVariable int frId, HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("report/sellReport/sellReportPdf/repFrMonthwiseSellPdf");
		try {
			String month[] = { "0", "Jan", "Feb", "Mar", "April", "May", "Jun", "July", "Aug", "Sep", "Oct", "Nov",
					"Dec" };

			DateTimeFormatter f = DateTimeFormatter.ofPattern("MM-uuuu");
			YearMonth ym = YearMonth.parse(fromDate, f);

			LocalDate fDate = ym.atDay(1);
			System.out.println("fdate" + fDate);

			YearMonth ym1 = YearMonth.parse(toDate, f);
			LocalDate tDate = ym1.atEndOfMonth();
			System.out.println("tdate" + tDate);

			RestTemplate restTemplate = new RestTemplate();

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("frId", frId);

			map.add("fromDate", "" + fDate);
			map.add("toDate", "" + tDate);

			getRepFrDatewiseSellResponse = new ArrayList<GetRepFrDatewiseSellResponse>();

			ParameterizedTypeReference<List<GetRepFrDatewiseSellResponse>> typeRef = new ParameterizedTypeReference<List<GetRepFrDatewiseSellResponse>>() {
			};
			ResponseEntity<List<GetRepFrDatewiseSellResponse>> responseEntity = restTemplate
					.exchange(Constant.URL + "getRepMonthwiseSell", HttpMethod.POST, new HttpEntity<>(map), typeRef);

			getRepFrDatewiseSellResponse = responseEntity.getBody();

			model.addObject("reportList", getRepFrDatewiseSellResponse);
			model.addObject("month", month);

			map = new LinkedMultiValueMap<String, Object>();

			map.add("frId", frId);
			Franchisee franchisee = restTemplate.getForObject(Constant.URL + "getFranchisee?frId={frId}",
					Franchisee.class, frId);
			model.addObject("frName", franchisee.getFrName());
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}
		return model;
	}

	@RequestMapping(value = "pdf/showSellItemwiseReportpPdf/{fromDate}/{toDate}/{frId}/{catId}", method = RequestMethod.GET)
	public ModelAndView showSellItemwiseReportpPdf(@PathVariable String fromDate, @PathVariable String toDate,
			@PathVariable int frId, @PathVariable int catId, HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("report/sellReport/sellReportPdf/repFrItemwiseSellPdf");
		RestTemplate restTemplate = new RestTemplate();
		try {
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("frId", frId);
			map.add("fromDate", fromDate);
			map.add("toDate", toDate);
			map.add("catId", catId);
			getRepFrItemwiseSellResponseList = new ArrayList<GetRepFrItemwiseSellResponse>();

			ParameterizedTypeReference<List<GetRepFrItemwiseSellResponse>> typeRef = new ParameterizedTypeReference<List<GetRepFrItemwiseSellResponse>>() {
			};
			ResponseEntity<List<GetRepFrItemwiseSellResponse>> responseEntity = restTemplate
					.exchange(Constant.URL + "getRepItemwiseSell", HttpMethod.POST, new HttpEntity<>(map), typeRef);

			getRepFrItemwiseSellResponseList = responseEntity.getBody();

			map = new LinkedMultiValueMap<String, Object>();

			map.add("frId", frId);
			Franchisee franchisee = restTemplate.getForObject(Constant.URL + "getFranchisee?frId={frId}",
					Franchisee.class, frId);
			model.addObject("frName", franchisee.getFrName());
			model.addObject("reportList", getRepFrItemwiseSellResponseList);
			model.addObject("fromDate", fromDate);
			model.addObject("toDate", toDate);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}
		return model;
	}

	@RequestMapping(value = "pdf/showSellDateItemwisewiseReportpPdf/{fromDate}/{toDate}/{frId}/{catId}", method = RequestMethod.GET)
	public ModelAndView showSellDateItemwisewiseReportpPdf(@PathVariable String fromDate, @PathVariable String toDate,
			@PathVariable int frId, @PathVariable int catId, HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("report/sellReport/sellReportPdf/repFrDateItemwiseSellPdf");
		RestTemplate restTemplate = new RestTemplate();
		try {
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("frId", frId);
			map.add("fromDate", fromDate);
			map.add("toDate", toDate);
			map.add("catId", catId);
			getRepFrItemwiseSellResponseList = new ArrayList<GetRepFrItemwiseSellResponse>();

			ParameterizedTypeReference<List<GetRepFrItemwiseSellResponse>> typeRef = new ParameterizedTypeReference<List<GetRepFrItemwiseSellResponse>>() {
			};
			ResponseEntity<List<GetRepFrItemwiseSellResponse>> responseEntity = restTemplate
					.exchange(Constant.URL + "getRepDateItemwiseSell", HttpMethod.POST, new HttpEntity<>(map), typeRef);

			getRepFrItemwiseSellResponseList = responseEntity.getBody();

			map = new LinkedMultiValueMap<String, Object>();

			map.add("frId", frId);
			Franchisee franchisee = restTemplate.getForObject(Constant.URL + "getFranchisee?frId={frId}",
					Franchisee.class, frId);
			model.addObject("frName", franchisee.getFrName());

			System.out.println("LList " + getRepFrItemwiseSellResponseList.toString());
			model.addObject("reportList", getRepFrItemwiseSellResponseList);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}
		return model;
	}

	@RequestMapping(value = "pdf/showSellBillwiseReportPdf/{fromDate}/{toDate}/{frId}", method = RequestMethod.GET)
	public ModelAndView showSellBillwiseReportpPdf(@PathVariable String fromDate, @PathVariable String toDate,
			@PathVariable int frId, HttpServletRequest request, HttpServletResponse response) {
		System.out.println("BILL LIST pdf");

		ModelAndView model = new ModelAndView("report/sellReport/sellReportPdf/repFrSellBillwiseSellPdf");
		try {
			System.out.println("BILL LIST try");

			/*
			 * HttpSession ses = request.getSession(); Franchisee frDetails = (Franchisee)
			 * ses.getAttribute("frDetails");
			 */
			RestTemplate restTemplate = new RestTemplate();

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			// int frId=frDetails.getFrId();
			map.add("frId", frId);
			map.add("fromDate", fromDate);
			map.add("toDate", toDate);

			getSellBillHeaderList = new ArrayList<GetSellBillHeader>();

			ParameterizedTypeReference<List<GetSellBillHeader>> typeRef = new ParameterizedTypeReference<List<GetSellBillHeader>>() {
			};
			ResponseEntity<List<GetSellBillHeader>> responseEntity = restTemplate
					.exchange(Constant.URL + "getSellBillHeader", HttpMethod.POST, new HttpEntity<>(map), typeRef);

			getSellBillHeaderList = responseEntity.getBody();
			System.out.println("BILL LIST" + getSellBillHeaderList.toString());

			map = new LinkedMultiValueMap<String, Object>();

			map.add("frId", frId);
			Franchisee franchisee = restTemplate.getForObject(Constant.URL + "getFranchisee?frId={frId}",
					Franchisee.class, frId);
			model.addObject("frName", franchisee.getFrName());

			model.addObject("fromDate", fromDate);
			model.addObject("toDate", toDate);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}

		model.addObject("reportList", getSellBillHeaderList);
		return model;
	}

	@RequestMapping(value = "pdf/showSellTaxReportpPdf/{fromDate}/{toDate}/{frId}", method = RequestMethod.GET)
	public ModelAndView showSellTaxReportpPdf(@PathVariable String fromDate, @PathVariable String toDate,
			@PathVariable int frId, HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("report/sellReport/sellReportPdf/repFrTaxSellPdf");

		RestTemplate restTemplate = new RestTemplate();
		try {
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("frId", frId);
			map.add("fromDate", fromDate);
			map.add("toDate", toDate);
			getRepTaxSell = new ArrayList<GetRepTaxSell>();
			getRepTaxSell = new ArrayList<GetRepTaxSell>();

			ParameterizedTypeReference<List<GetRepTaxSell>> typeRef = new ParameterizedTypeReference<List<GetRepTaxSell>>() {
			};
			ResponseEntity<List<GetRepTaxSell>> responseEntity = restTemplate.exchange(Constant.URL + "getRepTaxSell",
					HttpMethod.POST, new HttpEntity<>(map), typeRef);

			getRepTaxSell = responseEntity.getBody();
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}

		model.addObject("reportList", getRepTaxSell);
		return model;
	}

	@RequestMapping(value = "pdf/showSellTaxDatewiseReportpPdf/{fromDate}/{toDate}/{frId}", method = RequestMethod.GET)
	public ModelAndView showSellTaxDatewiseReportpPdf(@PathVariable String fromDate, @PathVariable String toDate,
			@PathVariable int frId, HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("report/sellReport/sellReportPdf/repFrDatewiseTaxSellPdf");
		RestTemplate restTemplate = new RestTemplate();
		try {
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("frId", frId);
			map.add("fromDate", fromDate);
			map.add("toDate", toDate);
			getRepTaxSell = new ArrayList<GetRepTaxSell>();

			ParameterizedTypeReference<List<GetRepTaxSell>> typeRef = new ParameterizedTypeReference<List<GetRepTaxSell>>() {
			};
			ResponseEntity<List<GetRepTaxSell>> responseEntity = restTemplate
					.exchange(Constant.URL + "getRepDatewiseTaxSell", HttpMethod.POST, new HttpEntity<>(map), typeRef);

			getRepTaxSell = responseEntity.getBody();

			model.addObject("reportList", getRepTaxSell);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}
		return model;
	}

	@RequestMapping(value = "pdf/showSellTaxBillwiseReportpPdf/{fromDate}/{toDate}/{frId}", method = RequestMethod.GET)
	public ModelAndView showSellTaxBillwiseReportpPdf(@PathVariable String fromDate, @PathVariable String toDate,
			@PathVariable int frId, HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("report/sellReport/sellReportPdf/repFrBillwiseTaxSellPdf");
		RestTemplate restTemplate = new RestTemplate();

		MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
		map.add("frId", frId);
		map.add("fromDate", fromDate);
		map.add("toDate", toDate);
		// getFrGrnDetail
		System.out.println(frId + fromDate + toDate);
		getRepTaxSell = new ArrayList<GetRepTaxSell>();
		try {

			ParameterizedTypeReference<List<GetRepTaxSell>> typeRef = new ParameterizedTypeReference<List<GetRepTaxSell>>() {
			};
			ResponseEntity<List<GetRepTaxSell>> responseEntity = restTemplate
					.exchange(Constant.URL + "getRepBillwiseTaxSell", HttpMethod.POST, new HttpEntity<>(map), typeRef);

			getRepTaxSell = responseEntity.getBody();
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}
		model.addObject("reportList", getRepTaxSell);
		return model;
	}

	@RequestMapping(value = "pdf/showPurchaseTaxBillwiseReportPdf/{fromDate}/{toDate}/{frId}", method = RequestMethod.GET)
	public ModelAndView showPurchaseTaxBillwiseReportpPdf(@PathVariable String fromDate, @PathVariable String toDate,
			@PathVariable int frId, HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("report/purchaseReport/purchaseReportPdf/billWiseTaxReportPdf");
		try {
			RestTemplate restTemplate = new RestTemplate();

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

			map.add("frId", frId);
			map.add("fromDate", Main.formatDate(fromDate));
			map.add("toDate", Main.formatDate(toDate));

			billWiseTaxReport = new ArrayList<BillWiseTaxReport>();

			BillWiseTaxReportList billWiseTaxReportList = restTemplate
					.postForObject(Constant.URL + "/showBillWiseTaxReport", map, BillWiseTaxReportList.class);

			billWiseTaxReport = billWiseTaxReportList.getBillWiseTaxReportList();

			model.addObject("reportList", billWiseTaxReport);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}

		return model;
	}

	@RequestMapping(value = "pdf/showPurchaseMonthwiseReportPdf/{fromDate}/{toDate}/{frId}", method = RequestMethod.GET)
	public ModelAndView showPurchaseMonthwiseReportpPdf(@PathVariable String fromDate, @PathVariable String toDate,
			@PathVariable int frId, HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("report/purchaseReport/purchaseReportPdf/monthWisePurchasePdf");
		try {
			String month[] = { "0", "Jan", "Feb", "Mar", "April", "May", "Jun", "July", "Aug", "Sep", "Oct", "Nov",
					"Dec" };
			DateTimeFormatter f = DateTimeFormatter.ofPattern("MM-uuuu");
			YearMonth ym = YearMonth.parse(fromDate, f);

			LocalDate fDate = ym.atDay(1);
			System.out.println("fdate" + fDate);

			YearMonth ym1 = YearMonth.parse(toDate, f);
			LocalDate tDate = ym1.atEndOfMonth();
			System.out.println("tdate" + tDate);

			RestTemplate restTemplate = new RestTemplate();

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

			map.add("frId", frId);
			map.add("fromDate", "" + fDate);
			map.add("toDate", "" + tDate);

			monthWiseReportList = new ArrayList<MonthWiseReport>();

			MonthWiseReportList monthWiseReportListBean = restTemplate
					.postForObject(Constant.URL + "/showMonthWiseReport", map, MonthWiseReportList.class);

			monthWiseReportList = monthWiseReportListBean.getMonthWiseReportList();
			map = new LinkedMultiValueMap<String, Object>();

			map.add("frId", frId);
			Franchisee franchisee = restTemplate.getForObject(Constant.URL + "getFranchisee?frId={frId}",
					Franchisee.class, frId);
			model.addObject("frName", franchisee.getFrName());

			model.addObject("month", month);
			model.addObject("reportList", monthWiseReportList);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}
		return model;
	}

	@RequestMapping(value = "pdf/showPurchaseItemwiseReportpPdf/{fromDate}/{toDate}/{frId}/{catId}", method = RequestMethod.GET)
	public ModelAndView showPurchaseItemwiseReportpPdf(@PathVariable String fromDate, @PathVariable String toDate,
			@PathVariable int frId, @PathVariable int catId, HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("report/purchaseReport/purchaseReportPdf/itemWiseReportPdf");
		RestTemplate restTemplate = new RestTemplate();
		try {
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

			map.add("frId", frId);
			map.add("fromDate", Main.formatDate(fromDate));
			map.add("toDate", Main.formatDate(toDate));
			map.add("catId", catId);

			itemWiseReportList = new ArrayList<ItemWiseReport>();

			ItemWiseReportList itemWiseList = restTemplate.postForObject(Constant.URL + "/showItemWiseReport", map,
					ItemWiseReportList.class);

			itemWiseReportList = itemWiseList.getItemWiseReportList();
			map = new LinkedMultiValueMap<String, Object>();

			map.add("frId", frId);
			Franchisee franchisee = restTemplate.getForObject(Constant.URL + "getFranchisee?frId={frId}",
					Franchisee.class, frId);
			model.addObject("frName", franchisee.getFrName());

			model.addObject("reportList", itemWiseReportList);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}
		return model;
	}

	@RequestMapping(value = "pdf/showPurchaseItemwiseDetailPdf/{fromDate}/{toDate}/{frId}/{catId}", method = RequestMethod.GET)
	public ModelAndView showPurchaseItemwiseDetailpPdf(@PathVariable String fromDate, @PathVariable String toDate,
			@PathVariable int frId, @PathVariable int catId, HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("report/purchaseReport/purchaseReportPdf/itemWiseDetailPdf");
		try {
			RestTemplate restTemplate = new RestTemplate();

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

			map.add("frId", frId);
			map.add("fromDate", Main.formatDate(fromDate));
			map.add("toDate", Main.formatDate(toDate));
			map.add("catId", catId);

			itemWiseDetailReportList = new ArrayList<ItemWiseDetail>();

			ItemWiseDetailList itemWiseDetailList = restTemplate
					.postForObject(Constant.URL + "/showItemWiseDetailsReport", map, ItemWiseDetailList.class);

			itemWiseDetailReportList = itemWiseDetailList.getItemWiseDetailList();

			map = new LinkedMultiValueMap<String, Object>();

			map.add("frId", frId);
			Franchisee franchisee = restTemplate.getForObject(Constant.URL + "getFranchisee?frId={frId}",
					Franchisee.class, frId);
			model.addObject("frName", franchisee.getFrName());

			model.addObject("reportList", itemWiseDetailReportList);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}

		return model;
	}

	@RequestMapping(value = "pdf/showPurchaseBillwiseReportPdf/{fromDate}/{toDate}/{frId}", method = RequestMethod.GET)
	public ModelAndView showPurchaseBillwiseReportPdf(@PathVariable String fromDate, @PathVariable String toDate,
			@PathVariable int frId, HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("report/purchaseReport/purchaseReportPdf/billWisePurchaseReportPdf");

		RestTemplate restTemplate = new RestTemplate();

		MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
		System.out.println("frId" + frId);

		map.add("frId", frId);
		map.add("fromDate", Main.formatDate(fromDate));
		map.add("toDate", Main.formatDate(toDate));

		billWisePurchaseReportList = new ArrayList<BillWisePurchaseReport>();
		try {
			BillWisePurchaseList billWisePurchaseList = restTemplate
					.postForObject(Constant.URL + "/showBillWisePurchaseReport", map, BillWisePurchaseList.class);

			billWisePurchaseReportList = billWisePurchaseList.getBillWisePurchaseList();

			map = new LinkedMultiValueMap<String, Object>();

			map.add("frId", frId);
			Franchisee franchisee = restTemplate.getForObject(Constant.URL + "getFranchisee?frId={frId}",
					Franchisee.class, frId);
			model.addObject("frName", franchisee.getFrName());

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}
		model.addObject("fromDate", fromDate);
		model.addObject("toDate", toDate);
		model.addObject("reportList", billWisePurchaseReportList);
		return model;
	}

	/*
	 * @RequestMapping(value = "/pdfCustBill", method = RequestMethod.GET) public
	 * ModelAndView demoBill(HttpServletRequest request, HttpServletResponse
	 * response) { String sellBillNo=request.getParameter("billNo"); //String
	 * fr_Id=request.getParameter("frId"); int billNo=Integer.parseInt(sellBillNo);
	 * //int billNo=Integer.parseInt(fr_Id); //HttpSession ses =
	 * request.getSession(); //Franchisee frDetails = (Franchisee)
	 * ses.getAttribute("frDetails");
	 * 
	 * 
	 * ModelAndView model=new ModelAndView("report/franchCompInvoice");
	 * 
	 * RestTemplate rest=new RestTemplate(); MultiValueMap<String, Object> map=new
	 * LinkedMultiValueMap<String, Object>();
	 * 
	 * map.add("billNo", billNo); if(frGstType!=0) { model=new
	 * ModelAndView("report/franchTaxInvoice"); List<GetCustBillTax>
	 * getCustBilTaxList=rest.postForObject(Constant.URL+"getCustomerBillTax", map,
	 * List.class);
	 * 
	 * model.addObject("custBilltax", getCustBilTaxList); }
	 * 
	 * List<GetCustmoreBillResponse>
	 * getCustmoreBillResponseList=rest.postForObject(Constant.URL+
	 * "getCustomerBill", map, List.class);
	 * 
	 * System.out.println("Custmore Bill : "+getCustmoreBillResponseList.toString())
	 * ;
	 * 
	 * model.addObject("billList", getCustmoreBillResponseList); return model; }
	 */

	private Dimension format = PD4Constants.A4;
	private boolean landscapeValue = false;
	private int topValue = 8;
	private int leftValue = 0;
	private int rightValue = 0;
	private int bottomValue = 8;
	private String unitsValue = "m";
	private String proxyHost = "";
	private int proxyPort = 0;

	private int userSpaceWidth = 750;
	private static int BUFFER_SIZE = 1024;

	@RequestMapping(value = "/pdf", method = RequestMethod.GET)
	public void showPDF(HttpServletRequest request, HttpServletResponse response) {

		String url = request.getParameter("reportURL");

		File f = new File("/opt/tomcat-latest/webapps/uploads/report.pdf");
		// File f = new File("/home/ats-12/pdf/ordermemo221.pdf");
		try {
			runConverter(Constant.ReportURL + url, f, request, response);
		} catch (IOException e) {
			// TODO Auto-generated catch block

			System.out.println("Pdf conversion exception " + e.getMessage());
		}

		// get absolute path of the application
		ServletContext context = request.getSession().getServletContext();
		String appPath = context.getRealPath("");
		String filename = "ordermemo221.pdf";
		String filePath = "/opt/tomcat-latest/webapps/uploads/report.pdf";
		// String filePath="/home/ats-12/pdf/ordermemo221.pdf";
		// construct the complete absolute path of the file
		String fullPath = appPath + filePath;
		File downloadFile = new File(filePath);
		FileInputStream inputStream = null;
		try {
			inputStream = new FileInputStream(downloadFile);
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {
			// get MIME type of the file
			String mimeType = context.getMimeType(fullPath);
			if (mimeType == null) {
				// set to binary type if MIME mapping not found
				mimeType = "application/pdf";
			}
			System.out.println("MIME type: " + mimeType);

			String headerKey = "Content-Disposition";

			// response.addHeader("Content-Disposition", "attachment;filename=report.pdf");
			response.setContentType("application/pdf");

			// get output stream of the response
			OutputStream outStream;

			outStream = response.getOutputStream();

			byte[] buffer = new byte[BUFFER_SIZE];
			int bytesRead = -1;

			// write bytes read from the input stream into the output stream

			while ((bytesRead = inputStream.read(buffer)) != -1) {
				outStream.write(buffer, 0, bytesRead);
			}

			inputStream.close();
			outStream.close();

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	private void runConverter(String urlstring, File output, HttpServletRequest request, HttpServletResponse response)
			throws IOException {

		if (urlstring.length() > 0) {
			if (!urlstring.startsWith("http://") && !urlstring.startsWith("file:")) {
				urlstring = "http://" + urlstring;
			}
			System.out.println("PDF URL " + urlstring);
			java.io.FileOutputStream fos = new java.io.FileOutputStream(output);

			PD4ML pd4ml = new PD4ML();

			try {

				Dimension landscapeA4 = pd4ml.changePageOrientation(PD4Constants.A4);
				pd4ml.setPageSize(landscapeA4);

				PD4PageMark footer = new PD4PageMark();

				footer.setPageNumberTemplate("Page $[page] of $[total]");
				footer.setPageNumberAlignment(PD4PageMark.RIGHT_ALIGN);
				footer.setFontSize(10);
				footer.setAreaHeight(20);

				pd4ml.setPageFooter(footer);

			} catch (Exception e) {
				System.out.println("Pdf conversion method excep " + e.getMessage());
			}

			if (unitsValue.equals("mm")) {
				pd4ml.setPageInsetsMM(new Insets(topValue, leftValue, bottomValue, rightValue));
			} else {
				pd4ml.setPageInsets(new Insets(topValue, leftValue, bottomValue, rightValue));
			}

			pd4ml.setHtmlWidth(userSpaceWidth);

			pd4ml.render(urlstring, fos);
		}
	}

	@RequestMapping(value = "/showCRNoteRegisterDone", method = RequestMethod.GET)
	public ModelAndView showCRNoteRegisterDone(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("reports/crNote_register_done");

		try {

			ZoneId z = ZoneId.of("Asia/Calcutta");

			LocalDate date = LocalDate.now(z);
			DateTimeFormatter formatters = DateTimeFormatter.ofPattern("d-MM-uuuu");
			String todaysDate = date.format(formatters);

			model.addObject("todaysDate", todaysDate);

		} catch (Exception e) {
			System.out.println("Exce in showRegCakeSpOrderReport " + e.getMessage());
			e.printStackTrace();
		}

		return model;
	}

	List<CrNoteRegItem> crNoteRegItemListDone = new ArrayList<>();
	// getCRNoteRegister Ajax

	@RequestMapping(value = "/getCRNoteRegisterDone", method = RequestMethod.GET)
	public @ResponseBody List<CrNoteRegItem> getCRNoteRegisterDone(HttpServletRequest request,
			HttpServletResponse response) throws FileNotFoundException {

		HttpSession ses = request.getSession();
		Franchisee frDetails = (Franchisee) ses.getAttribute("frDetails");

		MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

		RestTemplate restTemplate = new RestTemplate();

		System.out.println("inside getCRNoteRegister ajax call");

		String fromDate = request.getParameter("fromDate");
		String toDate = request.getParameter("toDate");
		try {

			map.add("fromDate", DateConvertor.convertToYMD(fromDate));

			map.add("toDate", DateConvertor.convertToYMD(toDate));
			map.add("frId", frDetails.getFrId());

			CrNoteRegisterList crnArray = restTemplate.postForObject(Constant.URL + "getCrNoteRegisterDoneByFrId", map,
					CrNoteRegisterList.class);

			List<CrNoteRegSp> crnRegSpList = new ArrayList<>();

			crNoteRegItemListDone = crnArray.getCrNoteRegItemList();
			crnRegSpList = crnArray.getCrNoteRegSpList();

			for (int j = 0; j < crnRegSpList.size(); j++) {
				int flag = 0;

				for (int i = 0; i < crNoteRegItemListDone.size(); i++) {

					if (crNoteRegItemListDone.get(i).getCrnId() == crnRegSpList.get(j).getCrnId()) {
						flag = 1;
						crNoteRegItemListDone.get(i)
								.setCrnQty(crNoteRegItemListDone.get(i).getCrnQty() + crnRegSpList.get(j).getCrnQty());

						crNoteRegItemListDone.get(i).setCrnTaxable(
								(crNoteRegItemListDone.get(i).getCrnTaxable() + crnRegSpList.get(j).getCrnTaxable()));

						crNoteRegItemListDone.get(i).setCgstAmt(
								(crNoteRegItemListDone.get(i).getCgstAmt() + crnRegSpList.get(j).getCgstAmt()));
						crNoteRegItemListDone.get(i).setSgstAmt(
								(crNoteRegItemListDone.get(i).getSgstAmt() + crnRegSpList.get(j).getSgstAmt()));
						crNoteRegItemListDone.get(i).setCrnAmt(
								(crNoteRegItemListDone.get(i).getCrnAmt() + crnRegSpList.get(j).getCrnAmt()));

					}

				}

				if (flag == 0) {

					System.err.println("New hsn code item found ");

					CrNoteRegItem regItem = new CrNoteRegItem();

					regItem.setCrnDate(crnRegSpList.get(j).getCrnDate());

					regItem.setBillDate(crnRegSpList.get(j).getBillDate());
					regItem.setCrndId(crnRegSpList.get(j).getCrndId());
					regItem.setCrnId(crnRegSpList.get(j).getCrnId());
					regItem.setCrnQty(crnRegSpList.get(j).getCrnQty());
					regItem.setCgstAmt(crnRegSpList.get(j).getCgstAmt());
					regItem.setCgstPer(crnRegSpList.get(j).getCgstPer());
					regItem.setFrGstNo(crnRegSpList.get(j).getFrGstNo());
					regItem.setFrName(crnRegSpList.get(j).getFrName());
					regItem.setCrnAmt(crnRegSpList.get(j).getCrnAmt());
					regItem.setHsnCode(crnRegSpList.get(j).getHsnCode());
					regItem.setInvoiceNo(crnRegSpList.get(j).getInvoiceNo());
					regItem.setSgstAmt(crnRegSpList.get(j).getSgstAmt());
					regItem.setSgstPer(crnRegSpList.get(j).getSgstPer());
					regItem.setCrnTaxable(crnRegSpList.get(j).getCrnTaxable());

					regItem.setFrCode(crnRegSpList.get(j).getFrCode());

					crNoteRegItemListDone.add(regItem);
				}
			}

			System.err.println("crNoteRegItemList combined  " + crNoteRegItemListDone.toString());

			List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

			ExportToExcel expoExcel = new ExportToExcel();
			List<String> rowData = new ArrayList<String>();

			rowData.add("Sr. No.");
			rowData.add("GSTIN/UIN of Recipient");
			rowData.add("Receiver Name");
			rowData.add("Invoice/Advance Receipt Number");
			rowData.add("Invoice/Advance Receipt date");
			rowData.add("Note/Refund Voucher Number");
			rowData.add("Note/Refund Voucher date");
			rowData.add("Document Type");
			rowData.add("Place Of Supply");
			rowData.add("Note/Refund Voucher Value");
			rowData.add("Applicable % of Tax Rate");
			rowData.add("Rate");
			rowData.add("Taxable Value");
			rowData.add("Cess Amount");

			expoExcel.setRowData(rowData);
			exportToExcelList.add(expoExcel);
			float crnQty = 0.0f;
			float crnTaxable = 0.0f;
			float cgstAmt = 0.0f;
			float sgstAmt = 0.0f;
			float crnAmt = 0.0f;

			for (int i = 0; i < crNoteRegItemListDone.size(); i++) {
				float crnTotal = 0.0f;
				for (int j = 0; j < crNoteRegItemListDone.size(); j++) {
					if (crNoteRegItemListDone.get(i).getCrnId() == crNoteRegItemListDone.get(j).getCrnId()) {
						crnTotal = crnTotal + roundUp(crNoteRegItemListDone.get(j).getCrnAmt());
					}
				}

				expoExcel = new ExportToExcel();
				rowData = new ArrayList<String>();
				rowData.add("" + (i + 1));
				rowData.add("" + crNoteRegItemListDone.get(i).getFrGstNo());
				rowData.add("" + crNoteRegItemListDone.get(i).getFrName());
				rowData.add("" + crNoteRegItemListDone.get(i).getInvoiceNo());
				rowData.add("" + crNoteRegItemListDone.get(i).getBillDate());
				rowData.add("" + crNoteRegItemListDone.get(i).getFrCode());
				rowData.add("" + crNoteRegItemListDone.get(i).getCrnDate());
				rowData.add(" ");
				rowData.add("27-Maharashtra");
				double crnTotalAmt = Double.parseDouble(crnTotal + " ");
				String strCrnAmt = String.format("%.0f", crnTotalAmt);
				rowData.add("" + strCrnAmt);
				rowData.add(" ");
				double crnTaxableAmt = Double.parseDouble(crNoteRegItemListDone.get(i).getCrnTaxable() + " ");
				String strCrnTaxable = String.format("%.0f", crnTaxableAmt);
				rowData.add(
						"" + (crNoteRegItemListDone.get(i).getCgstPer() + crNoteRegItemListDone.get(i).getSgstPer()));
				rowData.add("" + strCrnTaxable);
				rowData.add("0");

				crnQty = crnQty + crNoteRegItemListDone.get(i).getCrnQty();
				crnTaxable = crnTaxable + crNoteRegItemListDone.get(i).getCrnTaxable();
				cgstAmt = cgstAmt + crNoteRegItemListDone.get(i).getCgstAmt();
				sgstAmt = sgstAmt + crNoteRegItemListDone.get(i).getSgstAmt();
				crnAmt = crnAmt + crNoteRegItemListDone.get(i).getCrnAmt();

				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);

			}
			expoExcel = new ExportToExcel();
			rowData = new ArrayList<String>();
			rowData.add("Total");
			rowData.add("");
			rowData.add("");
			rowData.add("");
			rowData.add("");
			rowData.add("");
			rowData.add("");
			rowData.add("");
			rowData.add("");

			rowData.add("" + Math.round(crnAmt));
			rowData.add("");
			rowData.add("");

			rowData.add("" + roundUp(crnTaxable));

			rowData.add("");

			expoExcel.setRowData(rowData);
			exportToExcelList.add(expoExcel);

			HttpSession session = request.getSession();
			session.setAttribute("exportExcelList", exportToExcelList);
			session.setAttribute("excelName", "CrNoteRegItem");

		} catch (Exception e) {

			e.printStackTrace();

		}
		return crNoteRegItemListDone;
	}

	@RequestMapping(value = "/getCRNoteRegisterDonePdf/{fromdate}/{todate}", method = RequestMethod.GET)
	public void getCRNoteRegisterDonePdf(@PathVariable String fromdate, @PathVariable String todate,
			HttpServletRequest request, HttpServletResponse response) throws FileNotFoundException {

		Document document = new Document(PageSize.A4);
		document.setPageSize(PageSize.A4.rotate());
		// ByteArrayOutputStream out = new ByteArrayOutputStream();

		DateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
		Calendar cal = Calendar.getInstance();

		System.out.println("timegetCRNoteRegisterPdf PDF ==" + dateFormat.format(cal.getTime()));
		String timeStamp = dateFormat.format(cal.getTime());
		String FILE_PATH = Constant.REPORT_SAVE;
		File file = new File(FILE_PATH);

		PdfWriter writer = null;

		FileOutputStream out = new FileOutputStream(FILE_PATH);

		try {
			writer = PdfWriter.getInstance(document, out);
		} catch (DocumentException e) {

			e.printStackTrace();
		}

		PdfPTable table = new PdfPTable(13);
		table.setHeaderRows(1);
		try {
			System.out.println("Inside PDF Table try");
			table.setWidthPercentage(100);
			table.setWidths(
					new float[] { 0.7f, 1.1f, 2.0f, 2.1f, 2.3f, 2.0f, 2.2f, 1.2f, 1.2f, 1.2f, 0.9f, 0.9f, 1.2f });
			Font headFont = new Font(FontFamily.HELVETICA, 8, Font.NORMAL, BaseColor.BLACK);
			Font headFont1 = new Font(FontFamily.HELVETICA, 10, Font.BOLD, BaseColor.BLACK);
			Font f = new Font(FontFamily.TIMES_ROMAN, 10.0f, Font.UNDERLINE, BaseColor.BLUE);

			PdfPCell hcell;
			hcell = new PdfPCell(new Phrase("Sr.", headFont1));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(BaseColor.PINK);
			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("CRN No", headFont1));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(BaseColor.PINK);
			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("CRN Date", headFont1));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(BaseColor.PINK);
			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Invoice No", headFont1));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(BaseColor.PINK);
			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Invoice Date", headFont1));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(BaseColor.PINK);
			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Party Name", headFont1));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(BaseColor.PINK);
			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("GST No", headFont1));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(BaseColor.PINK);
			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Tax Rate", headFont1));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(BaseColor.PINK);
			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Bill Qty", headFont1)); // Varience title replaced with P2 Production
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(BaseColor.PINK);
			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Taxable Amt", headFont1)); // Varience title replaced with P2 Production
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(BaseColor.PINK);
			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("CGST Amt", headFont1)); // Varience title replaced with P2 Production
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(BaseColor.PINK);
			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("SGST Amt", headFont1)); // Varience title replaced with P2 Production
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(BaseColor.PINK);
			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Bill Amt", headFont1)); // Varience title replaced with P2 Production
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(BaseColor.PINK);
			table.addCell(hcell);

			int index = 0;
			for (int j = 0; j < crNoteRegItemListDone.size(); j++) {

				index++;
				PdfPCell cell;

				cell = new PdfPCell(new Phrase(String.valueOf(index), headFont));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_CENTER);
				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + crNoteRegItemListDone.get(j).getFrCode(), headFont));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);
				cell.setPaddingRight(1);
				table.addCell(cell);

				cell = new PdfPCell(new Phrase(String.valueOf(crNoteRegItemListDone.get(j).getCrnDate()), headFont));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);
				cell.setPaddingRight(1);
				table.addCell(cell);

				cell = new PdfPCell(new Phrase(crNoteRegItemListDone.get(j).getInvoiceNo(), headFont));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);
				cell.setPaddingRight(1);
				table.addCell(cell);

				cell = new PdfPCell(new Phrase(String.valueOf(crNoteRegItemListDone.get(j).getBillDate()), headFont));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);
				cell.setPaddingRight(1);
				table.addCell(cell);

				cell = new PdfPCell(new Phrase(String.valueOf(crNoteRegItemListDone.get(j).getFrName()), headFont));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);
				cell.setPaddingRight(1);
				table.addCell(cell);

				cell = new PdfPCell(new Phrase(String.valueOf(crNoteRegItemListDone.get(j).getFrGstNo()), headFont));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);
				cell.setPaddingRight(1);
				table.addCell(cell);

				cell = new PdfPCell(new Phrase(
						String.valueOf(roundUp(
								crNoteRegItemListDone.get(j).getCgstPer() + crNoteRegItemListDone.get(j).getSgstPer())),
						headFont));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
				cell.setPaddingRight(1);
				table.addCell(cell);

				cell = new PdfPCell(
						new Phrase(String.valueOf(roundUp(crNoteRegItemListDone.get(j).getCrnQty())), headFont));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
				cell.setPaddingRight(8);
				table.addCell(cell);

				double crnTaxable = Double.parseDouble(crNoteRegItemListDone.get(j).getCrnTaxable() + " ");
				String strCrnTaxable = String.format("%.0f", crnTaxable);

				cell = new PdfPCell(new Phrase(strCrnTaxable, headFont));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
				cell.setPaddingRight(8);
				table.addCell(cell);

				cell = new PdfPCell(
						new Phrase(String.valueOf(roundUp(crNoteRegItemListDone.get(j).getCgstAmt())), headFont));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
				cell.setPaddingRight(8);
				table.addCell(cell);

				cell = new PdfPCell(
						new Phrase(String.valueOf(roundUp(crNoteRegItemListDone.get(j).getSgstAmt())), headFont));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
				cell.setPaddingRight(8);
				table.addCell(cell);

				double crnAmt = Double.parseDouble(crNoteRegItemListDone.get(j).getCrnAmt() + " ");
				String strCrnAmt = String.format("%.0f", crnAmt);

				cell = new PdfPCell(new Phrase(strCrnAmt, headFont));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
				cell.setPaddingRight(8);
				table.addCell(cell);

			}
			document.open();

			Paragraph heading = new Paragraph(
					"Credit Note Register Done Report \n From Date:" + fromdate + " To Date:" + todate);
			heading.setAlignment(Element.ALIGN_CENTER);
			document.add(heading);

			DateFormat DF = new SimpleDateFormat("dd-MM-yyyy");

			document.add(new Paragraph("\n"));

			document.add(table);

			document.close();

			if (file != null) {

				String mimeType = URLConnection.guessContentTypeFromName(file.getName());

				if (mimeType == null) {

					mimeType = "application/pdf";

				}

				response.setContentType(mimeType);

				response.addHeader("content-disposition", String.format("inline; filename=\"%s\"", file.getName()));

				// response.setHeader("Content-Disposition", String.format("attachment;
				// filename=\"%s\"", file.getName()));

				response.setContentLength((int) file.length());

				InputStream inputStream = new BufferedInputStream(new FileInputStream(file));

				try {
					FileCopyUtils.copy(inputStream, response.getOutputStream());
				} catch (IOException e) {
					System.out.println("Excep in Opening a Pdf File");
					e.printStackTrace();
				}

			}

		} catch (DocumentException ex) {

			System.out.println("Pdf Generation Error: Prod From Orders" + ex.getMessage());

			ex.printStackTrace();

		}
	}

	@RequestMapping(value = "/showTaxReport", method = RequestMethod.GET)
	public ModelAndView showTaxReport(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = null;
		HttpSession session = request.getSession();
		String fromDate = "";
		String toDate = "";

		model = new ModelAndView("reports/tax1Report");
		// Constants.mainAct =2;
		// Constants.subAct =20;
		List<Tax1Report> taxReportList = null;

		try {

			RestTemplate restTemplate = new RestTemplate();

			HttpSession ses = request.getSession();
			Franchisee frDetails = (Franchisee) ses.getAttribute("frDetails");

			fromDate = request.getParameter("fromDate");
			toDate = request.getParameter("toDate");

			if (fromDate == null && toDate == null) {
				Date date = new Date();
				SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
				fromDate = formatter.format(date);
				toDate = formatter.format(date);
			}
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("fromDate", fromDate);
			map.add("toDate", toDate);
			map.add("frId", frDetails.getFrId());

			ParameterizedTypeReference<List<Tax1Report>> typeRef = new ParameterizedTypeReference<List<Tax1Report>>() {
			};
			ResponseEntity<List<Tax1Report>> responseEntity = restTemplate
					.exchange(Constant.URL + "getTax1ReportByFrId", HttpMethod.POST, new HttpEntity<>(map), typeRef);

			taxReportList = responseEntity.getBody();
			model.addObject("taxReportList", taxReportList);
			model.addObject("fromDate", fromDate);
			model.addObject("toDate", toDate);

			System.out.println("taxReportListtaxReportListtaxReportList" + taxReportList.toString());
			System.out.println("taxReportListtaxReportListtaxReportList" + fromDate);
			System.out.println("taxReportListtaxReportListtaxReportList" + toDate);

			// exportToExcel
			List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

			ExportToExcel expoExcel = new ExportToExcel();
			List<String> rowData = new ArrayList<String>();

			expoExcel = new ExportToExcel();
			rowData = new ArrayList<String>();
			rowData.add("Sr.No.");
			rowData.add("GSTIN/UIN of Recipient");
			rowData.add("Receiver Name");
			rowData.add("Invoice No");
			rowData.add("Invoice date");
			rowData.add("Invoice Value");
			rowData.add("Place of Supply");
			rowData.add("Reverse Charge");

			rowData.add("Applicable % of Tax Rate");
			rowData.add("Invoice Type");
			rowData.add("E Commerce GSTIN");
			rowData.add("Rate");
			rowData.add("Taxable Value");
			rowData.add("Cess Amount");

			expoExcel.setRowData(rowData);
			exportToExcelList.add(expoExcel);

			float taxableAmt = 0.0f;
			float cgstSum = 0.0f;
			float sgstSum = 0.0f;

			float totalTax = 0.0f;
			float totalFinal = 0.0f;
			float grandTotal = 0.0f;

			for (int i = 0; i < taxReportList.size(); i++) {
				float finalTotal = 0;
				for (int j = 0; j < taxReportList.size(); j++) {

					if (taxReportList.get(j).getBillNo() == taxReportList.get(i).getBillNo()) {
						finalTotal = finalTotal + taxReportList.get(j).getGrandTotal();
					}
				}

				taxableAmt = taxableAmt + taxReportList.get(i).getTaxableAmt();
				cgstSum = cgstSum + taxReportList.get(i).getCgstAmt();
				sgstSum = sgstSum + taxReportList.get(i).getSgstAmt();

				totalTax = totalTax + taxReportList.get(i).getTotalTax();
				grandTotal = grandTotal + taxReportList.get(i).getGrandTotal();
				totalFinal = totalFinal + finalTotal;

				expoExcel = new ExportToExcel();
				rowData = new ArrayList<String>();
				rowData.add((i + 1) + "");
				rowData.add("" + taxReportList.get(i).getFrGstNo());
				rowData.add("" + taxReportList.get(i).getFrName());
				rowData.add("" + taxReportList.get(i).getInvoiceNo());
				rowData.add("" + taxReportList.get(i).getBillDate());

				rowData.add("" + finalTotal);
				rowData.add("27-Maharashtra");
				rowData.add("N");
				rowData.add(" ");

				rowData.add("Regular");
				rowData.add(" ");

				rowData.add("" + (taxReportList.get(i).getCgstPer() + taxReportList.get(i).getSgstPer()));
				rowData.add("" + taxReportList.get(i).getTaxableAmt());
				rowData.add("0");

				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);

			}

			expoExcel = new ExportToExcel();
			rowData = new ArrayList<String>();

			rowData.add("Total");
			rowData.add("");
			rowData.add("");
			rowData.add("");
			rowData.add("");
			rowData.add("" + roundUp(totalFinal));
			rowData.add("");
			rowData.add("");
			rowData.add("");
			rowData.add("");
			rowData.add("");
			rowData.add("");
			rowData.add("");
			rowData.add("");

			expoExcel.setRowData(rowData);
			exportToExcelList.add(expoExcel);

			session.setAttribute("exportExcelList", exportToExcelList);
			session.setAttribute("excelName", "Tax1Report");
		} catch (Exception e) {
			System.out.println("Exc in Tax Report" + e.getMessage());
			e.printStackTrace();
		}

		return model;

	}
}
