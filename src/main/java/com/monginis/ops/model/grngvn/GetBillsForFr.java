package com.monginis.ops.model.grngvn;

import java.util.Date;

public class GetBillsForFr {
	
	
	private int billNo;
	
	private int invoiceNo;
	
	private String billDate;

	public int getBillNo() {
		return billNo;
	}

	public void setBillNo(int billNo) {
		this.billNo = billNo;
	}

	public int getInvoiceNo() {
		return invoiceNo;
	}

	public void setInvoiceNo(int invoiceNo) {
		this.invoiceNo = invoiceNo;
	}

	public String getBillDate() {
		return billDate;
	}

	public void setBillDate(String billDate) {
		this.billDate = billDate;
	}

	@Override
	public String toString() {
		return "GetBillsForFr [billNo=" + billNo + ", invoiceNo=" + invoiceNo + ", billDate=" + billDate + "]";
	}

	
	

}
