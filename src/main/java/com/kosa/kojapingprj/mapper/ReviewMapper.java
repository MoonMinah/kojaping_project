package com.kosa.kojapingprj.mapper;

import com.kosa.kojaping.entity.Review;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ReviewMapper {
    // 결제 내역 삽입
    public int insertReview(Review review);

    //내가 작성한 리뷰 조회
    public Review selectReviewById(String memberNo, String accommodationNo);


}
