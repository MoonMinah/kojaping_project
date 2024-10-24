package com.kosa.kojapingprj.controller;

import com.kosa.kojaping.entity.Accommodation;
import com.kosa.kojaping.entity.Member;
import com.kosa.kojaping.service.AccommodationService;
import com.kosa.kojaping.service.LocationService;
import com.kosa.kojaping.service.MemberService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;

@Slf4j
@Controller
@RequestMapping("/host")
public class HostController {
    @Autowired
    private MemberService memberService;

    @Autowired
    private AccommodationService accommodationService;

    @Autowired
    private LocationService locationService;

    @GetMapping("/hostPage")
    public String hostPage(Model model) {
        String sessionId = SecurityContextHolder.getContext().getAuthentication().getName();

        Member resultMember = memberService.selectMemberByUserId(sessionId);
        log.info("hostPage() : selectMemberByUserId() = {}", resultMember);

        List<Accommodation> resultAccommodation = accommodationService.selectAccommodationByMemberNo(resultMember.getMemberNo());
        log.info("hostPage() : selectAccommodationByMemberNo() = {}", resultAccommodation);

        for (Accommodation accommodation : resultAccommodation) {
            List<String> images = accommodationService.selectAccommodationImageUrlByAccommodationNo(accommodation.getAccommodationNo());
            accommodation.setImageUrls(images); // DTO에 이미지 리스트 추가
        }

        model.addAttribute("accommodations", resultAccommodation);

        return "hostPage";
    }

    @GetMapping("/hostPage/location")
    public String showLocationForm() {
        return "hostLocationForm";
    }

    @PostMapping("/hostPage/addLocation")
    public String addLocation(@ModelAttribute Accommodation accommodation, Model model) {
        String sessionId = SecurityContextHolder.getContext().getAuthentication().getName();

        String address = accommodation.getAddress();
        String locationName = address.substring(0, 2);

        Member resultMember = memberService.selectMemberByUserId(sessionId);
        log.info("addLocation() : selectMemberByUserId() = {}", resultMember);
        Long locationNo = locationService.selectLocationNoByLocationName(locationName);
        log.info("addLocation() : selectLocationNoByLocationName() = {}", locationNo);

        accommodation.setMemberNo(resultMember.getMemberNo());
        accommodation.setLocationNo(locationNo);

        model.addAttribute("postcode", accommodation.getPostcode());
        model.addAttribute("address", accommodation.getAddress());
        model.addAttribute("detailAddress", accommodation.getDetailAddress());
        model.addAttribute("extraAddress", accommodation.getExtraAddress());
        model.addAttribute("latitude", accommodation.getLatitude());
        model.addAttribute("longitude", accommodation.getLongitude());
        model.addAttribute("locationNo", accommodation.getLocationNo());
        model.addAttribute("memberNo", accommodation.getMemberNo());
        log.info("addLocation() : model = {}", model);

        String encodedAddress = URLEncoder.encode(accommodation.getAddress(), StandardCharsets.UTF_8);
        String encodedDetailAddress = URLEncoder.encode(accommodation.getDetailAddress(), StandardCharsets.UTF_8);
        String encodedExtraAddress = URLEncoder.encode(accommodation.getExtraAddress(), StandardCharsets.UTF_8);
        String redirectUrl = String.format("/host/hostPage/amenities?postcode=%s&address=%s&detailAddress=%s&extraAddress=%s&latitude=%s&longitude=%s&locationNo=%s&memberNo=%s",
                accommodation.getPostcode(),
                encodedAddress,
                encodedDetailAddress,
                encodedExtraAddress,
                accommodation.getLatitude(),
                accommodation.getLongitude(),
                accommodation.getLocationNo(),
                accommodation.getMemberNo());

        return "redirect:" + redirectUrl;
    }

