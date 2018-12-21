/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.ecpp.entity;

import org.hibernate.validator.constraints.Length;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import javax.validation.constraints.NotNull;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.modules.sys.entity.User;

/**
 * 管理提升信息表Entity
 * @author zxt
 * @version 2018-03-21
 */
public class Information extends DataEntity<Information> {
	
	private static final long serialVersionUID = 1L;
	private String informationtitle;		// 信息标题
	private String informationcontent;		// 信息内容
	private String attachment;		// 附件
	private String status;		// 信息审核状态
	private String statuss;		// 信息审核状态
	private String attribute1;		// 扩展字段1  //是否为管理员发布的
	private String attribute2;		// 扩展字段2
	private String attribute3;		// 扩展字段3		统计浏览量
	private String attribute4;		// 扩展字段4  信息用
	private Date delDate;		// 删除时间
	private User user;			//用户
	private Integer MonthReportNum;			//月报统计值

	public String getStatuss() {
		return statuss;
	}

	public void setStatuss(String statuss) {
		this.statuss = statuss;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Information() {
		super();
	}

	public Information(String id){
		super(id);
	}

	@Length(min=0, max=50, message="信息标题长度必须介于 0 和 25 之间")
	public String getInformationtitle() {
		return informationtitle;
	}

	public void setInformationtitle(String informationtitle) {
		this.informationtitle = informationtitle;
	}
	
	@Length(min=0, max=15000000, message="信息内容长度必须介于 0 和 1500000 之间")
	public String getInformationcontent() {
		return informationcontent;
	}

	public void setInformationcontent(String informationcontent) {
		this.informationcontent = informationcontent;
	}
	
	@Length(min=0, max=20000, message="附件长度必须介于 0 和 20000 之间")
	public String getAttachment() {
		return attachment;
	}

	public void setAttachment(String attachment) {
		this.attachment = attachment;
	}
	
	@Length(min=0, max=64, message="信息审核状态长度必须介于 0 和 64 之间")
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
	@NotNull(message="删除时间不能为空")
	public Date getDelDate() {
		return delDate;
	}

	public void setDelDate(Date delDate) {
		this.delDate = delDate;
	}

	public Integer getMonthReportNum() {
		return MonthReportNum;
	}

	public void setMonthReportNum(Integer monthReportNum) {
		MonthReportNum = monthReportNum;
	}
}