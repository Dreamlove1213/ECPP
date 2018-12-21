/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.stion.entity;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 新建机构Entity
 * @author awei
 * @version 2018-05-12
 */
public class Strformationitem extends DataEntity<Strformationitem> {
	
	private static final long serialVersionUID = 1L;
	private String nane;		// 姓名
	private String oa;		// oa账号
	private String bumen;		// 部门
	private String zhiwei;		// 职位
	private String dianhua;		// 电话
	private String shouji;		// 手机
	private String youxiang;		// 邮箱
	private Strformation strformation;		// 组建机构表id 父类
	private String attribute1;		// 扩展字段1
	private String attribute2;		// 扩展字段2
	private String attribute3;		// 扩展字段3
	private String attribute4;		// 扩展字段4
	private Date delDate;		// del_date
	
	public Strformationitem() {
		super();
	}

	public Strformationitem(String id){
		super(id);
	}

	public Strformationitem(Strformation strformation){
		this.strformation = strformation;
	}

	@Length(min=0, max=255, message="姓名长度必须介于 0 和 255 之间")
	public String getNane() {
		return nane;
	}

	public void setNane(String nane) {
		this.nane = nane;
	}
	
	@Length(min=0, max=255, message="oa账号长度必须介于 0 和 255 之间")
	public String getOa() {
		return oa;
	}

	public void setOa(String oa) {
		this.oa = oa;
	}
	
	@Length(min=0, max=255, message="部门长度必须介于 0 和 255 之间")
	public String getBumen() {
		return bumen;
	}

	public void setBumen(String bumen) {
		this.bumen = bumen;
	}
	
	@Length(min=0, max=255, message="职位长度必须介于 0 和 255 之间")
	public String getZhiwei() {
		return zhiwei;
	}

	public void setZhiwei(String zhiwei) {
		this.zhiwei = zhiwei;
	}
	
	@Length(min=0, max=255, message="电话长度必须介于 0 和 255 之间")
	public String getDianhua() {
		return dianhua;
	}

	public void setDianhua(String dianhua) {
		this.dianhua = dianhua;
	}
	
	@Length(min=0, max=255, message="手机长度必须介于 0 和 255 之间")
	public String getShouji() {
		return shouji;
	}

	public void setShouji(String shouji) {
		this.shouji = shouji;
	}
	
	@Length(min=0, max=255, message="邮箱长度必须介于 0 和 255 之间")
	public String getYouxiang() {
		return youxiang;
	}

	public void setYouxiang(String youxiang) {
		this.youxiang = youxiang;
	}
	
	@Length(min=0, max=64, message="组建机构表id长度必须介于 0 和 64 之间")
	public Strformation getStrformation() {
		return strformation;
	}

	public void setStrformation(Strformation strformation) {
		this.strformation = strformation;
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