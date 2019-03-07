package com.ats.rusafrontend.model;
 

public class CmsSearchData {
	
	 
	private int cmsPageId; 
	private int moduleId; 
	private String heading;  
	private String pageDesc; 
	private String addDate; 
	private String pageName;  
	private String pageSlug;
	public int getCmsPageId() {
		return cmsPageId;
	}
	public void setCmsPageId(int cmsPageId) {
		this.cmsPageId = cmsPageId;
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
	public String getPageDesc() {
		return pageDesc;
	}
	public void setPageDesc(String pageDesc) {
		this.pageDesc = pageDesc;
	}
	public String getAddDate() {
		return addDate;
	}
	public void setAddDate(String addDate) {
		this.addDate = addDate;
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
	@Override
	public String toString() {
		return "CmsSearchData [cmsPageId=" + cmsPageId + ", moduleId=" + moduleId + ", heading=" + heading
				+ ", pageDesc=" + pageDesc + ", addDate=" + addDate + ", pageName=" + pageName + ", pageSlug="
				+ pageSlug + "]";
	}
	
	

}
