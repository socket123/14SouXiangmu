package com.vrv.controller.backgroud;

import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.math.RandomUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
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
import org.springframework.web.servlet.ModelAndView;

import com.vrv.entity.SSUser;
import com.vrv.service.impl.UserService;
import com.vrv.utils.Common;
import com.vrv.utils.MD5Util;
import com.vrv.utils.Pager;

@Controller
@RequestMapping(value = "admin/user")
public class SSUserController {

    @Autowired
    UserService userService;

    @RequestMapping(value = "")
    public String findOrderList(ModelMap modelMap, Integer pageNumber, SSUser ssUser) {
        Pager<SSUser> page = userService.getPage(ssUser, pageNumber);
        modelMap.put("page", page);
        modelMap.put("ssUser", ssUser);
        return "backgroud/userlist";
    }

    @RequestMapping(value = "gotoUserList")
    public String gotoUserList(ModelMap modelMap, Integer pageNumber, SSUser ssUser,
            HttpServletRequest request) {
        ssUser.setIsTeam(1);
        Pager<SSUser> page = userService.getPage(ssUser, pageNumber);
        modelMap.put("page", page);
        modelMap.put("ssUser", ssUser);
        if (request.getParameter("id") != null && !"".equals(request.getParameter("id"))) {
            modelMap.put("teamId", Integer.valueOf(request.getParameter("id")));
        }
        return "backgroud/user_list";
    }

    @RequestMapping(value = "importForm")
    public ModelAndView importForm() {
        return new ModelAndView("backgroud/upload");
    }


