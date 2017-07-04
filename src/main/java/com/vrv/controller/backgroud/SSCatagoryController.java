package com.vrv.controller.backgroud;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.vrv.contans.MyConfig;
import com.vrv.entity.SSCatagory;
import com.vrv.service.impl.SSCatagoryService;
import com.vrv.service.log.MyLog;
import com.vrv.utils.Pager;

@Controller
@RequestMapping(value = "admin/resource")
public class SSCatagoryController {

	@Autowired
	SSCatagoryService ssResourceService;

	@RequestMapping(value = "")
	public String findOrderList(ModelMap modelMap, Integer pageNumber, SSCatagory ssResource) {
		ssResource.setType(1);
		Pager<SSCatagory> page = ssResourceService.getPage(ssResource, pageNumber);
		modelMap.put("page", page);
		modelMap.put("ssResource", ssResource);
		return "backgroud/resourceType";
	}

	@RequestMapping(value = "gotoTeamType")
	public String gotoTeamType(ModelMap modelMap, Integer pageNumber, SSCatagory ssResource) {
		ssResource.setType(2);
		Pager<SSCatagory> page = ssResourceService.getPage(ssResource, pageNumber);
		modelMap.put("page", page);
		modelMap.put("ssResource", ssResource);
		return "backgroud/teamType";
	}

	@RequestMapping(value = "gotoAdd")
	public ModelAndView gotoAdd(HttpServletRequest request) {
		return new ModelAndView("backgroud/addCatagory");
	}

	@RequestMapping(value = "gotoTeamAdd")
	public ModelAndView gotoTeamAdd(HttpServletRequest request) {
		return new ModelAndView("backgroud/addTeamType");
	}

	@MyLog(module = "catagory", type = "add", content = "新增资源类别")
	@RequestMapping(value = "addResourceType", produces = MyConfig.PRODUCES)
	@ResponseBody
	public Map<String, Object> addResourceType(SSCatagory record) {
		Map<String, Object> map = new HashMap<>();
		record.setCreateTime(new Date());
		record.setType(1);
		Integer i = ssResourceService.insert(record);
		map.put("message", i);
		return map;
	}

	@MyLog(module = "catagory", type = "add", content = "新增团队类别")
	@RequestMapping(value = "addTeamType", produces = MyConfig.PRODUCES)
	@ResponseBody
	public Map<String, Object> addTeamType(SSCatagory record) {
		Map<String, Object> map = new HashMap<>();
		record.setCreateTime(new Date());
		record.setType(2);
		Integer i = ssResourceService.insert(record);
		map.put("message", i);
		return map;
	}

	@RequestMapping(value = "gotoEdit")
	public ModelAndView gotoEdit(ModelMap map, Integer id) {
		SSCatagory ssResource = ssResourceService.get(id);
		map.put("ssResource", ssResource);
		return new ModelAndView("backgroud/editCatagory", map);
	}

	@RequestMapping(value = "gotoEditTeam")
	public ModelAndView gotoEditTeam(ModelMap map, Integer id) {
		SSCatagory ssResource = ssResourceService.get(id);
		map.put("ssResource", ssResource);
		return new ModelAndView("backgroud/editTeamType", map);
	}

	@MyLog(module = "catagory", type = "edit", content = "编辑资源类别")
	@RequestMapping(value = "editResourceType", produces = MyConfig.PRODUCES)
	@ResponseBody
	public Map<String, Object> editResourceType(SSCatagory record) {
		Map<String, Object> map = new HashMap<>();
		Integer i = ssResourceService.saveOrUpdate(record, record.getId());
		map.put("message", i);
		return map;
	}

	@MyLog(module = "catagory", type = "edit", content = "编辑团队类别")
	@RequestMapping(value = "editTeamType", produces = MyConfig.PRODUCES)
	@ResponseBody
	public Map<String, Object> editTeamType(SSCatagory record) {
		Map<String, Object> map = new HashMap<>();
		Integer i = ssResourceService.saveOrUpdate(record, record.getId());
		map.put("message", i);
		return map;
	}

	@MyLog(module = "catagory", type = "delete", content = "删除资源分类")
	@RequestMapping(value = "deleteResourceType", produces = MyConfig.PRODUCES)
	@ResponseBody
	public Map<String, Object> deleteResourceType(Integer id) {
		Map<String, Object> map = new HashMap<>();
		Integer i = ssResourceService.delete(id);
		map.put("message", i);
		return map;
	}

	@MyLog(module = "catagory", type = "delete", content = "删除团队分类")
	@RequestMapping(value = "deleteTeamType", produces = MyConfig.PRODUCES)
	@ResponseBody
	public Map<String, Object> deleteTeamType(Integer id) {
		Map<String, Object> map = new HashMap<>();
		Integer i = ssResourceService.delete(id);
		map.put("message", i);
		return map;
	}

}
