package com.monginis.ops.model;

public class FrPurchaseDash {

	private float prevPurchaseTotal;
	private float curPurchaseTotal;

	private float prevGrnTotal;
	private float curGrnTotal;

	private float prevGvnTotal;
	private float curGvnTotal;

	private float preActualTotal;
	private float curActualTotal;

	public float getPrevPurchaseTotal() {
		return prevPurchaseTotal;
	}

	public void setPrevPurchaseTotal(float prevPurchaseTotal) {
		this.prevPurchaseTotal = prevPurchaseTotal;
	}

	public float getCurPurchaseTotal() {
		return curPurchaseTotal;
	}

	public void setCurPurchaseTotal(float curPurchaseTotal) {
		this.curPurchaseTotal = curPurchaseTotal;
	}

	public float getPrevGrnTotal() {
		return prevGrnTotal;
	}

	public void setPrevGrnTotal(float prevGrnTotal) {
		this.prevGrnTotal = prevGrnTotal;
	}

	public float getCurGrnTotal() {
		return curGrnTotal;
	}

	public void setCurGrnTotal(float curGrnTotal) {
		this.curGrnTotal = curGrnTotal;
	}

	public float getPrevGvnTotal() {
		return prevGvnTotal;
	}

	public void setPrevGvnTotal(float prevGvnTotal) {
		this.prevGvnTotal = prevGvnTotal;
	}

	public float getCurGvnTotal() {
		return curGvnTotal;
	}

	public void setCurGvnTotal(float curGvnTotal) {
		this.curGvnTotal = curGvnTotal;
	}

	public float getPreActualTotal() {
		return preActualTotal;
	}

	public void setPreActualTotal(float preActualTotal) {
		this.preActualTotal = preActualTotal;
	}

	public float getCurActualTotal() {
		return curActualTotal;
	}

	public void setCurActualTotal(float curActualTotal) {
		this.curActualTotal = curActualTotal;
	}

	@Override
	public String toString() {
		return "FrPurchaseDash [prevPurchaseTotal=" + prevPurchaseTotal + ", curPurchaseTotal=" + curPurchaseTotal
				+ ", prevGrnTotal=" + prevGrnTotal + ", curGrnTotal=" + curGrnTotal + ", prevGvnTotal=" + prevGvnTotal
				+ ", curGvnTotal=" + curGvnTotal + ", preActualTotal=" + preActualTotal + ", curActualTotal="
				+ curActualTotal + "]";
	}

}
