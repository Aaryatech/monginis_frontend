package com.monginis.ops.model;

import java.util.List;

public class MenuLimitList {

	private List<MenuLimit> menuLimit;

	public List<MenuLimit> getMenuLimit() {
		return menuLimit;
	}

	public void setMenuLimit(List<MenuLimit> menuLimit) {
		this.menuLimit = menuLimit;
	}

	@Override
	public String toString() {
		return "MenuLimitList [menuLimit=" + menuLimit + "]";
	}

}
