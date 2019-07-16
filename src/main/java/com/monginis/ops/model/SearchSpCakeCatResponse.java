package com.monginis.ops.model;

import com.monginis.ops.model.album.Album;

public class SearchSpCakeCatResponse {

	ErrorMessage errorMessage;
	SpecialCake specialCake;
	Album album;
	public ErrorMessage getErrorMessage() {
		return errorMessage;
	}
	public void setErrorMessage(ErrorMessage errorMessage) {
		this.errorMessage = errorMessage;
	}
	public SpecialCake getSpecialCake() {
		return specialCake;
	}
	public void setSpecialCake(SpecialCake specialCake) {
		this.specialCake = specialCake;
	}
	public Album getAlbum() {
		return album;
	}
	public void setAlbum(Album album) {
		this.album = album;
	}
	@Override
	public String toString() {
		return "SearchSpCakeCatResponse [errorMessage=" + errorMessage + ", specialCake=" + specialCake + ", album="
				+ album + "]";
	}
	
	
}
