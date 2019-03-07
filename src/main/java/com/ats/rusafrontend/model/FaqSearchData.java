package com.ats.rusafrontend.model;
 

public class FaqSearchData {
	 
	private int faqId; 
	private int moduleId; 
	private String faqQue;  
	private String faqAns; 
	private String addDate; 
	private String editDate;
	private String pageName;  
	private String pageSlug;
	public int getFaqId() {
		return faqId;
	}
	public void setFaqId(int faqId) {
		this.faqId = faqId;
	}
	public int getModuleId() {
		return moduleId;
	}
	public void setModuleId(int moduleId) {
		this.moduleId = moduleId;
	}
	public String getFaqQue() {
		return faqQue;
	}
	public void setFaqQue(String faqQue) {
		this.faqQue = faqQue;
	}
	public String getFaqAns() {
		return faqAns;
	}
	public void setFaqAns(String faqAns) {
		this.faqAns = faqAns;
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
	@Override
	public String toString() {
		return "FaqSearchData [faqId=" + faqId + ", moduleId=" + moduleId + ", faqQue=" + faqQue + ", faqAns=" + faqAns
				+ ", addDate=" + addDate + ", editDate=" + editDate + ", pageName=" + pageName + ", pageSlug="
				+ pageSlug + "]";
	}
	
	

}
