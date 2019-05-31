package com.ats.rusafrontend.model;
 

public class NewsSearchData {
	  
	private int newsblogsId; 
	private int moduleId; 
	private String heading;  
	private String descriptions; 
	private String addDate; 
	private String editDate;
	private String pageName;  
	private String pageSlug;
	private String exVar1;
	private String featuredImage;
	
	public int getNewsblogsId() {
		return newsblogsId;
	}
	public void setNewsblogsId(int newsblogsId) {
		this.newsblogsId = newsblogsId;
	}
	public int getModuleId() {
		return moduleId;
	}
	public void setModuleId(int moduleId) {
		this.moduleId = moduleId;
	}
	public String getHeading() {
		return heading;
	}
	public void setHeading(String heading) {
		this.heading = heading;
	}
	public String getDescriptions() {
		return descriptions;
	}
	public void setDescriptions(String descriptions) {
		this.descriptions = descriptions;
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
	public String getPageName() {
		return pageName;
	}
	public void setPageName(String pageName) {
		this.pageName = pageName;
	}
	public String getPageSlug() {
		return pageSlug;
	}
	public void setPageSlug(String pageSlug) {
		this.pageSlug = pageSlug;
	}
	public String getExVar1() {
		return exVar1;
	}
	public void setExVar1(String exVar1) {
		this.exVar1 = exVar1;
	}
	public String getFeaturedImage() {
		return featuredImage;
	}
	public void setFeaturedImage(String featuredImage) {
		this.featuredImage = featuredImage;
	}
	@Override
	public String toString() {
		return "NewsSearchData [newsblogsId=" + newsblogsId + ", moduleId=" + moduleId + ", heading=" + heading
				+ ", descriptions=" + descriptions + ", addDate=" + addDate + ", editDate=" + editDate + ", pageName="
				+ pageName + ", pageSlug=" + pageSlug + ", exVar1=" + exVar1 + ", featuredImage=" + featuredImage + "]";
	}
	
	

}
