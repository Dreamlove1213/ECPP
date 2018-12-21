package com.thinkgem.jeesite.common.utils;

import com.thinkgem.jeesite.modules.ecpp.service.PlaninformationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

@Service
@Lazy(false)
public class timerTask {
    @Autowired
    PlaninformationService planinformationService;

    /**
     *  统计数据自动更新
     *  定时器自动完成
     *  每天凌晨03：01：01
     */
    @Scheduled(cron = "01 01 03 * * *")//秒 分 时 日 月 年
    public void show() {
        planinformationService.autoRunUpdateData();
    }
}
