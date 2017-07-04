package com.vrv.service.impl;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.vrv.entity.AreaCode;
import com.vrv.entity.TeamRelation;
import com.vrv.entity.TransportTeam;
import com.vrv.mapper.TransportTeamMapper;
import com.vrv.service.BaseService;

@Service
public class TransportTeamService extends BaseService<TransportTeam> {
	@Autowired
	TransportTeamMapper transportTeamMapper;

	@Autowired
	TeamRelationService teamRelationService;

	// 查询 团队 数据
	public List<TransportTeam> getList_TuanDui(Map<String,Object> maps){
		return transportTeamMapper.getList_TuanDui(maps);
	}
	// 查询 团队负责人 数据
	public List<TransportTeam> getList_userGongzuoLiang(Map<String,Object> maps){
		return transportTeamMapper.getList_userGongzuoLiang(maps);
	}

	// 查询 民工 数据
	public List<TransportTeam> getList_workers(Map<String,Object> maps){
		return transportTeamMapper.getList_workers(maps);
	}



	// 民工数据 计算
	public  List<TransportTeam> transpostTeams_select(String startTime,String endTime){
		// 获取 获取民工工作量
		Map<String,Object> maps= new HashMap<String,Object>();
		maps.put("is_big","1");
		maps.put("startTime",startTime);
		maps.put("endTime",endTime);
		List<TransportTeam> transpostTeams_xiao  = getList_workers(maps);// 小件
		Map<String,Object> maps_zhong= new HashMap<String,Object>();
		maps_zhong.put("is_big","2");
		maps_zhong.put("startTime",startTime);
		maps_zhong.put("endTime",endTime);
		List<TransportTeam> transpostTeams_zhong  = getList_workers(maps_zhong);// 中件
		Map<String,Object> maps_big= new HashMap<String,Object>();
		maps_big.put("is_big","3");
		maps_big.put("startTime",startTime);
		maps_big.put("endTime",endTime);
		List<TransportTeam> transpostTeams_big  = getList_workers(maps_big);// 大件

		List<TransportTeam> transpostTeams = transportTeamsList_object(transpostTeams_xiao,transpostTeams_zhong,transpostTeams_big);

		return  transpostTeams;
	}




	// 民工 团队 计算
	public  List<TransportTeam> getList_TuanDui_list(String startTime,String endTime){

		// 获取 获取民工工作量
		Map<String,Object> maps= new HashMap<String,Object>();
		maps.put("is_big","1");
		maps.put("startTime",startTime);
		maps.put("endTime",endTime);
		List<TransportTeam> transpostTeams_xiao  = getList_TuanDui(maps);// 小件
		Map<String,Object> maps_zhong= new HashMap<String,Object>();
		maps_zhong.put("is_big","2");
		maps_zhong.put("startTime",startTime);
		maps_zhong.put("endTime",endTime);
		List<TransportTeam> transpostTeams_zhong  = getList_TuanDui(maps_zhong);// 中件
		Map<String,Object> maps_big= new HashMap<String,Object>();
		maps_big.put("is_big","3");
		maps_big.put("startTime",startTime);
		maps_big.put("endTime",endTime);
		List<TransportTeam> transpostTeams_big  = getList_TuanDui(maps_big);// 大件

		List<TransportTeam> transpostTeams = transportTeamsList_object_tuandui(transpostTeams_xiao,transpostTeams_zhong,transpostTeams_big);

		return  transpostTeams;
	}

	// 民工 团队 负责人 计算
	public  List<TransportTeam> getList_userGongzuoLiang_list(String startTime,String endTime){
		// 获取 获取民工工作量
		Map<String,Object> maps= new HashMap<String,Object>();
		maps.put("is_big","1");
		maps.put("startTime",startTime);
		maps.put("endTime",endTime);
		List<TransportTeam> transpostTeams_xiao  = getList_userGongzuoLiang(maps);// 小件
		Map<String,Object> maps_zhong= new HashMap<String,Object>();
		maps_zhong.put("is_big","2");
		maps_zhong.put("startTime",startTime);
		maps_zhong.put("endTime",endTime);
		List<TransportTeam> transpostTeams_zhong  = getList_userGongzuoLiang(maps_zhong);// 中件
		Map<String,Object> maps_big= new HashMap<String,Object>();
		maps_big.put("is_big","3");
		maps_big.put("startTime",startTime);
		maps_big.put("endTime",endTime);
		List<TransportTeam> transpostTeams_big  = getList_userGongzuoLiang(maps_big);// 大件

		List<TransportTeam> transpostTeams = transportTeamsList_object(transpostTeams_xiao,transpostTeams_zhong,transpostTeams_big);

		return  transpostTeams;

	}

	// 获取 多个 list 里的值 团队
	public  List<TransportTeam> transportTeamsList_object_tuandui(List<TransportTeam> transpostTeams_xiao,
														  List<TransportTeam> transpostTeams_zhong,
														  List<TransportTeam> transpostTeams_big){
		List<TransportTeam> transpostTeams = new ArrayList<TransportTeam>();
		if(null != transpostTeams_xiao && transpostTeams_xiao.size() > 0){
			for(TransportTeam transportTeam_xiao : transpostTeams_xiao){
				Double xiao = 0.00;
				TransportTeam transportTeam = new TransportTeam();
				xiao += Double.parseDouble(transportTeam_xiao.getCounts());
				transportTeam = transportTeam_xiao;
				transportTeam.setIs_big_xiao(xiao+"");
				transpostTeams.add(transportTeam);
			}
			for(int i = 0 ; i < transpostTeams_zhong.size() ; i ++){
				Double zhong = 0.00;
				zhong += Double.parseDouble(transpostTeams_zhong.get(i).getCounts());
				System.out.println("中件");
				transpostTeams.get(i).setIs_big_zhong(zhong+"");
			}
			for(int j = 0 ; j < transpostTeams_big.size() ; j ++){
				Double big = 0.00;
				big += Double.parseDouble(transpostTeams_big.get(j).getCounts());
				transpostTeams.get(j).setIs_big_big(big + "");
			}
		}
		return  transpostTeams;
	}



