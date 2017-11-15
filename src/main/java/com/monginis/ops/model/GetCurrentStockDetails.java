package com.monginis.ops.model;

public class GetCurrentStockDetails {
	
	private int stockDetailId;

	private int itemId;

	private String itemName;

	private int regOpeningStock;

	private int spOpeningStock;
	
	private int regTotalPurchase;
	
	private int spTotalPurchase;
	
	private int regTotalGrnGvn;
	
	private int regTotalSell;

	private int spTotalSell;
	
	private int stockHeaderId;
	
	private int currentRegStock;
	
	private int currentSpStock;
	
	

	public int getStockDetailId() {
		return stockDetailId;
	}

	public void setStockDetailId(int stockDetailId) {
		this.stockDetailId = stockDetailId;
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

	public int getRegOpeningStock() {
		return regOpeningStock;
	}

	public void setRegOpeningStock(int regOpeningStock) {
		this.regOpeningStock = regOpeningStock;
	}

	public int getSpOpeningStock() {
		return spOpeningStock;
	}

	public void setSpOpeningStock(int spOpeningStock) {
		this.spOpeningStock = spOpeningStock;
	}

	public int getRegTotalPurchase() {
		return regTotalPurchase;
	}

	public void setRegTotalPurchase(int regTotalPurchase) {
		this.regTotalPurchase = regTotalPurchase;
	}

	public int getSpTotalPurchase() {
		return spTotalPurchase;
	}

	public void setSpTotalPurchase(int spTotalPurchase) {
		this.spTotalPurchase = spTotalPurchase;
	}

	public int getRegTotalGrnGvn() {
		return regTotalGrnGvn;
	}

	public void setRegTotalGrnGvn(int regTotalGrnGvn) {
		this.regTotalGrnGvn = regTotalGrnGvn;
	}

	public int getRegTotalSell() {
		return regTotalSell;
	}

	public void setRegTotalSell(int regTotalSell) {
		this.regTotalSell = regTotalSell;
	}

	public int getSpTotalSell() {
		return spTotalSell;
	}

	public void setSpTotalSell(int spTotalSell) {
		this.spTotalSell = spTotalSell;
	}

	public int getStockHeaderId() {
		return stockHeaderId;
	}

	public void setStockHeaderId(int stockHeaderId) {
		this.stockHeaderId = stockHeaderId;
	}

	public int getCurrentRegStock() {
		return currentRegStock;
	}

	public void setCurrentRegStock(int currentRegStock) {
		this.currentRegStock = currentRegStock;
	}

	public int getCurrentSpStock() {
		return currentSpStock;
	}

	public void setCurrentSpStock(int currentSpStock) {
		this.currentSpStock = currentSpStock;
	}

	@Override
	public String toString() {
		return "GetCurrentStockDetails [stockDetailId=" + stockDetailId + ", itemId=" + itemId + ", itemName="
				+ itemName + ", regOpeningStock=" + regOpeningStock + ", spOpeningStock=" + spOpeningStock
				+ ", regTotalPurchase=" + regTotalPurchase + ", spTotalPurchase=" + spTotalPurchase
				+ ", regTotalGrnGvn=" + regTotalGrnGvn + ", regTotalSell=" + regTotalSell + ", spTotalSell="
				+ spTotalSell + ", stockHeaderId=" + stockHeaderId + ", currentRegStock=" + currentRegStock
				+ ", currentSpStock=" + currentSpStock + "]";
	}
	

}
