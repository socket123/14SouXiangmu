package com.vrv.entity;

import java.util.Date;

public class TransportTeam {
	private Integer id;

	private String teamName;

	private Integer userId;

	private Integer isEnable;

	private String ability;

	private Date createTime;

	private String jobNum;

	private Integer catagoryId;

	private Integer type;

	private Integer teamType;

	Integer[] ssOrder;

	String[] areaCode;

	String[] resourceid;

	String[] uid;

	private Integer orderdata;

	private String startTime;

	private String endTime;






// 临时变量
	private String trunk_worker_count;//干线团队民工工作量统计
	private String branchsend_worker_count;//送货的支线团队工作量统计
	private String branchrecip_worker_count;//接货的支县团队民工工作量统计
	private String user_name;//姓名
	private String telephone;//电话
	private String is_big;// 大件 小件

	private String is_big_xiao;//  小件
	private String is_big_zhong;// 中件
	private String is_big_big;// 大件

	private  String counts;// 总数


	public String getCounts() {
		return counts;
	}

	public void setCounts(String counts) {
		this.counts = counts;
	}

	public String getIs_big_xiao() {
		return is_big_xiao;
	}

	public void setIs_big_xiao(String is_big_xiao) {
		this.is_big_xiao = is_big_xiao;
	}

	public String getIs_big_zhong() {
		return is_big_zhong;
	}

	public void setIs_big_zhong(String is_big_zhong) {
		this.is_big_zhong = is_big_zhong;
	}

	public String getIs_big_big() {
		return is_big_big;
	}

	public void setIs_big_big(String is_big_big) {
		this.is_big_big = is_big_big;
	}

	public String getTrunk_worker_count() {
		return trunk_worker_count;
	}

	public void setTrunk_worker_count(String trunk_worker_count) {
		this.trunk_worker_count = trunk_worker_count;
	}

	public String getBranchsend_worker_count() {
		return branchsend_worker_count;
	}

	public void setBranchsend_worker_count(String branchsend_worker_count) {
		this.branchsend_worker_count = branchsend_worker_count;
	}

	public String getBranchrecip_worker_count() {
		return branchrecip_worker_count;
	}

	public void setBranchrecip_worker_count(String branchrecip_worker_count) {
		this.branchrecip_worker_count = branchrecip_worker_count;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public String getTelephone() {
		return telephone;
	}

	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}

	public String getIs_big() {
		return is_big;
	}

	public void setIs_big(String is_big) {
		this.is_big = is_big;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getTeamName() {
		return teamName;
	}

	public void setTeamName(String teamName) {
		this.teamName = teamName == null ? null : teamName.trim();
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public Integer getIsEnable() {
		return isEnable;
	}

	public void setIsEnable(Integer isEnable) {
		this.isEnable = isEnable;
	}

	public String getAbility() {
		return ability;
	}

	public void setAbility(String ability) {
		this.ability = ability == null ? null : ability.trim();
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public String getJobNum() {
		return jobNum;
	}

	public void setJobNum(String jobNum) {
		this.jobNum = jobNum;
	}

	public Integer getCatagoryId() {
		return catagoryId;
	}

	public void setCatagoryId(Integer catagoryId) {
		this.catagoryId = catagoryId;
	}

	public String[] getAreaCode() {
		return areaCode;
	}

	public void setAreaCode(String[] areaCode) {
		this.areaCode = areaCode;
	}

	public String[] getResourceid() {
		return resourceid;
	}

	public void setResourceid(String[] resourceid) {
		this.resourceid = resourceid;
	}

	public String[] getUid() {
		return uid;
	}

	public void setUid(String[] uid) {
		this.uid = uid;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public Integer[] getSsOrder() {
		return ssOrder;
	}

	public void setSsOrder(Integer[] ssOrder) {
		this.ssOrder = ssOrder;
	}

	public Integer getTeamType() {
		return teamType;
	}

	public void setTeamType(Integer teamType) {
		this.teamType = teamType;
	}

	public Integer getOrderdata() { return orderdata; }

	public void setOrderdata(Integer orderdata) {this.orderdata = orderdata;}

	public String getStartTime() {return startTime;}

	public void setStartTime(String startTime) {this.startTime = startTime;}

	public String getEndTime() {return endTime;}

	public void setEndTime(String endTime) {this.endTime = endTime;}

}