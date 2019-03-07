package com.ats.rusafrontend.model;
 
public class MetaData {
	 
	private int id; 
	private String siteTitle; 
	private String metaDescription; 
	private String metaAuthor; 
	private String metaKeywords; 
	private int languageId; 
	private String addDate; 
	private String editDate; 
	private int addedByUserId; 
	private int editByUserId;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getSiteTitle() {
		return siteTitle;
	}
	public void setSiteTitle(String siteTitle) {
		this.siteTitle = siteTitle;
	}
	public String getMetaDescription() {
		return metaDescription;
	}
	public void setMetaDescription(String metaDescription) {
		this.metaDescription = metaDescription;
	}
	public String getMetaAuthor() {
		return metaAuthor;
	}
	public void setMetaAuthor(String metaAuthor) {
		this.metaAuthor = metaAuthor;
	}
	public String getMetaKeywords() {
		return metaKeywords;
	}
	public void setMetaKeywords(String metaKeywords) {
		this.metaKeywords = metaKeywords;
	}
	public int getLanguageId() {
		return languageId;
	}
	public void setLanguageId(int languageId) {
		this.languageId = languageId;
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
	@Override
	public String toString() {
		return "MetaData [id=" + id + ", siteTitle=" + siteTitle + ", metaDescription=" + metaDescription
				+ ", metaAuthor=" + metaAuthor + ", metaKeywords=" + metaKeywords + ", languageId=" + languageId
				+ ", addDate=" + addDate + ", editDate=" + editDate + ", addedByUserId=" + addedByUserId
				+ ", editByUserId=" + editByUserId + "]";
	}
	 
	

}
