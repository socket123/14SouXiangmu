package com.vrv.entity;

import java.io.Serializable;

/**
 * 订单
 * 
 * @author www
 */
public class Order implements Serializable {
    /**
	* 
	*/
    private static final long serialVersionUID = 2250575863664798066L;

    private Integer id;

    private Integer send_user_id;

    private String send_user;// 发件人',

    private String send_username;// 发件人',

    private String send_phone;// 发件人电话',

    private String send_position;// 发件人位置',

    private String create_time;// 申请时间',

    private String remark;// 备注',

    private Integer recip_user_id;

    private String recip_user;// 收货人',

    private String recip_username;// 收货人',

    private String recip_phone;// 收货人电话',

    private String recip_position;// 收货位置',

    private String remarkTwo;

    private String recip_time;// 收货时间',

    private String delivery_time;// 接货时间',

    private Integer team_id;// 运输团队id',

    private String waybill_number;// 运单号',

    private Integer is_big;// 是否大件，1是0否',

    private Integer is_urgent;// 是否急件，1是0否',

    private Integer status;// 状态\r\n1.申请中\r\n2.已接货\r\n3.已完成

    private String team_name;// 运输团队名称

    private String createTime;// 接货时间

    private String username;// 运输团队负责人

    private String startTime;// 申请开始时间

    private String endTime;// 申请结束时间

    private String recipStartTime;// 收货开始时间

    private String recipEndTime;// 收货结束时间

    private Integer unusual;// 是否异常0:正常 1异常

    private String firstpoint_time;//第一次支线到达分拨点时间

    private String trunkdelivery_time;//干线接货时间

    private String branchpoint_time;//第二次干线到达分拨点时间

    private String branchdelivery_time;//支线从分拨点接货时间

    private String trunk_id;//干线团队id

    private Integer branchsend_id;//送货的支线团队id

    private Integer branchrecip_id;//接货的支线团队id

    private String jobNumOne;

    private String jobNumTwo;

    private String telephone;

    private String source;

    private Integer startIndex;

    private Integer endIndex;

    private Integer newCount;

    private Integer dayDistance;

    private Integer isOverDeliverTime;

    private Integer isOverAcceptTime;

    private String deliver_job_num;

    private String deliver_telephone;

    private String unloading_time;

    private String carryout_code;

    private Integer send_courier;

    private Integer recip_courier;

    private Integer if_evalute_send;

    private Integer if_evalute_recip;

    private Integer workload;

    private Integer trunk_courier;

    private Integer if_band_carryout;


    private String trunk_worker_id;//干线团队民工id
    private String branchsend_worker_id;//送货的支线团队民工id
    private String branchrecip_worker_id;//接货的支县团队民工id
    private String trunk_worker_count;//干线团队民工工作量统计
    private String branchsend_worker_count;//送货的支线团队工作量统计
    private String branchrecip_worker_count;//接货的支县团队民工工作量统计


    public String getTrunk_worker_id() {
        return trunk_worker_id;
    }

    public void setTrunk_worker_id(String trunk_worker_id) {
        this.trunk_worker_id = trunk_worker_id;
    }

    public String getBranchsend_worker_id() {
        return branchsend_worker_id;
    }

    public void setBranchsend_worker_id(String branchsend_worker_id) {
        this.branchsend_worker_id = branchsend_worker_id;
    }

    public String getBranchrecip_worker_id() {
        return branchrecip_worker_id;
    }

