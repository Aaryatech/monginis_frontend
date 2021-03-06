package com.monginis.ops.model;
import java.sql.Date;
import java.util.List;



public class GetCustmoreBillResponse {


private int sellBillDetailNo;

private int sellBillNo;

private String invoiceNo;

private Date billDate;

private String custName;

private String frAddress;

private int frId;

private String frMob;

private String frName;

private int itemId;

private String itemName;

private float taxableAmt;

private float discountPer;


private float discountAmt;

 
private int intBillAmt;

private int intDiscAmt;

private float cgstPer;

private float sgstPer;

private float igstPer;

private String gstn;

private float bill_amount;

private float mrp;

private int qty;

private float igstRs;

private float cgstRs;

private float sgstRs;

private String itemHsncd; //mahendra 12-03-2021

public int getSellBillDetailNo() {
	return sellBillDetailNo;
}

public void setSellBillDetailNo(int sellBillDetailNo) {
	this.sellBillDetailNo = sellBillDetailNo;
}

public int getSellBillNo() {
	return sellBillNo;
}

public void setSellBillNo(int sellBillNo) {
	this.sellBillNo = sellBillNo;
}

public String getInvoiceNo() {
	return invoiceNo;
}

public void setInvoiceNo(String invoiceNo) {
	this.invoiceNo = invoiceNo;
}

public Date getBillDate() {
	return billDate;
}

public void setBillDate(Date billDate) {
	this.billDate = billDate;
}

public String getCustName() {
	return custName;
}

public void setCustName(String custName) {
	this.custName = custName;
}

public String getFrAddress() {
	return frAddress;
}

public void setFrAddress(String frAddress) {
	this.frAddress = frAddress;
}

public int getFrId() {
	return frId;
}

public void setFrId(int frId) {
	this.frId = frId;
}

public String getFrMob() {
	return frMob;
}

public void setFrMob(String frMob) {
	this.frMob = frMob;
}

public String getFrName() {
	return frName;
}

public void setFrName(String frName) {
	this.frName = frName;
}

public int getItemId() {
	return itemId;
}

public void setItemId(int itemId) {
	this.itemId = itemId;
}

public String getItemName() {
	return itemName;
}

public void setItemName(String itemName) {
	this.itemName = itemName;
}

public float getTaxableAmt() {
	return taxableAmt;
}

public void setTaxableAmt(float taxableAmt) {
	this.taxableAmt = taxableAmt;
}

public float getCgstPer() {
	return cgstPer;
}

public void setCgstPer(float cgstPer) {
	this.cgstPer = cgstPer;
}

public float getSgstPer() {
	return sgstPer;
}

public void setSgstPer(float sgstPer) {
	this.sgstPer = sgstPer;
}

public float getIgstPer() {
	return igstPer;
}

public void setIgstPer(float igstPer) {
	this.igstPer = igstPer;
}

public String getGstn() {
	return gstn;
}

public void setGstn(String gstn) {
	this.gstn = gstn;
}

public float getBill_amount() {
	return bill_amount;
}

public void setBill_amount(float bill_amount) {
	this.bill_amount = bill_amount;
}

public float getMrp() {
	return mrp;
}

public void setMrp(float mrp) {
	this.mrp = mrp;
}

public int getQty() {
	return qty;
}

public void setQty(int qty) {
	this.qty = qty;
}

public float getIgstRs() {
	return igstRs;
}

public void setIgstRs(float igstRs) {
	this.igstRs = igstRs;
}

public float getCgstRs() {
	return cgstRs;
}

public void setCgstRs(float cgstRs) {
	this.cgstRs = cgstRs;
}

public float getSgstRs() {
	return sgstRs;
}

public void setSgstRs(float sgstRs) {
	this.sgstRs = sgstRs;
}

public float getDiscountPer() {
	return discountPer;
}

public void setDiscountPer(float discountPer) {
	this.discountPer = discountPer;
}

public float getDiscountAmt() {
	return discountAmt;
}

public void setDiscountAmt(float discountAmt) {
	this.discountAmt = discountAmt;
}

public int getIntBillAmt() {
	return intBillAmt;
}

public void setIntBillAmt(int intBillAmt) {
	this.intBillAmt = intBillAmt;
}

public int getIntDiscAmt() {
	return intDiscAmt;
}

public void setIntDiscAmt(int intDiscAmt) {
	this.intDiscAmt = intDiscAmt;
}

public String getItemHsncd() {
	return itemHsncd;
}

public void setItemHsncd(String itemHsncd) {
	this.itemHsncd = itemHsncd;
}

@Override
public String toString() {
	return "GetCustmoreBillResponse [sellBillDetailNo=" + sellBillDetailNo + ", sellBillNo=" + sellBillNo
			+ ", invoiceNo=" + invoiceNo + ", billDate=" + billDate + ", custName=" + custName + ", frAddress="
			+ frAddress + ", frId=" + frId + ", frMob=" + frMob + ", frName=" + frName + ", itemId=" + itemId
			+ ", itemName=" + itemName + ", taxableAmt=" + taxableAmt + ", discountPer=" + discountPer
			+ ", discountAmt=" + discountAmt + ", intBillAmt=" + intBillAmt + ", intDiscAmt=" + intDiscAmt
			+ ", cgstPer=" + cgstPer + ", sgstPer=" + sgstPer + ", igstPer=" + igstPer + ", gstn=" + gstn
			+ ", bill_amount=" + bill_amount + ", mrp=" + mrp + ", qty=" + qty + ", igstRs=" + igstRs + ", cgstRs="
			+ cgstRs + ", sgstRs=" + sgstRs + ", itemHsncd=" + itemHsncd + "]";
}


}
