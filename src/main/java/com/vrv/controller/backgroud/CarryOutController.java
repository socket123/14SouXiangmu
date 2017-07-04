package com.vrv.controller.backgroud;

import com.vrv.contans.MyConfig;
import com.vrv.entity.*;
import com.vrv.service.log.MyLog;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.vrv.service.impl.*;
import com.vrv.utils.Common;
import com.vrv.utils.Pager;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by LXX on 2017-04-27.
 */
@Controller
@RequestMapping(value = "admin/carryOut")
public class CarryOutController {

    @Autowired
    CarryOutService carryOutService;

    @Autowired
    TransportTeamService transportTeamService;

    @Autowired
    CarryoutDeptService carryOutDeptService;

    @Autowired
    CarryoutStateService carryoutStateService;

    @RequestMapping(value = "carryOutlist")
    public String carryOutlist(ModelMap modelMap, Integer pageNumber, CarryOut carryOut) {
        Pager<CarryOut> page = carryOutService.getPage(carryOut, pageNumber);
        List<TransportTeam> transportTeam = transportTeamService.selectTeamAll();
        modelMap.put("page", page);
        modelMap.put("carryOut", carryOut);
        modelMap.put("transportTeam",transportTeam);
        return "backgroud/carryOutList";
    }

    @RequestMapping(value = "gotoCarryoutAdd")
    public ModelAndView gotoCarryoutTypeAdd(HttpServletRequest request, ModelMap modelMap) {
        Map<String, Object> maps = new HashMap<String, Object>();
        List<CarryoutDept> carryoutDept = carryOutDeptService.loadAll(maps);
        List<CarryoutState> carryoutState = carryoutStateService.loadAll(maps);
        modelMap.put("carryoutDept", carryoutDept);
        modelMap.put("carryoutState", carryoutState);
        return new ModelAndView("backgroud/addCarryout");
    }

    @RequestMapping(value = "addCarryout", produces = MyConfig.PRODUCES)
    @ResponseBody
    public Map<String, Object> addCarryoutType(CarryOut record) {
        Map<String, Object> map = new HashMap<>();
        CarryOut CarryOut = carryOutService.findByCarryoutCode(record.getCarryoutCode());
        if(null != CarryOut){
            map.put("message", 0);
            map.put("mess", "载具编码不能重复");
            return map;
        }
        record.setCreateTime(new Date());
        Integer i = carryOutService.insert(record);
        map.put("message", i);
        return map;
    }

    @RequestMapping("/toCarryOutEdit")
    public ModelAndView toCarryOutEdit(Integer id, ModelMap modelMap) {
        CarryOut carryOut = carryOutService.get(id);
        Map<String, Object> maps = new HashMap<String, Object>();
        List<CarryoutDept> carryoutDept = carryOutDeptService.loadAll(maps);
        List<CarryoutState> carryoutState = carryoutStateService.loadAll(maps);
        modelMap.put("carryOut", carryOut);
        modelMap.put("carryoutDept", carryoutDept);
        modelMap.put("carryoutState", carryoutState);
        return new ModelAndView("backgroud/editCarryOut", modelMap);
    }

    @RequestMapping(value = "/carryOutUpdateStatus")
    @ResponseBody
    public Map<String, Object> edit(CarryOut carryOut) {
        Map<String, Object> map = new HashMap<String, Object>();
        int count = carryOutService.update(carryOut);
        map.put("code", count);
        return map;
    }

