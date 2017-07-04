package com.vrv.service.impl;

import com.vrv.entity.Evaluate;
import com.vrv.mapper.EvaluateMapper;
import com.vrv.service.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

/**
 * Created by LXX on 2017-05-03.
 */
@Service
public class EvaluateService extends BaseService<Evaluate> {

    @Autowired
    EvaluateMapper evaluateMapper;

    public List<Evaluate> findEvaluateAnalysis(String startTime,String endTime){return evaluateMapper.findEvaluateAnalysis(startTime,endTime);}

    public List<Evaluate> findEvaluateAnalysisByTeam(String startTime,String endTime,String teamId){return evaluateMapper.findEvaluateAnalysisByTeam(startTime,endTime,teamId);}


}
