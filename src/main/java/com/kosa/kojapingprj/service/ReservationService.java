package com.kosa.kojapingprj.service;

import com.kosa.kojaping.entity.Reservation;

import java.util.List;

public interface ReservationService {
    public void insertReservation(Reservation reservationDTO); //예약정보 등록

    //예약번호 조회
    public String selectReservationNo(String memberNo);

    public Reservation selectReservationNoByObject(String memberNo);

    //내가 예약한 숙소 목록
    List<Reservation> selectReservationsByMemberNo(String memberNo);

    public String createReservation(Reservation reservation);

    List<Reservation> findByCheckInOut(String accommodationNo, String checkIn, String checkOut);
}
