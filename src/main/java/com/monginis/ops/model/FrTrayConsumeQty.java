package com.monginis.ops.model;

public class FrTrayConsumeQty {

	private int orderId;
	private int frId;
	private float orderQty;
	private float trayQty;

	public int getOrderId() {
		return orderId;
	}

	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}

	public int getFrId() {
		return frId;
	}

	public void setFrId(int frId) {
		this.frId = frId;
	}

	public float getOrderQty() {
		return orderQty;
	}

	public void setOrderQty(float orderQty) {
		this.orderQty = orderQty;
	}

	public float getTrayQty() {
		return trayQty;
	}

	public void setTrayQty(float trayQty) {
		this.trayQty = trayQty;
	}

	@Override
	public String toString() {
		return "FrTrayConsumeQty [orderId=" + orderId + ", frId=" + frId + ", orderQty=" + orderQty + ", trayQty="
				+ trayQty + "]";
	}

}
