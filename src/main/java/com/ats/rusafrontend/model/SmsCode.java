package com.ats.rusafrontend.model;

public class SmsCode {

	private int smsCodeId;
	
	private String userUuid;
	
	private String smsCode;
	
	private String dateSent;
	
	private int smsType;

	public int getSmsCodeId() {
		return smsCodeId;
	}

	public void setSmsCodeId(int smsCodeId) {
		this.smsCodeId = smsCodeId;
	}

	public String getUserUuid() {
		return userUuid;
	}

	public void setUserUuid(String userUuid) {
		this.userUuid = userUuid;
	}

	public String getSmsCode() {
		return smsCode;
	}

	public void setSmsCode(String smsCode) {
		this.smsCode = smsCode;
	}

	public String getDateSent() {
		return dateSent;
	}

	public void setDateSent(String dateSent) {
		this.dateSent = dateSent;
	}

	public int getSmsType() {
		return smsType;
	}

	public void setSmsType(int smsType) {
		this.smsType = smsType;
	}

	@Override
	public String toString() {
		return "smsCode [smsCodeId=" + smsCodeId + ", userUuid=" + userUuid + ", smsCode=" + smsCode + ", dateSent="
				+ dateSent + ", smsType=" + smsType + "]";
	}

	
	
}
