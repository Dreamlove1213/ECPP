/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.stion.entity;

import com.thinkgem.jeesite.common.utils.excel.annotation.ExcelField;
import org.hibernate.validator.constraints.Length;
import com.thinkgem.jeesite.modules.sys.entity.Office;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import java.util.List;
import com.google.common.collect.Lists;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 新建机构Entity
 * @author awei
 * @version 2018-05-12
 */
public class Strformation extends DataEntity<Strformation> {
	
	private static final long serialVersionUID = 1L;
	private String name;		// 姓名
	private String zhiwei;		// 职位
	private String dianhua;		// 电话
	private String youxiang;		// 邮箱
	private String status;		// 信息状态
	private String attribute1;		// 扩展字段1
	private String attribute2;		// 扩展字段2
	private String attribute3;		// 扩展字段3
	private String attribute4;		// 扩展字段4
	private Office unit;		// 单位
	private Date delDate;		// del_date
	private List<Strformationitem> strformationitemList = Lists.newArrayList();		// 子表列表
	
	public Strformation() {
		super();
	}

	public Strformation(String id){
		super(id);
	}

	@ExcelField(title="姓名", align=2, sort=20)
	@Length(min=0, max=64, message="姓名长度必须介于 0 和 64 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@ExcelField(title="职位", align=2, sort=30)
	@Length(min=0, max=255, message="职位长度必须介于 0 和 255 之间")
	public String getZhiwei() {
		return zhiwei;
	}

	public void setZhiwei(String zhiwei) {
		this.zhiwei = zhiwei;
	}

	@ExcelField(title="电话", align=2, sort=40)
	@Length(min=0, max=255, message="电话长度必须介于 0 和 255 之间")
	public String getDianhua() {
		return dianhua;
	}

	public void setDianhua(String dianhua) {
		this.dianhua = dianhua;
	}

	@ExcelField(title="邮箱", align=2, sort=50)
	@Length(min=0, max=255, message="邮箱长度必须介于 0 和 255 之间")
	public String getYouxiang() {
		return youxiang;
	}

	public void setYouxiang(String youxiang) {
		this.youxiang = youxiang;
	}
	
	@Length(min=0, max=64, message="信息状态长度必须介于 0 和 64 之间")
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

	@ExcelField(title="单位", align=2, sort=10)
	public Office getUnit() {
		return unit;
	}

	public void setUnit(Office unit) {
		this.unit = unit;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getDelDate() {
		return delDate;
	}

	public void setDelDate(Date delDate) {
		this.delDate = delDate;
	}
	
	public List<Strformationitem> getStrformationitemList() {
		return strformationitemList;
	}

	public void setStrformationitemList(List<Strformationitem> strformationitemList) {
		this.strformationitemList = strformationitemList;
	}
}