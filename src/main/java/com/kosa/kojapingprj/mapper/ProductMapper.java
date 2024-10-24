package com.kosa.kojapingprj.mapper;

import com.kosa.kojaping.entity.Accommodation;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;


@Mapper
public interface ProductMapper {
    // 전체 제품을 가져오는 메서드
    List<Accommodation> findAllProducts();

    void deleteProductByaccommodationNo(String accommodationNo);
}
