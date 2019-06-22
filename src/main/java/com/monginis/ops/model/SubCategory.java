
package com.monginis.ops.model;

public class SubCategory {

	private Integer subCatId;
	private String subCatName;
	private Integer delStatus;

	private Integer catId;

	public Integer getSubCatId() {
		return subCatId;
	}

	public void setSubCatId(Integer subCatId) {
		this.subCatId = subCatId;
	}

	public String getSubCatName() {
		return subCatName;
	}

	public void setSubCatName(String subCatName) {
		this.subCatName = subCatName;
	}

	public Integer getDelStatus() {
		return delStatus;
	}

	public void setDelStatus(Integer delStatus) {
		this.delStatus = delStatus;
	}

	@Override
	public String toString() {
		return "SubCategory [subCatId=" + subCatId + ", subCatName=" + subCatName + ", delStatus=" + delStatus
				+ ", catId=" + catId + "]";
	}

	public Integer getCatId() {
		return catId;
	}

	public void setCatId(Integer catId) {
		this.catId = catId;
	}

}
