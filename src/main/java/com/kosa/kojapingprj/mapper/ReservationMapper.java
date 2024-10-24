package com.kosa.kojapingprj.mapper;

import com.kosa.kojaping.entity.Reservation;
import org.apache.ibatis.annotations.Mapper;

import java.util.Date;
import java.util.List;

@Mapper

public interface ReservationMapper {

    //예약정보 등록
    public void insertReservation(Reservation reservationDTO);

    //내가 예약한 숙소 목록조회
    List<Reservation> selectReservationsByMemberNo(String memberNo);

    List<Reservation> findByCheckInOut(Date checkOut, Date checkIn);


    public Reservation selectReservationNoByObject(String memberNo);


    //예약번호 조회
    public String selectReservationNo(String memberNo);
}
