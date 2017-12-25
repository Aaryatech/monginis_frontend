package com.monginis.ops.model;

public class FranchiseSup{
	

	private boolean error;
	
	private String message;
	
	private int id;
	
	private int frId;
	
	private String frPanNo;
	
	private String frState;
	
	private String frCountry;
	
	private String pass1;

	private String pass2;

	private String pass3;

	
	private int delStatus;

	
	public String getPass1() {
		return pass1;
	}

	public void setPass1(String pass1) {
		this.pass1 = pass1;
	}

	public String getPass2() {
		return pass2;
	}

	public void setPass2(String pass2) {
		this.pass2 = pass2;
	}

	public String getPass3() {
		return pass3;
	}

	public void setPass3(String pass3) {
		this.pass3 = pass3;
	}

	public boolean isError() {
		return error;
	}

	public void setError(boolean error) {
		this.error = error;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getFrId() {
		return frId;
	}

	public void setFrId(int frId) {
		this.frId = frId;
	}

	public String getFrPanNo() {
		return frPanNo;
	}

	public void setFrPanNo(String frPanNo) {
		this.frPanNo = frPanNo;
	}

	public String getFrState() {
		return frState;
	}

	public void setFrState(String frState) {
		this.frState = frState;
	}

	public String getFrCountry() {
		return frCountry;
	}

	public void setFrCountry(String frCountry) {
		this.frCountry = frCountry;
	}

	public int getDelStatus() {
		return delStatus;
	}

	public void setDelStatus(int delStatus) {
		this.delStatus = delStatus;
	}

	@Override
	public String toString() {
		return "FranchiseSup [error=" + error + ", message=" + message + ", id=" + id + ", frId=" + frId + ", frPanNo="
				+ frPanNo + ", frState=" + frState + ", frCountry=" + frCountry + ", pass1=" + pass1 + ", pass2="
				+ pass2 + ", pass3=" + pass3 + ", delStatus=" + delStatus + "]";
	}
    
}
