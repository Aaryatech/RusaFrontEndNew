package com.ats.rusafrontend.model;

import java.util.List;
 
public class TopMenuList {
	
	List<SectionTree> sectionlist;
	List<CategoryList> categoryList;
	List<SubCategoryList> subCatList;
	public List<SectionTree> getSectionlist() {
		return sectionlist;
	}
	public void setSectionlist(List<SectionTree> sectionlist) {
		this.sectionlist = sectionlist;
	}
	public List<CategoryList> getCategoryList() {
		return categoryList;
	}
	public void setCategoryList(List<CategoryList> categoryList) {
		this.categoryList = categoryList;
	}
	public List<SubCategoryList> getSubCatList() {
		return subCatList;
	}
	public void setSubCatList(List<SubCategoryList> subCatList) {
		this.subCatList = subCatList;
	}
	@Override
	public String toString() {
		return "TopMenuList [sectionlist=" + sectionlist + ", categoryList=" + categoryList + ", subCatList="
				+ subCatList + "]";
	}
	
	
	

}
