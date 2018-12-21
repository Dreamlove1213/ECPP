/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.sys.web;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.modules.ecpp.entity.Statistics;
import com.thinkgem.jeesite.modules.ecpp.service.StatisticsService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.ecpp.entity.Planinformation;
import com.thinkgem.jeesite.modules.ecpp.entity.TypeView;
import com.thinkgem.jeesite.modules.sys.entity.Dict;
import com.thinkgem.jeesite.modules.sys.entity.Office;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.service.OfficeService;
import com.thinkgem.jeesite.modules.sys.utils.DictUtils;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;

/**
 * 机构Controller
 *
 * @author ThinkGem
 * @version 2013-5-15
 */
@Controller
@RequestMapping(value = "${adminPath}/sys/office")
public class OfficeController extends BaseController {

    @Autowired
    private OfficeService officeService;
    @Autowired
    private StatisticsService statisticsService;

    @ModelAttribute("office")
    public Office get(@RequestParam(required = false) String id) {
        if (StringUtils.isNotBlank(id)) {
            return officeService.get(id);
        } else {
            return new Office();
        }
    }

    @RequiresPermissions("sys:office:view")
    @RequestMapping(value = {""})
    public String index(Office office, Model model) {
//        model.addAttribute("list", officeService.findAll());
        return "modules/sys/officeIndex";
    }

    @RequiresPermissions("sys:office:view")
    @RequestMapping(value = {"list"})
    public String list(Office office, Model model) {
        List<Office> p = officeService.findList(office);
        model.addAttribute("list", officeService.findList(office));
        return "modules/sys/officeList";
    }

    /**
     * 企业归档  机构列表
     * @param office
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequiresPermissions("user")
    @RequestMapping(value = {"officeList"})
    public String officeList(Office office, HttpServletRequest request, HttpServletResponse response, Model model) {
        Page<Office> page = officeService.findsPage(new Page<Office>(request, response), office);
        model.addAttribute("page", page);
        return "modules/ecpp/part3/officeList";
    }

    /**
     * 第二环节  问题与目标通过通过和驳回  机构列表
     * @param office
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequiresPermissions("sys:office:view")
    @RequestMapping(value = {"officePlan2List"})
    public String officePlan2List(Office office, HttpServletRequest request, HttpServletResponse response, Model model) {
        Planinformation p = new Planinformation();
        if(UserUtils.getUser().getName() == "游客" || "游客".equals(UserUtils.getUser().getName())){
            p.setShstatus("1");
        }
        p.setStatus("1");
        office.setPlaninformation(p);
        Page<Office> page = officeService.findsPage(new Page<Office>(request, response), office);
        model.addAttribute("page", page);
        return "modules/ecpp/part2/officePlan2List";
    }


    /**
     * 第三环节
     * @param office
     * @param request
     * @param response
     * @param redirectAttributes
     * @param model
     * @return
     */
    @RequiresPermissions("sys:office:view1")
    @RequestMapping(value = {"officePlan3List"})
    public String officePlan3List(Office office, HttpServletRequest request, HttpServletResponse response,RedirectAttributes redirectAttributes, Model model) {
        Planinformation p = new Planinformation();
        p.setShstatus("1");
        p.setStatus("1");
        p.setThreesement("1");
        office.setPlaninformation(p);
        Page<Office> page = officeService.findsPage(new Page<Office>(request, response), office);
        model.addAttribute("page", page);
        return "modules/ecpp/part3/officePlan3List";
    }


    /**
     * 第四环节
     * @param office
     * @param request
     * @param response
     * @param redirectAttributes
     * @param model
     * @return
     */
    @RequiresPermissions("sys:office:view")
    @RequestMapping(value = {"officePlan4List"})
    public String officePlan4List(Office office, HttpServletRequest request, HttpServletResponse response,RedirectAttributes redirectAttributes, Model model) {
        Planinformation p = new Planinformation();
        p.setShstatus("1");
        p.setStatus("1");
        p.setThreesement("1");
        p.setFoursegment("1");
        office.setPlaninformation(p);
        Page<Office> page = officeService.findsPage(new Page<Office>(request, response), office);
        model.addAttribute("page", page);
        return "modules/ecpp/part4/officePlan4List";
    }