    @RequestMapping(value = "importCarryOut")
    @ResponseBody
    public Map<String, Object> importCarryOut(@RequestParam("file") MultipartFile[] files) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("result", 0);
        MultipartFile file = null;
        if (1 == files.length) {
            file = files[0];
        }
        if (null == file) {
            return null;
        }
        String alreaycarryOutNo = "";
        String unFullcarryOutNo = "";
        try {
            String fileName = file.getOriginalFilename().substring(
                    file.getOriginalFilename().lastIndexOf("."));
            Workbook workbook = Common.getWorkbookByHZName(fileName, file);
            Sheet sheet = workbook.getSheetAt(0);
            if (null != sheet) {
                for (int i = 1; i <= sheet.getLastRowNum(); i++) {
                    int h = i + 1;
                    CarryOut carryOut = new CarryOut();
                    // 获取excel row
                    Row row = sheet.getRow(i);
                    if (row != null) {
                        if (row.getCell(0) != null && row.getCell(1) != null && row.getCell(2) != null) {
                            //设置载具编码
                            row.getCell(0).setCellType(HSSFCell.CELL_TYPE_STRING);
                            String carryoutCode = row.getCell(0).toString();
                            carryOut.setCarryoutCode(carryoutCode);

                            //设置图号
                            row.getCell(1).setCellType(HSSFCell.CELL_TYPE_STRING);
                            String figurenum = row.getCell(1).toString();
                            carryOut.setFigurenum(figurenum);

                            //设置描述
                            row.getCell(2).setCellType(HSSFCell.CELL_TYPE_STRING);
                            String describe = row.getCell(2).toString();
                            carryOut.setDepict(describe);

                            //设置创建时间
                            carryOut.setCreateTime(new Date());

                            CarryOut carryOut1 = carryOutService.findByCarryoutCode(carryoutCode);
                            if (null == carryOut1) {
                                //为空新增
                                carryOut.setStatus(0);//初始化时待使用
                                carryOut.setIsEnable(1);//初始化时启用
                                carryOutService.insert(carryOut);
                                map.put("result", 1);
                            } else {
                                //否则修改
                                alreaycarryOutNo += row.getCell(0).toString() + ",";
                                carryOut.setId(carryOut1.getId());
                                carryOutService.update(carryOut);
                                map.put("result", 1);
                            }
                        } else {
                            unFullcarryOutNo += row.getCell(0).toString() + ",";
                            continue;
                        }
                    }
                }
                if (!alreaycarryOutNo.equals("")) {
                    alreaycarryOutNo = alreaycarryOutNo.substring(0, alreaycarryOutNo.lastIndexOf(","));
                }
                if (!unFullcarryOutNo.equals("")) {
                    unFullcarryOutNo = unFullcarryOutNo.substring(0, unFullcarryOutNo.lastIndexOf(","));
                }
                map.put("alreayjobNum", alreaycarryOutNo);
                map.put("unFullJobNum", unFullcarryOutNo);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
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
        Sheet sheet = wb.createSheet("载具导入模板");
        Row row = sheet.createRow((int) 0);
        // 第四步，创建单元格，并设置值表头 设置表头居中
        CellStyle style = wb.createCellStyle();

        style.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 创建一个居中格式
        try {
            Cell cell = row.createCell((short) 0);
            cell.setCellValue("载具编码");
            cell.setCellStyle(style);
            cell = row.createCell((short) 1);
            cell.setCellValue("图号");
            cell.setCellStyle(style);
            cell = row.createCell((short) 2);
            cell.setCellValue("描述");
            cell.setCellStyle(style);

            String fileName = "载具导入模板" + ".xlsx";
            String codeFileName = URLEncoder.encode(fileName, "UTF-8");
            String headStr = "attachment; filename=\"" + codeFileName + "\"";
            response.setContentType("application/vnd.ms-excel");
            // response.setContentType("application/octet-stream");
            response.setHeader("Content-Disposition", headStr);
            out = response.getOutputStream();
            wb.write(out);
            out.flush();
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @RequestMapping(value = "deleteCarryout")
    @ResponseBody
    public Map<String, Object> deleteCarryoutType(Integer id) {
        Map<String, Object> map = new HashMap<>();
        CarryOut CarryOut = carryOutService.get(id);
        if("1".equals(CarryOut.getStatus())){//当前载具已使用，不可以删除
            map.put("mess", "该载具正在使用");
            map.put("message", 0);
            return map;
        }
        Integer i = carryOutService.delete(id);
        map.put("message", i);
        return map;
    }

    @MyLog(module = "carryOut", type = "export", content = "导出载具")
    @RequestMapping(value = "exportCarryOutExcel")
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
            cell.setCellValue(OrderAllListController.getChineseWord("carryout_code"));
            cell.setCellStyle(style);
            cell = row.createCell((short) 1);
            cell.setCellValue(OrderAllListController.getChineseWord("figurenum"));
            cell.setCellStyle(style);
            cell = row.createCell((short) 2);
            cell.setCellValue(OrderAllListController.getChineseWord("carryoutDeptName"));
            cell.setCellStyle(style);
            cell = row.createCell((short) 3);
            cell.setCellValue(OrderAllListController.getChineseWord("carryoutStateName"));
            cell.setCellStyle(style);
            cell = row.createCell((short) 4);
            cell.setCellValue(OrderAllListController.getChineseWord("pname"));
            cell.setCellStyle(style);
            cell = row.createCell((short) 5);
            cell.setCellValue(OrderAllListController.getChineseWord("depict"));
            cell.setCellStyle(style);
            cell = row.createCell((short) 6);
            cell.setCellValue(OrderAllListController.getChineseWord("carryoutstatus"));
            cell.setCellStyle(style);
            cell = row.createCell((short) 7);
            cell.setCellValue(OrderAllListController.getChineseWord("belongto"));
            cell.setCellStyle(style);
            cell = row.createCell((short) 8);
            cell.setCellValue(OrderAllListController.getChineseWord("last_time"));
            cell.setCellStyle(style);
            cell = row.createCell((short) 9);
            cell.setCellValue(OrderAllListController.getChineseWord("carryout_create_time"));
            cell.setCellStyle(style);
            SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm");
            CarryOut carryOut = new CarryOut();
            if (!"".equals(request.getParameter("position"))) {
                String position = request.getParameter("position");
                carryOut.setPosition(position);
            }
            if (!"".equals(request.getParameter("teamId"))) {
                String teamId = request.getParameter("teamId");
                carryOut.setTeamId(Integer.valueOf(teamId));
            }
            List<CarryOut> list = carryOutService.findCarryoutList(carryOut);
            for (int i = 0; i < list.size(); i++) {
                row = sheet.createRow((int) i + 1);
                CarryOut co = list.get(i);
                if (co.getCarryoutCode() != null) {
                    row.createCell((short) 0).setCellValue(co.getCarryoutCode());
                } else {
                    row.createCell((short) 0).setCellValue("");
                }
                if (co.getFigurenum() != null) {
                    row.createCell((short) 1).setCellValue(co.getFigurenum());
                } else {
                    row.createCell((short) 1).setCellValue("");
                }
                if (co.getCarryoutDeptName() != null) {
                    row.createCell((short) 2).setCellValue(co.getCarryoutDeptName());
                } else {
                    row.createCell((short) 2).setCellValue("");
                }
                if (co.getCarryoutStateName() != null) {
                    row.createCell((short) 3).setCellValue(co.getCarryoutStateName());
                } else {
                    row.createCell((short) 3).setCellValue("");
                }
                if (co.getPname() != null) {
                    row.createCell((short) 4).setCellValue(co.getPname());
                } else {
                    row.createCell((short) 4).setCellValue("");
                }
                if (co.getDepict() != null) {
                    row.createCell((short) 5).setCellValue(co.getDepict());
                } else {
                    row.createCell((short) 5).setCellValue("");
                }
                if (co.getStatus() != null) {
                    if (co.getStatus() == 1) {
                        row.createCell((short) 6).setCellValue("使用中");
                        if(co.getTeamName() !=null){
                            row.createCell((short) 7).setCellValue(co.getTeamName());
                        } else{
                            row.createCell((short) 7).setCellValue("");
                        }

                    } else{
                        row.createCell((short) 6).setCellValue("未使用");
                        if(co.getPosition() !=null){
                            row.createCell((short) 7).setCellValue(co.getPosition());
                        } else{
                            row.createCell((short) 7).setCellValue("");
                        }
                    }
                } else {
                    row.createCell((short) 6).setCellValue("");
                    row.createCell((short) 7).setCellValue("");
                }
                if (co.getLastTime() != null) {
                    String str=sdf.format(co.getLastTime());
                    row.createCell((short) 8).setCellValue(str);
                } else {
                    row.createCell((short) 8).setCellValue("");
                }
                if (co.getCreateTime() != null) {
                    String str=sdf.format(co.getCreateTime());
                    row.createCell((short) 9).setCellValue(str);
                } else {
                    row.createCell((short) 9).setCellValue("");
                }
            }
            // 下载
            OutputStream out;
            String fileName = "载具数据" + ".xls";
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





}
