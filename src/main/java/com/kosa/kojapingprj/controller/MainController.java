package com.kosa.kojapingprj.controller;


import com.kosa.kojaping.entity.*;
import com.kosa.kojaping.mapper.PaymentMapper;
import com.kosa.kojaping.service.*;
import jakarta.validation.Valid;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

@Slf4j
@Controller
public class MainController {
    @Autowired
    private MemberService memberService;

    @Autowired
    private ProductService productService;

    @Autowired
    private AccommodationService accommodationService;

    @Autowired
    private PaymentService paymentService;

    @Autowired
    private ReservationService reservationService;

    @Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;
    @Autowired
    private PaymentMapper paymentMapper;

    @GetMapping({"", "/"})
    public String mainPage(Model model) {
        String sessionId = SecurityContextHolder.getContext().getAuthentication().getName();

        Member resultMember = memberService.selectMemberByUserId(sessionId);

        productService.syncMySQLToElasticsearch();
        log.info("mainPage() : selectMemberByUserId() = {}", resultMember);

        model.addAttribute("loginMember", resultMember);

        return "mainPage";
    }

    @GetMapping("/loginForm")
    public String loginForm() {
        return "loginForm";
    }

    @GetMapping("/signupForm")
    public String signupForm(Model model) {
        model.addAttribute("member", new Member());

        return "signupForm";
    }

    @PostMapping("/signupOk")
    public String signupOk(@ModelAttribute @Valid Member member, Errors errors, Model model) {
        if(errors.hasErrors()) {
            model.addAttribute("member", member);

            Map<String, String> validatorResult = memberService.validateHandling(errors);
            for(String key : validatorResult.keySet()) {
                model.addAttribute(key, validatorResult.get(key));
            }

            model.addAttribute("roleNo", member.getRoleNo());
            log.info("roleNo = {}", member.getRoleNo());

            return "signupForm";
        }

        log.info("회원 가입 요청 : member = {}", member);

        member.setRoleNo(member.getRoleNo());
        member.setPassword(bCryptPasswordEncoder.encode(member.getPassword()));

        int resultMember = memberService.insertMember(member);
        log.info("signupOk() : resultMember = {}", resultMember);

        if(resultMember > 0) {
            return "redirect:/loginForm";
        }

        return "signupForm";
    }

    @GetMapping("/selectRoom")
    public String selectRoom(
            @RequestParam String address,
            @RequestParam String checkIn,
            @RequestParam String checkOut,
            @RequestParam int maxGuest,
            Model model
    ) {
        String sessionId = SecurityContextHolder.getContext().getAuthentication().getName();

        Member resultMember = memberService.selectMemberByUserId(sessionId);

        log.info("header() : selectMemberByUserId() = {}", resultMember);

        model.addAttribute("loginMember", resultMember);

        // 1. address, maxGuest, status를 기준으로 숙소 목록 조회
        List<Accommodation> accommodations = accommodationService.findByAddressAndMaxGuest(address, maxGuest);

        // 예약이 없는 숙소를 저장할 리스트
        List<Accommodation> availableAccommodations = new ArrayList<>();

        // 2. 해당 기간에 예약이 있는지 확인하여 필터링
        for (Accommodation accommodation : accommodations) {
            List<Reservation> reservations = reservationService.findByCheckInOut(accommodation.getAccommodationNo(), checkIn, checkOut);
            log.info("selectRoom() : findByCheckInOut() = {}", reservations);

            // 3. 예약이 없으면 availableAccommodations 리스트에 추가
            if (reservations.isEmpty()) {
                List<String> imageUrls = accommodationService.selectAccommodationImageUrlByAccommodationNo(accommodation.getAccommodationNo());
                accommodation.setImageUrls(imageUrls);
                availableAccommodations.add(accommodation);
            }
        }

        log.info("selectRoom() : availableAccommodations = {}", availableAccommodations);


        // 4. Model에 데이터 추가
        model.addAttribute("address", address);
        model.addAttribute("checkIn", checkIn);
        model.addAttribute("checkOut", checkOut);
        model.addAttribute("maxGuest", maxGuest);
        model.addAttribute("accommodations", availableAccommodations);

        //log.info("selectRoom() : availableAccommodations = {}", availableAccommodations);

        return "selectResult";
    }


