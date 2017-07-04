package com.vrv.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vrv.entity.TransportWay;
import com.vrv.mapper.TransportWayMapper;
import com.vrv.service.BaseService;

@Service
public class TransportWayService extends BaseService<TransportWay> {
	@Autowired
	TransportWayMapper transportWayMapper;

	public TransportWay findTransportWayById(Integer id) {
		return transportWayMapper.findTransportWayById(id);

	}

	public Integer deleteTransportById(Integer id) {
		return transportWayMapper.deleteTransportById(id);
	}
}
