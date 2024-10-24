package com.kosa.kojapingprj.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class AccommodationImage {
    private Long imageNo;
    private String accommodationNo;
    private String imageUrl;
    private String uploadedAt;
}
