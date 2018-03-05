package com.monginis.ops.model.grngvn;

import java.util.List;

public class GrnGvnPdf {
	
	String frName;
	
	String srNo;
	
	String date;
	
	
	List<GetGrnGvnDetails> detail;


	public String getFrName() {
		return frName;
	}


	public void setFrName(String frName) {
		this.frName = frName;
	}


	public String getSrNo() {
		return srNo;
	}


	public void setSrNo(String srNo) {
		this.srNo = srNo;
	}


	public String getDate() {
		return date;
	}


	public void setDate(String date) {
		this.date = date;
	}


	public List<GetGrnGvnDetails> getDetail() {
		return detail;
	}


	public void setDetail(List<GetGrnGvnDetails> detail) {
		this.detail = detail;
	}


	@Override
	public String toString() {
		return "GrnGvnPdf [frName=" + frName + ", srNo=" + srNo + ", date=" + date + ", detail=" + detail + "]";
	}
	

}
