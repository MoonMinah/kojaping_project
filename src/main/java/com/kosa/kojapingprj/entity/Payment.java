package com.kosa.kojapingprj.entity;

import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
public class Payment {
    private String paymentNo;
    private String reservationNo;
    private String paymentMethod; // KG이니시스, 카카오페이, 네이버 페이, 무통장 입금
    private String paymentStatus; // 성공, 실패
    private BigDecimal paymentAmount;
    private LocalDateTime paymentDate;
}
