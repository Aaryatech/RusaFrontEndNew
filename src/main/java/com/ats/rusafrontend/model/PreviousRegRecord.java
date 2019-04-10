package com.ats.rusafrontend.model;
 

public class PreviousRegRecord {
	 
	private int prevId; 
	private int regId; 
	private String record; 
	private String lastUpdate; 
	private String extraVar1; 
	private boolean isError; 
	private String message;
	
	public int getPrevId() {
		return prevId;
	}
	public void setPrevId(int prevId) {
		this.prevId = prevId;
	}
	public int getRegId() {
		return regId;
	}
	public void setRegId(int regId) {
		this.regId = regId;
	}
	public String getRecord() {
		return record;
	}
	public void setRecord(String record) {
		this.record = record;
	}
	public String getLastUpdate() {
		return lastUpdate;
	}
	public void setLastUpdate(String lastUpdate) {
		this.lastUpdate = lastUpdate;
	}
	public String getExtraVar1() {
		return extraVar1;
	}
	public void setExtraVar1(String extraVar1) {
		this.extraVar1 = extraVar1;
	}
	public boolean isError() {
		return isError;
	}
	public void setError(boolean isError) {
		this.isError = isError;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	@Override
	public String toString() {
		return "PreviousRegRecord [prevId=" + prevId + ", regId=" + regId + ", record=" + record + ", lastUpdate="
				+ lastUpdate + ", extraVar1=" + extraVar1 + ", isError=" + isError + ", message=" + message + "]";
	}
	
	

}
