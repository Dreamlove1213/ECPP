/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.ecpp.entity;

import org.hibernate.validator.constraints.Length;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 管理提升 计划改进项Entity
 * @author zxt
 * @version 2018-03-21
 */
public class Improvements extends DataEntity<Improvements> {
	
	private static final long serialVersionUID = 1L;
	private Planinformation planid;			// 计划信息ID 父类
	private String improvedtitle;			// 改进项标题
	private String weight;					// 权重
	private String principal;				// 责任人
	private Date finishtime;				// 完成时间
	private Double improvementprogress;		// 改进项进度
	private Double improvementprogressTureValue;		// 改进项进度页面输出的值
	
	private String status;			// 状态
	private String content;			// 扩展字段1
	private String attribute2;		// 扩展字段2
	private String attribute3;		// 扩展字段3
	private String attribute4;		// 扩展字段4
	private String attachment;		// 改进项成果
	private String attribute6;		// 扩展字段4
	private Double score;			// 得分
	private Double money1;			//1阶段提升效益
	private Double money2;			//2阶段提升效益
	private String progrcess;		//改进项进度
	private Date delDate;			// 删除时间
	private String planType;		// 计划类型
	private Integer num;			// 改进项数量统计
	private Double total;			// 改进项*权重之和

	public String getAttribute6() {
		return attribute6;
	}

	public void setAttribute6(String attribute6) {
		this.attribute6 = attribute6;
	}

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	public Improvements() {
		super();
	}

	public String getPlanType() {
		return planType;
	}

	public void setPlanType(String planType) {
		this.planType = planType;
	}

	public Improvements(String id){
		super(id);
	}

	public Improvements(Planinformation planid){
		this.planid = planid;
	}

	@Length(min=0, max=64, message="计划信息ID长度必须介于 0 和 64 之间")
	public Planinformation getPlanid() {
		return planid;
	}

	public void setPlanid(Planinformation planid) {
		this.planid = planid;
	}
	
	@Length(min=0, max=50, message="改进项标题长度必须介于 0 和 50 之间")
	public String getImprovedtitle() {
		return improvedtitle;
	}

	public void setImprovedtitle(String improvedtitle) {
		this.improvedtitle = improvedtitle;
	}
	
	public String getWeight() {
		return weight;
	}

	public void setWeight(String weight) {
		this.weight = weight;
	}
	
	@Length(min=0, max=20, message="责任人长度必须介于 0 和 20 之间")
	public String getPrincipal() {
		return principal;
	}

	public void setPrincipal(String principal) {
		this.principal = principal;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd")
	public Date getFinishtime() {
		return finishtime;
	}

	public void setFinishtime(Date finishtime) {
		this.finishtime = finishtime;
	}
	
	public Double getImprovementprogress() {
		return improvementprogress;
	}

	public void setImprovementprogress(Double improvementprogress) {
		this.improvementprogress = improvementprogress;
	}
	
	@Length(min=0, max=64, message="状态长度必须介于 0 和 64 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	@Length(min=0, max=1024, message="扩展字段1长度必须介于 0 和 1024 之间")
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
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
	
	public Double getImprovementprogressTureValue(Double improvementprogress) {
		return improvementprogressTureValue;
	}

	public void setImprovementprogressTureValue(Double improvementprogressTureValue) {
		this.improvementprogressTureValue = improvementprogressTureValue;
	}

	public String getAttachment() {
		return attachment;
	}

	public void setAttachment(String attachment) {
		this.attachment = attachment;
	}

	public Double getMoney1() {
		return money1;
	}

	public void setMoney1(Double money1) {
		this.money1 = money1;
	}

	public Double getMoney2() {
		return money2;
	}

	public void setMoney2(Double money2) {
		this.money2 = money2;
	}

	public String getProgrcess() {
		return progrcess;
	}

	public void setProgrcess(String progrcess) {
		this.progrcess = progrcess;
	}

	public Double getScore() {
		return score;
	}

	public void setScore(Double score) {
		this.score = score;
	}

	public Double getTotal() {
		return total;
	}

	public void setTotal(Double total) {
		this.total = total;
	}
}