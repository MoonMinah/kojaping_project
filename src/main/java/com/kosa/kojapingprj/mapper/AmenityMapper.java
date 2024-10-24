package com.kosa.kojapingprj.mapper;

import com.kosa.kojaping.entity.Amenity;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface AmenityMapper {

    Amenity findByAmenityName(String amenityName);
}
