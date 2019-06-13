package com.ats.rusafrontend.model;
 

public class DocType {
 
	private int typeId; 
	private String typeName; 
	private int delStatus;
	public int getTypeId() {
		return typeId;
	}
	public void setTypeId(int typeId) {
		this.typeId = typeId;
	}
	public String getTypeName() {
		return typeName;
	}
	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}
	public int getDelStatus() {
		return delStatus;
	}
	public void setDelStatus(int delStatus) {
		this.delStatus = delStatus;
	}
	@Override
	public String toString() {
		return "DocType [typeId=" + typeId + ", typeName=" + typeName + ", delStatus=" + delStatus + "]";
	}
	
	
	
}
