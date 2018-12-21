package com.thinkgem.jeesite.modules.gzdt.entity;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.thinkgem.jeesite.common.persistence.DataEntity;

public class Informations extends DataEntity<Informations>{
	private static final long serialVersionUID = 1L;
	private String url;
	private Date createDate;
	private String name;
	
	public Informations() {
		super();
	}
	
	public Informations(String id){
		super(id);
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	@JsonFormat(pattern = "yyyy-MM-dd")
	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
}
