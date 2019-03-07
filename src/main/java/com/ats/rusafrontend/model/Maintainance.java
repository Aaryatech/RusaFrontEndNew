package com.ats.rusafrontend.model;
 

public class Maintainance {
	 
	private int id; 
	private int maintenanceStatus; 
	private String message; 
	private int isCurrent; 
	private String addDate; 
	private String editDate; 
	private int exInt1; 
	private int exInt2; 
	private String exVar1; 
	private String exVar2; 
	private String fromDate; 
	private String toDate;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getMaintenanceStatus() {
		return maintenanceStatus;
	}
	public void setMaintenanceStatus(int maintenanceStatus) {
		this.maintenanceStatus = maintenanceStatus;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public int getIsCurrent() {
		return isCurrent;
	}
	public void setIsCurrent(int isCurrent) {
		this.isCurrent = isCurrent;
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
	public int getExInt1() {
		return exInt1;
	}
	public void setExInt1(int exInt1) {
		this.exInt1 = exInt1;
	}
	public int getExInt2() {
		return exInt2;
	}
	public void setExInt2(int exInt2) {
		this.exInt2 = exInt2;
	}
	public String getExVar1() {
		return exVar1;
	}
	public void setExVar1(String exVar1) {
		this.exVar1 = exVar1;
	}
	public String getExVar2() {
		return exVar2;
	}
	public void setExVar2(String exVar2) {
		this.exVar2 = exVar2;
	}
	public String getFromDate() {
		return fromDate;
	}
	public void setFromDate(String fromDate) {
		this.fromDate = fromDate;
	}
	public String getToDate() {
		return toDate;
	}
	public void setToDate(String toDate) {
		this.toDate = toDate;
	}
	@Override
	public String toString() {
		return "Maintainance [id=" + id + ", maintenanceStatus=" + maintenanceStatus + ", message=" + message
				+ ", isCurrent=" + isCurrent + ", addDate=" + addDate + ", editDate=" + editDate + ", exInt1=" + exInt1
				+ ", exInt2=" + exInt2 + ", exVar1=" + exVar1 + ", exVar2=" + exVar2 + ", fromDate=" + fromDate
				+ ", toDate=" + toDate + "]";
	}

}