    @GetMapping("/hostPage/amenities")
    public String showAmenitiesForm(@RequestParam String postcode,
                                    @RequestParam String address,
                                    @RequestParam String detailAddress,
                                    @RequestParam String extraAddress,
                                    @RequestParam BigDecimal latitude,
                                    @RequestParam BigDecimal longitude,
                                    @RequestParam Long locationNo,
                                    @RequestParam String memberNo,
                                    Model model) {
        model.addAttribute("postcode", postcode);
        model.addAttribute("address", address);
        model.addAttribute("detailAddress", detailAddress);
        model.addAttribute("extraAddress", extraAddress);
        model.addAttribute("latitude", latitude);
        model.addAttribute("longitude", longitude);
        model.addAttribute("locationNo", locationNo);
        model.addAttribute("memberNo", memberNo);
        log.info("showAmenitiesForm() : modelByAddLocation = {}", model);

        return "hostAmenitiesForm";
    }

    @PostMapping("/hostPage/addAmenities")
    public String addAmenities(@ModelAttribute Accommodation accommodation,
                               @RequestParam List<String> amenityName,
                               Model model) {
        log.info("addAmenities() : postcode={}, address={}, detailAddress={}, extraAddress={}, latitude={}, longitude={}, locationNo={}, memberNo={}, amenityName={}",
                accommodation.getPostcode(),
                accommodation.getAddress(),
                accommodation.getDetailAddress(),
                accommodation.getExtraAddress(),
                accommodation.getLatitude(),
                accommodation.getLongitude(),
                accommodation.getLocationNo(),
                accommodation.getMemberNo(),
                amenityName);

        model.addAttribute("amenityName", amenityName);
        model.addAttribute("postcode", accommodation.getPostcode());
        model.addAttribute("address", accommodation.getAddress());
        model.addAttribute("detailAddress", accommodation.getDetailAddress());
        model.addAttribute("extraAddress", accommodation.getExtraAddress());
        model.addAttribute("latitude", accommodation.getLatitude());
        model.addAttribute("longitude", accommodation.getLongitude());
        model.addAttribute("locationNo", accommodation.getLocationNo());
        model.addAttribute("memberNo", accommodation.getMemberNo());

        String amenities = URLEncoder.encode(String.join(",", amenityName), StandardCharsets.UTF_8);
        String encodedAddress = URLEncoder.encode(accommodation.getAddress(), StandardCharsets.UTF_8);
        String encodedDetailAddress = URLEncoder.encode(accommodation.getDetailAddress(), StandardCharsets.UTF_8);
        String encodedExtraAddress = URLEncoder.encode(accommodation.getExtraAddress(), StandardCharsets.UTF_8);
        String redirectUrl = String.format("/host/hostPage/settings?postcode=%s&address=%s&detailAddress=%s&extraAddress=%s&latitude=%s&longitude=%s&locationNo=%s&memberNo=%s&amenityName=%s",
                accommodation.getPostcode(), encodedAddress, encodedDetailAddress, encodedExtraAddress, accommodation.getLatitude(), accommodation.getLongitude(), accommodation.getLocationNo(), accommodation.getMemberNo(), amenities);

        return "redirect:" + redirectUrl;
    }

    @GetMapping("/hostPage/settings")
    public String showSettingsForm(@RequestParam String postcode,
                                   @RequestParam String address,
                                   @RequestParam String detailAddress,
                                   @RequestParam String extraAddress,
                                   @RequestParam BigDecimal latitude,
                                   @RequestParam BigDecimal longitude,
                                   @RequestParam Long locationNo,
                                   @RequestParam String memberNo,
                                   @RequestParam(required = false) List<String> amenityName,
                                   Model model) {
        model.addAttribute("postcode", postcode);
        model.addAttribute("address", address);
        model.addAttribute("detailAddress", detailAddress);
        model.addAttribute("extraAddress", extraAddress);
        model.addAttribute("latitude", latitude);
        model.addAttribute("longitude", longitude);
        model.addAttribute("locationNo", locationNo);
        model.addAttribute("memberNo", memberNo);
        model.addAttribute("amenityName", amenityName);
        log.info("showSettingsForm() : modelByAddAmenities = {}", model);

        return "hostSettingsForm";
    }