    /**
     * 导入 用户
     * @param files
     * @return
     */
    @RequestMapping(value = "importUser")
    @ResponseBody
    public Map<String, Object> importUser(@RequestParam("file") MultipartFile[] files) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("result", 0);
        MultipartFile file = null;
        if (1 == files.length) {
            file = files[0];
        }
        if (null == file) {
            return null;
        }
        String alreayjobNum = "";
        String unFullJobNum = "";
        try {
            String fileName = file.getOriginalFilename().substring(
                    file.getOriginalFilename().lastIndexOf("."));
            Workbook workbook = Common.getWorkbookByHZName(fileName, file);
            Sheet sheet = workbook.getSheetAt(0);
            if (null != sheet) {
                for (int i = 1; i <= sheet.getLastRowNum(); i++) {
                    SSUser ssUser = new SSUser();
                    // 获取excel row
                    Row row = sheet.getRow(i);
                    if (row != null) {
                        if (row.getCell(1) != null && row.getCell(2) != null) {
                            //设置姓名
                            ssUser.setUserName(row.getCell(0).toString());

                            //设置工号
                            row.getCell(1).setCellType(HSSFCell.CELL_TYPE_STRING);
                            String jobNum = row.getCell(1).toString();
                            ssUser.setJobNum(jobNum);
                            System.out.println("左上端单元是==========>： " + row.getCell(1));
                            System.out.println("左上端单元是==========>： " + row.getCell(2));

                            //设置电话
                            row.getCell(2).setCellType(HSSFCell.CELL_TYPE_STRING);
                            String telephone = row.getCell(2).toString();
                            //                            Double tempPhone = Double.parseDouble(telephone);
                            //                            Long tempPhone2 = tempPhone.longValue();
                            //                            telephone = tempPhone2.toString().trim();
                            ssUser.setTelephone(telephone);
                            //设置豆豆号
                            row.getCell(3).setCellType(HSSFCell.CELL_TYPE_STRING);
                            ssUser.setDdId(row.getCell(3).toString());

                            //设置是否团队成员
                            if (null != row.getCell(4) && "是".equals(row.getCell(4).toString())) {
                                ssUser.setIsTeam(1);
                            } else {
                                ssUser.setIsTeam(0);
                            }
                            //设置是否是民工成员
                            if (null != row.getCell(5) && "是".equals(row.getCell(5).toString())) {
                                ssUser.setIs_worker(1);// 是
                                ssUser.setWorker_status(2);//空闲
                            } else {
                                ssUser.setIs_worker(0);
                            }
                            String salt = String.valueOf(RandomUtils.nextInt(100000));
                            ssUser.setPassword(MD5Util.getMD5Code("123456", salt));
                            ssUser.setSalt(salt);
                            ssUser.setCreateTime(new Date());
                            ssUser.setIsOpen(0);
                            ssUser.setDdId("");

                            SSUser lUser = userService.findByUser(jobNum);
                            if (null == lUser) {
                                //为空新增
                                userService.insert(ssUser);
                                map.put("result", 1);
                            } else {
                                //否则修改
                                alreayjobNum += row.getCell(1).toString() + ",";
                                ssUser.setId(lUser.getId());
                                userService.update(ssUser);
                                map.put("result", 1);
                            }
                        } else {
                            unFullJobNum += row.getCell(1).toString() + ",";
                            continue;
                        }
                    }
                }
                if (alreayjobNum != "") {
                    alreayjobNum = alreayjobNum.substring(0, alreayjobNum.lastIndexOf(","));
                }
                if (unFullJobNum != "") {
                    unFullJobNum = unFullJobNum.substring(0, unFullJobNum.lastIndexOf(","));
                }
                map.put("alreayjobNum", alreayjobNum);
                map.put("unFullJobNum", unFullJobNum);
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
        /**
         *  临时更改
         */
        //临时更改
//        Workbook wb = new HSSFWorkbook();
        //临时更改
        // 第二步，在webbook中添加一个sheet,对应Excel文件中的sheet
        Sheet sheet = wb.createSheet("人员导入模板");
        Row row = sheet.createRow((int) 0);
        // 第四步，创建单元格，并设置值表头 设置表头居中
        CellStyle style = wb.createCellStyle();

        style.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 创建一个居中格式
        try {
            Cell cell = row.createCell((short) 0);
            cell.setCellValue("姓名");
            cell.setCellStyle(style);
            cell = row.createCell((short) 1);
            cell.setCellValue("工号");
            cell.setCellStyle(style);
            cell = row.createCell((short) 2);
            cell.setCellValue("电话");
            cell.setCellStyle(style);
            cell = row.createCell((short) 3);
            cell.setCellValue("对应豆豆id");
            cell.setCellStyle(style);
            cell = row.createCell((short) 4);
            cell.setCellValue("是否运输团队成员");
            cell.setCellStyle(style);
            cell = row.createCell((short) 5);
            cell.setCellValue("是否为民工");
            cell.setCellStyle(style);


            String fileName = "人员导入模板" + ".xlsx";
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

    @RequestMapping(value = "offUserIsteam")
    @ResponseBody
    public Map<String, Object> offUserIsteam(Integer id) {
        Map<String, Object> map = new HashMap<>();
        SSUser ssUser = new SSUser();
        map.put("message", 0);
        try {
            ssUser.setId(id);
            ssUser.setIsTeam(0);
            Integer i = userService.update(ssUser);
            map.put("message", i);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return map;
    }

    @RequestMapping(value = "openUserIsteam")
    @ResponseBody
    public Map<String, Object> openUserIsteam(Integer id) {
        Map<String, Object> map = new HashMap<>();
        SSUser ssUser = new SSUser();
        map.put("message", 0);
        try {
            ssUser.setId(id);
            ssUser.setIsTeam(1);
            Integer i = userService.update(ssUser);
            map.put("message", i);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return map;
    }

    @RequestMapping(value = "gotoEditUser")
    public ModelAndView gotoEditUser(Integer id, ModelMap modelMap) {
        SSUser ssUser = userService.findUserById(id);
        modelMap.put("ssUser", ssUser);
        return new ModelAndView("backgroud/editUser", modelMap);
    }

    @RequestMapping(value = "editUser")
    @ResponseBody
    public Map<String, Object> editUser(Integer id, String telephone) {
        Map<String, Object> map = new HashMap<>();
        SSUser ssUser = new SSUser();
        map.put("message", 0);
        try {
            ssUser.setId(id);
            ssUser.setTelephone(telephone);
            Integer i = userService.update(ssUser);
            map.put("message", i);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return map;
    }

    @RequestMapping(value = "/syncUser")
    @ResponseBody
    public Map<String, Object> syncUser() {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("result", userService.saveDDUser());
        return map;
    }

}
