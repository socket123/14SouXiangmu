package com.vrv.controller.backgroud;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.vrv.entity.*;
import com.vrv.utils.DateUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.vrv.contans.MyConfig;
import com.vrv.service.impl.AreaCodeService;
import com.vrv.service.impl.SSCatagoryService;
import com.vrv.service.impl.SSResourceService;
import com.vrv.service.impl.TeamRelationService;
import com.vrv.service.impl.TransportTeamService;
import com.vrv.service.impl.UserService;
import com.vrv.utils.Pager;

@Controller
@RequestMapping(value = "admin/transTeam")
public class TransportTeamController {

	@Autowired
	TransportTeamService transpostTeamService;

	@Autowired
	SSCatagoryService cateService;

	@Autowired
	UserService userService;

	@Autowired
	SSResourceService ssResourceService;

	@Autowired
	AreaCodeService areaService;

	@Autowired
	TeamRelationService teamRelationService;

	@RequestMapping(value = "gotoTransportTeamList")
	public String gotoTransportTeamList(ModelMap modelMap, Integer pageNumber, TransportTeam transportTeam) {
		Pager<TransportTeam> page = transpostTeamService.getPage(transportTeam, pageNumber);
		modelMap.put("page", page);
		modelMap.put("transportTeam", transportTeam);
		return "backgroud/transportTeamList";
	}

	@RequestMapping(value = "gotoAddTransportTeam")
	public ModelAndView gotoAddTransportTeam(ModelMap modelMap, Integer id) {
		List<SSCatagory> list = cateService.findTeamList(2);
		// List<SSUser> userList = userService.findUserList();
		List<SSUser> jobNumlist = userService.findJobNumById(id);
		TransportTeam team = new TransportTeam();
		List<AreaCode> areaList = null;
		List<SSResource> resList = null;
		if (null != id) {
			team = transpostTeamService.get(id);
			areaList = areaService.selectAreaByTeamId(id);
			resList = ssResourceService.getListByTeamId(id);
		}
		modelMap.put("obj", team);
		modelMap.put("areaList", areaList);
		modelMap.put("resList", resList);
		modelMap.put("list", list);
		modelMap.put("jobNumlist", jobNumlist);
		return new ModelAndView("backgroud/addTransportTeam", modelMap);
	}

	@RequestMapping(value = "findAreaList")
	public String findAreaList(ModelMap model, @RequestParam(defaultValue = "1") int pageNo, AreaCode area) {
		area.setIsEnable(1);
		Pager<AreaCode> page = areaService.getPage(area, pageNo, 3000);
		model.put("page", page);
		model.put("area", area);
		return "backgroud/arealist";
	}

	@RequestMapping(value = "gotoResourceList")
	public String gotoResourceList(ModelMap modelMap, Integer pageNumber, SSResource ssResou) {
		Pager<SSResource> page = ssResourceService.getPage(ssResou, pageNumber);
		modelMap.put("page", page);
		return "backgroud/resource_list";
	}

	@RequestMapping(value = "findTeamList")
	@ResponseBody
	public List<Map<String, Object>> findTeamList(SSCatagory ssCatagory, ModelMap modelMap) {
		List<Map<String, Object>> mapList = new ArrayList<Map<String, Object>>();
		Integer type = 2;
		List<SSCatagory> sslist = cateService.findTeamList(type);
		Map<String, Object> mapObj = null;
		for (SSCatagory ss : sslist) {
			mapObj = new HashMap<String, Object>();
			List<TransportTeam> list = transpostTeamService.findTeamNameList(ss.getId());
			mapObj.put(ss.getCatName(), list);
			mapObj.put(ss.getCatName() + "_id", ss.getId());
			mapList.add(mapObj);
		}
		return mapList;
	}