    /**
     * 部门归档  机构列表
     * @param office
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequiresPermissions("user")
    @RequestMapping(value = {"officeListCompany"})
    public String officeListCompany(Office office, HttpServletRequest request, HttpServletResponse response, Model model) {
        Page<Office> page = officeService.findsPage(new Page<Office>(request, response), office);
        model.addAttribute("page", page);
        return "modules/ecpp/part3/officeListCompany";
    }

    @RequiresPermissions("sys:office:view")
    @RequestMapping(value = "form")
    public String form(Office office, Model model) {
        User user = UserUtils.getUser();
        if (office.getParent() == null || office.getParent().getId() == null) {
            office.setParent(user.getOffice());
        }
        office.setParent(officeService.get(office.getParent().getId()));
        if (office.getArea() == null) {
            office.setArea(user.getOffice().getArea());
        }
        // 自动获取排序号
        if (StringUtils.isBlank(office.getId()) && office.getParent() != null) {
            int size = 0;
            List<Office> list = officeService.findAll();
            for (int i = 0; i < list.size(); i++) {
                Office e = list.get(i);
                if (e.getParent() != null && e.getParent().getId() != null
                        && e.getParent().getId().equals(office.getParent().getId())) {
                    size++;
                }
            }
            office.setCode(office.getParent().getCode() + StringUtils.leftPad(String.valueOf(size > 0 ? size + 1 : 1), 3, "0"));
        }
        model.addAttribute("office", office);
        return "modules/sys/officeForm";
    }

    @RequiresPermissions("sys:office:edit")
    @RequestMapping(value = "save")
    public String save(Office office, Model model, RedirectAttributes redirectAttributes) {
        if (Global.isDemoMode()) {
            addMessage(redirectAttributes, "演示模式，不允许操作！");
            return "redirect:" + adminPath + "/sys/office/";
        }
        if (!beanValidator(model, office)) {
            return form(office, model);
        }
        officeService.save(office);

        if (office.getChildDeptList() != null) {
            Office childOffice = null;
            for (String id : office.getChildDeptList()) {
                childOffice = new Office();
                childOffice.setName(DictUtils.getDictLabel(id, "sys_office_common", "未知"));
                childOffice.setParent(office);
                childOffice.setArea(office.getArea());
                childOffice.setType("2");
                childOffice.setGrade(String.valueOf(Integer.valueOf(office.getGrade()) + 1));
                childOffice.setUseable(Global.YES);
                officeService.save(childOffice);
            }
        }

        addMessage(redirectAttributes, "保存机构'" + office.getName() + "'成功");
        String id = "0".equals(office.getParentId()) ? "" : office.getParentId();
        return "redirect:" + adminPath + "/sys/office/list?id=" + id + "&parentIds=" + office.getParentIds();
    }

    @RequiresPermissions("sys:office:edit")
    @RequestMapping(value = "delete")
    public String delete(Office office, RedirectAttributes redirectAttributes) {
        if (Global.isDemoMode()) {
            addMessage(redirectAttributes, "演示模式，不允许操作！");
            return "redirect:" + adminPath + "/sys/office/list";
        }
//		if (officeService.isRoot(id)){
//			addMessage(redirectAttributes, "删除机构失败, 不允许删除顶级机构或编号空");
//		}else{
        officeService.delete(office);
        addMessage(redirectAttributes, "删除机构成功");
//		}
        return "redirect:" + adminPath + "/sys/office/list?id=" + office.getParentId() + "&parentIds=" + office.getParentIds();
    }

    /**
     * 六大板块统计图 重写
     * @param office
     * @return
     */
    @RequiresPermissions("user")
    @RequestMapping(value = "checkEchartPlateSix")
    public String checkEchartPlateSix(Office office, Model model) {
        List<String> jhlxlist = new ArrayList<String>();
        List<String> bklist = new ArrayList<String>();
        List<Map> mbbllist = new ArrayList<Map>();
        List<Map> gjxbllist = new ArrayList<Map>();

        List<Dict> zdlist = DictUtils.getDictList("ecpp_plate_type");    //板块字典
        for (int i = 0; i < zdlist.size(); i++) {    //循环去除板块字典中的“无”
            if (zdlist.get(i).getValue().equals("0"))
                zdlist.remove(i);
        }

        //六大板块
        for (Dict zd : zdlist) {
            if (zd != null) {
                String name = zd.getLabel();
                if (name != null && !"".equals(name)) {
                    jhlxlist.add(name);
                    String value = zd.getValue();
                    bklist.add(value);

                    //3  二级单位	2 集团部门
                    //根据文档说明，只有二级单位才有板块之分
                    //获取目标数量和改进项数量
                    Integer mbNum = statisticsService.getCountMbByOfficeAndBk(DictUtils.OFFICE_TYPE3,value);
                    Integer gjxNum = statisticsService.getCountGjxByOfficeAndBk(DictUtils.OFFICE_TYPE3,value);

                    Map<String, Object> map = new HashMap<String, Object>();
                    map.put("name", name);
                    map.put("value", mbNum);
                    mbbllist.add(map);

                    Map<String, Object> maps = new HashMap<String, Object>();
                    maps.put("name", name);
                    maps.put("value", gjxNum);
                    gjxbllist.add(maps);

                }
            }
        }

        Boolean flagB1 = false;
        Boolean flagB2 = false;
        Integer s = (Integer) mbbllist.get(0).get("value");


        if (mbbllist.size() != 0) {
            for (int i = 0; i < mbbllist.size(); i++) {
                if ((Integer) mbbllist.get(i).get("value") != 0) {
                    flagB1 = true;
                }
            }
        }
        if (gjxbllist.size() != 0) {
            for (int i = 0; i < gjxbllist.size(); i++) {
                if ((Integer) gjxbllist.get(i).get("value") != 0) {
                    flagB2 = true;
                }
            }
        }
        model.addAttribute("flagB1", flagB1);
        model.addAttribute("flagB2", flagB2);
        model.addAttribute("jhlxlist", jhlxlist);       //字典   板块名称
        model.addAttribute("bklist", bklist);          //字典    板块名称对应的值
        model.addAttribute("mbbllist", mbbllist);      //mbbllist Map<String,String>  name,value
        model.addAttribute("gjxbllist", gjxbllist);   //gjxbllist Map<String,String>  name,value
        return "modules/sys/officeCountCheck";
    }

