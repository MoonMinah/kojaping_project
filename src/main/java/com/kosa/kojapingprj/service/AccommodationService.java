package com.kosa.kojapingprj.service;

import com.kosa.kojaping.entity.Accommodation;
import com.kosa.kojaping.entity.Location;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface AccommodationService {
    public List<Accommodation> selectAccommodationByMemberNo(String memberNo);

    public List<Accommodation> getAllAccommodations();

    public void registerAccommodation(Accommodation accommodation, List<MultipartFile> imageFiles, String uploadDir, String sessionId);

    public List<String> selectAccommodationImageUrlByAccommodationNo(String accommodationNo);

    Accommodation findAccommodationByNo(String accommodationNo);

    public Location LocationByNo(long locationNo);

    List<Accommodation> findByAddressAndMaxGuest(String address, int maxGuest);



    public int updateAccommodationStatusForDelete(String accommodationNo);
}
