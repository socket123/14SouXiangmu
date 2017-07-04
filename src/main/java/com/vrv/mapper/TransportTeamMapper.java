package com.vrv.mapper;

import java.util.List;
import java.util.Map;

import com.vrv.entity.TransportTeam;
import org.apache.ibatis.annotations.Param;

public interface TransportTeamMapper extends BaseDao<TransportTeam> {
    public TransportTeam selectTeamByUserId(Integer userId);

    List<TransportTeam> findTeamNameList(Integer id);

    List<TransportTeam> findJobNumById(Integer id);

    List<TransportTeam> selectTeamAll();

    List<TransportTeam> findTeamAnalysis(@Param("startTime") String startTime,@Param("endTime") String endTime);

    List<TransportTeam> findTeamUserAnalysis(TransportTeam team);

    List<TransportTeam> findTeamTrunkAnalysis(@Param("startTime") String startTime,@Param("endTime") String endTime);

    List<TransportTeam> findTeamUserTrunkAnalysis(TransportTeam team);


    // 查询 民工 数据
    List<TransportTeam> getList_workers(Map<String,Object> maps);
    // 查询 团队 数据
    List<TransportTeam> getList_TuanDui(Map<String,Object> maps);
    // 查询 团队负责人 数据
    List<TransportTeam> getList_userGongzuoLiang(Map<String,Object> maps);




}