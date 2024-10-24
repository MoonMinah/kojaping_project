package com.kosa.kojapingprj.service.serviceImpl;

import com.kosa.kojaping.mapper.LocationMapper;
import com.kosa.kojaping.service.LocationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LocationServiceImpl implements LocationService {
    @Autowired
    private LocationMapper locationMapper;

    @Override
    public Long selectLocationNoByLocationName(String locationName) {
        return locationMapper.selectLocationNoByLocationName(locationName);
    }
}