    /**
     * 六大板块统计图 --子页面 (重写)
     * @param office
     * @return
     */
    @RequiresPermissions("user")
    @RequestMapping(value = "checkEchartChildren")
    public String checkEchartChildren(Office office, Model model) {

        List<String> jhlxlist = new ArrayList<String>();
        List<String> bkVallist = new ArrayList<String>();        //板块字典的值
        List<Integer> mbbllist = new ArrayList<Integer>();
        List<Integer> gjxbllist = new ArrayList<Integer>();

        List<Dict> zdlist = DictUtils.getDictList("ecpp_plate_type");        //板块字典
        for (int i = 0; i < zdlist.size(); i++) {    //循环去除板块字典中的“无”
            if (zdlist.get(i).getValue().equals("0"))
                zdlist.remove(i);
        }
        for (Dict zd : zdlist) {//循环六次
            if (zd != null) {
                String name = zd.getLabel();
                String bkVal = zd.getValue();
                jhlxlist.add(name);
                bkVallist.add(bkVal);

                //3  二级单位	2 集团部门
                //根据文档说明，只有二级单位才有板块之分
                //获取目标数量和改进项数量
                Integer mbNum = statisticsService.getCountMbByOfficeAndBk(DictUtils.OFFICE_TYPE3,bkVal);
                Integer gjxNum = statisticsService.getCountGjxByOfficeAndBk(DictUtils.OFFICE_TYPE3,bkVal);
                mbbllist.add(mbNum);
                gjxbllist.add(gjxNum);
            }
        }
        model.addAttribute("jhlxlist", jhlxlist);
        model.addAttribute("bkVallist", bkVallist);
        model.addAttribute("mbbllist", mbbllist);
        model.addAttribute("gjxbllist", gjxbllist);
        return "modules/sys/checkEchartChildren";
    }

