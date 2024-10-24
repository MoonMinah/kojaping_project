package com.kosa.kojapingprj.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Review {

    private String reviewNo; //리뷰번호
    private String accommodationNo; //숙소번호
    private String memberNo; //회원번호
    private int rating; //별점
    private String comment; //리뷰내용
    private LocalDateTime createdAt; //작성 일시
    private String status; //활셩여부



}
