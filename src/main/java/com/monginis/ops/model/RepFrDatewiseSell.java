package com.monginis.ops.model;

import java.util.Date;

public class RepFrDatewiseSell {

	
	private int cashAmt;
	private int cardAmt;
	private int otherAmt;
	private Date date;
	public int getCashAmt() {
		return cashAmt;
	}
	public void setCashAmt(int cashAmt) {
		this.cashAmt = cashAmt;
	}
	public int getCardAmt() {
		return cardAmt;
	}
	public void setCardAmt(int cardAmt) {
		this.cardAmt = cardAmt;
	}
	public int getOtherAmt() {
		return otherAmt;
	}
	public void setOtherAmt(int otherAmt) {
		this.otherAmt = otherAmt;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	@Override
	public String toString() {
		return "RepFrDatewiseSell [cashAmt=" + cashAmt + ", cardAmt=" + cardAmt + ", otherAmt=" + otherAmt + ", date="
				+ date + "]";
	}
	
	
}
