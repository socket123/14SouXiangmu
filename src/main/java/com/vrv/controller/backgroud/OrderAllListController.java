package com.vrv.controller.backgroud;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.vrv.controller.font.SendMsgController;
import com.vrv.utils.DateUtil;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.vrv.contans.MyConfig;
import com.vrv.entity.Order;
import com.vrv.entity.QRJson;
import com.vrv.entity.SysConfig;
import com.vrv.mapper.OrderMapper;
import com.vrv.service.impl.OrderServiceImpl;
import com.vrv.service.impl.SystemConfigServiceImpl;
import com.vrv.service.log.MyLog;
import com.vrv.utils.Pager;

@Controller
@RequestMapping("admin/orderAll")
public class OrderAllListController {

	@Autowired
	OrderServiceImpl orderServiceImpl;

	@Autowired
	OrderMapper orderMapper;

	@Autowired
	SystemConfigServiceImpl sysConfigService;

	@Autowired
	SendMsgController sendMsgController;

	@RequestMapping(value = "")
	public String findOrderList(ModelMap modelMap, Integer pageNumber, Order order) {
		Pager<Order> page = orderServiceImpl.getPage(order, pageNumber);
		List<Order> list = page.getList();
		SysConfig sysConfig = sysConfigService.findSystemConfig();
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		for (Order od : list) {
			try {
				// 接单
				if (od.getStatus() == 1) {
					Date d1 = df.parse(df.format(new Date()));
					Date d2 = df.parse(od.getCreate_time());
					long diff = d1.getTime() - d2.getTime();
					long min = diff / (1000 * 60);
					if (sysConfig.getDeliveryTimeout() > min) {
						od.setUnusual(0);
					} else {
						od.setUnusual(1);
					}
				} else if (od.getStatus() == 2) {
					Date d1 = df.parse(df.format(new Date()));
					Date d2 = df.parse(od.getCreate_time());
					long diff = d1.getTime() - d2.getTime();
					long min = diff / (1000 * 60);
					if (sysConfig.getReceivTimeout() > min) {
						od.setUnusual(0);
					} else {
						od.setUnusual(1);
					}
				}
			} catch (Exception e) {
			}
		}
		page.setList(list);
		modelMap.put("page", page);
		modelMap.put("order", order);
		return "backgroud/orderList";
	}

