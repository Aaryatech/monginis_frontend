
package com.monginis.ops.billing;


public class GetBillDetail {

    private Integer billDetailNo;
    private Integer billNo;
    private Integer menuId;
    private Integer catId;
    private Integer itemId;
    private Integer orderQty;
    private Integer billQty;
    private Integer orderId;
    private Integer rateType;
    private float rate;
    private float mrp;
    private float grandTotal;
    private float sgstPer;
    private float sgstRs;
    private float cgstPer;
    private float cgstRs;
    private float igstPer;
    private float igstRs;
    private float taxableAmt;
    private String remark;
    private Integer delStaus;
    private String itemName;
    private String catName;
    private String billDate;
    private float base_rate;
	public Integer getBillDetailNo() {
		return billDetailNo;
	}
	public void setBillDetailNo(Integer billDetailNo) {
		this.billDetailNo = billDetailNo;
	}
	public Integer getBillNo() {
		return billNo;
	}
	public void setBillNo(Integer billNo) {
		this.billNo = billNo;
	}
	public Integer getMenuId() {
		return menuId;
	}
	public void setMenuId(Integer menuId) {
		this.menuId = menuId;
	}
	public Integer getCatId() {
		return catId;
	}
	public void setCatId(Integer catId) {
		this.catId = catId;
	}
	public Integer getItemId() {
		return itemId;
	}
	public void setItemId(Integer itemId) {
		this.itemId = itemId;
	}
	public Integer getOrderQty() {
		return orderQty;
	}
	public void setOrderQty(Integer orderQty) {
		this.orderQty = orderQty;
	}
	public Integer getBillQty() {
		return billQty;
	}
	public void setBillQty(Integer billQty) {
		this.billQty = billQty;
	}
	public Integer getOrderId() {
		return orderId;
	}
	public void setOrderId(Integer orderId) {
		this.orderId = orderId;
	}
	public Integer getRateType() {
		return rateType;
	}
	public void setRateType(Integer rateType) {
		this.rateType = rateType;
	}
	public float getRate() {
		return rate;
	}
	public void setRate(float rate) {
		this.rate = rate;
	}
	
	public float getMrp() {
		return mrp;
	}
	public void setMrp(float mrp) {
		this.mrp = mrp;
	}
	public float getGrandTotal() {
		return grandTotal;
	}
	public void setGrandTotal(float grandTotal) {
		this.grandTotal = grandTotal;
	}
	public float getSgstPer() {
		return sgstPer;
	}
	public void setSgstPer(float sgstPer) {
		this.sgstPer = sgstPer;
	}
	public float getSgstRs() {
		return sgstRs;
	}
	public void setSgstRs(float sgstRs) {
		this.sgstRs = sgstRs;
	}
	public float getCgstPer() {
		return cgstPer;
	}
	public void setCgstPer(float cgstPer) {
		this.cgstPer = cgstPer;
	}
	public float getCgstRs() {
		return cgstRs;
	}
	public void setCgstRs(float cgstRs) {
		this.cgstRs = cgstRs;
	}
	public float getIgstPer() {
		return igstPer;
	}
	public void setIgstPer(float igstPer) {
		this.igstPer = igstPer;
	}
	public float getIgstRs() {
		return igstRs;
	}
	public void setIgstRs(float igstRs) {
		this.igstRs = igstRs;
	}
	public float getTaxableAmt() {
		return taxableAmt;
	}
	public void setTaxableAmt(float taxableAmt) {
		this.taxableAmt = taxableAmt;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public Integer getDelStaus() {
		return delStaus;
	}
	public void setDelStaus(Integer delStaus) {
		this.delStaus = delStaus;
	}
	public String getItemName() {
		return itemName;
	}
	public void setItemName(String itemName) {
		this.itemName = itemName;
	}
	public String getCatName() {
		return catName;
	}
	public void setCatName(String catName) {
		this.catName = catName;
	}
	public String getBillDate() {
		return billDate;
	}
	public void setBillDate(String billDate) {
		this.billDate = billDate;
	}
	public float getBase_rate() {
		return base_rate;
	}
	public void setBase_rate(float base_rate) {
		this.base_rate = base_rate;
	}
	@Override
	public String toString() {
		return "GetBillDetail [billDetailNo=" + billDetailNo + ", billNo=" + billNo + ", menuId=" + menuId + ", catId="
				+ catId + ", itemId=" + itemId + ", orderQty=" + orderQty + ", billQty=" + billQty + ", orderId="
				+ orderId + ", rateType=" + rateType + ", rate=" + rate + ", mrp=" + mrp + ", grandTotal=" + grandTotal
				+ ", sgstPer=" + sgstPer + ", sgstRs=" + sgstRs + ", cgstPer=" + cgstPer + ", cgstRs=" + cgstRs
				+ ", igstPer=" + igstPer + ", igstRs=" + igstRs + ", taxableAmt=" + taxableAmt + ", remark=" + remark
				+ ", delStaus=" + delStaus + ", itemName=" + itemName + ", catName=" + catName + ", billDate="
				+ billDate + ", base_rate=" + base_rate + "]";
	}
    
    

  
}
