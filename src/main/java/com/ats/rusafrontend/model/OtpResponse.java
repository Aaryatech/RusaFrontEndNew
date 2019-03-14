package com.ats.rusafrontend.model;

public class OtpResponse {
	private boolean isError;
	private String msg;
	private Registration reg;
	
	public boolean isError() {
		return isError;
	}
	public void setError(boolean isError) {
		this.isError = isError;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public Registration getReg() {
		return reg;
	}
	public void setReg(Registration reg) {
		this.reg = reg;
	}
	@Override
	public String toString() {
		return "OtpResponse [isError=" + isError + ", msg=" + msg + ", reg=" + reg + "]";
	}
	
	
}
