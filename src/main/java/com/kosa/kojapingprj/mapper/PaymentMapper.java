package com.kosa.kojapingprj.mapper;

import com.kosa.kojaping.entity.Payment;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface PaymentMapper {
    // 결제 내역 삽입
    void insertPayment(Payment payment);

    public Payment selectPaymentsByReservationNo(String reservationNo);

    // 결제 상세 조회
    Payment selectPaymentDetail(String paymentNo);
}