    /**
     * 按类型统计
     * @param model
     * @return
     */
    @RequiresPermissions("user")
    @RequestMapping(value = "analyzeByType")
    public String analyzeByType(Model model) {
        List<TypeView> typeViewTargetList = new ArrayList<TypeView>();
        List<TypeView> typeViewImpList = new ArrayList<TypeView>();
        List<Dict> dict = DictUtils.getDictList("ecpp_plan_type");
        StringBuffer planName = new StringBuffer();    // 类型名称
        StringBuffer planValueTarget = new StringBuffer();    // 问题目标各类型值

        /**
         * 1: 基础类
         * 2：改善类
         * 3：执行类
         * 4：突破类
         */
        //目标
        Integer mbtype1 = statisticsService.getSumByPlantype("mbtype1");
        Integer mbtype2 = statisticsService.getSumByPlantype("mbtype2");
        Integer mbtype3 = statisticsService.getSumByPlantype("mbtype3");
        Integer mbtype4 = statisticsService.getSumByPlantype("mbtype4");

        //改进项
        Integer gjxtype1 = statisticsService.getSumByPlantype("gjxtype1");
        Integer gjxtype2 = statisticsService.getSumByPlantype("gjxtype2");
        Integer gjxtype3 = statisticsService.getSumByPlantype("gjxtype3");
        Integer gjxtype4 = statisticsService.getSumByPlantype("gjxtype4");

        for (int i = 0; i < dict.size(); i++) {
            TypeView typeView = new TypeView();
            TypeView typeView1 = new TypeView();
            String tempName = dict.get(i).getLabel();
            planName.append("'" + tempName + "',");    //公共数据：类型名称
            typeView.setName(tempName);
            typeView1.setName(tempName);
            if("1".equals(dict.get(i).getValue())){
                typeView.setValue(mbtype1);
                typeView1.setValue(gjxtype1);
            }
            if("2".equals(dict.get(i).getValue())){
                typeView.setValue(mbtype2);
                typeView1.setValue(gjxtype2);
            }
            if("3".equals(dict.get(i).getValue())){
                typeView.setValue(mbtype3);
                typeView1.setValue(gjxtype3);
            }
            if("4".equals(dict.get(i).getValue())){
                typeView.setValue(mbtype4);
                typeView1.setValue(gjxtype4);
            }
            typeViewTargetList.add(typeView);
            typeViewImpList.add(typeView1);
        }

        //控制前端页面饼状图的外圈文字与标识线是否显示
        Boolean flagPage1 = false;
        Boolean flagPage2 = false;
        if (typeViewTargetList.size() != 0) {
            for (int i = 0; i < typeViewTargetList.size(); i++) {
                if (typeViewTargetList.get(i).getValue() != 0) {
                    flagPage1 = true;
                }
            }
        }
        if (typeViewImpList.size() != 0) {
            for (int i = 0; i < typeViewImpList.size(); i++) {
                if (typeViewImpList.get(i).getValue() != 0) {
                    flagPage2 = true;
                }
            }
        }

		/* 按类型*/
        model.addAttribute("dict", dict);
        model.addAttribute("planName", planName);
        model.addAttribute("flagPage1", flagPage1);
        model.addAttribute("flagPage2", flagPage2);
        model.addAttribute("typeViewImpList", typeViewImpList);
        model.addAttribute("typeViewTargetList", typeViewTargetList);
        return "modules/sys/analyzeByType";
    }

