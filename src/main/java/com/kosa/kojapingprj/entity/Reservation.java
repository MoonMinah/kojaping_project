package com.kosa.kojapingprj.entity;

import lombok.Data;

import java.math.BigDecimal;
import java.sql.Timestamp;

@Data
public class Reservation {
    private String reservationNo;
    private String memberNo;
    private String accommodationNo;
    private Timestamp checkIn;
    private Timestamp checkOut;
    private BigDecimal totalPrice;
    private String reservationStatus;
    private Timestamp createdAt;

    // 숙소 정보를 저장할 필드 추가
    private Accommodation accommodation;

    //결제 정보를 저장할 필드
    private Payment payment;

    //리뷰 정보를 저장할 필드
    private Review review;
}
