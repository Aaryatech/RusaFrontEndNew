package com.ats.rusafrontend.model;
 

public class PageMetaData {
	 
	private int pageId; 
	private String pagName; 
	private String pageMetaTitle; 
	private String pageMetaDescription; 
	private String pageMetaKeyword;
	private int sectionId;
	
	public int getPageId() {
		return pageId;
	}
	public void setPageId(int pageId) {
		this.pageId = pageId;
	}
	public String getPagName() {
		return pagName;
	}
	public void setPagName(String pagName) {
		this.pagName = pagName;
	}
	public String getPageMetaTitle() {
		return pageMetaTitle;
	}
	public void setPageMetaTitle(String pageMetaTitle) {
		this.pageMetaTitle = pageMetaTitle;
	}
	public String getPageMetaDescription() {
		return pageMetaDescription;
	}
	public void setPageMetaDescription(String pageMetaDescription) {
		this.pageMetaDescription = pageMetaDescription;
	}
	public String getPageMetaKeyword() {
		return pageMetaKeyword;
	}
	public void setPageMetaKeyword(String pageMetaKeyword) {
		this.pageMetaKeyword = pageMetaKeyword;
	}
	public int getSectionId() {
		return sectionId;
	}
	public void setSectionId(int sectionId) {
		this.sectionId = sectionId;
	}
	@Override
	public String toString() {
		return "PageMetaData [pageId=" + pageId + ", pagName=" + pagName + ", pageMetaTitle=" + pageMetaTitle
				+ ", pageMetaDescription=" + pageMetaDescription + ", pageMetaKeyword=" + pageMetaKeyword
				+ ", sectionId=" + sectionId + "]";
	}
	
	

}
