package com.ats.rusafrontend.model;

import java.util.List;

public class CalenderList {
	
	private int success;
	
	List<Result> result;

	public int getSuccess() {
		return success;
	}

	public void setSuccess(int success) {
		this.success = success;
	}

	public List<Result> getResult() {
		return result;
	}

	public void setResult(List<Result> result) {
		this.result = result;
	}

	@Override
	public String toString() {
		return "CalenderList [success=" + success + ", result=" + result + "]";
	}
	

}