    @PostMapping("/hostPage/addSettings")
    public String addSettings(@ModelAttribute Accommodation accommodation,
                              @RequestParam(required = false) List<String> amenityName,
                              Model model) {
        model.addAttribute("postcode", accommodation.getPostcode());
        model.addAttribute("address", accommodation.getAddress());
        model.addAttribute("detailAddress", accommodation.getDetailAddress());
        model.addAttribute("extraAddress", accommodation.getExtraAddress());
        model.addAttribute("latitude", accommodation.getLatitude());
        model.addAttribute("longitude", accommodation.getLongitude());
        model.addAttribute("locationNo", accommodation.getLocationNo());
        model.addAttribute("memberNo", accommodation.getMemberNo());
        model.addAttribute("amenityName", amenityName);
        model.addAttribute("title", accommodation.getTitle());
        model.addAttribute("description", accommodation.getDescription());
        model.addAttribute("pricePerNight", accommodation.getPricePerNight());
        model.addAttribute("maxGuest", accommodation.getMaxGuest());
        model.addAttribute("bedroomCnt", accommodation.getBedroomCnt());
        model.addAttribute("bedCnt", accommodation.getBedCnt());
        model.addAttribute("bathCnt", accommodation.getBathCnt());
        log.info("addSettings() : model = {}", model);

        String amenities = URLEncoder.encode(String.join(",", amenityName), StandardCharsets.UTF_8);
        String encodedAddress = URLEncoder.encode(accommodation.getAddress(), StandardCharsets.UTF_8);
        String encodedDetailAddress = URLEncoder.encode(accommodation.getDetailAddress(), StandardCharsets.UTF_8);
        String encodedExtraAddress = URLEncoder.encode(accommodation.getExtraAddress(), StandardCharsets.UTF_8);
        String encodedTitle = URLEncoder.encode(accommodation.getTitle(), StandardCharsets.UTF_8);
        String encodedDescription = URLEncoder.encode(accommodation.getDescription(), StandardCharsets.UTF_8);
        String redirectUrl = String.format("/host/hostPage/photos?postcode=%s&address=%s&detailAddress=%s&extraAddress=%s&latitude=%s&longitude=%s&locationNo=%s&memberNo=%s&amenityName=%s&title=%s&description=%s&pricePerNight=%s&maxGuest=%s&bedroomCnt=%s&bedCnt=%s&bathCnt=%s",
                accommodation.getPostcode(), encodedAddress, encodedDetailAddress, encodedExtraAddress, accommodation.getLatitude(), accommodation.getLongitude(), accommodation.getLocationNo(), accommodation.getMemberNo(), amenities, encodedTitle, encodedDescription, accommodation.getPricePerNight(), accommodation.getMaxGuest(), accommodation.getBedroomCnt(), accommodation.getBedCnt(), accommodation.getBathCnt());

        return "redirect:" + redirectUrl;
    }

    @GetMapping("/hostPage/photos")
    public String showPhotosForm(@RequestParam String postcode,
                                 @RequestParam String address,
                                 @RequestParam String detailAddress,
                                 @RequestParam String extraAddress,
                                 @RequestParam BigDecimal latitude,
                                 @RequestParam BigDecimal longitude,
                                 @RequestParam Long locationNo,
                                 @RequestParam String memberNo,
                                 @RequestParam(required = false) List<String> amenityName,
                                 @RequestParam String title,
                                 @RequestParam String description,
                                 @RequestParam BigDecimal pricePerNight,
                                 @RequestParam int maxGuest,
                                 @RequestParam int bedroomCnt,
                                 @RequestParam int bedCnt,
                                 @RequestParam int bathCnt,
                                 Model model) {
        model.addAttribute("postcode", postcode);
        model.addAttribute("address", address);
        model.addAttribute("detailAddress", detailAddress);
        model.addAttribute("extraAddress", extraAddress);
        model.addAttribute("latitude", latitude);
        model.addAttribute("longitude", longitude);
        model.addAttribute("locationNo", locationNo);
        model.addAttribute("memberNo", memberNo);
        model.addAttribute("amenityName", amenityName);
        model.addAttribute("title", title);
        model.addAttribute("description", description);
        model.addAttribute("pricePerNight", pricePerNight);
        model.addAttribute("maxGuest", maxGuest);
        model.addAttribute("bedroomCnt", bedroomCnt);
        model.addAttribute("bedCnt", bedCnt);
        model.addAttribute("bathCnt", bathCnt);
        log.info("showPhotosForm() : modelByAddSettings = {}", model);

        return "hostPhotosForm";
    }

