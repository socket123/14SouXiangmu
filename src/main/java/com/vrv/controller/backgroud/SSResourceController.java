package com.vrv.controller.backgroud;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
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
import com.vrv.entity.SSResource;
import com.vrv.service.impl.SSCatagoryService;
import com.vrv.service.impl.SSResourceService;
import com.vrv.service.log.MyLog;
import com.vrv.utils.Pager;

@Controller
@RequestMapping(value = "admin/resou")
public class SSResourceController {

	@Autowired
	SSResourceService ssResourceService;

	@Autowired
	SSCatagoryService ssCatagoryService;

	@RequestMapping(value = "gotoResourceList")
	public String gotoResourceList(ModelMap modelMap, Integer pageNumber, SSResource ssResource) {
		Pager<SSResource> page = ssResourceService.getPage(ssResource, pageNumber);
		modelMap.put("page", page);
		modelMap.put("ssResource", ssResource);
		return "backgroud/resourceList";
	}

	@RequestMapping(value = "gotoAdd")
	public ModelAndView gotoAdd(HttpServletRequest request, SSCatagory ssCatagory, ModelMap modelMap) {
		Integer type = 1;
		List<SSCatagory> list = ssCatagoryService.findCatagoryList(type);
		modelMap.put("list", list);
		return new ModelAndView("backgroud/addResource", modelMap);
	}

	@MyLog(module = "resource", type = "add", content = "新增资源")
	@RequestMapping(value = "addResource", produces = MyConfig.PRODUCES)
	@ResponseBody
	public Map<String, Object> addResource(SSResource ssResource) {
		Map<String, Object> map = new HashMap<>();
		ssResource.setCreateTime(new Date());
		Integer i = ssResourceService.insert(ssResource);
		map.put("message", i);
		return map;
	}

	@RequestMapping(value = "gotoEdit")
	public ModelAndView gotoEdit(ModelMap map, Integer id) {
		SSResource ssResource = ssResourceService.get(id);
		Integer type = 1;
		List<SSCatagory> list = ssCatagoryService.findCatagoryList(type);
		map.put("list", list);
		map.put("ssResource", ssResource);
		return new ModelAndView("backgroud/editResource", map);
	}

	@MyLog(module = "resource", type = "edit", content = "编辑资源")
	@RequestMapping(value = "editResource", produces = MyConfig.PRODUCES)
	@ResponseBody
	public Map<String, Object> editResource(SSResource ssResource) {
		Map<String, Object> map = new HashMap<>();
		Integer i = ssResourceService.saveOrUpdate(ssResource, ssResource.getId());
		map.put("message", i);
		return map;
	}

	@MyLog(module = "resource", type = "delete", content = "删除资源")
	@RequestMapping(value = "deleteResource", produces = MyConfig.PRODUCES)
	@ResponseBody
	public Map<String, Object> deleteResource(Integer id) {
		Map<String, Object> map = new HashMap<>();
		Integer i = ssResourceService.delete(id);
		map.put("message", i);
		return map;
	}

	@RequestMapping(value = "findCatagoryList")
	@ResponseBody
	public List<Map<String, Object>> findCatagoryList(SSCatagory ssCatagory, ModelMap modelMap) {
		List<Map<String, Object>> mapList = new ArrayList<Map<String, Object>>();
		Integer type = 1;
		List<SSCatagory> sslist = ssCatagoryService.findCatagoryList(type);
		Map<String, Object> mapObj = null;
		for (SSCatagory ss : sslist) {
			mapObj = new HashMap<String, Object>();
			List<SSResource> list = ssResourceService.findResourceList(ss.getId());
			mapObj.put(ss.getCatName(), list);
			mapObj.put(ss.getCatName() + "_id", ss.getId());
			mapList.add(mapObj);
		}
		return mapList;
	}

}
