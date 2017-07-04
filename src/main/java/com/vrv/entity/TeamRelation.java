package com.vrv.entity;

public class TeamRelation {
	private Integer id;

	private Integer teamId;

	private Integer otherId;

	private Integer type;

	private Integer ssOrder;


	private Integer ids;

	private String userName;



	private String telephone;

	public Integer getIds() {
		return ids;
	}

	public void setIds(Integer ids) {
		this.ids = ids;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getTelephone() {
		return telephone;
	}

	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getTeamId() {
		return teamId;
	}

	public void setTeamId(Integer teamId) {
		this.teamId = teamId;
	}

	public Integer getOtherId() {
		return otherId;
	}

	public void setOtherId(Integer otherId) {
		this.otherId = otherId;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public Integer getSsOrder() {
		return ssOrder;
	}

	public void setSsOrder(Integer ssOrder) {
		this.ssOrder = ssOrder;
	}

}