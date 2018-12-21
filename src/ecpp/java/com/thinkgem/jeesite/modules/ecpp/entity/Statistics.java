/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.ecpp.entity;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 统计Entity
 * @author zxy
 * @version 2018-07-18
 */
public class Statistics extends DataEntity<Statistics> {
	
	private static final long serialVersionUID = 1L;
	private String officename;		// 公司名称
	private String officetype;		// 公司类型
	private String plantype;		// 计划类型
	private Integer muprogress;		// 目标进度
	private Integer sjprogress;		// 实际进度
	private Integer munum;		// 目标数量
	private Integer gjxnum;		// 改进项数量
	private Integer mbtype1;		//
	private Integer mbtype2;		//
	private Integer mbtype3;		//
	private Integer mbtype4;		//
	private Integer gjxtype1;		//
	private Integer gjxtype2;		//
	private Integer gjxtype3;		//
	private Integer gjxtype4;		//
	private String attribute3;		// 已经完成的改进项数量
	private String attribute4;		// 扩展字段4
	private String attribute5;		// 扩展字段5
	private String attribute6;		// 扩展字段6
	private Date delDate;		// del_date
	private Integer pageIndex;
	private Integer pageSize;

	public Integer getMbtype1() {
		return mbtype1;
	}

	public void setMbtype1(Integer mbtype1) {
		this.mbtype1 = mbtype1;
	}

	public Integer getMbtype2() {
		return mbtype2;
	}

	public void setMbtype2(Integer mbtype2) {
		this.mbtype2 = mbtype2;
	}

	public Integer getMbtype3() {
		return mbtype3;
	}

	public void setMbtype3(Integer mbtype3) {
		this.mbtype3 = mbtype3;
	}

	public Integer getMbtype4() {
		return mbtype4;
	}

	public void setMbtype4(Integer mbtype4) {
		this.mbtype4 = mbtype4;
	}

	public Integer getGjxtype1() {
		return gjxtype1;
	}

	public void setGjxtype1(Integer gjxtype1) {
		this.gjxtype1 = gjxtype1;
	}

	public Integer getGjxtype2() {
		return gjxtype2;
	}

	public void setGjxtype2(Integer gjxtype2) {
		this.gjxtype2 = gjxtype2;
	}

	public Integer getGjxtype3() {
		return gjxtype3;
	}

	public void setGjxtype3(Integer gjxtype3) {
		this.gjxtype3 = gjxtype3;
	}

	public Integer getGjxtype4() {
		return gjxtype4;
	}

	public void setGjxtype4(Integer gjxtype4) {
		this.gjxtype4 = gjxtype4;
	}



	public Integer getMunum() {
		return munum;
	}

	public void setMunum(Integer munum) {
		this.munum = munum;
	}

	public Integer getGjxnum() {
		return gjxnum;
	}

	public void setGjxnum(Integer gjxnum) {
		this.gjxnum = gjxnum;
	}
	
	public Statistics() {
		super();
	}

	public Statistics(String id){
		super(id);
	}

	public String getOfficename() {
		return officename;
	}

	public void setOfficename(String officename) {
		this.officename = officename;
	}
	
	public String getOfficetype() {
		return officetype;
	}

	public void setOfficetype(String officetype) {
		this.officetype = officetype;
	}
	
	public String getPlantype() {
		return plantype;
	}

	public void setPlantype(String plantype) {
		this.plantype = plantype;
	}

	
	public String getAttribute3() {
		return attribute3;
	}

	public void setAttribute3(String attribute3) {
		this.attribute3 = attribute3;
	}
	
	public String getAttribute4() {
		return attribute4;
	}

	public void setAttribute4(String attribute4) {
		this.attribute4 = attribute4;
	}
	
	public String getAttribute5() {
		return attribute5;
	}

	public void setAttribute5(String attribute5) {
		this.attribute5 = attribute5;
	}
	
	public String getAttribute6() {
		return attribute6;
	}

	public void setAttribute6(String attribute6) {
		this.attribute6 = attribute6;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getDelDate() {
		return delDate;
	}

	public void setDelDate(Date delDate) {
		this.delDate = delDate;
	}

	public Integer getMuprogress() {
		return muprogress;
	}

	public void setMuprogress(Integer muprogress) {
		this.muprogress = muprogress;
	}

	public Integer getSjprogress() {
		return sjprogress;
	}

	public void setSjprogress(Integer sjprogress) {
		this.sjprogress = sjprogress;
	}

	public Integer getPageIndex() {
		return pageIndex;
	}

	public void setPageIndex(Integer pageIndex) {
		this.pageIndex = pageIndex;
	}

	public Integer getPageSize() {
		return pageSize;
	}

	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}
}