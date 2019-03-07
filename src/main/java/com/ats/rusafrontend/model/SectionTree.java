package com.ats.rusafrontend.model;

import java.util.List;
 
 

public class SectionTree {
	
	private int sectionId; 
	private String sectionName; 
	private String sectionSlugname; 
	private String sectionDesc; 
	private int pageId; 
	private int secSortNo; 
	private int catCount;
	private String externalUrl; 
	private String externalUrlTarget;
	List<CategoryList> catList;
	public int getSectionId() {
		return sectionId;
	}
	public void setSectionId(int sectionId) {
		this.sectionId = sectionId;
	}
	public String getSectionName() {
		return sectionName;
	}
	public void setSectionName(String sectionName) {
		this.sectionName = sectionName;
	}
	public String getSectionSlugname() {
		return sectionSlugname;
	}
	public void setSectionSlugname(String sectionSlugname) {
		this.sectionSlugname = sectionSlugname;
	}
	public String getSectionDesc() {
		return sectionDesc;
	}
	public void setSectionDesc(String sectionDesc) {
		this.sectionDesc = sectionDesc;
	}
	public int getPageId() {
		return pageId;
	}
	public void setPageId(int pageId) {
		this.pageId = pageId;
	}
	public int getSecSortNo() {
		return secSortNo;
	}
	public void setSecSortNo(int secSortNo) {
		this.secSortNo = secSortNo;
	}
	public List<CategoryList> getCatList() {
		return catList;
	}
	public void setCatList(List<CategoryList> catList) {
		this.catList = catList;
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
	public int getCatCount() {
		return catCount;
	}
	public void setCatCount(int catCount) {
		this.catCount = catCount;
	}
	@Override
	public String toString() {
		return "SectionTree [sectionId=" + sectionId + ", sectionName=" + sectionName + ", sectionSlugname="
				+ sectionSlugname + ", sectionDesc=" + sectionDesc + ", pageId=" + pageId + ", secSortNo=" + secSortNo
				+ ", catCount=" + catCount + ", externalUrl=" + externalUrl + ", externalUrlTarget=" + externalUrlTarget
				+ ", catList=" + catList + "]";
	}
	 

}
