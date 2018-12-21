/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.ecpp.entity;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import java.util.List;
import com.google.common.collect.Lists;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 管理提升 计划改进项Entity
 * @author zxt
 * @version 2018-03-21
 */
public class Planinformation extends DataEntity<Planinformation> {
	
	private static final long serialVersionUID = 1L;
	private String plantitle;		// 计划标题
	private String problemdescription;		// 问题描述
	private String plantype;		// 计划类型
	private String overallgoals;		// 总体目标
	private String planprincipal;		// 负责人
	private Double plannedprogress;		// 计划执行进度
	private String situationandeffect;		// 提升情况及效果
	private String selfevaluation;		// 单位自我评价
	private Double selfevaluationscore;		// 自我评价得分
	private Double averagescore;		// 平均分
	private Date evaluationdate;		// 自我评价时间
	private Resultrecord groupproposal;		// 改革小组建议
	private Date outgroupproposaldate;		// 改革小组建议提出时间
	private String organisationalmeasures;		// 组织评价
	private String evaluationscore;		// 组织评价得分
	private Date organisationadodate;		// 组织评价时间
	private String status;		// 状态
	private String shstatus;		// 目标审核状态
	private String saveStatus;		// 保存状态
	private String threesement;		// 第三环节归档标志
	private String foursegment;		// 第四环节归档标志
	private String segment;		// 环节归档标志
	private String addSum;		// 保存状态
	private String attribute1;		// 扩展字段1
	private String attribute2;		// 扩展字段2
	private String attribute3;		// 扩展字段3
	private String attribute4;		// 扩展字段4
	private String attribute5;		// 扩展字段5
	private String attribute6;		// 扩展字段6
	private String attribute7;		// 扩展字段7
	private String attribute8;		// 扩展字段8
	private String attribute9;		// 扩展字段9
	private String attribute10;		// 扩展字段10
	private String attribute11;		// 扩展字段11	//提交or保存判定  0为保存  1为提交  第四环节
	private String attribute12;		// 扩展字段12	//提交or保存判定  0为保存  1为提交  第二环节
	private Date delDate;		// 删除时间
	private String record;		// 建议、效果 信息 id
	private String sturts;		// //提交or保存判定  0为保存  1为提交  非数据库项
	private Date endDate;		// 计划完成时间
	private Date tijiaotime;		// 目标提交时间
	private String tishengrizhi;		// 提交历史中间变量
	private Integer numUnit;			//统计该部门提交的目标数量

	private Integer num1;		//目标数量
	private Integer num2;		//改经项数量
	private String urlParmeter;

	//新加字段
	private Integer effectivenessmoney1;	//减两金
	private Integer effectivenessmoney2;	//降成本
	private Double effectivenessmoney3;		//提效益
	private Integer effectivenessmoney4;	//增效益
	private Double effectivenessmoney5;		//降负债
	private Integer effectivenessmoney6;	//减费用

	private String effremarks1;				//减两金备注
	private String effremarks2;				//降成本备注
	private String effremarks3;				//提效益备注
	private String effremarks4;				//增效益备注
	private String effremarks5;				//降负债备注
	private String effremarks6;				//减费用备注

	public Integer getEffectivenessmoney1() {
		return effectivenessmoney1;
	}

	public void setEffectivenessmoney1(Integer effectivenessmoney1) {
		this.effectivenessmoney1 = effectivenessmoney1;
	}

	public Integer getEffectivenessmoney2() {
		return effectivenessmoney2;
	}

	public void setEffectivenessmoney2(Integer effectivenessmoney2) {
		this.effectivenessmoney2 = effectivenessmoney2;
	}

	public Double getEffectivenessmoney3() {
		return effectivenessmoney3;
	}

	public void setEffectivenessmoney3(Double effectivenessmoney3) {
		this.effectivenessmoney3 = effectivenessmoney3;
	}

	public Integer getEffectivenessmoney4() {
		return effectivenessmoney4;
	}

	public void setEffectivenessmoney4(Integer effectivenessmoney4) {
		this.effectivenessmoney4 = effectivenessmoney4;
	}

	public Double getEffectivenessmoney5() {
		return effectivenessmoney5;
	}

	public void setEffectivenessmoney5(Double effectivenessmoney5) {
		this.effectivenessmoney5 = effectivenessmoney5;
	}

	public Integer getEffectivenessmoney6() {
		return effectivenessmoney6;
	}

