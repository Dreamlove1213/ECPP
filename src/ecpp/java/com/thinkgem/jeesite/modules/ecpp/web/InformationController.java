/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.ecpp.web;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.thinkgem.jeesite.modules.ecppwork.entity.EcppWorkprogramme;
import com.thinkgem.jeesite.modules.ecppwork.service.EcppWorkprogrammeService;
import org.apache.ibatis.jdbc.Null;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.Encodes;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.config.entity.EcppConfig;
import com.thinkgem.jeesite.modules.config.service.EcppConfigService;
import com.thinkgem.jeesite.modules.ecpp.entity.Information;
import com.thinkgem.jeesite.modules.ecpp.entity.Planinformation;
import com.thinkgem.jeesite.modules.ecpp.service.InformationService;
import com.thinkgem.jeesite.modules.ecpp.service.PlaninformationService;
import com.thinkgem.jeesite.modules.gzdt.entity.EcppInformationCopy;
import com.thinkgem.jeesite.modules.gzdt.service.EcppInformationCopyService;
import com.thinkgem.jeesite.modules.sys.entity.Office;
import com.thinkgem.jeesite.modules.sys.entity.Role;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.service.OfficeService;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;

/**
 * 管理提升信息表Controller
 *
 * @author zxt
 * @version 2018-03-21
 */
@Controller
@RequestMapping(value = "${adminPath}/ecpp/information")
public class InformationController extends BaseController {
    @Autowired
    private PlaninformationService planinformationService;
    @Autowired
    private EcppInformationCopyService ecppInformationCopyService;
    @Autowired
    private InformationService informationService;
    @Autowired
    private OfficeService officeService;
    @Autowired
    private EcppConfigService ecppConfigService;
    @Autowired
    private EcppWorkprogrammeService ecppWorkprogrammeService;

    // 文件保存目录相对路径
    private String basePath = "userfiles";

    @ModelAttribute
    public Information get(@RequestParam(required = false) String id) {
        Information entity = null;
        if (StringUtils.isNotBlank(id)) {
            entity = informationService.get(id);
        }
        if (entity == null) {
            entity = new Information();
        }
        return entity;
    }

    /**
     * 信息搜索
     * */
    @RequestMapping(value = "sousuo")
    public String sousuo(Information information, HttpServletRequest request, HttpServletResponse response, Model model) {
        information.setStatus("1");
        Page<Information> page = informationService.findPage2(new Page<Information>(request, response), information);
        model.addAttribute("page", page);
        return "modules/ecpp/part1/informationCheckInfoList";
    }