	@MyLog(module = "order", type = "edit", content = "更新订单状态")
	@RequestMapping(value = "updateStatusById", produces = MyConfig.PRODUCES)
	@ResponseBody
	public Map<String, Object> updateStatusById(HttpServletRequest request, Order order) {
		Map<String, Object> map = new HashMap<>();
		map.put("message", 0);
		try {
			Integer i = orderMapper.updateOrderStatusById(order);
			map.put("message", i);
			order = orderServiceImpl.get(order.getId());
			if(order.getStatus().equals(4)){//取消订单
				sendMsgController.sendMsgtoTeam(request, order, 1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}

	@MyLog(module = "order", type = "edit", content = "更新订单状态")
	@RequestMapping(value = "updateOrderStatusById", produces = MyConfig.PRODUCES)
	@ResponseBody
	public Map<String, Object> updateOrderStatusById(Order order) {
		Map<String, Object> map = new HashMap<>();
		map.put("message", 0);
		try {
			Integer i = orderMapper.updateOrderStatusById(order);
			map.put("message", i);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}

	@MyLog(module = "order", type = "delete", content = "删除订单")
	@RequestMapping(value = "deleteOrderById", produces = MyConfig.PRODUCES)
	@ResponseBody
	public Map<String, Object> deleteOrderById(Integer id) {
		Map<String, Object> map = new HashMap<>();
		map.put("message", 0);
		try {
			Integer i = orderServiceImpl.delete(id);
			map.put("message", i);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}

	@MyLog(module = "order", type = "edit", content = "更新订单状态")
	@RequestMapping(value = "updateOrderStatusByNum", produces = MyConfig.PRODUCES)
	@ResponseBody
	public Map<String, Object> updateOrderStatusByNum(Order order) {
		Map<String, Object> map = new HashMap<>();
		map.put("message", 0);
		try {
			if ("".equals(order.getWaybill_number())) {
				if (!"".equals(order.getRemark())) {
					Gson gson = new Gson();
					QRJson qrStr = gson.fromJson(order.getRemark(), QRJson.class);
					order.setWaybill_number(qrStr.getSerialNo());
					Integer i = orderMapper.updateOrderByNum(order);
					map.put("message", i);
				}
			} else {
				Integer i = orderMapper.updateOrderByNum(order);
				map.put("message", i);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}

	@RequestMapping(value = "findOrderDetailById", produces = MyConfig.PRODUCES)
	@ResponseBody
	public ModelAndView findOrderDetailById(HttpServletRequest request, Order order) {
		Map<String, Object> map = new HashMap<>();
		try {
			Integer id = Integer.valueOf(request.getParameter("id"));
			order = orderMapper.findOrderDetailById(id);
			map.put("order", order);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView("backgroud/orderDetail", map);
	}

	@MyLog(module = "order", type = "export", content = "导出订单")
	@RequestMapping(value = "exportOrderExcel")
	public String exportOrderExcel(HttpServletRequest request, HttpServletResponse response) {
		// 第一步，创建一个webbook，对应一个Excel文件
		HSSFWorkbook wb = new HSSFWorkbook();
		// 第二步，在webbook中添加一个sheet,对应Excel文件中的sheet
		HSSFSheet sheet = wb.createSheet();
		// 第三步，在sheet中添加表头第0行,注意老版本poi对Excel的行数列数有限制short
		HSSFRow row = sheet.createRow((int) 0);
		// 第四步，创建单元格，并设置值表头 设置表头居中
		HSSFCellStyle style = wb.createCellStyle();
		style.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 创建一个居中格式
		try {
			HSSFCell cell = row.createCell((short) 0);
			cell.setCellValue(getChineseWord("order_num"));
			cell.setCellStyle(style);
			cell = row.createCell((short) 1);
			cell.setCellValue(getChineseWord("status"));
			cell.setCellStyle(style);
			cell = row.createCell((short) 2);
			cell.setCellValue(getChineseWord("send_user_id"));
			cell.setCellStyle(style);
			cell = row.createCell((short) 3);
			cell.setCellValue(getChineseWord("send_position"));
			cell.setCellStyle(style);
			cell = row.createCell((short) 4);
			cell.setCellValue(getChineseWord("create_time"));
			cell.setCellStyle(style);
			cell = row.createCell((short) 5);
			cell.setCellValue(getChineseWord("recip_user_id"));
			cell.setCellStyle(style);
			cell = row.createCell((short) 6);
			cell.setCellValue(getChineseWord("recip_position"));
			cell.setCellStyle(style);
			Order order = new Order();
			if (!"".equals(request.getParameter("waybill_number"))) {
				String waybill_number = request.getParameter("waybill_number");
				order.setWaybill_number(waybill_number);
			}
			if (!"".equals(request.getParameter("jobNumOne"))) {
				String jobNumOne = request.getParameter("jobNumOne");
				order.setJobNumOne(jobNumOne);
			}
			if (!"".equals(request.getParameter("jobNumTwo"))) {
				String jobNumTwo = request.getParameter("jobNumTwo");
				order.setJobNumTwo(jobNumTwo);
			}
			if (!"".equals(request.getParameter("status"))) {
				Integer status = Integer.valueOf(request.getParameter("status"));
				order.setStatus(status);
			}
			if (request.getParameter("statrTime") != null) {
				String startTime = request.getParameter("statrTime");
				order.setStartTime(startTime);
			}
			if (!"".equals(request.getParameter("endTime"))) {
				String endTime = request.getParameter("endTime");
				order.setEndTime(endTime);
			}
			if (!"".equals(request.getParameter("recipStartTime"))) {
				String recipStartTime = request.getParameter("recipStartTime");
				order.setRecipStartTime(recipStartTime);
			}
			if (!"".equals(request.getParameter("recipEndTime"))) {
				String recipEndTime = request.getParameter("recipEndTime");
				order.setRecipEndTime(recipEndTime);
			}
			List<Order> list = orderMapper.findOrderList(order);
			for (int i = 0; i < list.size(); i++) {
				row = sheet.createRow((int) i + 1);
				Order od = list.get(i);
				if (od.getWaybill_number() != null) {
					row.createCell((short) 0).setCellValue(od.getSource() + od.getWaybill_number());
				} else {
					row.createCell((short) 0).setCellValue("");
				}
				if (od.getStatus() != null) {
					if (od.getStatus() == 1) {
						row.createCell((short) 1).setCellValue("申请中");
					}
					if (od.getStatus() == 2) {
						row.createCell((short) 1).setCellValue("运输中");
					}

					if (od.getStatus() == 3) {
						row.createCell((short) 1).setCellValue("已完成");
					}

					if (od.getStatus() == 4) {
						row.createCell((short) 1).setCellValue("已取消");
					}
					if (od.getStatus() == 5) {
						row.createCell((short) 1).setCellValue("已卸货");
					}
				} else {
					row.createCell((short) 1).setCellValue("");
				}
				if (od.getJobNumOne() != null) {
					row.createCell((short) 2).setCellValue(od.getJobNumOne());
				} else {
					row.createCell((short) 2).setCellValue("");
				}
				if (od.getSend_position() != null) {
					row.createCell((short) 3).setCellValue(od.getSend_position());
				} else {
					row.createCell((short) 3).setCellValue("");
				}
				if (od.getCreate_time() != null) {
					row.createCell((short) 4).setCellValue(od.getCreate_time());
				} else {
					row.createCell((short) 4).setCellValue("");
				}
				if (od.getJobNumTwo() != null) {
					row.createCell((short) 5).setCellValue(od.getJobNumTwo());
				} else {
					row.createCell((short) 5).setCellValue("");
				}
				if (od.getRecip_position() != null) {
					row.createCell((short) 6).setCellValue(od.getRecip_position());
				} else {
					row.createCell((short) 6).setCellValue("");
				}

			}
			// 下载
			OutputStream out;
			String fileName = "订单数据" + ".xls";
			String codeFileName = URLEncoder.encode(fileName, "UTF-8");
			String headStr = "attachment; filename=\"" + codeFileName + "\"";
			response.setContentType("application/vnd.ms-excel");
			response.setHeader("Content-Disposition", headStr);
			out = response.getOutputStream();
			wb.write(out);
			out.flush();
			out.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public static String getChineseWord(String propertyName) throws IOException {
		InputStream is = null;
		Properties dbproperties = new Properties();
		is = OrderServiceImpl.class.getResourceAsStream("/config/exporttitle.properties");
		dbproperties.load(is);
		String propertyValue = dbproperties.getProperty(propertyName).toString();
		return propertyValue;
	}

	@RequestMapping(value = "gotoRecy")
	public ModelAndView gotoRecy() {
		return new ModelAndView("backgroud/recy");
	}


	@RequestMapping(value = "orderAnalysis")
	public String orderAnalysis(ModelMap modelMap, String startTime) {
		List<Order> order = null;
		if(null == startTime || startTime.equals("")){
			startTime = DateUtil.getNowDate("yyyy-MM-dd");
		}
		try{
			order = orderMapper.findOrderAnalysis(startTime);
		}catch (Exception e){}
		modelMap.put("order",order);
		modelMap.put("startTime",startTime);
		return "backgroud/orderAnalysis";
	}
}
