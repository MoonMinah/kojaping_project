package com.kosa.kojapingprj.service;


import com.kosa.kojaping.entity.Review;

public interface ReviewService {



    // 리뷰 등록
    public int insertReview(Review review);

    ///내가 작성한 리뷰 조회
    public Review selectReviewById(String memberNo, String accommodationNo);



}
