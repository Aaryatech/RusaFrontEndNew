package com.ats.rusafrontend.model;
 

public class GetPagesModule {
	 
	private int id; 
	private int moduleId; 
	private int pageId; 
	private int primaryKeyId; 
	private String pageName; 
	private String name; 
	private String content;
	private String secctionName;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getModuleId() {
		return moduleId;
	}
	public void setModuleId(int moduleId) {
		this.moduleId = moduleId;
	}
	public int getPageId() {
		return pageId;
	}
	public void setPageId(int pageId) {
		this.pageId = pageId;
	}
	public int getPrimaryKeyId() {
		return primaryKeyId;
	}
	public void setPrimaryKeyId(int primaryKeyId) {
		this.primaryKeyId = primaryKeyId;
	}
	public String getPageName() {
		return pageName;
	}
	public void setPageName(String pageName) {
		this.pageName = pageName;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getSecctionName() {
		return secctionName;
	}
	public void setSecctionName(String secctionName) {
		this.secctionName = secctionName;
	}
	@Override
	public String toString() {
		return "GetPagesModule [id=" + id + ", moduleId=" + moduleId + ", pageId=" + pageId + ", primaryKeyId="
				+ primaryKeyId + ", pageName=" + pageName + ", name=" + name + ", content=" + content
				+ ", secctionName=" + secctionName + "]";
	}
	
	

}
