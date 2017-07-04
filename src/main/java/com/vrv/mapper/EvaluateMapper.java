package com.vrv.mapper;

import com.vrv.entity.Evaluate;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface EvaluateMapper extends BaseDao<Evaluate> {
    int deleteByPrimaryKey(Integer id);

    int insert(Evaluate record);

    int insertSelective(Evaluate record);

    Evaluate selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Evaluate record);

    int updateByPrimaryKey(Evaluate record);

    List<Evaluate> findEvaluateAnalysis(@Param("startTime") String startTime, @Param("endTime") String endTime);

    List<Evaluate> findEvaluateAnalysisByTeam(@Param("startTime") String startTime, @Param("endTime") String endTime, @Param("teamId") String teamId);

}