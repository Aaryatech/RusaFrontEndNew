package com.ats.rusafrontend.model;
 
public class InstituteInfo {
	 
	private int mhInstId; 
	private String aisheCode; 
	private String insName; 
	private String district; 
	private String taluka; 
	private int affUniversity; 
	private String est_year; 
	private String uniName;
	private int yesNo;
	
	public int getMhInstId() {
		return mhInstId;
	}
	public void setMhInstId(int mhInstId) {
		this.mhInstId = mhInstId;
	}
	public String getAisheCode() {
		return aisheCode;
	}
	public void setAisheCode(String aisheCode) {
		this.aisheCode = aisheCode;
	}
	public String getInsName() {
		return insName;
	}
	public void setInsName(String insName) {
		this.insName = insName;
	}
	public String getDistrict() {
		return district;
	}
	public void setDistrict(String district) {
		this.district = district;
	}
	public String getTaluka() {
		return taluka;
	}
	public void setTaluka(String taluka) {
		this.taluka = taluka;
	}
	public int getAffUniversity() {
		return affUniversity;
	}
	public void setAffUniversity(int affUniversity) {
		this.affUniversity = affUniversity;
	}
	public String getEst_year() {
		return est_year;
	}
	public void setEst_year(String est_year) {
		this.est_year = est_year;
	}
	public String getUniName() {
		return uniName;
	}
	public void setUniName(String uniName) {
		this.uniName = uniName;
	}
	
	
	public int getYesNo() {
		return yesNo;
	}
	public void setYesNo(int yesNo) {
		this.yesNo = yesNo;
	}
	@Override
	public String toString() {
		return "InstituteInfo [mhInstId=" + mhInstId + ", aisheCode=" + aisheCode + ", insName=" + insName
				+ ", district=" + district + ", taluka=" + taluka + ", affUniversity=" + affUniversity + ", est_year="
				+ est_year + ", uniName=" + uniName + ", yesNo=" + yesNo + "]";
	}
	
	

}