    @GetMapping("/accommodationList")
    public String accommodation(Model model) {

        List<Accommodation> accommodations = accommodationService.getAllAccommodations();
        List<String> images = new ArrayList<>();
        // 각 숙소에 대한 이미지 조회
        for (Accommodation accommodation : accommodations) {

            images = accommodationService.selectAccommodationImageUrlByAccommodationNo(accommodation.getAccommodationNo());
            accommodation.setImageUrls(images); // DTO에 이미지 리스트 추가
            log.info("images = {}", images.toString());
        }

        log.info("accommodation() : " + accommodations.get(32).getImageUrls());
        log.info("숙소 : " + accommodations.toString());
        model.addAttribute("accommodations", accommodations);
        return "accommodationList"; //숙소목록
    }


    @GetMapping("/accommodationDetail")
    public String getAccommodationDetail(Model model, @RequestParam("accommodationNo") String accommodationNo) {
        // 숙소 정보 가져오기
        log.info("숙소 상세 페이지 - 숙소번호 : " + accommodationNo);
        Accommodation accommodation = accommodationService.findAccommodationByNo(accommodationNo);
        List<String>images = new ArrayList<>();

        images = accommodationService.selectAccommodationImageUrlByAccommodationNo(accommodation.getAccommodationNo());
        accommodation.setImageUrls(images);
        log.info("images = {}", images.toString());
        Location location = accommodationService.LocationByNo(accommodation.getLocationNo());

        log.info("숙소상세 페이지 - 숙소정보 : " + accommodation.toString());
        log.info("숙소상세 페이지 - 위치정보 : " + location.toString());
        // 모델에 데이터 추가
        model.addAttribute("accommodation", accommodation);
        model.addAttribute("location", location);

        return "accommodationDetail"; // 숙소 상세
    }

    @Secured("게스트")
    @PostMapping("/reservation")
    public String reservation(Model model, @RequestParam("accommodationNo") String accommodationNo, @RequestParam("checkin") String checkin, @RequestParam("checkout") String checkout
            ,@RequestParam("guests") String guests) {

        String sessionId = SecurityContextHolder.getContext().getAuthentication().getName();
        log.info("현재 로그인 된 사용자 : " + sessionId);
        Member resultMember = memberService.selectMemberByUserId(sessionId);

        Accommodation accommodation = accommodationService.findAccommodationByNo(accommodationNo);
        log.info("reservation : accommodation = {}", accommodation.toString());
        Location location = accommodationService.LocationByNo(accommodation.getLocationNo());
        System.out.println("체크인 : " + checkin);
        log.info("location = {}", location.toString());
        //예약 설정
        Reservation reservation = new Reservation();
        reservation.setMemberNo(resultMember.getMemberNo());
        reservation.setAccommodationNo(accommodation.getAccommodationNo());
        try {
            // String 형식을 Date로 변환한 후, 이를 Timestamp로 변환
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            SimpleDateFormat dateFormat1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String parsedLocalDateTimeNow = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
            Date parsedCheckin = dateFormat.parse(checkin);
            Date parsedCheckout = dateFormat.parse(checkout);
            // Date parsedCreateAt = dateFormat1.parse(parsedLocalDateTimeNow);

            // 일수 계산 (체크인 ~ 체크아웃 차이)
            long diffInMillies = Math.abs(parsedCheckout.getTime() - parsedCheckin.getTime());
            long diffDays = TimeUnit.DAYS.convert(diffInMillies, TimeUnit.MILLISECONDS); // 체크인-체크아웃의 일수 계산

            // 총 가격 계산 (일수 * 게스트 수 * 1박 비용)
            int guestCount = Integer.parseInt(guests);
            BigDecimal totalPrice = accommodation.getPricePerNight().multiply(BigDecimal.valueOf(diffDays))
                    .multiply(BigDecimal.valueOf(guestCount));
            // Date 객체를 Timestamp로 변환하여 예약에 설정
            reservation.setCheckIn(new Timestamp(parsedCheckin.getTime()));
            reservation.setCheckOut(new Timestamp(parsedCheckout.getTime()));
            reservation.setTotalPrice(totalPrice);
            // reservation.setCreatedAt(new Timestamp(parsedCreateAt.getTime()));
        } catch (ParseException e) {
            e.printStackTrace();
            return "error"; //  에러 페이지
        }
        /*String currentTimestampToString = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(checkin);
        String currentTimestampToString1 = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(checkout);
        reservation.setCheckIn(Timestamp.valueOf(currentTimestampToString));
        reservation.setCheckOut(Timestamp.valueOf(currentTimestampToString1));*/

        reservation.setReservationStatus("대기");  // 아직 확정되지 않은 상태로 처리
        // 결제 성공 후에 예약 번호를 확정할 것이므로 reservationNo는 결제 후에 생성

        log.info("결제 페이지 - 숙소정보 : " + accommodation.toString());
        log.info("결제 페이지 - 위치정보 : " + location.toString());

        // 결제 페이지로 모델 값 전달
        model.addAttribute("accommodation", accommodation);
        model.addAttribute("location", location);
        model.addAttribute("checkin", checkin);
        model.addAttribute("checkout", checkout);
        model.addAttribute("guests", guests);
        model.addAttribute("reservation", reservation); // reservation 정보 전달
        model.addAttribute("totalPrice", reservation.getTotalPrice()); // 총 가격 전달
        model.addAttribute("sessionId", sessionId);
        model.addAttribute("resultMember", resultMember);
        return "reservation";
    }

