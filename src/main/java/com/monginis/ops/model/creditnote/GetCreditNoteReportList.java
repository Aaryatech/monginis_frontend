package com.monginis.ops.model.creditnote;

import java.util.List;

import com.monginis.ops.model.Info;

public class GetCreditNoteReportList {

	List<GetCreditNoteReport> creditNoteReport;
	Info info;

	public List<GetCreditNoteReport> getCreditNoteReport() {
		return creditNoteReport;
	}

	public void setCreditNoteReport(List<GetCreditNoteReport> creditNoteReport) {
		this.creditNoteReport = creditNoteReport;
	}

	public Info getInfo() {
		return info;
	}

	public void setInfo(Info info) {
		this.info = info;
	}

	@Override
	public String toString() {
		return "GetCreditNoteReportList [creditNoteReport=" + creditNoteReport + ", info=" + info + "]";
	}

}