    /**
     * 首页
     * @param information
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequiresPermissions("ecpp:information:view")
    @RequestMapping(value = {"index", ""})
    public String index(Information information, HttpServletRequest request, HttpServletResponse response, Model model) {
        List<EcppInformationCopy> list1 = this.ecppInformationCopyService.findInfoList();
        List<Information> list2 = this.informationService.findInfoList("dep");
        List<Information> list3 = this.informationService.findInfoList("info");

        Planinformation planinformation = new Planinformation();
        Office off1 = new Office();
        off1.setType("2");
        planinformation.setUnit(off1);
        planinformation.setStatus("1");            //查询已经提交的
        planinformation.setShstatus("1");          //查询已经审核通过的
        List<Planinformation> list4 = planinformationService.findListByqiyeGroupByUnit(planinformation);

        planinformation.setThreesement("1");
        List<Planinformation> list45 = planinformationService.findListByqiyeGroupByUnit(planinformation);//第三环节
        planinformation.setFoursegment("1");
        List<Planinformation> list46 = planinformationService.findListByqiyeGroupByUnit(planinformation);//第四环节

        if (list4.size() != 0) {
            for (int i = 0; i < list4.size(); i++) {
                String shStatus = list4.get(i).getShstatus();
                if ("1".equals(shStatus)) {
                    list4.get(i).setSegment("二");
                }
            }
        }
        if (list45.size() != 0) {
            for (int i = 0; i < list45.size(); i++) {
                String segMent = list45.get(i).getThreesement();
                if ("1".equals(segMent)) {
                    list45.get(i).setSegment("三");
                }
            }
        }
        if (list46.size() != 0) {
            for (int i = 0; i < list46.size(); i++) {
                String segMent = list46.get(i).getFoursegment();
                if ("1".equals(segMent)) {
                    list46.get(i).setSegment("四");
                }
            }
        }


        Planinformation planinformation1 = new Planinformation();
        off1.setType("3");
        planinformation1.setShstatus("1");//已经通过审核的
        planinformation1.setStatus("1");//已经提交的
        planinformation1.setUnit(off1);
        List<Planinformation> list5 = planinformationService.findListByqiyeGroupByUnit(planinformation1);//第二环节

        planinformation1.setThreesement("1");
        List<Planinformation> list6 = planinformationService.findListByqiyeGroupByUnit(planinformation1);//第三环节
        planinformation1.setFoursegment("1");
        List<Planinformation> list7 = planinformationService.findListByqiyeGroupByUnit(planinformation1);//第四环节
        if (list5.size() != 0) {
            for (int i = 0; i < list5.size(); i++) {
                String shStatus = list5.get(i).getShstatus();
                if ("1".equals(shStatus)) {
                    list5.get(i).setSegment("二");
                }
            }
        }
        if (list6.size() != 0) {
            for (int i = 0; i < list6.size(); i++) {
                String segMent = list6.get(i).getThreesement();
                if ("1".equals(segMent)) {
                    list6.get(i).setSegment("三");
                }
            }
        }
        if (list7.size() != 0) {
            for (int i = 0; i < list7.size(); i++) {
                String segMent = list7.get(i).getFoursegment();
                if ("1".equals(segMent)) {
                    list7.get(i).setSegment("四");
                }
            }
        }

        list46.addAll(list45);
        list46.addAll(list4);
        list5.addAll(list6);
        list5.addAll(list7);

        Date nowdate = new Date();    //当前时间

        if (list1.size() != 0) {
            for (int i = 0; i < list1.size(); i++) {
                Date n = list1.get(i).getCreateDate();
                Integer chazhi1 = (int) ((nowdate.getTime() - n.getTime()) / (1000 * 60 * 60 * 24));    //当前时间-7月1号    小于0   比值为0
                if (chazhi1 <= 2) {
                    list1.get(i).setRemarks("1");    //输出借用新闻中的备注字段实现，新闻发布两天之内，标题上显示一个“new”的字样（需要标识）
                } else {
                    list1.get(i).setRemarks("0");
                }
            }
        }

        if (list2.size() != 0) {
            for (int i = 0; i < list2.size(); i++) {
                Date n = list2.get(i).getCreateDate();
                Integer chazhi1 = (int) ((nowdate.getTime() - n.getTime()) / (1000 * 60 * 60 * 24));    //当前时间-7月1号    小于0   比值为0
                if (chazhi1 <= 2) {
                    list2.get(i).setRemarks("1");    //输出借用新闻中的备注字段实现，新闻发布两天之内，标题上显示一个“new”的字样（需要标识）
                } else {
                    list2.get(i).setRemarks("0");
                }
            }
        }

        if (list3.size() != 0) {
            for (int i = 0; i < list3.size(); i++) {
                Date n = list3.get(i).getCreateDate();
                Integer chazhi1 = (int) ((nowdate.getTime() - n.getTime()) / (1000 * 60 * 60 * 24));    //当前时间-7月1号    小于0   比值为0
                if (chazhi1 <= 2) {
                    list3.get(i).setRemarks("1");    //输出借用新闻中的备注字段实现，新闻发布两天之内，标题上显示一个“new”的字样（需要标识）
                } else {
                    list3.get(i).setRemarks("0");
                }
            }
        }


        // office  type  3: 企业   2：部门
        EcppWorkprogramme ecppWorkprogramme = new EcppWorkprogramme();
        Office o = new Office();
        o.setType("3");
        ecppWorkprogramme.setStatus("1");
        ecppWorkprogramme.setUnit(o);
        List<EcppWorkprogramme> ecppWorkprogrammeListUnit = ecppWorkprogrammeService.findListByqiyeGroupByUnit(ecppWorkprogramme);
        o.setType("2");
        List<EcppWorkprogramme> ecppWorkprogrammeListCompany = ecppWorkprogrammeService.findListByqiyeGroupByUnit(ecppWorkprogramme);

        model.addAttribute("list1", list1);
        model.addAttribute("list2", list2);
        model.addAttribute("list3", list3);
        model.addAttribute("list4", list46);
        model.addAttribute("list5", list5);
        model.addAttribute("ecppWorkprogrammeList", ecppWorkprogrammeListUnit);
        model.addAttribute("ecppWorkprogrammeCompany", ecppWorkprogrammeListCompany);

        EcppConfig ecppConfig = new EcppConfig();
        if (ecppConfigService.findList(ecppConfig).size() != 0) {
            ecppConfig =  ecppConfigService.findList(ecppConfig).get(0);
        }

        model.addAttribute("ecppConfig", ecppConfig);
        return "modules/ecpp/index";
    }

    /**
     * 信息审议
     *
     * @param information
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequiresPermissions("ecpp:information:view")
    @RequestMapping(value = "checkInfoList")
    public String checkInfoList(Information information, HttpServletRequest request, HttpServletResponse response, Model model) {
        information.setStatus("3");
        Page<Information> page = informationService.findPage5(new Page<Information>(request, response), information);
        model.addAttribute("page", page);
        return "modules/ecpp/part1/informationCheckInfoList";
    }

    /**
     * 历史消息
     * @param information
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequiresPermissions("ecpp:information:view")
    @RequestMapping(value = "hositoryList")
    public String hositoryList(Information information, HttpServletRequest request, HttpServletResponse response, Model model) {
        List<Role> roleList = UserUtils.getRoleList();
        int a=0;
        for(Role role:roleList){
            if("reform".equals(role.getEnname())){
                a=a+1;
            }
        }
        if (a != 1){
            String officeId = UserUtils.getUser().getOffice().getId();
            Office o = officeService.getOne(officeId);
            information.setUnit(o);
        }
        Page<Information> page = informationService.findPage5(new Page<Information>(request, response), information);
        model.addAttribute("page", page);
        return "modules/ecpp/part1/informationhositoryList";
    }

    /**
     * 信息审议
     *
     * @param information
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequiresPermissions("ecpp:information:view")
    @RequestMapping(value = "tijiaolist")
    public String tijiaolist(Information information, HttpServletRequest request, HttpServletResponse response, Model model, RedirectAttributes redirectAttributes) {
        information.setStatus("0");
        informationService.save(information);
        addMessage(redirectAttributes, "提交信息成功");
        return "redirect:" + Global.getAdminPath() + "/ecpp/information/list?repage";
    }

    @RequiresPermissions("ecpp:information:view")
    @RequestMapping(value = {"list"})
    public String list(Information information, HttpServletRequest request, HttpServletResponse response, Model model) {
        information.setUnit(UserUtils.getUser().getOffice());
        Page<Information> page = informationService.findPage4(new Page<Information>(request, response), information);
        model.addAttribute("page", page);
        return "modules/ecpp/part1/informationList";
    }

    /**
     * 企业归档信息列表
     * @param information
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequiresPermissions("ecpp:information:view")
    @RequestMapping(value = {"guidangqiyelist"})
    public String guidangqiyelist(Information information, HttpServletRequest request, HttpServletResponse response, Model model) {
        Office o = new Office();
        Planinformation planinformation1 = new Planinformation();
        o.setType("3");
        planinformation1.setShstatus("1");//已经通过审核的
        planinformation1.setStatus("1");//已经提交的
        planinformation1.setUnit(o);

        planinformation1.setThreesement("1");   //第三阶段已经归档的
        planinformation1.setFoursegment("1");   //第四阶段已经归档的
        List<Planinformation> list7 = planinformationService.findListByqiyeGroupByUnit(planinformation1);//第四环节
        planinformation1.setFoursegment(null);
        List<Planinformation> list6 = planinformationService.findListByqiyeGroupByUnit(planinformation1);//第三环节
        planinformation1.setThreesement(null);
        List<Planinformation> list5 = planinformationService.findListByqiyeGroupByUnit(planinformation1);//第二环节
        if (list5.size() != 0) {
            for (int i = 0; i < list5.size(); i++) {
                String shStatus = list5.get(i).getShstatus();
                if ("1".equals(shStatus)) {
                    list5.get(i).setSegment("二");
                }
            }
        }
        if (list6.size() != 0) {
            for (int i = 0; i < list6.size(); i++) {
                String segMent = list6.get(i).getThreesement();
                if ("1".equals(segMent)) {
                    list6.get(i).setSegment("三");
                }
            }
        }
        if (list7.size() != 0) {
            for (int i = 0; i < list7.size(); i++) {
                String segMent = list7.get(i).getFoursegment();
                if ("1".equals(segMent)) {
                    list7.get(i).setSegment("四");
                }
            }
        }

        //-------------------------------------------------------
        EcppWorkprogramme ecppWorkprogramme = new EcppWorkprogramme();
        ecppWorkprogramme.setStatus("1");
        ecppWorkprogramme.setUnit(o);
        List<EcppWorkprogramme> ecppWorkprogrammeListUnit = ecppWorkprogrammeService.findListByqiyeGroupByUnit(ecppWorkprogramme);
      /*  list5.addAll(list7);
        list5.addAll(list6);*/
        list7.addAll(list6);
        list7.addAll(list5);
        model.addAttribute("ecppWorkprogrammeList", ecppWorkprogrammeListUnit);
        Planinformation pNew = new Planinformation();
        List<Planinformation> listNewL = planinformationService.findListByqiyeGroupByUnit(pNew);//第二环节
        model.addAttribute("list5", list7);
        return "modules/ecpp/qiyeguidangList";
    }

    /**
     * 部门信息列表
     * @param information
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequiresPermissions("ecpp:information:view")
    @RequestMapping(value = {"guidangbumenlist"})
    public String guidangbumenlist(Information information, HttpServletRequest request, HttpServletResponse response, Model model) {
        Planinformation planinformation = new Planinformation();
        Office o = new Office();
        o.setType("2");
        planinformation.setUnit(o);
        planinformation.setStatus("1");            //查询已经提交的
        planinformation.setShstatus("1");          //查询已经审核通过的
        planinformation.setThreesement("1");
        planinformation.setFoursegment("1");
        List<Planinformation> list46 = planinformationService.findListByqiyeGroupByUnit(planinformation);//第四环节
        planinformation.setFoursegment(null);
        List<Planinformation> list45 = planinformationService.findListByqiyeGroupByUnit(planinformation);//第三环节
        planinformation.setThreesement(null);
        List<Planinformation> list4 = planinformationService.findListByqiyeGroupByUnit(planinformation);//第二环节

        if (list4.size() != 0) {
            for (int i = 0; i < list4.size(); i++) {
                String shStatus = list4.get(i).getShstatus();
                if ("1".equals(shStatus)) {
                    list4.get(i).setSegment("二");
                }
            }
        }
        if (list45.size() != 0) {
            for (int i = 0; i < list45.size(); i++) {
                String segMent = list45.get(i).getThreesement();
                if ("1".equals(segMent)) {
                    list45.get(i).setSegment("三");
                }
            }
        }
        if (list46.size() != 0) {
            for (int i = 0; i < list46.size(); i++) {
                String segMent = list46.get(i).getFoursegment();
                if ("1".equals(segMent)) {
                    list46.get(i).setSegment("四");
                }
            }
        }
        list46.addAll(list45);
        list46.addAll(list4);
        EcppWorkprogramme ecppWorkprogramme = new EcppWorkprogramme();
        o.setType("2");
        ecppWorkprogramme.setStatus("1");
        ecppWorkprogramme.setUnit(o);
        List<EcppWorkprogramme> ecppWorkprogrammeListCompany = ecppWorkprogrammeService.findListByqiyeGroupByUnit(ecppWorkprogramme);
        model.addAttribute("ecppWorkprogrammeCompany",ecppWorkprogrammeListCompany);
        model.addAttribute("list4",list46);
        return "modules/ecpp/bumenguidangList";
    }



    @RequiresPermissions("ecpp:information:view")
    @RequestMapping(value = {"list1"})
    public String list1(Information information, HttpServletRequest request, HttpServletResponse response, Model model) {
        information.setStatus("1");
        Office office = new Office();
        office.setType("1");
        information.setUnit(office);
        Page<Information> page = informationService.findPage(new Page<Information>(request, response), information);
        model.addAttribute("page", page);
        return "modules/ecpp/part1/informationList3";
    }

    @RequiresPermissions("ecpp:information:view")
    @RequestMapping(value = {"list2"})
    public String list2(Information information, HttpServletRequest request, HttpServletResponse response, Model model) {
        //获取用户角色，判断是否有删除操作权限
        Boolean isAllowDel = false;
        User user = UserUtils.getUser();
        if (user != null && user.getRoleList() != null) {
            List<Role> roleList = user.getRoleList();
            for (int i = 0; i < roleList.size(); i++) {
                String roleName = roleList.get(i).getEnname();
                if (roleName != null && roleName.equals("reform")) {    // 若用户属于改革办小组，则有删除操作权限
                    isAllowDel = true;
                }
            }
        }

        information.setStatus("1");
        Office office = new Office();
        office.setType("2");
        information.setUnit(office);
        Page<Information> page = informationService.findPage(new Page<Information>(request, response), information);
        model.addAttribute("page", page);
        model.addAttribute("isAllowDel", isAllowDel);
        return "modules/ecpp/part1/informationList2";
    }

    @RequiresPermissions("ecpp:information:view")
    @RequestMapping(value = {"list3"})
    public String list3(Information information, HttpServletRequest request, HttpServletResponse response, Model model) {
        //获取用户角色，判断是否有删除操作权限
        Boolean isAllowDel = false;
        User user = UserUtils.getUser();
        if (user != null && user.getRoleList() != null) {
            List<Role> roleList = user.getRoleList();
            for (int i = 0; i < roleList.size(); i++) {
                String roleName = roleList.get(i).getEnname();
                if (roleName != null && roleName.equals("reform")) {    // 若用户属于改革办小组，则有删除操作权限
                    isAllowDel = true;
                }
            }
        }

        information.setStatus("1");
        Office office = new Office();
        office.setType("3");
        information.setUnit(office);
        Page<Information> page = informationService.findPage(new Page<Information>(request, response), information);
        model.addAttribute("page", page);
        model.addAttribute("isAllowDel", isAllowDel);
        return "modules/ecpp/part1/informationList3";
    }

    @RequiresPermissions("ecpp:information:view")
    @RequestMapping(value = "form")
    public String form(Information information, Model model) {
        if (information != null) {
            String id = information.getId();
            if (id != null && !"".equals(id)) {
                information.setAttribute4("2");
                informationService.save(information);
            }
        }

        model.addAttribute("information", information);
        return "modules/ecpp/part1/informationForm";
    }

    /**
     * 资讯发布
     *
     * @version 2018-03-21
     */
    @RequiresPermissions("ecpp:information:view")
    @RequestMapping(value = "newForm")
    public String newForm(Information information, Model model) {
        model.addAttribute("information", information);
        return "modules/ecpp/part1/informationnewForm";
    }

    @RequiresPermissions("ecpp:information:view")
    @RequestMapping(value = "informationDetails")
    public String informationDetails(Information information, Model model) {
        model.addAttribute("information", information);
        return "modules/ecpp/part1/informationDetails";
    }

    /**
     * 统计浏览量
     *
     * @param information
     * @param request
     * @param response
     * @param model
     */
    @RequestMapping(value = "ajaxCount")
    public void ajaxCount(Information information, HttpServletRequest request, HttpServletResponse response, Model model) {
        if (information.getAttribute3() == null || "".equals(information.getAttribute3())) {
            Integer count = 0;
            count = count + 1;
            information.setAttribute3(String.valueOf(count));
        } else {
            Integer count = Integer.valueOf(information.getAttribute3());
            count = count + 1;
            information.setAttribute3(String.valueOf(count));
        }
        informationService.save(information);
    }


    /**
     * 信息审核
     *
     * @version 2018-03-21
     */
    @RequiresPermissions("ecpp:information:view")
    @RequestMapping(value = "informationCheck")
    public String informationCheck(Information information, Model model) {
        model.addAttribute("information", information);
        return "modules/ecpp/part1/informationCheck";
    }

    /**
     * 审核通过
     *
     * @version 2018-03-21
     */
    @RequiresPermissions("ecpp:information:view")
    @RequestMapping(value = "pass")
    public String pass(Information information, HttpServletRequest request, HttpServletResponse response, Model model) {
        information.setStatus("1");
        informationService.save(information);
        return renderString(response, "1");
    }

    /**
     * 审核驳回
     *
     * @version 2018-03-21
     */
    @RequiresPermissions("ecpp:information:view")
    @RequestMapping(value = "noPass")
    public String noPass(Information information, HttpServletRequest request, HttpServletResponse response, Model model) {
        information.setStatus("2");
        information.setAttribute4("1");
        informationService.save(information);
        return renderString(response, "1");
    }

    /**
     * Ajax 获取数据
     *
     * @version 2018-03-21
     */
    @RequiresPermissions("ecpp:information:view")
    @RequestMapping(value = "getData")
    public String getData(Information information, HttpServletRequest request, HttpServletResponse response, Model model) {
        List<Information> informationList = informationService.findList(information);
        return renderString(response, informationList);
    }


    @RequiresPermissions("ecpp:information:edit")
    @RequestMapping(value = "save")
    public String save(Information information, Model model, RedirectAttributes redirectAttributes) {
        Date time = new Date();
        information.setDelDate(time);                //删除时间
        if (information.getStatuss() != null && !"".equals(information.getStatuss())) {
            information.setStatus(information.getStatuss());                    //审核状态  保存为3提交为0
        } else {
            information.setStatus("1");                    //审核状态  保存为3提交为0
        }
        if (!beanValidator(model, information)) {
            return form(information, model);
        }
        information.setUnit(UserUtils.getUser().getOffice());
        String str = Encodes.unescapeHtml(information.getInformationcontent());
        information.setInformationcontent(str);
        information.setAttribute3("0");//初始化浏览量为0
        informationService.save(information);
        if ("0".equals(information.getStatuss())) {
            addMessage(redirectAttributes, "提交信息成功");
        } else {
            addMessage(redirectAttributes, "保存信息成功");
        }
        return "redirect:" + Global.getAdminPath() + "/ecpp/information/list?repage";
        //return "redirect:"+Global.getAdminPath()+"/ecpp/planinformation/a3List?repage";
    }

    //	@RequiresPermissions("ecpp:information:edit")
    @ResponseBody
    @RequestMapping(value = "saveFile")
    public String saveFile(Information information, Model model, RedirectAttributes redirectAttributes) {
        Date time = new Date();
        information.setDelDate(time);                //删除时间
        if (information.getStatuss() != null && !"".equals(information.getStatuss())) {
            information.setStatus(information.getStatuss());                    //审核状态  保存为3提交为0
        } else {
            information.setStatus("1");                    //审核状态  保存为3提交为0
        }
        if (!beanValidator(model, information)) {
            return form(information, model);
        }
        information.setUnit(UserUtils.getUser().getOffice());
        String str = Encodes.unescapeHtml(information.getInformationcontent());
        information.setInformationcontent(str);
        informationService.save(information);
        if ("0".equals(information.getStatuss())) {
            addMessage(redirectAttributes, "提交信息成功");
        } else {
            addMessage(redirectAttributes, "保存信息成功");
        }
        return information.getId();
    }

    @RequiresPermissions("ecpp:information:edit")
    @RequestMapping(value = "delete")
    public String delete(Information information, RedirectAttributes redirectAttributes, @RequestParam(required = false, defaultValue = "") String todo) {
        informationService.delete(information);
        addMessage(redirectAttributes, "删除信息成功");
        if (StringUtils.isBlank(todo)) {
            return "redirect:" + Global.getAdminPath() + "/ecpp/information/list2";
        }
        return "redirect:" + Global.getAdminPath() + "/ecpp/information/checkInfoList";
    }

    @RequiresPermissions("ecpp:information:edit")
    @RequestMapping(value = "deleteList3")
    public String deleteList3(Information information, RedirectAttributes redirectAttributes) {
        informationService.delete(information);
        addMessage(redirectAttributes, "删除信息成功");
        return "redirect:" + Global.getAdminPath() + "/ecpp/information/list3";
    }

    /*
     * @param id 文件上传目录，每条信息单独拥有一个id命名的文件夹
     */
    @RequestMapping(value = "fileUpload")
    public String fileUpload(MultipartHttpServletRequest request, HttpServletResponse response, String id) throws IOException {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        String ymd = sdf.format(new Date());

        String newUrl = request.getSession().getServletContext().getRealPath("/") + basePath + "/";
        newUrl += ymd + "/";

        File tempfile = new File(newUrl);
        if (!tempfile.exists()) {
            tempfile.mkdirs();
        }
        String filePath = "";
        List<MultipartFile> files = request.getFiles("file");
        for (MultipartFile file : files) {
            try {
                //获取输出流
                OutputStream os = new FileOutputStream(newUrl + file.getOriginalFilename());
                //获取输入流 CommonsMultipartFile 中可以直接得到文件的流
                InputStream is = file.getInputStream();
                byte[] bts = new byte[102400];
                //一个一个字节的读取并写入
                while (is.read(bts) != -1) {
                    os.write(bts);
                }
                os.flush();
                os.close();
                is.close();

            } catch (FileNotFoundException e) {
                e.printStackTrace();
            }
            filePath += basePath + "/" + ymd + "/" + file.getOriginalFilename() + "|";
        }
        return renderString(response, filePath);
    }

}