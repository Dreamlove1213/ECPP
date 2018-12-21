/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.stion.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.stion.entity.Strformation;
import com.thinkgem.jeesite.modules.stion.dao.StrformationDao;
import com.thinkgem.jeesite.modules.stion.entity.Strformationitem;
import com.thinkgem.jeesite.modules.stion.dao.StrformationitemDao;

/**
 * 新建机构Service
 * @author awei
 * @version 2018-05-12
 */
@Service
@Transactional(readOnly = true)
public class StrformationService extends CrudService<StrformationDao, Strformation> {

	@Autowired
	private StrformationitemDao strformationitemDao;
	
	public Strformation get(String id) {
		Strformation strformation = super.get(id);
		strformation.setStrformationitemList(strformationitemDao.findList(new Strformationitem(strformation)));
		return strformation;
	}
	
	public List<Strformation> findList(Strformation strformation) {
		return super.findList(strformation);
	}
	
	public Page<Strformation> findPage(Page<Strformation> page, Strformation strformation) {
		return super.findPage(page, strformation);
	}
	
	@Transactional(readOnly = false)
	public void save(Strformation strformation) {
		super.save(strformation);
		for (Strformationitem strformationitem : strformation.getStrformationitemList()){
			if (strformationitem.getId() == null){
				continue;
			}
			if (Strformationitem.DEL_FLAG_NORMAL.equals(strformationitem.getDelFlag())){
				if (StringUtils.isBlank(strformationitem.getId())){
					strformationitem.setStrformation(strformation);
					strformationitem.preInsert();
					strformationitemDao.insert(strformationitem);
				}else{
					strformationitem.preUpdate();
					strformationitemDao.update(strformationitem);
				}
			}else{
				strformationitemDao.delete(strformationitem);
			}
		}
	}
	
	@Transactional(readOnly = false)
	public void delete(Strformation strformation) {
		super.delete(strformation);
		strformationitemDao.delete(new Strformationitem(strformation));
	}
	
}