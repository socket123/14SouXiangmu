package com.vrv.utils;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.URL;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Properties;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.springframework.web.multipart.MultipartFile;

public class Common {
	public static boolean checkIsFinalUser(String id) throws IOException {
		InputStream is = null;
		Properties dbproperties = new Properties();
		is = Common.class.getResourceAsStream("/endTaskKey.properties");
		dbproperties.load(is);
		String code = dbproperties.getProperty("task").toString();
		String[] codes = code.split(",");
		for (String codeObj : codes) {
			if (codeObj.equals(id)) {
				return true;
			}
		}
		return false;
	}

	public static boolean updateValueByKey(String key, String value) {
		boolean flag = false;
		OutputStream fos = null;
		Properties prop = new Properties();
		InputStream fis = null;
		// InputStream is =
		// Common.class.getResourceAsStream("/endTaskKey.properties");
		URL url = Common.class.getResource("/endTaskKey.properties");
		try {
			File file = new File(url.toURI());
			if (!file.exists()) {
				file.createNewFile();
			}
			fis = new FileInputStream(file);
			prop.load(fis);
			fis.close();
			fos = new FileOutputStream(file);
			prop.setProperty(key, value);
			prop.store(fos, "1111111111");
			fos.close();
		} catch (Exception e) {
			// TODO: handle exception
		}
		return flag;
	}

	public static Workbook getWorkbookByHZName(String HZName, MultipartFile file)
			throws IOException, InvalidFormatException {
		Workbook workbook;
		boolean isExcel2007 = false;
		if (HZName.equals(".xlsx")) {
			isExcel2007 = true;
		}
		if (isExcel2007) {
			workbook = WorkbookFactory.create(file.getInputStream());
		} else {
			workbook = new HSSFWorkbook(file.getInputStream());
		}
		return workbook;
	}

	/**
	 * 获得转正日期
	 * 
	 * @param 开始日期
	 * @param 试用月数
	 * @return
	 * @throws ParseException
	 */
	public static String getFormalDate(String beginDate, Integer trialMonth) throws ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(sdf.parse(beginDate));
		int DAY_OF_MONTH = calendar.get(Calendar.DAY_OF_MONTH);
		if (DAY_OF_MONTH > 15) {
			calendar.add(Calendar.MONTH, trialMonth);
		} else {
			trialMonth = trialMonth - 1;
			calendar.add(Calendar.MONTH, trialMonth);
		}
		calendar.set(Calendar.DAY_OF_MONTH, 1);
		return sdf.format(calendar.getTime());
	}

	public static String getIpAddress(HttpServletRequest request) {
		String ip = request.getHeader("x-forwarded-for");
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_CLIENT_IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_X_FORWARDED_FOR");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}
		return ip;
	}

	public static String callCmd(String[] cmd) {
		String result = "";
		String line = "";
		try {
			Process proc = Runtime.getRuntime().exec(cmd);
			InputStreamReader is = new InputStreamReader(proc.getInputStream());
			BufferedReader br = new BufferedReader(is);
			while ((line = br.readLine()) != null) {
				result += line;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	/**
	 * @param cmd
	 *            第一个命令
	 * @param another
	 *            第二个命令
	 * @return 第二个命令的执行结果
	 */
	public static String callCmd(String[] cmd, String[] another) {
		String result = "";
		String line = "";
		try {
			Runtime rt = Runtime.getRuntime();
			Process proc = rt.exec(cmd);
			proc.waitFor(); // 已经执行完第一个命令，准备执行第二个命令
			proc = rt.exec(another);
			InputStreamReader is = new InputStreamReader(proc.getInputStream());
			BufferedReader br = new BufferedReader(is);
			while ((line = br.readLine()) != null) {
				result += line;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	/**
	 * @param ip
	 *            目标ip,一般在局域网内
	 * @param sourceString
	 *            命令处理的结果字符串
	 * @param macSeparator
	 *            mac分隔符号
	 * @return mac地址，用上面的分隔符号表示
	 */
	public static String filterMacAddress(final String ip, final String sourceString, final String macSeparator) {
		String result = "";
		String regExp = "((([0-9,A-F,a-f]{1,2}" + macSeparator + "){1,5})[0-9,A-F,a-f]{1,2})";
		Pattern pattern = Pattern.compile(regExp);
		Matcher matcher = pattern.matcher(sourceString);
		while (matcher.find()) {
			result = matcher.group(1);
			if (sourceString.indexOf(ip) <= sourceString.lastIndexOf(matcher.group(1))) {
				break; // 如果有多个IP,只匹配本IP对应的Mac.
			}
		}

		return result;
	}

	/**
	 * @param ip
	 *            目标ip
	 * @return Mac Address
	 */
	public static String getMacInWindows(final String ip) {
		String result = "";
		String[] cmd = { "cmd", "/c", "ping " + ip };
		String[] another = { "cmd", "/c", "arp -a" };

		String cmdResult = callCmd(cmd, another);
		result = filterMacAddress(ip, cmdResult, "-");

		return result;
	}

	/**
	 * @param ip
	 *            目标ip
	 * @return Mac Address
	 */
	public static String getMacInLinux(final String ip) {
		String result = "";
		String[] cmd = { "/bin/sh", "-c", "ping " + ip + " -c 2 && arp -a" };
		String cmdResult = callCmd(cmd);
		result = filterMacAddress(ip, cmdResult, ":");

		return result;
	}

	/**
	 * 获取MAC地址
	 * 
	 * @return 返回MAC地址
	 */
	public static String getMacAddress(String ip) {
		// String macAddress = "";
		// macAddress = getMacInWindows(ip).trim();
		// if (macAddress == null || "".equals(macAddress)) {
		// macAddress = getMacInLinux(ip).trim();
		// }
		// return macAddress;
		return null;
	}
}
