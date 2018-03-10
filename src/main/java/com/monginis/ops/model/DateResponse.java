package com.monginis.ops.model;

import java.io.Serializable;

public class DateResponse implements Serializable{

	private String deliveryToDate;
	
	private String deliveryFromDate;

	public String getDeliveryToDate() {
		return deliveryToDate;
	}

	public void setDeliveryToDate(String deliveryToDate) {
		this.deliveryToDate = deliveryToDate;
	}

	public String getDeliveryFromDate() {
		return deliveryFromDate;
	}

	public void setDeliveryFromDate(String deliveryFromDate) {
		this.deliveryFromDate = deliveryFromDate;
	}

	@Override
	public String toString() {
		return "DateResponse [deliveryToDate=" + deliveryToDate + ", deliveryFromDate=" + deliveryFromDate + "]";
	}

    
}