    @PostMapping("/paymentOk")
    public String paymentOk(@RequestParam Map<String, Object> params, Model model,
                            @ModelAttribute Payment payment,
                            @ModelAttribute Reservation reservation,
                            @ModelAttribute String sessionId) {
        log.info("결제 완료 데이터: " + params);
        sessionId = SecurityContextHolder.getContext().getAuthentication().getName();
        Member resultMember = memberService.selectMemberByUserId(sessionId);

        // 결제 성공 여부 확인
        if (params.get("paymentStatus").equals("성공")) {
            // 예약과 결제 정보를 처리하는 로직
            // hidden 필드로 넘겨받은 데이터를 사용하여 로직을 진행
            reservation.setReservationNo(params.get("reservationNo").toString());
            reservation.setMemberNo(params.get("memberNo").toString());
            reservation.setAccommodationNo(params.get("accommodationNo").toString());
            try {
                // String 형식을 Date로 변환한 후, 이를 Timestamp로 변환
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                SimpleDateFormat dateFormat1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                String parsedLocalDateTimeNow = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
                Date parsedCheckin = dateFormat.parse((String) params.get("checkin"));
                Date parsedCheckout = dateFormat.parse((String) params.get("checkout"));
                // Date 객체를 Timestamp로 변환하여 예약에 설정
                reservation.setCheckIn(new Timestamp(parsedCheckin.getTime()));
                reservation.setCheckOut(new Timestamp(parsedCheckout.getTime()));
                // reservation.setCreatedAt(new Timestamp(parsedCreateAt.getTime()));
            } catch (ParseException e) {
                e.printStackTrace();
                return "error"; //  에러 페이지
            }
            reservation.setTotalPrice(new BigDecimal(params.get("totalPrice").toString()));
            reservation.setReservationStatus("확정");

            log.info("예약 정보 - memberNo: " + reservation.getMemberNo());
            log.info("예약 정보 - accommodationNo: " + reservation.getAccommodationNo());
            // 결제 정보 처리
            payment.setReservationNo(reservation.getReservationNo());
            payment.setPaymentMethod(params.get("paymentMethod").toString());
            payment.setPaymentAmount(new BigDecimal(params.get("totalPrice").toString()));

            log.info("payment : " + payment.getPaymentAmount());
            // 예약과 결제 정보를 트랜잭션 처리
            String paymentId = paymentService.transactionInsert(reservation, payment);
            log.info("결제 및 예약 정보가 성공적으로 저장되었습니다: " + paymentId);
            // 결제 완료 정보 모델로 전달
            payment = paymentService.getPaymentDetail(paymentId);
            model.addAttribute("payment1", payment);
            model.addAttribute("reservationNo", reservation.getReservationNo());
            model.addAttribute("accommodationName", params.get("accommodationName"));
            model.addAttribute("pricePerNight", params.get("paid_amount"));
            model.addAttribute("paymentMethod", params.get("paymentMethod"));
            model.addAttribute("resultMember", resultMember);
        } else {
            log.error("결제에 실패했습니다.");
            return "error";  // 결제가 실패했을 경우 에러 페이지로 이동
        }

        return "redirect:/guest/mypage/myReservation";  // 메인으로 이동
    }

    @GetMapping("/guest/guestInfo")
    @ResponseBody
    public String guestInfo() {
        String sessionId = SecurityContextHolder.getContext().getAuthentication().getName();

        return sessionId;
    }

}
