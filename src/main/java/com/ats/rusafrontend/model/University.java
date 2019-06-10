package com.ats.rusafrontend.model;
 

public class University {
	 
	private int uniId; 
	private String uniName; 
	private int delStatus;
	public int getUniId() {
		return uniId;
	}
	public void setUniId(int uniId) {
		this.uniId = uniId;
	}
	public String getUniName() {
		return uniName;
	}
	public void setUniName(String uniName) {
		this.uniName = uniName;
	}
	public int getDelStatus() {
		return delStatus;
	}
	public void setDelStatus(int delStatus) {
		this.delStatus = delStatus;
	}
	@Override
	public String toString() {
		return "University [uniId=" + uniId + ", uniName=" + uniName + ", delStatus=" + delStatus + "]";
	}
	
	

}
