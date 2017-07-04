package com.vrv.service.impl;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.vrv.entity.SSUser;
import com.vrv.entity.TransportTeam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vrv.entity.TeamRelation;
import com.vrv.mapper.TeamRelationMapper;
import com.vrv.service.BaseService;

@Service
public class TeamRelationService extends BaseService<TeamRelation> {

	@Autowired
	TransportTeamService teamService;



	@Autowired
	TeamRelationMapper teamRelationMapper;

	public int deleteByTeam(int teamId, int type) {
		return teamRelationMapper.deleteByTeam(teamId, type);
	}

	public List<TeamRelation> selectByTeam(int teamId, int type) {
		return teamRelationMapper.selectByTeam(teamId, type);
	}

	public int findTeamRelation(TeamRelation teamRelation) {
		return teamRelationMapper.findTeamRelation(teamRelation);
	}


	// 根据状态  查询
	public  List<TeamRelation> selectByTeam_type(TeamRelation teamRelation){

		return  teamRelationMapper.selectByTeam_type(teamRelation);
	}



	//增加
	public  int insertSelective(TeamRelation teamRelation){

		return teamRelationMapper.insertSelective(teamRelation);
	}


	// 查询
	public    List<TeamRelation> teamRelationList(SSUser user){
		List<TeamRelation> teamRelationList = new ArrayList<TeamRelation>();
		if(null != user.getId()) {
			TransportTeam transportTeam = teamService.selectTeamByUserId(user.getId());

			if(null != transportTeam){
				TeamRelation teamRelation = new TeamRelation();
				teamRelation.setTeamId(transportTeam.getId());
				teamRelationList = selectByTeam_type(teamRelation);//1范围，2资源，3负责人、4承运小队

			}

		}
		return  teamRelationList;
	}


	// 保存 民工 id
	public Map<String,String>  worker_list_save(SSUser user ){
		Map<String,String> maps = new HashMap<String,String>();
		List<TeamRelation> teamRelationList = teamRelationList(user);
		if(null != teamRelationList && teamRelationList.size() > 0){
			String stes = "";
			for (TeamRelation teamRelation : teamRelationList){
					stes += teamRelation.getOtherId()+",";
				}
				Integer is = teamRelationList.size()+1;
			float count = (float)1/is;
			DecimalFormat df = new DecimalFormat("0.00");//格式化小数，不足的补0
			String filesize = df.format(count);//返回的是String类型的
			maps.put("id",","+stes);
			maps.put("count",filesize);
			return maps;
		}
		maps.put("id",null);
		maps.put("count",null);
		return maps;

	}

}
