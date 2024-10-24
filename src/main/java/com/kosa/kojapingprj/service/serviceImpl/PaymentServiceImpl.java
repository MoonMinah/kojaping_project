package com.kosa.kojapingprj.service.serviceImpl;


import com.kosa.kojaping.entity.Payment;
import com.kosa.kojaping.entity.Reservation;
import com.kosa.kojaping.mapper.PaymentMapper;
import com.kosa.kojaping.mapper.ReservationMapper;
import com.kosa.kojaping.service.PaymentService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Slf4j
public class PaymentServiceImpl implements PaymentService {


    @Autowired
    private ReservationServiceImpl reservationServiceImpl;

    @Autowired
    private ReservationMapper reservationMapper;

    @Autowired
    private PaymentMapper paymentMapper;


    //예약과 동시에 결제 진행
    @Override
    @Transactional
    public String transactionInsert(Reservation reservation, Payment payment) {
        log.info("Before inserting reservation - reservationNo (before): " + reservation.getReservationNo());

        // 예약 생성, createReservation 사용
        String reservationNo = reservationServiceImpl.createReservation(reservation);
        reservation.setReservationNo(reservationNo);
        log.info("After inserting reservation - reservationNo (after): " + reservation.getReservationNo());

        // payment에 reservationNo 세팅
        payment.setReservationNo(reservation.getReservationNo());
        log.info("Before inserting payment - reservationNo: " + payment.getReservationNo());

        // 결제 삽입
        paymentMapper.insertPayment(payment);

        return reservationNo;
    }

    @Override
    public void insertPayment(Payment payment) {

    }

    @Override
    public Payment selectPaymentsByReservationNo(String reservationNo) {
        return paymentMapper.selectPaymentsByReservationNo(reservationNo);
    }

    // 결제 상세 조회
    public Payment getPaymentDetail(String paymentNo) {

        return paymentMapper.selectPaymentDetail(paymentNo);
    }
}

