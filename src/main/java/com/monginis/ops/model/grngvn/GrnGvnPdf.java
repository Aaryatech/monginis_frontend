package com.monginis.ops.model.grngvn;

import java.util.List;

public class GrnGvnPdf {
	
	String frName;
	
	String srNo;
	
	String date;
	
	int type;// 1 for GRN , 0 for GVN
	
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


	public int getType() {
		return type;
	}


	public void setType(int type) {
		this.type = type;
	}


	@Override
	public String toString() {
		return "GrnGvnPdf [frName=" + frName + ", srNo=" + srNo + ", date=" + date + ", type=" + type + ", detail="
				+ detail + "]";
	}
	
}
