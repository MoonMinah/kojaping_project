package com.kosa.kojapingprj.service;


import com.kosa.kojaping.entity.Payment;
import com.kosa.kojaping.entity.Reservation;

public interface PaymentService {


    public String transactionInsert(Reservation reservation, Payment payment);

    // 결제 등록
    public void insertPayment(Payment payment);

    //특정 숙소예약 번호 별 결제 내역 조회
    public Payment selectPaymentsByReservationNo(String reservationNo);


    // 결제 상세 조회
    public Payment getPaymentDetail(String paymentNo);

}
