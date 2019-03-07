package com.ats.rusafrontend.model;
 

public class GallerySearchData {
	
	 
	private int galleryDetailsId; 
	private int moduleId; 
	private String fileName; 
	private String title; 
	private String addDate; 
	private String editDate;
	private String pageName;  
	private String pageSlug;
	public int getGalleryDetailsId() {
		return galleryDetailsId;
	}
	public void setGalleryDetailsId(int galleryDetailsId) {
		this.galleryDetailsId = galleryDetailsId;
	}
	public int getModuleId() {
		return moduleId;
	}
	public void setModuleId(int moduleId) {
		this.moduleId = moduleId;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
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
		return "GallerySearchData [galleryDetailsId=" + galleryDetailsId + ", moduleId=" + moduleId + ", fileName="
				+ fileName + ", title=" + title + ", addDate=" + addDate + ", editDate=" + editDate + ", pageName="
				+ pageName + ", pageSlug=" + pageSlug + "]";
	}
	
	

}
