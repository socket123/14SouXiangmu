package com.vrv.controller.backgroud;

import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.vrv.contans.MyConfig;
import com.vrv.entity.AreaCode;
import com.vrv.entity.SSUser;
import com.vrv.entity.UserAreaRelation;
import com.vrv.service.impl.AreaCodeService;
import com.vrv.service.impl.UserAreaRelationService;
import com.vrv.service.impl.UserService;
import com.vrv.utils.Common;
import com.vrv.utils.Pager;

@Controller
@RequestMapping("/admin/areaCode")
public class AreaCodeController {
	private static Logger logger = Logger.getLogger(AreaCodeController.class);

	@Autowired
	AreaCodeService areaService;

	@Autowired
	UserService userService;

	@Autowired
	UserAreaRelationService userAreaRelationService;

	@RequestMapping("/list")
	public String list(ModelMap model, @RequestParam(defaultValue = "1") int pageNo, AreaCode area) {
		Pager<AreaCode> page = areaService.getPage(area, pageNo);
		model.put("page", page);
		model.put("area", area);
		return "backgroud/areaCode_list";
	}

	@RequestMapping("/toEdit")
	public String toEdit(ModelMap model) {
		return "areaCode_edit";
	}

	@RequestMapping(value = "/edit", produces = MyConfig.PRODUCES)
	@ResponseBody
	public Map<String, Object> edit(AreaCode area) {
		Map<String, Object> map = new HashMap<String, Object>();
		int count = areaService.update(area);
		map.put("code", count);
		return map;
	}

