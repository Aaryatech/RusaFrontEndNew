package com.ats.rusafrontend.model;

import java.util.List;
 
public class CategoryList {
	 
	private int catId; 
	private String catName; 
	private String catDesc; 
	private String slugName; 
	private int pageId; 
	private int parentId; 
	private int sectionId; 
	private int subCatCount; 
	private int catSortNo; 
	private String externalUrl; 
	private String externalUrlTarget; 
	List<SubCategoryList> subCatList;
	
	
	public int getParentId() {
		return parentId;
	}
	public void setParentId(int parentId) {
		this.parentId = parentId;
	}
	public int getCatId() {
		return catId;
	}
	public void setCatId(int catId) {
		this.catId = catId;
	}
	public String getCatName() {
		return catName;
	}
	public void setCatName(String catName) {
		this.catName = catName;
	}
	public String getCatDesc() {
		return catDesc;
	}
	public void setCatDesc(String catDesc) {
		this.catDesc = catDesc;
	}
	public String getSlugName() {
		return slugName;
	}
	public void setSlugName(String slugName) {
		this.slugName = slugName;
	}
	public int getPageId() {
		return pageId;
	}
	public void setPageId(int pageId) {
		this.pageId = pageId;
	}
	public int getCatSortNo() {
		return catSortNo;
	}
	public void setCatSortNo(int catSortNo) {
		this.catSortNo = catSortNo;
	}
	public List<SubCategoryList> getSubCatList() {
		return subCatList;
	}
	public void setSubCatList(List<SubCategoryList> subCatList) {
		this.subCatList = subCatList;
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
	public int getSubCatCount() {
		return subCatCount;
	}
	public void setSubCatCount(int subCatCount) {
		this.subCatCount = subCatCount;
	}
	public int getSectionId() {
		return sectionId;
	}
	public void setSectionId(int sectionId) {
		this.sectionId = sectionId;
	}
	@Override
	public String toString() {
		return "CategoryList [catId=" + catId + ", catName=" + catName + ", catDesc=" + catDesc + ", slugName="
				+ slugName + ", pageId=" + pageId + ", parentId=" + parentId + ", sectionId=" + sectionId
				+ ", subCatCount=" + subCatCount + ", catSortNo=" + catSortNo + ", externalUrl=" + externalUrl
				+ ", externalUrlTarget=" + externalUrlTarget + ", subCatList=" + subCatList + "]";
	}

}