	@RequestMapping(value = "editTeam", produces = MyConfig.PRODUCES)
	@ResponseBody
	public Map<String, Object> editTeam(TransportTeam team) {
		int count = 0;
		if (null == team.getId()) {
			count = transpostTeamService.addTeam(team);
		} else {
			count = transpostTeamService.update(team);
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("message", count);
		return map;
	}

	@RequestMapping(value = "deleteTeam", produces = MyConfig.PRODUCES)
	@ResponseBody
	public Map<String, Object> deleteTeam(Integer id) {
		int count = transpostTeamService.delete(id);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("message", count);
		return map;
	}

	@RequestMapping(value = "findTeamRelation")
	@ResponseBody
	public Map<String, Object> findTeamRelation(HttpServletRequest request, TeamRelation teamRelation) {
		Integer otherId = Integer.valueOf(request.getParameter("other_id"));
		if (request.getParameter("team_id") != null && !"".equals(request.getParameter("team_id"))) {
			Integer teamId = Integer.valueOf(request.getParameter("team_id"));
			teamRelation.setId(teamId);
		}
		teamRelation.setOtherId(otherId);
		int count = teamRelationService.findTeamRelation(teamRelation);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("message", count);
		return map;
	}

	/**
	 *  统计
	 * @param modelMap
	 * @param startTime
	 * @param endTime
	 * @param searchFlag
	 * @return
	 */
	@RequestMapping(value = "transTeamAnalysis")
	public String orderAnalysis(ModelMap modelMap,String startTime,String endTime,Integer searchFlag,Integer pageNumber) {
		List<TransportTeam> transpostTeam = new ArrayList<TransportTeam>();
		Map<Integer, Object> transpostTeamUser = new HashMap<Integer, Object>();
		if(null == startTime || startTime.equals("")){
			startTime = DateUtil.getNowDate("yyyy-MM-dd");
		}
		if(null == endTime || endTime.equals("")){
			endTime = DateUtil.getNowDate("yyyy-MM-dd");
		}
		if(null == searchFlag || searchFlag.equals("")){
			searchFlag=0;
		}

//			if(searchFlag == 0){//配送人员
//				transpostTeam = transpostTeamService.findTeamAnalysis(startTime,endTime);
//			} else if(searchFlag == 1){//中转人员
//				transpostTeam = transpostTeamService.findTeamTrunkAnalysis(startTime,endTime);
//			}
//			if(null != transpostTeam){
//				TransportTeam tt = new TransportTeam();
//				tt.setStartTime(startTime);
//				tt.setEndTime(endTime);
//				for(int i = 0;i<transpostTeam.size();i++){
//					int tid = transpostTeam.get(i).getId();
//					tt.setId(tid);
//					List<TransportTeam> transpostTeamU =  new ArrayList<TransportTeam>();
//					if(searchFlag == 0){//配送人员
//						transpostTeamU = transpostTeamService.findTeamUserAnalysis(tt);
//					} else if(searchFlag == 1){//中转人员
//						transpostTeamU = transpostTeamService.findTeamUserTrunkAnalysis(tt);
//					}
//					transpostTeamUser.put(tid,transpostTeamU);
//				}
//			}

		// 获取 获取民工工作量
		if(searchFlag == 2){
			List<TransportTeam>	transpostTeams = transpostTeamService.transpostTeams_select(startTime,endTime);
			Pager<TransportTeam> page = new Pager<TransportTeam>(transpostTeams.size(),pageNumber) ;//总记录数 当前页
			page.setList(transpostTeams);
			modelMap.put("page",page);
		}else if(searchFlag == 0){
			// 获取 获取团队工作量
			List<TransportTeam>	transpostTeams = transpostTeamService.getList_TuanDui_list(startTime,endTime);
			Pager<TransportTeam> page = new Pager<TransportTeam>(transpostTeams.size(),pageNumber) ;//总记录数 当前页
			page.setList(transpostTeams);
			modelMap.put("page",page);
		}else if(searchFlag == 1){
			// 获取 团队负责人工作量
			List<TransportTeam>	transpostTeams = transpostTeamService.getList_userGongzuoLiang_list(startTime,endTime);
			Pager<TransportTeam> page = new Pager<TransportTeam>(transpostTeams.size(),pageNumber) ;//总记录数 当前页
			page.setList(transpostTeams);
			modelMap.put("page",page);
		}


		modelMap.put("transpostTeam",transpostTeam);
		modelMap.put("transpostTeamUser",transpostTeamUser);
		modelMap.put("startTime",startTime);
		modelMap.put("endTime",endTime);
		modelMap.put("searchFlag",searchFlag);
		return "backgroud/transTeamAnalysis";
	}
}
