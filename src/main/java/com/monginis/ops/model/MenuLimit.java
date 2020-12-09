package com.monginis.ops.model;

public class MenuLimit {

	private int menuId;
	private int subCatId;
	private int limit;

	public int getMenuId() {
		return menuId;
	}

	public void setMenuId(int menuId) {
		this.menuId = menuId;
	}

	public int getSubCatId() {
		return subCatId;
	}

	public void setSubCatId(int subCatId) {
		this.subCatId = subCatId;
	}

	public int getLimit() {
		return limit;
	}

	public void setLimit(int limit) {
		this.limit = limit;
	}

	@Override
	public String toString() {
		return "MenuLimit [menuId=" + menuId + ", subCatId=" + subCatId + ", limit=" + limit + "]";
	}

}