	public void setEffectivenessmoney6(Integer effectivenessmoney6) {
		this.effectivenessmoney6 = effectivenessmoney6;
	}

	public String getEffremarks1() {
		return effremarks1;
	}

	public void setEffremarks1(String effremarks1) {
		this.effremarks1 = effremarks1;
	}

	public String getEffremarks2() {
		return effremarks2;
	}

	public void setEffremarks2(String effremarks2) {
		this.effremarks2 = effremarks2;
	}

	public String getEffremarks3() {
		return effremarks3;
	}

	public void setEffremarks3(String effremarks3) {
		this.effremarks3 = effremarks3;
	}

	public String getEffremarks4() {
		return effremarks4;
	}

	public void setEffremarks4(String effremarks4) {
		this.effremarks4 = effremarks4;
	}

	public String getEffremarks5() {
		return effremarks5;
	}

	public void setEffremarks5(String effremarks5) {
		this.effremarks5 = effremarks5;
	}

	public String getEffremarks6() {
		return effremarks6;
	}

	public void setEffremarks6(String effremarks6) {
		this.effremarks6 = effremarks6;
	}

	public String getSturts() {
		return sturts;
	}

	public void setSturts(String sturts) {
		this.sturts = sturts;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	private List<Improvements> improvementsList = Lists.newArrayList();		// 子表列表
	
	public Planinformation() {
		super();
	}

	public Planinformation(String id){
		super(id);
	}

	@Length(min=0, max=50, message="计划标题长度必须介于 0 和 50 之间")
	public String getPlantitle() {
		return plantitle;
	}

	public void setPlantitle(String plantitle) {
		this.plantitle = plantitle;
	}
	
	@Length(min=0, max=50000, message="问题描述长度必须介于 0 和 50000 之间")
	public String getProblemdescription() {
		return problemdescription;
	}

	public void setProblemdescription(String problemdescription) {
		this.problemdescription = problemdescription;
	}
	
	@Length(min=0, max=64, message="计划类型长度必须介于 0 和 64 之间")
	public String getPlantype() {
		return plantype;
	}

	public void setPlantype(String plantype) {
		this.plantype = plantype;
	}
	
	@Length(min=0, max=50000, message="总体目标长度必须介于 0 和 50000 之间")
	public String getOverallgoals() {
		return overallgoals;
	}

	public void setOverallgoals(String overallgoals) {
		this.overallgoals = overallgoals;
	}
	
	@Length(min=0, max=20, message="负责人长度必须介于 0 和 20 之间")
	public String getPlanprincipal() {
		return planprincipal;
	}

	public void setPlanprincipal(String planprincipal) {
		this.planprincipal = planprincipal;
	}
	
	public Double getPlannedprogress() {
		return plannedprogress;
	}

	public void setPlannedprogress(Double plannedprogress) {
		this.plannedprogress = plannedprogress;
	}
	
	@Length(min=0, max=50000, message="提升情况及效果长度必须介于 0 和 50000 之间")
	public String getSituationandeffect() {
		return situationandeffect;
	}

	public void setSituationandeffect(String situationandeffect) {
		this.situationandeffect = situationandeffect;
	}
	
	@Length(min=0, max=2048000, message="单位自我评价长度必须介于 0 和 204800 之间")
	public String getSelfevaluation() {
		return selfevaluation;
	}

	public void setSelfevaluation(String selfevaluation) {
		this.selfevaluation = selfevaluation;
	}
	
	public Double getSelfevaluationscore() {
		return selfevaluationscore;
	}

	public void setSelfevaluationscore(Double selfevaluationscore) {
		this.selfevaluationscore = selfevaluationscore;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getEvaluationdate() {
		return evaluationdate;
	}

	public void setEvaluationdate(Date evaluationdate) {
		this.evaluationdate = evaluationdate;
	}
	
	public Resultrecord getGroupproposal() {
		return groupproposal;
	}

	public void setGroupproposal(Resultrecord groupproposal) {
		this.groupproposal = groupproposal;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getOutgroupproposaldate() {
		return outgroupproposaldate;
	}

	public void setOutgroupproposaldate(Date outgroupproposaldate) {
		this.outgroupproposaldate = outgroupproposaldate;
	}
	
	@Length(min=0, max=204800, message="组织评价长度必须介于 0 和 204800 之间")
	public String getOrganisationalmeasures() {
		return organisationalmeasures;
	}

	public void setOrganisationalmeasures(String organisationalmeasures) {
		this.organisationalmeasures = organisationalmeasures;
	}
	
	public String getEvaluationscore() {
		return evaluationscore;
	}

	public void setEvaluationscore(String evaluationscore) {
		this.evaluationscore = evaluationscore;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getOrganisationadodate() {
		return organisationadodate;
	}

	public void setOrganisationadodate(Date organisationadodate) {
		this.organisationadodate = organisationadodate;
	}
	
	@Length(min=0, max=64, message="状态长度必须介于 0 和 64 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	@Length(min=0, max=204800, message="扩展字段1长度必须介于 0 和 204800之间")
	public String getAttribute1() {
		return attribute1;
	}

	public void setAttribute1(String attribute1) {
		this.attribute1 = attribute1;
	}
	
	@Length(min=0, max=204800, message="扩展字段2长度必须介于 0 和 204800 之间")
	public String getAttribute2() {
		return attribute2;
	}

	public void setAttribute2(String attribute2) {
		this.attribute2 = attribute2;
	}
	
	@Length(min=0, max=204800, message="扩展字段3长度必须介于 0 和 204800 之间")
	public String getAttribute3() {
		return attribute3;
	}

	public void setAttribute3(String attribute3) {
		this.attribute3 = attribute3;
	}
	
	@Length(min=0, max=204800, message="扩展字段4长度必须介于 0 和 204800之间")
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
	
	public List<Improvements> getImprovementsList() {
		return improvementsList;
	}

	public void setImprovementsList(List<Improvements> improvementsList) {
		this.improvementsList = improvementsList;
	}

	public String getRecord() {
		return record;
	}

	public void setRecord(String record) {
		this.record = record;
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

	public String getAttribute7() {
		return attribute7;
	}

	public void setAttribute7(String attribute7) {
		this.attribute7 = attribute7;
	}

	public String getAttribute8() {
		return attribute8;
	}

	public void setAttribute8(String attribute8) {
		this.attribute8 = attribute8;
	}

	public String getAttribute9() {
		return attribute9;
	}

	public void setAttribute9(String attribute9) {
		this.attribute9 = attribute9;
	}

	public String getAttribute10() {
		return attribute10;
	}

	public void setAttribute10(String attribute10) {
		this.attribute10 = attribute10;
	}

	public String getAttribute11() {
		return attribute11;
	}

	public void setAttribute11(String attribute11) {
		this.attribute11 = attribute11;
	}

	public String getAttribute12() {
		return attribute12;
	}

	public void setAttribute12(String attribute12) {
		this.attribute12 = attribute12;
	}

	public String getSaveStatus() {
		return saveStatus;
	}

	public void setSaveStatus(String saveStatus) {
		this.saveStatus = saveStatus;
	}

	public String getAddSum() {
		return addSum;
	}

	public void setAddSum(String addSum) {
		this.addSum = addSum;
	}

	public String getTishengrizhi() {
		return tishengrizhi;
	}

	public void setTishengrizhi(String tishengrizhi) {
		this.tishengrizhi = tishengrizhi;
	}

	public Date getTijiaotime() {
		return tijiaotime;
	}

	public void setTijiaotime(Date tijiaotime) {
		this.tijiaotime = tijiaotime;
	}

	public String getShstatus() {
		return shstatus;
	}

	public void setShstatus(String shstatus) {
		this.shstatus = shstatus;
	}

	public Double getAveragescore() {
		return averagescore;
	}

	public void setAveragescore(Double averagescore) {
		this.averagescore = averagescore;
	}

	public String getThreesement() {
		return threesement;
	}

	public void setThreesement(String threesement) {
		this.threesement = threesement;
	}

	public String getSegment() {
		return segment;
	}

	public void setSegment(String segment) {
		this.segment = segment;
	}

	public String getFoursegment() {
		return foursegment;
	}

	public void setFoursegment(String foursegment) {
		this.foursegment = foursegment;
	}

	public Integer getNumUnit() {
		return numUnit;
	}

	public void setNumUnit(Integer numUnit) {
		this.numUnit = numUnit;
	}

	public Integer getNum1() {
		return num1;
	}

	public void setNum1(Integer num1) {
		this.num1 = num1;
	}

	public Integer getNum2() {
		return num2;
	}

	public void setNum2(Integer num2) {
		this.num2 = num2;
	}

	public String getUrlParmeter() {
		return urlParmeter;
	}

	public void setUrlParmeter(String urlParmeter) {
		this.urlParmeter = urlParmeter;
	}
}