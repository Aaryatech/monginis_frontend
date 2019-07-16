package com.monginis.ops.model;

public class AlbumCodeAndName {

	private int albumId;
	private String albumCode;
	private String albumName;
	
	

	public int getAlbumId() {
		return albumId;
	}

	public void setAlbumId(int albumId) {
		this.albumId = albumId;
	}

	public String getAlbumCode() {
		return albumCode;
	}

	public void setAlbumCode(String albumCode) {
		this.albumCode = albumCode;
	}

	public String getAlbumName() {
		return albumName;
	}

	public void setAlbumName(String albumName) {
		this.albumName = albumName;
	}
	
	

	@Override
	public String toString() {
		return "AlbumCodeAndName [albumId=" + albumId + ", albumCode=" + albumCode + ", albumName=" + albumName + "]";
	}

}