    public void setBranchrecip_worker_id(String branchrecip_worker_id) {
        this.branchrecip_worker_id = branchrecip_worker_id;
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

    public String getSource() {
        return source;
    }

    public void setSource(String source) {
        this.source = source;
    }

    public String getDeliver_job_num() {
        return deliver_job_num;
    }

    public void setDeliver_job_num(String deliver_job_num) {
        this.deliver_job_num = deliver_job_num;
    }

    public String getDeliver_telephone() {
        return deliver_telephone;
    }

    public void setDeliver_telephone(String deliver_telephone) {
        this.deliver_telephone = deliver_telephone;
    }

    public Integer getIsOverDeliverTime() {
        return isOverDeliverTime;
    }

    public void setIsOverDeliverTime(Integer isOverDeliverTime) {
        this.isOverDeliverTime = isOverDeliverTime;
    }

    public Integer getIsOverAcceptTime() {
        return isOverAcceptTime;
    }

    public void setIsOverAcceptTime(Integer isOverAcceptTime) {
        this.isOverAcceptTime = isOverAcceptTime;
    }

    public Integer getDayDistance() {
        return dayDistance;
    }

    public void setDayDistance(Integer dayDistance) {
        this.dayDistance = dayDistance;
    }

    public Integer getNewCount() {
        return newCount;
    }

    public void setNewCount(Integer newCount) {
        this.newCount = newCount;
    }

    public Integer getStartIndex() {
        return startIndex;
    }

    public void setStartIndex(Integer startIndex) {
        this.startIndex = startIndex;
    }

    public Integer getEndIndex() {
        return endIndex;
    }

    public void setEndIndex(Integer endIndex) {
        this.endIndex = endIndex;
    }

    public Integer getSend_user_id() {
        return send_user_id;
    }

    public void setSend_user_id(Integer send_user_id) {
        this.send_user_id = send_user_id;
    }

    public Integer getRecip_user_id() {
        return recip_user_id;
    }

    public void setRecip_user_id(Integer recip_user_id) {
        this.recip_user_id = recip_user_id;
    }

    public String getRemarkTwo() {
        return remarkTwo;
    }

    public void setRemarkTwo(String remarkTwo) {
        this.remarkTwo = remarkTwo;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getSend_user() {
        return send_user;
    }

    public void setSend_user(String send_user) {
        this.send_user = send_user;
    }

    public String getSend_phone() {
        return send_phone;
    }

    public void setSend_phone(String send_phone) {
        this.send_phone = send_phone;
    }

    public String getSend_position() {
        return send_position;
    }

    public void setSend_position(String send_position) {
        this.send_position = send_position;
    }

    public String getCreate_time() {
        return create_time;
    }

    public void setCreate_time(String create_time) {
        this.create_time = create_time;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getRecip_user() {
        return recip_user;
    }

    public void setRecip_user(String recip_user) {
        this.recip_user = recip_user;
    }

    public String getRecip_phone() {
        return recip_phone;
    }

    public void setRecip_phone(String recip_phone) {
        this.recip_phone = recip_phone;
    }

    public String getRecip_position() {
        return recip_position;
    }

    public void setRecip_position(String recip_position) {
        this.recip_position = recip_position;
    }

    public String getRecip_time() {
        return recip_time;
    }

    public void setRecip_time(String recip_time) {
        this.recip_time = recip_time;
    }

    public String getDelivery_time() {
        return delivery_time;
    }

    public void setDelivery_time(String delivery_time) {
        this.delivery_time = delivery_time;
    }

    public Integer getTeam_id() {
        return team_id;
    }

    public void setTeam_id(Integer team_id) {
        this.team_id = team_id;
    }

    public String getWaybill_number() {
        return waybill_number;
    }

    public void setWaybill_number(String waybill_number) {
        this.waybill_number = waybill_number;
    }

    public Integer getIs_big() {
        return is_big;
    }

    public void setIs_big(Integer is_big) {
        this.is_big = is_big;
    }

    public Integer getIs_urgent() {
        return is_urgent;
    }

    public void setIs_urgent(Integer is_urgent) {
        this.is_urgent = is_urgent;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Order() {
        super();
    }

    public String getTeam_name() {
        return team_name;
    }

    public void setTeam_name(String team_name) {
        this.team_name = team_name;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public String getRecipStartTime() {
        return recipStartTime;
    }

    public void setRecipStartTime(String recipStartTime) {
        this.recipStartTime = recipStartTime;
    }

    public String getRecipEndTime() {
        return recipEndTime;
    }

    public void setRecipEndTime(String recipEndTime) {
        this.recipEndTime = recipEndTime;
    }

    public Integer getUnusual() {
        return unusual;
    }

    public void setUnusual(Integer unusual) {
        this.unusual = unusual;
    }

    public String getJobNumOne() {
        return jobNumOne;
    }

    public void setJobNumOne(String jobNumOne) {
        this.jobNumOne = jobNumOne;
    }

    public String getJobNumTwo() {
        return jobNumTwo;
    }

    public void setJobNumTwo(String jobNumTwo) {
        this.jobNumTwo = jobNumTwo;
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public String getUnloading_time() {
        return unloading_time;
    }

    public void setUnloading_time(String unloading_time) {
        this.unloading_time = unloading_time;
    }

    public String getFirstpoint_time() {return firstpoint_time;}

    public void setFirstpoint_time(String firstpoint_time) {this.firstpoint_time = firstpoint_time;}

    public String getTrunkdelivery_time() {return trunkdelivery_time;}

    public void setTrunkdelivery_time(String trunkdelivery_time) {this.trunkdelivery_time = trunkdelivery_time;}

    public String getBranchpoint_time() {return branchpoint_time;}

    public void setBranchpoint_time(String branchpoint_time) {this.branchpoint_time = branchpoint_time;}

    public String getBranchdelivery_time() {return branchdelivery_time;}

    public void setBranchdelivery_time(String branchdelivery_time) {this.branchdelivery_time = branchdelivery_time;}

    public String getTrunk_id() {return trunk_id;}

    public void setTrunk_id(String trunk_id) {this.trunk_id = trunk_id;}

    public Integer getBranchsend_id() {return branchsend_id;}

    public void setBranchsend_id(Integer branchsend_id) {this.branchsend_id = branchsend_id;}

    public Integer getBranchrecip_id() {return branchrecip_id;}

    public void setBranchrecip_id(Integer branchrecip_id) {this.branchrecip_id = branchrecip_id;}

    public String getCarryoutCode() {return carryout_code;}

    public void setCarryoutCode(String carryout_code) {this.carryout_code = carryout_code;}

    public Integer getSend_courier() {return send_courier;}

    public void setSend_courier(Integer send_courier) {this.send_courier = send_courier;}

    public Integer getRecip_courier() {return recip_courier;}

    public void setRecip_courier(Integer recip_courier) {this.recip_courier = recip_courier;}

    public Integer getIf_evalute_send() {return if_evalute_send;}

    public void setIf_evalute_send(Integer if_evalute_send) {this.if_evalute_send = if_evalute_send;}

    public Integer getIf_evalute_recip() {return if_evalute_recip;}

    public void setIf_evalute_recip(Integer if_evalute_recip) {this.if_evalute_recip = if_evalute_recip;}

    public Integer getWorkload() {return workload;}

    public void setWorkload(Integer workload) {this.workload = workload;}

    public Integer getTrunk_courier() {return trunk_courier;}

    public void setTrunk_courier(Integer trunk_courier) {this.trunk_courier = trunk_courier;}

    public Integer getIf_band_carryout() {return if_band_carryout;}

    public void setIf_band_carryout(Integer if_band_carryout) {this.if_band_carryout = if_band_carryout;}

    public String getSend_username() {return send_username;}

    public void setSend_username(String send_username) {this.send_username = send_username;}

    public String getRecip_username() {return recip_username;}

    public void setRecip_username(String recip_username) {this.recip_username = recip_username;}





}
