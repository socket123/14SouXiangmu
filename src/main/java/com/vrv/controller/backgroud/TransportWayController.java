package com.vrv.controller.backgroud;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.vrv.entity.TransportWay;
import com.vrv.service.impl.TransportWayService;
import com.vrv.utils.Pager;

@Controller
@RequestMapping(value = "admin/transportWay")
public class TransportWayController {

	@Autowired
	TransportWayService transportWayService;

	@RequestMapping(value = "gotoTransportWayList")
	public String gotoTransportWayList(ModelMap model, @RequestParam(defaultValue = "1") int pageNo,
			TransportWay transportWay) {
		Pager<TransportWay> page = transportWayService.getPage(transportWay, pageNo);
		model.put("page", page);
		model.put("transportWay", transportWay);
		return "backgroud/transportWay_list";
	}

	@RequestMapping(value = "gotoAddTransportWay")
	public ModelAndView gotoAddTransportWay() {
		return new ModelAndView("backgroud/addTransportWay");
	}

	@RequestMapping(value = "addTransportWay")
	@ResponseBody
	public Map<String, Object> addTransportWay(TransportWay transportWay) {
		Map<String, Object> map = new HashMap<>();
		map.put("message", 0);
		try {
			transportWay.setCreateTime(new Date());
			Integer i = transportWayService.insert(transportWay);
			map.put("message", i);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}

	@RequestMapping(value = "gotoEditTransportWay")
	public ModelAndView gotoEditTransportWay(TransportWay transportWay, Integer id, ModelMap map) {
		transportWay = transportWayService.findTransportWayById(id);
		map.put("transportWay", transportWay);
		return new ModelAndView("backgroud/editTransportWay", map);
	}

	@RequestMapping(value = "editTransportWay")
	@ResponseBody
	public Map<String, Object> editTransportWay(TransportWay transportWay) {
		Map<String, Object> map = new HashMap<>();
		map.put("message", 0);
		try {
			Integer i = transportWayService.update(transportWay);
			map.put("message", i);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}

	@RequestMapping(value = "deleteTransportWay")
	@ResponseBody
	public Map<String, Object> deleteTransportWay(Integer id) {
		Map<String, Object> map = new HashMap<>();
		map.put("message", 0);
		try {
			Integer i = transportWayService.deleteTransportById(id);
			map.put("message", i);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}

}
