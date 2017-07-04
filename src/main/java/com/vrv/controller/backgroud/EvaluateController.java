package com.vrv.controller.backgroud;

import com.vrv.entity.Evaluate;
import com.vrv.entity.TransportTeam;
import com.vrv.service.impl.EvaluateService;
import com.vrv.service.impl.TransportTeamService;
import com.vrv.utils.DateUtil;
import com.vrv.utils.Pager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

/**
 * Created by LXX on 2017-05-11.
 */
@Controller
@RequestMapping(value = "admin/evaluate")
public class EvaluateController {

    @Autowired
    EvaluateService evaluateService;

    @Autowired
    TransportTeamService transportTeamService;

    @RequestMapping(value = "evaluatelist")
    public String evaluatelist(ModelMap modelMap, Integer pageNumber, Evaluate evaluate) {
        Pager<Evaluate> page = evaluateService.getPage(evaluate, pageNumber);
        List<TransportTeam> transportTeam = transportTeamService.selectTeamAll();
        modelMap.put("page", page);
        modelMap.put("evaluate", evaluate);
        modelMap.put("transportTeam",transportTeam);
        return "backgroud/evaluateList";
    }

    @RequestMapping(value = "evaluateAnalysis")
    public String orderAnalysis(ModelMap modelMap,String startTime,String endTime,String teamId) {
        List<Evaluate> evaluate = null;
        List<TransportTeam> transportTeam = transportTeamService.selectTeamAll();
        if(null == startTime || startTime.equals("")){
            startTime = DateUtil.getNowDate("yyyy-MM-dd");
        }
        if(null == endTime || endTime.equals("")){
            endTime = DateUtil.getNowDate("yyyy-MM-dd");
        }
        try{
            if(null == teamId || teamId.equals("")){
                teamId = "0";
                evaluate = evaluateService.findEvaluateAnalysis(startTime,endTime);
            } else {
                evaluate = evaluateService.findEvaluateAnalysisByTeam(startTime,endTime,teamId);
            }
        }catch (Exception e){}
        modelMap.put("evaluate",evaluate);
        modelMap.put("startTime",startTime);
        modelMap.put("endTime",endTime);
        modelMap.put("teamId",teamId);
        modelMap.put("transportTeam",transportTeam);
        return "backgroud/evaluateAnalysis";
    }
}
