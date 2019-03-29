package com.ats.rusafrontend.model;
 
public class ImageListByCategory {
	 
	private int galleryDetailsId; 
	private int galleryCatId; 
	private int picCount; 
	private String cateName; 
	private String fileName;
	public int getGalleryDetailsId() {
		return galleryDetailsId;
	}
	public void setGalleryDetailsId(int galleryDetailsId) {
		this.galleryDetailsId = galleryDetailsId;
	}
	public int getGalleryCatId() {
		return galleryCatId;
	}
	public void setGalleryCatId(int galleryCatId) {
		this.galleryCatId = galleryCatId;
	}
	public int getPicCount() {
		return picCount;
	}
	public void setPicCount(int picCount) {
		this.picCount = picCount;
	}
	public String getCateName() {
		return cateName;
	}
	public void setCateName(String cateName) {
		this.cateName = cateName;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	@Override
	public String toString() {
		return "ImageListByCategory [galleryDetailsId=" + galleryDetailsId + ", galleryCatId=" + galleryCatId
				+ ", picCount=" + picCount + ", cateName=" + cateName + ", fileName=" + fileName + "]";
	}
	
	

}
