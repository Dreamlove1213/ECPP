/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.config.entity;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 管理提升控制信息Entity
 * @author zxt
 * @version 2018-03-21
 */
public class EcppConfig extends DataEntity<EcppConfig> {
	
	private static final long serialVersionUID = 1L;
	private String name;		// 名称
	private String iscurrentactivity;		// 是否当前执行活动
	private String isstart;		// 活动是否开启
	private String firstname;		// 第一阶段名称
	private String firstisstart;		// 第一阶段是否开启
	private Date firststartdate;		// 第一阶段开始时间
	private Date firstenddate;		// 第一阶段结束时间
	private String secondname;		// 第二阶段名称
	private String secondisstart;		// 第二阶段是否开启
	private Date secondstartdate;		// 第二阶段开始时间
	private Date secondenddate;		// 第二阶段结束时间
	private String thirdname;		// 第三阶段名称
	private String thirdisstart;		// 第三阶段是否开启
	private Date thirdstartdate;		// 第三阶段开始时间
	private Date thirdenddate;		// 第三阶段结束时间
	private String fouthname;		// 第四阶段名称
	private String fouthisstart;		// 第四阶段是否开启
	private Date fouthstartdate;		// 第四阶段开始时间
	private Date fouthenddate;		// 第四阶段结束时间
	private String code;		// 活动代码
	private Date activitycreatedate;		// 活动创建时间
	private String year;		// 年份
	private String attribute1;		// 扩展字段1
	private String attribute2;		// 扩展字段2
	private String attribute3;		// 扩展字段3
	private Date delDate;		// 删除时间
	
	public EcppConfig() {
		super();
	}

	public EcppConfig(String id){
		super(id);
	}

	@Length(min=0, max=100, message="名称长度必须介于 0 和 100 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Length(min=0, max=1, message="是否当前执行活动长度必须介于 0 和 1 之间")
	public String getIscurrentactivity() {
		return iscurrentactivity;
	}

	public void setIscurrentactivity(String iscurrentactivity) {
		this.iscurrentactivity = iscurrentactivity;
	}
	
	@Length(min=0, max=1, message="活动是否开启长度必须介于 0 和 1 之间")
	public String getIsstart() {
		return isstart;
	}

	public void setIsstart(String isstart) {
		this.isstart = isstart;
	}
	
	@Length(min=0, max=100, message="第一阶段名称长度必须介于 0 和 100 之间")
	public String getFirstname() {
		return firstname;
	}

	public void setFirstname(String firstname) {
		this.firstname = firstname;
	}
	
	@Length(min=0, max=1, message="第一阶段是否开启长度必须介于 0 和 1 之间")
	public String getFirstisstart() {
		return firstisstart;
	}

	public void setFirstisstart(String firstisstart) {
		this.firstisstart = firstisstart;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getFirststartdate() {
		return firststartdate;
	}

	public void setFirststartdate(Date firststartdate) {
		this.firststartdate = firststartdate;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getFirstenddate() {
		return firstenddate;
	}

	public void setFirstenddate(Date firstenddate) {
		this.firstenddate = firstenddate;
	}
	
	@Length(min=0, max=100, message="第二阶段名称长度必须介于 0 和 100 之间")
	public String getSecondname() {
		return secondname;
	}

	public void setSecondname(String secondname) {
		this.secondname = secondname;
	}
	
	@Length(min=0, max=1, message="第二阶段是否开启长度必须介于 0 和 1 之间")
	public String getSecondisstart() {
		return secondisstart;
	}

	public void setSecondisstart(String secondisstart) {
		this.secondisstart = secondisstart;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getSecondstartdate() {
		return secondstartdate;
	}

	public void setSecondstartdate(Date secondstartdate) {
		this.secondstartdate = secondstartdate;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getSecondenddate() {
		return secondenddate;
	}

	public void setSecondenddate(Date secondenddate) {
		this.secondenddate = secondenddate;
	}
	
	@Length(min=0, max=100, message="第三阶段名称长度必须介于 0 和 100 之间")
	public String getThirdname() {
		return thirdname;
	}

	public void setThirdname(String thirdname) {
		this.thirdname = thirdname;
	}
	
	@Length(min=0, max=1, message="第三阶段是否开启长度必须介于 0 和 1 之间")
	public String getThirdisstart() {
		return thirdisstart;
	}

	public void setThirdisstart(String thirdisstart) {
		this.thirdisstart = thirdisstart;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getThirdstartdate() {
		return thirdstartdate;
	}

	public void setThirdstartdate(Date thirdstartdate) {
		this.thirdstartdate = thirdstartdate;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getThirdenddate() {
		return thirdenddate;
	}

	public void setThirdenddate(Date thirdenddate) {
		this.thirdenddate = thirdenddate;
	}
	
	@Length(min=0, max=100, message="第四阶段名称长度必须介于 0 和 100 之间")
	public String getFouthname() {
		return fouthname;
	}

	public void setFouthname(String fouthname) {
		this.fouthname = fouthname;
	}
	
	@Length(min=0, max=1, message="第四阶段是否开启长度必须介于 0 和 1 之间")
	public String getFouthisstart() {
		return fouthisstart;
	}

	public void setFouthisstart(String fouthisstart) {
		this.fouthisstart = fouthisstart;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getFouthstartdate() {
		return fouthstartdate;
	}

	public void setFouthstartdate(Date fouthstartdate) {
		this.fouthstartdate = fouthstartdate;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getFouthenddate() {
		return fouthenddate;
	}

	public void setFouthenddate(Date fouthenddate) {
		this.fouthenddate = fouthenddate;
	}
	
	@Length(min=0, max=64, message="活动代码长度必须介于 0 和 64 之间")
	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getActivitycreatedate() {
		return activitycreatedate;
	}

	public void setActivitycreatedate(Date activitycreatedate) {
		this.activitycreatedate = activitycreatedate;
	}
	
	public String getYear() {
		return year;
	}

	public void setYear(String year) {
		this.year = year;
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
	
	@Length(min=0, max=64, message="扩展字段3长度必须介于 0 和 64 之间")
	public String getAttribute3() {
		return attribute3;
	}

	public void setAttribute3(String attribute3) {
		this.attribute3 = attribute3;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getDelDate() {
		return delDate;
	}

	public void setDelDate(Date delDate) {
		this.delDate = delDate;
	}
	
}