    @PostMapping("/hostPage/addPhotos")
    public String addPhotos(@ModelAttribute Accommodation accommodation,
                            @RequestParam("images") List<MultipartFile> imageFiles,
                            Model model) throws IOException {
        log.info("accommodation = {}", accommodation);

        // 이미지 저장 경로 설정 및 이미지 저장 처리
        String sessionId = SecurityContextHolder.getContext().getAuthentication().getName();
        String uploadDir = System.getProperty("user.dir") + "/src/main/webapp/WEB-INF/views/images/host/" + sessionId + "/";

        // 폴더가 존재하지 않으면 생성
        File dir = new File(uploadDir);
        if (!dir.exists()) {
            boolean dirCreated = dir.mkdirs();  // 다중 디렉토리 생성
            if (dirCreated) {
                log.info("폴더가 생성되었습니다: " + uploadDir);
            } else {
                log.error("폴더 생성 실패: " + uploadDir);
                throw new IOException("폴더 생성에 실패했습니다.");
            }
        }

        log.info("imageFiles의 사이즈 : " + imageFiles.size());


        // 트랜잭션 처리. 숙소정보등록과 사진정보 등록.
        accommodationService.registerAccommodation(accommodation, imageFiles, uploadDir, sessionId);

        for(int i = 0; i < imageFiles.size(); i++) {
            log.info("imageFiles" + i + " : " + imageFiles.get(i).getOriginalFilename());
        }

        log.info("Image URLs: " + accommodation.getImageUrls());

        List<String> resultAccommodationImage = accommodationService.selectAccommodationImageUrlByAccommodationNo(accommodation.getAccommodationNo());
        accommodation.setImageUrls(resultAccommodationImage);

        model.addAttribute("accommodation", accommodation);


        return "redirect:/host/hostPage/myAccommodations";
    }

    @GetMapping("/hostPage/myAccommodations")
    public String showMyAccommodationList(Model model) {
        String sessionId = SecurityContextHolder.getContext().getAuthentication().getName();

        Member resultMember = memberService.selectMemberByUserId(sessionId);
        log.info("showMyAccommodationList() : selectMemberByUserId() = {}", resultMember);

        List<Accommodation> resultAccommodation = accommodationService.selectAccommodationByMemberNo(resultMember.getMemberNo());
        // 각 숙소에 대한 이미지 조회
        for (Accommodation accommodation : resultAccommodation) {
            List<String> images = accommodationService.selectAccommodationImageUrlByAccommodationNo(accommodation.getAccommodationNo());
            accommodation.setImageUrls(images); // DTO에 이미지 리스트 추가
        }

        log.info("showMyAccommodationList() : selectAccommodationByMemberNo() = {}", resultAccommodation);


        model.addAttribute("accommodations", resultAccommodation);

        return "myAccommodationList";
    }

    @GetMapping("/hostPage/delete")
    public String deleteAccommodation(@RequestParam("accommodationNo") String accommodationNo, Model model) {
        int resultAccommodationSuccess = accommodationService.updateAccommodationStatusForDelete(accommodationNo);
        log.info("deleteAccommodation() : updateAccommodationStatusForDelete() = {}", resultAccommodationSuccess);

        String sessionId = SecurityContextHolder.getContext().getAuthentication().getName();
        Member resultMember = memberService.selectMemberByUserId(sessionId);
        log.info("deleteAccommodation() : selectMemberByUserId() = {}", resultMember);

        List<Accommodation> resultAccommodation = accommodationService.selectAccommodationByMemberNo(resultMember.getMemberNo());
        log.info("deleteAccommodation() : selectAccommodationByMemberNo() = {}", resultAccommodation);

        for(Accommodation accommodation : resultAccommodation) {
            List<String> images = accommodationService.selectAccommodationImageUrlByAccommodationNo(accommodation.getAccommodationNo());
            accommodation.setImageUrls(images);
        }

        model.addAttribute("accommodations", resultAccommodation);
        model.addAttribute("message", "숙소가 삭제되었습니다.");

        return "myAccommodationList";
    }
}
