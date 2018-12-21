/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.ecpp.entity;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 改进项进度记录Entity
 * @author zxt
 * @version 2018-03-22
 */
public class Progressrecord extends DataEntity<Progressrecord> {
	
	private static final long serialVersionUID = 1L;
	private String improvedid;		// 改进信息id
	private Double progress;		// 改进项进度
	private Date changedate;		// 变更时间
	private long attribute1;		// 扩展字段1
	private String attribute2;		// 扩展字段2
	private String attribute3;		// 扩展字段3
	private String attribute4;		// 扩展字段4
	private Date delDate;		// 删除时间
	
	public Progressrecord() {
		super();
	}

	public Progressrecord(String id){
		super(id);
	}

	@Length(min=0, max=64, message="改进信息id长度必须介于 0 和 64 之间")
	public String getImprovedid() {
		return improvedid;
	}

	public void setImprovedid(String improvedid) {
		this.improvedid = improvedid;
	}
	
	public Double getProgress() {
		return progress;
	}

	public void setProgress(Double progress) {
		this.progress = progress;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getChangedate() {
		return changedate;
	}

	public void setChangedate(Date changedate) {
		this.changedate = changedate;
	}
	
	@Length(min=0, max=1024000, message="扩展字段1长度必须介于 0 和 1024000 之间")
	public long getAttribute1() {
		return attribute1;
	}

	public void setAttribute1(long attribute1) {
		this.attribute1 = attribute1;
	}
	
	@Length(min=0, max=1024, message="扩展字段2长度必须介于 0 和 1024 之间")
	public String getAttribute2() {
		return attribute2;
	}

	public void setAttribute2(String attribute2) {
		this.attribute2 = attribute2;
	}
	
	@Length(min=0, max=1024, message="扩展字段3长度必须介于 0 和 1024 之间")
	public String getAttribute3() {
		return attribute3;
	}

	public void setAttribute3(String attribute3) {
		this.attribute3 = attribute3;
	}
	
	@Length(min=0, max=64, message="扩展字段4长度必须介于 0 和 64 之间")
	public String getAttribute4() {
		return attribute4;
	}

	public void setAttribute4(String attribute4) {
		this.attribute4 = attribute4;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getDelDate() {
		return delDate;
	}

	public void setDelDate(Date delDate) {
		this.delDate = delDate;
	}
	
}