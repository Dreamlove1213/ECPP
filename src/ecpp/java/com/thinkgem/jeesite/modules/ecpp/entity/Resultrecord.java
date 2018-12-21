/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.ecpp.entity;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 提升情况信息及小组建议Entity
 * @author zxt
 * @version 2018-03-22
 */
public class Resultrecord extends DataEntity<Resultrecord> {
	
	private static final long serialVersionUID = 1L;
	private String planid;		// 计划信息ID
	private Date reschangedate;		// 成果情况变更时间
	private String situationandresults;		// 提升情况及成果
	private Date opinionchangedate;		// 小组意见变更时间
	private String opinion;		// 改革小组意见
	private String status;		// 变更信息状态
	private String attribute1;		// 扩展字段1
	private String attribute2;		// 扩展字段2
	private String attribute3;		// 扩展字段3
	private String attribute4;		// 扩展字段4
	private Date delDate;		// 删除时间
	
	public Resultrecord() {
		super();
	}

	public Resultrecord(String id){
		super(id);
	}

	@Length(min=0, max=64, message="计划信息ID长度必须介于 0 和 64 之间")
	public String getPlanid() {
		return planid;
	}

	public void setPlanid(String planid) {
		this.planid = planid;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getReschangedate() {
		return reschangedate;
	}

	public void setReschangedate(Date reschangedate) {
		this.reschangedate = reschangedate;
	}
	
	@Length(min=0, max=2048000, message="提升情况及成果长度必须介于 0 和 2048000 之间")
	public String getSituationandresults() {
		return situationandresults;
	}

	public void setSituationandresults(String situationandresults) {
		this.situationandresults = situationandresults;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getOpinionchangedate() {
		return opinionchangedate;
	}

	public void setOpinionchangedate(Date opinionchangedate) {
		this.opinionchangedate = opinionchangedate;
	}
	
	@Length(min=0, max=2048, message="改革小组意见长度必须介于 0 和 2048 之间")
	public String getOpinion() {
		return opinion;
	}

	public void setOpinion(String opinion) {
		this.opinion = opinion;
	}
	
	@Length(min=0, max=2, message="变更信息状态长度必须介于 0 和 2 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	@Length(min=0, max=1024, message="扩展字段1长度必须介于 0 和 1024 之间")
	public String getAttribute1() {
		return attribute1;
	}

	public void setAttribute1(String attribute1) {
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