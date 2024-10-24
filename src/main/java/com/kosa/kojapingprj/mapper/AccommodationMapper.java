package com.kosa.kojapingprj.mapper;

import com.kosa.kojaping.entity.Accommodation;
import com.kosa.kojaping.entity.AccommodationImage;
import com.kosa.kojaping.entity.Location;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface AccommodationMapper {

    //숙소 상세보기
    public Accommodation findAccommodationByNo(String accommodationNo);
    //예약진행 시 위치를 뿌려주기 위한 기능
    public Location LocationByNo(long locationNo);

    //숙소 편의 시설 등록
    void insertAccommodationAmenity(String accommodationNo, Long amenityNo);

    public List<Accommodation> selectAccommodationByMemberNo(String memberNo);

    public List<Accommodation> getAllAccommodations();

    public int insertAccommodation(Accommodation accommodation);

    public int insertAccommodationImage(AccommodationImage accommodationImage);

    public List<String> selectAccommodationImageUrlByAccommodationNo(String accommodationNo);

    public int updateAccommodationStatusForDelete(String accommodationNo);
    public List<Accommodation> selectAccommodationByAddressAndMaxGuest(String address, int maxGuest);

}
