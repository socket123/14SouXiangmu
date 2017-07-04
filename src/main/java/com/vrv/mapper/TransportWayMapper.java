package com.vrv.mapper;

import com.vrv.entity.TransportWay;

public interface TransportWayMapper extends BaseDao<TransportWay> {

	TransportWay findTransportWayById(Integer id);

	Integer deleteTransportById(Integer id);

}
