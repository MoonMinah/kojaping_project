package com.kosa.kojapingprj.service.serviceImpl;

import com.kosa.kojaping.entity.Accommodation;
import com.kosa.kojaping.entity.AccommodationImage;
import com.kosa.kojaping.entity.Location;
import com.kosa.kojaping.mapper.AccommodationMapper;
import com.kosa.kojaping.mapper.AmenityMapper;
import com.kosa.kojaping.service.AccommodationService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Slf4j
@Service
public class AccommodationServiceImpl implements AccommodationService {
    @Autowired
    private AccommodationMapper accommodationMapper;
    @Autowired
    private AmenityMapper amenityMapper;

    @Override

    public List<Accommodation> selectAccommodationByMemberNo(String memberNo) {
        return accommodationMapper.selectAccommodationByMemberNo(memberNo);
    }

    @Override
    public List<Accommodation> getAllAccommodations() {
        return accommodationMapper.getAllAccommodations();
    }


//    @Override
//    @Transactional
//    public void registerAccommodation(Accommodation accommodation, List<MultipartFile> imageFiles, String uploadDir, String sessionId) {
//        // 1. 숙소 정보를 DB에 저장
//        int resultAccommodation = accommodationMapper.insertAccommodation(accommodation);
//        log.info("registerAccommodation() : insertAccommodation() = {}", resultAccommodation);
//        log.info("숙소 정보 : " + accommodation.toString());
//
//        // 2. 이미지를 서버에 저장하고, 이미지 경로를 DB에 저장
//        for (MultipartFile file : imageFiles) {
//            if (!file.isEmpty()) {
//                String uniqueFileName = UUID.randomUUID() + "_" + file.getOriginalFilename();
//                File saveFile = new File(uploadDir, uniqueFileName);
//                try {
//                    file.transferTo(saveFile);
//                    log.info("File saved at: {}", saveFile.getAbsolutePath());
//
//                    // 이미지 경로를 DB에 저장
//                    AccommodationImage accommodationImage = new AccommodationImage();
//                    accommodationImage.setAccommodationNo(accommodation.getAccommodationNo());
//                    accommodationImage.setImageUrl("/images/host/" + sessionId + "/" + uniqueFileName);
//                    int resultAccommodationImage = accommodationMapper.insertAccommodationImage(accommodationImage);
//                    log.info("registerAccommodation() : insertAccommodationImage() = {}", resultAccommodationImage);
//                    log.info("AccommodationNo(서비스 구현체): {}", accommodation.getAccommodationNo());
//                    log.info("Saved image path(서비스 구현체): {}", "/images/host/" + uniqueFileName);
//
//
//                    if (accommodation.getImageUrls() == null) {
//                        accommodation.setImageUrls(new ArrayList<>());
//                    }
//                    accommodation.getImageUrls().add("/images/host/" + sessionId + "/" + uniqueFileName);
//                } catch (IOException e) {
//                    e.printStackTrace();
//                }
//            }
//        }
//
//    }

    @Override
    @Transactional
    public void registerAccommodation(Accommodation accommodation, List<MultipartFile> imageFiles, String uploadDir, String sessionId) {
        // 1. 숙소 정보를 DB에 저장
        int resultAccommodation = accommodationMapper.insertAccommodation(accommodation);
        log.info("registerAccommodation() : insertAccommodation() = {}", resultAccommodation);
        log.info("숙소 정보 : " + accommodation.toString());

        // 2. 이미지를 서버에 저장하고, 이미지 경로를 DB에 저장
        List<String> imageUrls = new ArrayList<>();
        for (MultipartFile file : imageFiles) {
            if (!file.isEmpty()) {
                String uniqueFileName = UUID.randomUUID() + "_" + file.getOriginalFilename();
                File saveFile = new File(uploadDir, uniqueFileName);
                try {
                    // 파일 저장
                    file.transferTo(saveFile);
                    log.info("File saved at: {}", saveFile.getAbsolutePath());

                    // 이미지 경로를 DB에 저장
                    AccommodationImage accommodationImage = new AccommodationImage();
                    accommodationImage.setAccommodationNo(accommodation.getAccommodationNo()); // 숙소 번호 설정
                    accommodationImage.setImageUrl("/images/host/" + sessionId + "/" + uniqueFileName);
                    int resultAccommodationImage = accommodationMapper.insertAccommodationImage(accommodationImage); // 이미지 저장
                    log.info("registerAccommodation() : insertAccommodationImage() = {}", resultAccommodationImage);
                    log.info("AccommodationNo(서비스 구현체): {}", accommodation.getAccommodationNo());
                    log.info("Saved image path(서비스 구현체): {}", "/images/host/" + uniqueFileName);

                    // URL 리스트에 이미지 경로 추가
                    imageUrls.add("/images/host/" + sessionId + "/" + uniqueFileName);
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }

        // 3. 숙소 정보에 이미지 URL 리스트 추가
        accommodation.setImageUrls(imageUrls);
    }




    @Override
    public Accommodation findAccommodationByNo(String accommodationNo) {
        return accommodationMapper.findAccommodationByNo(accommodationNo);
    }

    @Override
    public Location LocationByNo(long locationNo) {
        return accommodationMapper.LocationByNo(locationNo);
    }

    @Override
    public List<Accommodation> findByAddressAndMaxGuest(String address, int maxGuest) {

        log.info("findByAddressAndMaxGuest : {}", accommodationMapper.selectAccommodationByAddressAndMaxGuest(address, maxGuest));
        return accommodationMapper.selectAccommodationByAddressAndMaxGuest(address, maxGuest);
    }

    @Override
    public List<String> selectAccommodationImageUrlByAccommodationNo(String accommodationNo) {
        return accommodationMapper.selectAccommodationImageUrlByAccommodationNo(accommodationNo);
    }

    @Override
    public int updateAccommodationStatusForDelete(String accommodationNo) {
        return accommodationMapper.updateAccommodationStatusForDelete(accommodationNo);
    }


}
