package com.vrv.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.vrv.entity.TeamRelation;

public interface TeamRelationMapper extends BaseDao<TeamRelation> {

	int deleteByTeam(@Param("teamId") int teamId, @Param("type") int type);

	List<TeamRelation> selectByTeam(@Param("teamId") int teamId, @Param("type") int type);

	// 根据状态  查询
	List<TeamRelation> selectByTeam_type(TeamRelation teamRelation);

	int findTeamRelation(TeamRelation teamRelation);


	//增加
	int insertSelective(TeamRelation teamRelation);

}