    /**
     * 四大类型统计图 --子页面
     *
     * @param model
     * @param flag
     * @return
     */
    @RequiresPermissions("user")
    @RequestMapping(value = "typeEchartChildren")
    public String typeEchartChildren(Model model, Integer flag) {
        List<String> jhlxlist = new ArrayList<String>();
        List<Integer> mbbllist = new ArrayList<Integer>();
        List<Integer> gjxbllist = new ArrayList<Integer>();

        /**
         * 1: 基础类
         * 2：改善类
         * 3：执行类
         * 4：突破类
         */
        //目标
        Integer mbtype1 = statisticsService.getSumByPlantype("mbtype1");
        Integer mbtype2 = statisticsService.getSumByPlantype("mbtype2");
        Integer mbtype3 = statisticsService.getSumByPlantype("mbtype3");
        Integer mbtype4 = statisticsService.getSumByPlantype("mbtype4");

        //改进项
        Integer gjxtype1 = statisticsService.getSumByPlantype("gjxtype1");
        Integer gjxtype2 = statisticsService.getSumByPlantype("gjxtype2");
        Integer gjxtype3 = statisticsService.getSumByPlantype("gjxtype3");
        Integer gjxtype4 = statisticsService.getSumByPlantype("gjxtype4");

        List<Dict> zdlist = DictUtils.getDictList("ecpp_plan_type");
        for (Dict zd : zdlist) {
            jhlxlist.add(zd.getLabel());
            String value = zd.getValue();
            if("1".equals(zd.getValue())){
                mbbllist.add(mbtype1);
                gjxbllist.add(gjxtype1);
            }
            if("2".equals(zd.getValue())){
                mbbllist.add(mbtype2);
                gjxbllist.add(gjxtype2);
            }
            if("3".equals(zd.getValue())){
                mbbllist.add(mbtype3);
                gjxbllist.add(gjxtype3);
            }
            if("4".equals(zd.getValue())){
                mbbllist.add(mbtype4);
                gjxbllist.add(gjxtype4);
            }
        }
        model.addAttribute("jhlxlist", jhlxlist);
        model.addAttribute("mbbllist", mbbllist);
        model.addAttribute("gjxbllist", gjxbllist);
        if (flag == 1) return "modules/sys/checkEchartChildrenByType";    //按类型统计页面的柱状图
        return "modules/sys/checkEchartChildren";                        //按板块统计页面的柱状图
    }

    /**
     * 按公司/按部门 柱状统计图  重写
     * @param office
     * @return
     */
    @RequiresPermissions("user")
    @RequestMapping(value = "institionOnly")
    public String institionOnly(Office office, String type, Model model) {

        List<String> dwlist = new ArrayList<String>();
        List<String> ofidlist = new ArrayList<String>();
        List<Integer> mbNumList = new ArrayList<Integer>();
        List<Integer> gjxNumList = new ArrayList<Integer>();
        Statistics statistics = new Statistics();
        statistics.setOfficetype(type);
        List<Statistics> statisticsList = statisticsService.findList(statistics);
        for (Statistics s : statisticsList){
            dwlist.add(s.getOfficename());
            ofidlist.add(s.getUnit().getId());
            mbNumList.add(s.getMunum());
            gjxNumList.add(s.getGjxnum());
        }

        model.addAttribute("ofidlist", ofidlist);   //officeId  用于数据穿透
        model.addAttribute("type", type);           //单位的类型
        model.addAttribute("dwlist", dwlist);       //公司的名称
        model.addAttribute("mbjdlist", mbNumList);   //目标的数量
        model.addAttribute("sjjdlist", gjxNumList);   //该进项的数量
        return "modules/sys/institionOnly";
    }

    /**
     * 获取机构JSON数据。
     *
     * @param extId    排除的ID
     * @param type     类型（1：公司；2：部门/小组/其它：3：用户）
     * @param grade    显示级别
     * @param response
     * @return
     */
    @RequiresPermissions("user")
    @ResponseBody
    @RequestMapping(value = "treeData")
    public List<Map<String, Object>> treeData(@RequestParam(required = false) String extId, @RequestParam(required = false) String type,
                                              @RequestParam(required = false) Long grade, @RequestParam(required = false) Boolean isAll, HttpServletResponse response) {
        List<Map<String, Object>> mapList = Lists.newArrayList();
        List<Office> list = officeService.findList(isAll);
        for (int i = 0; i < list.size(); i++) {
            Office e = list.get(i);
            if ((StringUtils.isBlank(extId) || (extId != null && !extId.equals(e.getId()) && e.getParentIds().indexOf("," + extId + ",") == -1))
                    && (type == null || (type != null && (type.equals("1") ? type.equals(e.getType()) : true)))
                    && (grade == null || (grade != null && Integer.parseInt(e.getGrade()) <= grade.intValue()))
                    && Global.YES.equals(e.getUseable())) {
                Map<String, Object> map = Maps.newHashMap();
                map.put("id", e.getId());
                map.put("pId", e.getParentId());
                map.put("pIds", e.getParentIds());
                map.put("name", e.getName());
                if (type != null && "3".equals(type)) {
                    map.put("isParent", true);
                }
                mapList.add(map);
            }
        }
        return mapList;
    }
}