	@RequestMapping(value = "importArea")
	@ResponseBody
	public Map<String, Object> importArea(@RequestParam("file") MultipartFile[] files) {
		Map<String, Object> map = new HashMap<String, Object>();
		int executeCount = 0;
		map.put("code", executeCount);
		String msg = "";
		String msg_trunk="";
		MultipartFile file = null;
		if (1 == files.length) {
			file = files[0];
		}
		if (null == file) {
			map.put("msg", "文件上传失败");
			return map;
		}
		try {
			String fileName = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
			Workbook workbook = Common.getWorkbookByHZName(fileName, file);
			Sheet sheet = workbook.getSheetAt(0);
			if (null == sheet) {
				map.put("msg", "文件上传失败");
				return map;
			}

			for (int i = 1; i <= sheet.getLastRowNum(); i++) {
				int h = i + 1;
				// 获取excel row
				Row row = sheet.getRow(i);
				if (row == null) {
					msg += h + "，";
					logger.info("row为空");
					continue;
				}
				if (null == row.getCell(0) || (null == row.getCell(1) && null == row.getCell(2))
						|| null == row.getCell(3)) {
					msg += h + "，";
					logger.info("数据不完整");
					continue;
				}
				row.getCell(0).setCellType(HSSFCell.CELL_TYPE_STRING);
				String code = row.getCell(0).toString();
				// 查询地址编码是否存在
				AreaCode area = areaService.findAreaCodeById(code);
				// 存在
				if (null != area) {
					// 先插入主表数据
					area.setAreaCode(code);
					String isOut = "";
					String isIn = "";
					if (null != row.getCell(1) && "是".equals(row.getCell(1).toString())) {
						isIn = "1";
					}
					if (null != row.getCell(2) && "是".equals(row.getCell(2).toString())) {
						isOut = "2";
						if (!StringUtils.isEmpty(isIn)) {
							isOut = ",2";
						}
					}
					if (null != row.getCell(4)) {
						AreaCode acode = areaService.findAreaCodeById(String.valueOf(row.getCell(4)));
						if (acode == null) {
							msg_trunk += h + "，";
							logger.info("所属中转点为:" + row.getCell(4) + "不存在");
							continue;
						} else{
							area.setAreaTrunk(acode.getAreaCode());
						}
					}
					area.setAreaOut(isIn + isOut);
					area.setIsEnable(1);
					area.setCreateTime(new Date());
					areaService.update(area);
					// 根据用户工号查询用户id
					row.getCell(3).setCellType(HSSFCell.CELL_TYPE_STRING);
					String[] jobNum = row.getCell(3).toString().split("/");
					if (null == jobNum) {
						msg += h + "，";
						logger.info("jobNum为空");
						continue;
					}
					// 先删除关联表中数据
					userAreaRelationService.delete(area.getId());
					for (int k = 0; k < jobNum.length; k++) {
						SSUser ssUser = userService.findByUser(jobNum[k]);
						if (ssUser == null) {
							msg += h + "，";
							logger.info("工号为:" + jobNum[k] + "不存在");
						} else {
							UserAreaRelation userAreaRelation = new UserAreaRelation();
							userAreaRelation.setAreaId(area.getId());
							userAreaRelation.setUserId(ssUser.getId());
							userAreaRelationService.insert(userAreaRelation);
							executeCount++;
						}
					}
				} else {// 不存在
					area = new AreaCode();
					area.setAreaCode(code);
					area.setCreateTime(new Date());
					area.setIsEnable(1);
					String isOut = "";
					String isIn = "";
					if (null != row.getCell(1) && "是".equals(row.getCell(1).toString())) {
						isIn = "1";
					}
					if (null != row.getCell(2) && "是".equals(row.getCell(2).toString())) {
						isOut = "2";
						if (!StringUtils.isEmpty(isIn)) {
							isOut = ",2";
						}
					}
					area.setAreaOut(isIn + isOut);
					if (null != row.getCell(4)) {
						AreaCode acode = areaService.findAreaCodeById(String.valueOf(row.getCell(4)));
						if (acode == null) {
							msg_trunk += h + "，";
							logger.info("所属中转点为:" + row.getCell(4) + "不存在");
							continue;
						}else{
							area.setAreaTrunk(acode.getAreaCode());
						}
					}
					// 根据用户工号查询用户id
					String[] jobNum = row.getCell(3).toString().split("/");
					if (null == jobNum) {
						msg += h + "，";
						logger.info("jobNum为空");
						continue;
					}
					areaService.insert(area);
					// 先删除关联表中数据
					userAreaRelationService.delete(area.getId());
					boolean flag = false;
					for (int k = 0; k < jobNum.length; k++) {
						SSUser ssUser = userService.findByUser(jobNum[k].replace(".0",""));
						if (ssUser == null) {
							msg += h + "，";
							logger.info("工号为:" + jobNum[k].replace(".0","") + "不存在");
						} else {
							area.setUserId(ssUser.getId() + "");
							areaService.update(area);
							UserAreaRelation userAreaRelation = new UserAreaRelation();
							userAreaRelation.setAreaId(area.getId());
							userAreaRelation.setUserId(ssUser.getId());
							userAreaRelationService.insert(userAreaRelation);
							flag = true;
						}
					}
					if (flag) {
						executeCount++;
					} else {
						areaService.delete(area.getId());
					}
				}
			}
			if (!StringUtils.isEmpty(msg)) {
				msg = "第" + msg.substring(0, msg.lastIndexOf("，")) + "行数据工号不存在";
			}
			if (!StringUtils.isEmpty(msg_trunk)) {
				msg = "第" + msg_trunk.substring(0, msg_trunk.lastIndexOf("，")) + "行数据所属中转点不存在";
			}
		} catch (Exception e) {
			e.printStackTrace();
			map.put("msg", "文件上传失败");
		}
		map.put("code", executeCount);
		map.put("msg", msg);
		return map;
	}

	// 下载模板
	@RequestMapping(value = "exportExcel")
	@ResponseBody
	public void exportExcel(HttpServletResponse response, HttpServletRequest request) {
		OutputStream out;
		// 第一步，创建一个webbook，对应一个Excel文件
		Workbook wb = new XSSFWorkbook();
		// 第二步，在webbook中添加一个sheet,对应Excel文件中的sheet
		Sheet sheet = wb.createSheet("配置点导入模板");
		Row row = sheet.createRow((int) 0);
		// 第四步，创建单元格，并设置值表头 设置表头居中
		CellStyle style = wb.createCellStyle();

		style.setAlignment(CellStyle.ALIGN_CENTER); // 创建一个居中格式
		try {
			Cell cell = row.createCell((short) 0);
			cell.setCellValue("配载点代码");
			cell.setCellStyle(style);
			cell = row.createCell((short) 1);
			cell.setCellValue("是否可转入");
			cell.setCellStyle(style);
			cell = row.createCell((short) 2);
			cell.setCellValue("是否可转出");
			cell.setCellStyle(style);
			cell = row.createCell((short) 3);
			cell.setCellValue("负责人工号");
			cell.setCellStyle(style);
			cell = row.createCell((short) 4);
			cell.setCellValue("所属中转点");
			cell.setCellStyle(style);

			String fileName = "配载点导入模板" + ".xlsx";
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

	}
}
