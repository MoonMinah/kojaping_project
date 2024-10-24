package com.kosa.kojapingprj.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import org.springframework.data.annotation.Id;
import org.springframework.data.elasticsearch.annotations.Document;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Document(indexName = "accommodations")
public class Accommodation {

    @Id
    private String accommodationNo;

    private String memberNo;
    private String title;
    private String description;
    private BigDecimal pricePerNight;
    private BigDecimal latitude;
    private BigDecimal longitude;
    private int postcode;
    private String address;
    private String detailAddress;
    private String extraAddress;
    private int maxGuest;
    private int bedroomCnt;
    private int bedCnt;
    private int bathCnt;
    private Long locationNo;
    private Timestamp createdAt;
    private Timestamp updateAt;
    private String status;

    private List<String> imageUrls;
}
