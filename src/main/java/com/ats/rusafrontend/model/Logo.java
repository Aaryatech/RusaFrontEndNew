package com.ats.rusafrontend.model;

public class Logo {
	
	private int id; 
	private String logoMain; 
	private String logo2; 
	private String logo3; 
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
	public String getLogoMain() {
		return logoMain;
	}
	public void setLogoMain(String logoMain) {
		this.logoMain = logoMain;
	}
	public String getLogo2() {
		return logo2;
	}
	public void setLogo2(String logo2) {
		this.logo2 = logo2;
	}
	public String getLogo3() {
		return logo3;
	}
	public void setLogo3(String logo3) {
		this.logo3 = logo3;
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
		return "Logo [id=" + id + ", logoMain=" + logoMain + ", logo2=" + logo2 + ", logo3=" + logo3 + ", addDate="
				+ addDate + ", editDate=" + editDate + ", addedByUserId=" + addedByUserId + ", editByUserId="
				+ editByUserId + "]";
	}
	
	

}
