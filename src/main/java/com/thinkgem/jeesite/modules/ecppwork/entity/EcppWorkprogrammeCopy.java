/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.ecppwork.entity;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 查看工作方案Entity
 * @author nan
 * @version 2018-03-31
 */
public class EcppWorkprogrammeCopy extends DataEntity<EcppWorkprogrammeCopy> {
	
	private static final long serialVersionUID = 1L;
	private String informationtitle;		// 工作方案标题
	private String informationcontent;		// 工作方案内容
	private String attachment;		// 附件
	private String status;		// 工作方案审核状态
	private String attribute1;		// 扩展字段1
	private String attribute2;		// 扩展字段2
	private String attribute3;		// 扩展字段3
	private String attribute4;		// 扩展字段4
	private Date delDate;		// del_date
	
	public EcppWorkprogrammeCopy() {
		super();
	}

	public EcppWorkprogrammeCopy(String id){
		super(id);
	}

	@Length(min=0, max=50, message="工作方案标题长度必须介于 0 和 50 之间")
	public String getInformationtitle() {
		return informationtitle;
	}

	public void setInformationtitle(String informationtitle) {
		this.informationtitle = informationtitle;
	}
	
	@Length(min=0, max=15000, message="工作方案内容长度必须介于 0 和 15000 之间")
	public String getInformationcontent() {
		return informationcontent;
	}

	public void setInformationcontent(String informationcontent) {
		this.informationcontent = informationcontent;
	}
	
	@Length(min=0, max=2000, message="附件长度必须介于 0 和 2000 之间")
	public String getAttachment() {
		return attachment;
	}

	public void setAttachment(String attachment) {
		this.attachment = attachment;
	}
	
	@Length(min=0, max=64, message="工作方案审核状态长度必须介于 0 和 64 之间")
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