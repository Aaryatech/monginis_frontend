package com.monginis.ops.model.spadvreport;


public class RegCakeAsSpOrderReport {

	private int rspId;
	
	private float mrp;
	
	private int qty;
	
	private float rspSubTotal;
	
	private float tax1;
	
	private float tax1Amt;
	
	private float tax2;
	
	private float tax2Amt;
	
	private String rspCustName;
	
	private String subCatName;
	
	private String itemName;

	public int getRspId() {
		return rspId;
	}

	public float getMrp() {
		return mrp;
	}

	public int getQty() {
		return qty;
	}

	public float getRspSubTotal() {
		return rspSubTotal;
	}

	public float getTax1() {
		return tax1;
	}

	public float getTax1Amt() {
		return tax1Amt;
	}

	public float getTax2() {
		return tax2;
	}

	public float getTax2Amt() {
		return tax2Amt;
	}

	public String getRspCustName() {
		return rspCustName;
	}

	public String getSubCatName() {
		return subCatName;
	}

	public String getItemName() {
		return itemName;
	}

	public void setRspId(int rspId) {
		this.rspId = rspId;
	}

	public void setMrp(float mrp) {
		this.mrp = mrp;
	}

	public void setQty(int qty) {
		this.qty = qty;
	}

	public void setRspSubTotal(float rspSubTotal) {
		this.rspSubTotal = rspSubTotal;
	}

	public void setTax1(float tax1) {
		this.tax1 = tax1;
	}

	public void setTax1Amt(float tax1Amt) {
		this.tax1Amt = tax1Amt;
	}

	public void setTax2(float tax2) {
		this.tax2 = tax2;
	}

	public void setTax2Amt(float tax2Amt) {
		this.tax2Amt = tax2Amt;
	}

	public void setRspCustName(String rspCustName) {
		this.rspCustName = rspCustName;
	}

	public void setSubCatName(String subCatName) {
		this.subCatName = subCatName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	@Override
	public String toString() {
		return "RegCakeAsSpOrderReport [rspId=" + rspId + ", mrp=" + mrp + ", qty=" + qty + ", rspSubTotal="
				+ rspSubTotal + ", tax1=" + tax1 + ", tax1Amt=" + tax1Amt + ", tax2=" + tax2 + ", tax2Amt=" + tax2Amt
				+ ", rspCustName=" + rspCustName + ", subCatName=" + subCatName + ", itemName=" + itemName + "]";
	}
	
}