	// 获取 多个 list 里的值
	public  List<TransportTeam> transportTeamsList_object(List<TransportTeam> transpostTeams_xiao,
														  List<TransportTeam> transpostTeams_zhong,
														  List<TransportTeam> transpostTeams_big){
		List<TransportTeam> transpostTeams = new ArrayList<TransportTeam>();
		if(null != transpostTeams_xiao && transpostTeams_xiao.size() > 0){
			for(TransportTeam transportTeam_xiao : transpostTeams_xiao){
				Double xiao = 0.00;
				TransportTeam transportTeam = new TransportTeam();
				xiao += Double.parseDouble(transportTeam_xiao.getTrunk_worker_count());
				xiao += Double.parseDouble(transportTeam_xiao.getBranchrecip_worker_count());
				xiao += Double.parseDouble(transportTeam_xiao.getBranchsend_worker_count());
				transportTeam = transportTeam_xiao;
				transportTeam.setIs_big_xiao(xiao+"");
				transpostTeams.add(transportTeam);
			}
			for(int i = 0 ; i < transpostTeams_zhong.size() ; i ++){
				Double zhong = 0.00;
				zhong += Double.parseDouble(transpostTeams_zhong.get(i).getTrunk_worker_count());
				zhong += Double.parseDouble(transpostTeams_zhong.get(i).getBranchrecip_worker_count());
				zhong += Double.parseDouble(transpostTeams_zhong.get(i).getBranchsend_worker_count());
				System.out.println("中件");
				transpostTeams.get(i).setIs_big_zhong(zhong+"");
			}
			for(int j = 0 ; j < transpostTeams_big.size() ; j ++){
				Double big = 0.00;
				big += Double.parseDouble(transpostTeams_big.get(j).getTrunk_worker_count());
				big += Double.parseDouble(transpostTeams_big.get(j).getBranchrecip_worker_count());
				big += Double.parseDouble(transpostTeams_big.get(j).getBranchsend_worker_count());
				transpostTeams.get(j).setIs_big_big(big + "");
			}
		}
		return transpostTeams;
	}

	public TransportTeam selectTeamByUserId(Integer userId) {
		return transportTeamMapper.selectTeamByUserId(userId);
	}

	public List<TransportTeam> findTeamNameList(Integer id) {
		return transportTeamMapper.findTeamNameList(id);
	}

	public List<TransportTeam> findJobNumById(Integer id) {
		return transportTeamMapper.findJobNumById(id);
	}

	public List<TransportTeam> selectTeamAll(){return transportTeamMapper.selectTeamAll();}

	@Transactional
	public int delete(Integer id) {
		teamRelationService.deleteByTeam(id, 1);
		teamRelationService.deleteByTeam(id, 2);
		return super.delete(id);
	}

	@Transactional
	public int update(TransportTeam obj) {
		int count = super.update(obj);
		teamRelationService.deleteByTeam(obj.getId(), 1);
		teamRelationService.deleteByTeam(obj.getId(), 2);
		teamRelationService.deleteByTeam(obj.getId(), 3);
		setRelation(obj);
		return count;
	}

	/**
	 * Description: <br>
	 * 添加团队
	 * 
	 * @param team
	 * @return <br>
	 */
	@Transactional
	public int addTeam(TransportTeam team) {
		team.setCreateTime(new Date());
		int count = super.insert(team);
		setRelation(team);
		return count;
	}

	public void setRelation(TransportTeam team) {
		for (int i = 0; null != team.getAreaCode() && i < team.getAreaCode().length; i++) {
			TeamRelation relation = new TeamRelation();
			relation.setTeamId(team.getId());
			relation.setOtherId(Integer.valueOf(team.getAreaCode()[i]));
			relation.setType(1);
			relation.setSsOrder(team.getSsOrder()[i]);
			teamRelationService.insert(relation);
		}
		for (int i = 0; null != team.getResourceid() && i < team.getResourceid().length; i++) {
			TeamRelation relation = new TeamRelation();
			relation.setTeamId(team.getId());
			relation.setOtherId(Integer.valueOf(team.getResourceid()[i]));
			relation.setType(2);
			teamRelationService.insert(relation);
		}
		for (int i = 0; null != team.getUid() && i < team.getUid().length; i++) {
			TeamRelation relation = new TeamRelation();
			relation.setTeamId(team.getId());
			relation.setOtherId(Integer.valueOf(team.getUid()[i]));
			relation.setType(3);
			teamRelationService.insert(relation);
		}
	}

	public List<AreaCode> getAreaByTeam(Integer teamId) {
		List<AreaCode> list = null;
		return list;
	}

	public List<TransportTeam> findTeamAnalysis(String startTime,String endTime){return transportTeamMapper.findTeamAnalysis(startTime,endTime);}

	public List<TransportTeam> findTeamUserAnalysis(TransportTeam team){return transportTeamMapper.findTeamUserAnalysis(team);}

	public List<TransportTeam> findTeamTrunkAnalysis(String startTime,String endTime){return transportTeamMapper.findTeamTrunkAnalysis(startTime,endTime);}

	public List<TransportTeam> findTeamUserTrunkAnalysis(TransportTeam team){return transportTeamMapper.findTeamUserTrunkAnalysis(team);}



}
