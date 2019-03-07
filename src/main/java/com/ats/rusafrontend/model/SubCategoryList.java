package com.ats.rusafrontend.model;
 

public class SubCategoryList {
	 
	private int subCatId; 
	private String subCatName; 
	private String subCatDesc; 
	private String subSlugName; 
	private int pageId; 
	private int parentId; 
	private int sectionId; 
	private int subSortNo; 
	private String externalUrl; 
	private String externalUrlTarget;
	
	
	public int getSubCatId() {
		return subCatId;
	}
	public void setSubCatId(int subCatId) {
		this.subCatId = subCatId;
	}
	public String getSubCatName() {
		return subCatName;
	}
	public void setSubCatName(String subCatName) {
		this.subCatName = subCatName;
	}
	public String getSubCatDesc() {
		return subCatDesc;
	}
	public void setSubCatDesc(String subCatDesc) {
		this.subCatDesc = subCatDesc;
	}
	public String getSubSlugName() {
		return subSlugName;
	}
	public void setSubSlugName(String subSlugName) {
		this.subSlugName = subSlugName;
	}
	public int getPageId() {
		return pageId;
	}
	public void setPageId(int pageId) {
		this.pageId = pageId;
	}
	public int getSubSortNo() {
		return subSortNo;
	}
	public void setSubSortNo(int subSortNo) {
		this.subSortNo = subSortNo;
	}
	public String getExternalUrl() {
		return externalUrl;
	}
	public void setExternalUrl(String externalUrl) {
		this.externalUrl = externalUrl;
	}
	public String getExternalUrlTarget() {
		return externalUrlTarget;
	}
	public void setExternalUrlTarget(String externalUrlTarget) {
		this.externalUrlTarget = externalUrlTarget;
	}
	public int getParentId() {
		return parentId;
	}
	public void setParentId(int parentId) {
		this.parentId = parentId;
	}
	public int getSectionId() {
		return sectionId;
	}
	public void setSectionId(int sectionId) {
		this.sectionId = sectionId;
	}
	@Override
	public String toString() {
		return "SubCategoryList [subCatId=" + subCatId + ", subCatName=" + subCatName + ", subCatDesc=" + subCatDesc
				+ ", subSlugName=" + subSlugName + ", pageId=" + pageId + ", parentId=" + parentId + ", sectionId="
				+ sectionId + ", subSortNo=" + subSortNo + ", externalUrl=" + externalUrl + ", externalUrlTarget="
				+ externalUrlTarget + "]";
	}
	
	

}
