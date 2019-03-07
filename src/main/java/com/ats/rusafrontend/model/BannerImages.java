package com.ats.rusafrontend.model;

public class BannerImages {

	
	private int id;
	
	private int cateId;
	
	private String sliderName;
	
	private String urlLink;
	
	private String linkName;
	
	private String text1;
	
	
	private String text2;
	
	private String text3;
	
	
	private String sliderImage;
	
	
	private int sortOrder;
	
	
	private String addDate;
	
	
	private String editDate;
	
	
	private int addedByUserId;
	
	
	private int editByUserId;
	
	
	private int isActive;
	
	
	private int delStatus;


	public int getId() {
		return id;
	}


	public void setId(int id) {
		this.id = id;
	}


	public int getCateId() {
		return cateId;
	}


	public void setCateId(int cateId) {
		this.cateId = cateId;
	}


	public String getSliderName() {
		return sliderName;
	}


	public void setSliderName(String sliderName) {
		this.sliderName = sliderName;
	}


	public String getUrlLink() {
		return urlLink;
	}


	public void setUrlLink(String urlLink) {
		this.urlLink = urlLink;
	}


	public String getLinkName() {
		return linkName;
	}


	public void setLinkName(String linkName) {
		this.linkName = linkName;
	}


	public String getText1() {
		return text1;
	}


	public void setText1(String text1) {
		this.text1 = text1;
	}


	public String getText2() {
		return text2;
	}


	public void setText2(String text2) {
		this.text2 = text2;
	}


	public String getText3() {
		return text3;
	}


	public void setText3(String text3) {
		this.text3 = text3;
	}


	public String getSliderImage() {
		return sliderImage;
	}


	public void setSliderImage(String sliderImage) {
		this.sliderImage = sliderImage;
	}


	public int getSortOrder() {
		return sortOrder;
	}


	public void setSortOrder(int sortOrder) {
		this.sortOrder = sortOrder;
	}


	public String getAddDate() {
		return addDate;
	}


	public void setAddDate(String addDate) {
		this.addDate = addDate;
	}


	public String getEditDate() {
		return editDate;
	}


	public void setEditDate(String editDate) {
		this.editDate = editDate;
	}


	public int getAddedByUserId() {
		return addedByUserId;
	}


	public void setAddedByUserId(int addedByUserId) {
		this.addedByUserId = addedByUserId;
	}


	public int getEditByUserId() {
		return editByUserId;
	}


	public void setEditByUserId(int editByUserId) {
		this.editByUserId = editByUserId;
	}


	public int getIsActive() {
		return isActive;
	}


	public void setIsActive(int isActive) {
		this.isActive = isActive;
	}


	public int getDelStatus() {
		return delStatus;
	}


	public void setDelStatus(int delStatus) {
		this.delStatus = delStatus;
	}


	@Override
	public String toString() {
		return "BannerImages [id=" + id + ", cateId=" + cateId + ", sliderName=" + sliderName + ", urlLink=" + urlLink
				+ ", linkName=" + linkName + ", text1=" + text1 + ", text2=" + text2 + ", text3=" + text3
				+ ", sliderImage=" + sliderImage + ", sortOrder=" + sortOrder + ", addDate=" + addDate + ", editDate="
				+ editDate + ", addedByUserId=" + addedByUserId + ", editByUserId=" + editByUserId + ", isActive="
				+ isActive + ", delStatus=" + delStatus + ", getId()=" + getId() + ", getCateId()=" + getCateId()
				+ ", getSliderName()=" + getSliderName() + ", getUrlLink()=" + getUrlLink() + ", getLinkName()="
				+ getLinkName() + ", getText1()=" + getText1() + ", getText2()=" + getText2() + ", getText3()="
				+ getText3() + ", getSliderImage()=" + getSliderImage() + ", getSortOrder()=" + getSortOrder()
				+ ", getAddDate()=" + getAddDate() + ", getEditDate()=" + getEditDate() + ", getAddedByUserId()="
				+ getAddedByUserId() + ", getEditByUserId()=" + getEditByUserId() + ", getIsActive()=" + getIsActive()
				+ ", getDelStatus()=" + getDelStatus() + ", getClass()=" + getClass() + ", hashCode()=" + hashCode()
				+ ", toString()=" + super.toString() + "]";
	}


	
}
