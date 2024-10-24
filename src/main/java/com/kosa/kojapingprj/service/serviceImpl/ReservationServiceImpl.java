package com.kosa.kojapingprj.service.serviceImpl;

import com.kosa.kojaping.entity.Reservation;
import com.kosa.kojaping.mapper.ReservationMapper;
import com.kosa.kojaping.service.ReservationService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Slf4j
public class ReservationServiceImpl implements ReservationService {

    @Autowired
    private ReservationMapper reservationMapper;

    @Override
    public void insertReservation(Reservation reservation) {
        reservationMapper.insertReservation(reservation);
        log.info("예약서비스Impl : " + reservation.getReservationNo());

    }

    /**
     * 예약정보 조회
     * @param memberNo
     * @return
     */
    @Override
    public String selectReservationNo(String memberNo) {
        return reservationMapper.selectReservationNo(memberNo);
    }

    @Override
    public Reservation selectReservationNoByObject(String memberNo) {
        return reservationMapper.selectReservationNoByObject(memberNo);
    }

    //내가 예약한 숙소 목록조회
    @Override
    public List<Reservation> selectReservationsByMemberNo(String memberNo) {
        log.info("서비스 구현체 : " + memberNo);
        log.info("숙소 목록" + reservationMapper.selectReservationsByMemberNo(memberNo));
        return reservationMapper.selectReservationsByMemberNo(memberNo);
    }

    @Override
    public String createReservation(Reservation reservation) {
        // 예약 정보 삽입
        reservationMapper.insertReservation(reservation);
        log.info("예약서비스Impl - 예약 정보 삽입 완료: " + reservation.getReservationNo());

        // 생성된 reservationNo 가져오기
        String reservationNo = reservationMapper.selectReservationNo(reservation.getMemberNo());
        reservation.setReservationNo(reservationNo);

        log.info("예약서비스Impl - 가져온 reservationNo: " + reservationNo);

        return reservationNo;
    }

    @Override
    public List<Reservation> findByCheckInOut(String accommodationNo, String checkIn, String checkOut) {
        return List.of();
    }

}
