/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.zzjg.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.zzjg.entity.EcppStrformationCopy;
import com.thinkgem.jeesite.modules.zzjg.entity.EcppStrformationCopyCopy;
import com.thinkgem.jeesite.modules.zzjg.dao.EcppStrformationCopyDao;

/**
 * 组织机构Service
 * @author nan
 * @version 2018-03-29
 */
@Service
@Transactional(readOnly = true)
public class EcppStrformationCopyService extends CrudService<EcppStrformationCopyDao, EcppStrformationCopy> {

	@Autowired
	private EcppStrformationCopyCopyService ecppStrformationCopyCopyService;
	
	public EcppStrformationCopy get(String id) {
		return super.get(id);
	}
	
	public List<EcppStrformationCopy> findList(EcppStrformationCopy ecppStrformationCopy) {
		return super.findList(ecppStrformationCopy);
	}
	
	public Page<EcppStrformationCopy> findPage(Page<EcppStrformationCopy> page, EcppStrformationCopy ecppStrformationCopy) {
		return super.findPage(page, ecppStrformationCopy);
	}
	
	@Transactional(readOnly = false)
	public void save(EcppStrformationCopy ecppStrformationCopy) {
		super.save(ecppStrformationCopy);
	}
	
	@Transactional(readOnly = false)
	public void saves(EcppStrformationCopy ecppStrformationCopy) {
		EcppStrformationCopyCopy ecppStrformationCopyCopy1=new EcppStrformationCopyCopy();
		ecppStrformationCopyCopy1.setUnit(ecppStrformationCopy.getUnit());
		ecppStrformationCopyCopyService.delete(ecppStrformationCopyCopy1);
		
		EcppStrformationCopyCopy ecppStrformationCopyCopy=new EcppStrformationCopyCopy();
		ecppStrformationCopyCopy.setId("");
		ecppStrformationCopyCopy.setDelFlag("0");
		ecppStrformationCopyCopy.setFzrnane(ecppStrformationCopy.getFzrnane());		// 姓名
		ecppStrformationCopyCopy.setFzrzhiwei(ecppStrformationCopy.getFzrzhiwei());		// 职位
		ecppStrformationCopyCopy.setFzrdianhua(ecppStrformationCopy.getFzrdianhua());	// 电话
		ecppStrformationCopyCopy.setFzryouxiang(ecppStrformationCopy.getFzryouxiang());		// 邮箱
		ecppStrformationCopyCopy.setLlrnane1(ecppStrformationCopy.getLlrnane1());	// 姓名
		ecppStrformationCopyCopy.setLlrbumen1(ecppStrformationCopy.getLlrbumen1());	// 部门
		ecppStrformationCopyCopy.setLlrzhiwei1(ecppStrformationCopy.getLlrzhiwei1());	// 职位
		ecppStrformationCopyCopy.setLlrdianhua1(ecppStrformationCopy.getLlrdianhua1());		// 电话
		ecppStrformationCopyCopy.setLlrshouji1(ecppStrformationCopy.getLlrshouji1());		// 手机
		ecppStrformationCopyCopy.setLlryouxiang1(ecppStrformationCopy.getLlryouxiang1());		// 邮箱
		ecppStrformationCopyCopy.setLlrnane2(ecppStrformationCopy.getLlrnane2());		// 姓名
		ecppStrformationCopyCopy.setLlrbumen2(ecppStrformationCopy.getLlrbumen2());		// 部门
		ecppStrformationCopyCopy.setLlrzhiwei2(ecppStrformationCopy.getLlrzhiwei2());	// 职位
		ecppStrformationCopyCopy.setLlrdianhua2(ecppStrformationCopy.getLlrdianhua2());		// 电话
		ecppStrformationCopyCopy.setLlrshouji2(ecppStrformationCopy.getLlrshouji2());		// 手机
		ecppStrformationCopyCopy.setLlryouxiang2(ecppStrformationCopy.getLlryouxiang2());		// 邮箱
		ecppStrformationCopyCopy.setUnit(ecppStrformationCopy.getUnit());
		ecppStrformationCopyCopy.setRemarks(ecppStrformationCopy.getRemarks());
		ecppStrformationCopyCopy.setStatus("0");
		ecppStrformationCopyCopyService.save(ecppStrformationCopyCopy);
	}
	
	@Transactional(readOnly = false)
	public void delete(EcppStrformationCopy ecppStrformationCopy) {
		super.delete(ecppStrformationCopy);
	}
	
}