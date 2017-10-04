package com.monginis.ops.model;

import java.util.List;


public class MCategory {
	  private Integer catId;
	    private String catName;
	    private Integer isSameDay;
	    private Integer delStatus;
	    private List<SubCategory> subCategory;
		public Integer getCatId() {
			return catId;
		}
		public void setCatId(Integer catId) {
			this.catId = catId;
		}
		public String getCatName() {
			return catName;
		}
		public void setCatName(String catName) {
			this.catName = catName;
		}
		public Integer getIsSameDay() {
			return isSameDay;
		}
		public void setIsSameDay(Integer isSameDay) {
			this.isSameDay = isSameDay;
		}
		public Integer getDelStatus() {
			return delStatus;
		}
		public void setDelStatus(Integer delStatus) {
			this.delStatus = delStatus;
		}
		public List<SubCategory> getSubCategory() {
			return subCategory;
		}
		public void setSubCategory(List<SubCategory> subCategory) {
			this.subCategory = subCategory;
		}
		@Override
		public String toString() {
			return "MCategory [catId=" + catId + ", catName=" + catName + ", isSameDay=" + isSameDay + ", delStatus="
					+ delStatus + ", subCategory=" + subCategory + "]";
		}

	    
}
