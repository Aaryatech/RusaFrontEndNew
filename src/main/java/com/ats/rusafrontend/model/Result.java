package com.ats.rusafrontend.model;

public class Result {
	 
	private String id; 
	private String title; 
	private String url; 
	private String _class; 
	private String start; 
	private String end;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String get_class() {
		return _class;
	}
	public void set_class(String _class) {
		this._class = _class;
	}
	public String getStart() {
		return start;
	}
	public void setStart(String start) {
		this.start = start;
	}
	public String getEnd() {
		return end;
	}
	public void setEnd(String end) {
		this.end = end;
	}
	@Override
	public String toString() {
		return "Result [id=" + id + ", title=" + title + ", url=" + url + ", _class=" + _class + ", start=" + start
				+ ", end=" + end + "]";
	}

}
