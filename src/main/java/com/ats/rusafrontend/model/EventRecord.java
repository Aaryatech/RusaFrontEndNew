package com.ats.rusafrontend.model;
 

public class EventRecord {
	 
	private int newsblogsId; 
	private String heading; 
	private String descriptions; 
	private int languageId; 
	private String featuredImage; 
	private String downloadPdf; 
	private int apply; 
	private int isFeedback;
	private String date;
	public int getNewsblogsId() {
		return newsblogsId;
	}
	public void setNewsblogsId(int newsblogsId) {
		this.newsblogsId = newsblogsId;
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
	public int getLanguageId() {
		return languageId;
	}
	public void setLanguageId(int languageId) {
		this.languageId = languageId;
	}
	public String getFeaturedImage() {
		return featuredImage;
	}
	public void setFeaturedImage(String featuredImage) {
		this.featuredImage = featuredImage;
	}
	public String getDownloadPdf() {
		return downloadPdf;
	}
	public void setDownloadPdf(String downloadPdf) {
		this.downloadPdf = downloadPdf;
	}
	public int getApply() {
		return apply;
	}
	public void setApply(int apply) {
		this.apply = apply;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public int getIsFeedback() {
		return isFeedback;
	}
	public void setIsFeedback(int isFeedback) {
		this.isFeedback = isFeedback;
	}
	@Override
	public String toString() {
		return "EventRecord [newsblogsId=" + newsblogsId + ", heading=" + heading + ", descriptions=" + descriptions
				+ ", languageId=" + languageId + ", featuredImage=" + featuredImage + ", downloadPdf=" + downloadPdf
				+ ", apply=" + apply + ", isFeedback=" + isFeedback + ", date=" + date + "]";
	}
	
	

}
