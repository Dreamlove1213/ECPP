/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.ecpp.entity;

/**
 * 按类型展示VO
 * @author zxt
 * @version 2018-05-13
 */
public class TypeView {
	
 
	private String name;	//类型名称
	
	private Integer value;	//统计值
	
	private String attrabute1;
	
	private String attrabute2;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getValue() {
		return value;
	}

	public void setValue(Integer value) {
		this.value = value;
	}

	public String getAttrabute1() {
		return attrabute1;
	}

	public void setAttrabute1(String attrabute1) {
		this.attrabute1 = attrabute1;
	}

	public String getAttrabute2() {
		return attrabute2;
	}

	public void setAttrabute2(String attrabute2) {
		this.attrabute2 = attrabute2;
	}
	
	
}