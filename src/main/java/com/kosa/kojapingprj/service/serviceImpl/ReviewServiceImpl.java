package com.kosa.kojapingprj.service.serviceImpl;

import com.kosa.kojaping.entity.Review;
import com.kosa.kojaping.mapper.ReviewMapper;
import com.kosa.kojaping.service.ReviewService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
@Slf4j
public class ReviewServiceImpl implements ReviewService {

    @Autowired
    ReviewMapper reviewMapper;


    @Override
    public int insertReview(Review review) {
        return reviewMapper.insertReview(review);
    }

    /**
     * 내가 작성한 리뷰 조회
     * @param memberNo
     * @param accommodationNo
     * @return
     */
    @Override
    public Review selectReviewById(String memberNo, String accommodationNo) {
        log.info("serviceImpl" + reviewMapper.selectReviewById(memberNo, accommodationNo));
        return reviewMapper.selectReviewById(memberNo, accommodationNo);
    }
}
