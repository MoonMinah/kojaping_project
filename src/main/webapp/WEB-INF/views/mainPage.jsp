<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Main</title>
    <!-- Date Range Picker CSS -->
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
    <!-- jQuery -->
    <script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
    <!-- Date Range Picker JS -->
    <script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap');

        /* 전체 레이아웃 스타일 */
        body {
            font-family: 'Do Hyeon', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background: url('https://static.yeogi.com/_next/static/media/05_Kv_PC_Light.3deeaa46.webp') no-repeat center center fixed; /* 배경 이미지 */
            background-size: cover; /* 화면에 맞춰 배경 이미지 크기 조정 */
        }

        header {
            background-color: #ffffff;
            padding: 20px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.1);
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        header h1 {
            margin: 0;
            font-size: 32px;
            color: #ff5a5f;
            font-weight: bold;
        }

        /* 드롭다운 메뉴 스타일 */
        .dropdown {
            position: relative;
            display: inline-block;
        }

        .dropbtn {
            background-color: #ff5a5f;
            color: white;
            padding: 12px 25px;
            font-size: 16px;
            border: none;
            border-radius: 25px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .dropbtn:hover {
            background-color: #ff3a3f;
        }

        .dropdown-content {
            display: none;
            position: absolute;
            right: 0;
            background-color: #ffffff;
            min-width: 160px;
            box-shadow: 0px 8px 16px rgba(0,0,0,0.2);
            border-radius: 8px;
            z-index: 1;
        }

        .dropdown-content a {
            color: #333333;
            padding: 12px 16px;
            text-decoration: none;
            display: block;
            transition: background-color 0.2s ease;
        }

        .dropdown-content a:hover {
            background-color: #f1f1f1;
        }

        .dropdown:hover .dropdown-content {
            display: block;
        }

        /* 검색 바 스타일 */
        .search-bar {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 20px;
            border-radius: 50px;
            background-color: #ffffff;
            box-shadow: 0px 4px 12px rgba(0, 0, 0, 0.1);
            max-width: 900px;
            margin: 200px auto 40px; /* 상단에 추가 마진 적용 */
            width: 80%;
            transition: transform 0.3s ease, width 0.3s ease;
            transform: scale(0.95);
        }

        .search-bar:hover {
            transform: scale(1);
            width: 90%;
        }

        .search-option {
            flex-grow: 1;
            padding: 10px;
            text-align: center;
            position: relative;
        }

        .search-option label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            font-size: 18px;
            color: #555555;
        }

        .search-option input {
            border: 1px solid #ccc;
            background-color: #f9f9f9;
            outline: none;
            padding: 10px;
            width: 100%;
            height: 48px;
            border-radius: 25px;
            font-size: 16px;
            box-sizing: border-box;
            text-align: center;
            transition: border 0.3s ease, box-shadow 0.3s ease;
        }

        .search-option input:focus {
            border: 1px solid #ff5a5f;
            box-shadow: 0 0 5px rgba(255, 90, 95, 0.5);
        }

        .search-btn {
            background-color: #ff5a5f;
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 50px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            height: 48px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 16px;
        }

        .search-btn:hover {
            background-color: #ff3a3f;
        }

        /* 팝업 메뉴 스타일 */
        .popup {
            display: none;
            position: absolute;
            background-color: white;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
            padding: 15px;
            border-radius: 10px;
            z-index: 1000;
            top: 100%;
            left: 0;
            width: 100%;
            box-sizing: border-box;
        }

        .popup.show {
            display: block;
        }

        .guest-option {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 0;
            border-bottom: 1px solid #eaeaea;
        }

        .guest-option:last-child {
            border-bottom: none;
        }

        .guest-option label {
            font-size: 16px;
            color: #555555;
        }

        .guest-option button {
            background-color: #f1f1f1;
            border: none;
            border-radius: 50%;
            width: 30px;
            height: 30px;
            text-align: center;
            font-size: 18px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .guest-option button:hover {
            background-color: #e0e0e0;
        }

        .guest-option span {
            font-size: 16px;
            padding: 0 10px;
            color: #333333;
        }

        /* 반응형 디자인 */
        @media (max-width: 768px) {
            .search-bar {
                flex-direction: column;
                width: 90%;
            }

            .search-option {
                width: 100%;
                margin-bottom: 15px;
            }

            .search-btn {
                width: 100%;
            }
        }
    </style>
</head>
<body>
<header>
    <h1>Kojaping</h1>
    <div class="dropdown">
        <button class="dropbtn">메뉴</button>
        <div class="dropdown-content">
            <c:choose>
                <c:when test="${not empty loginMember}">
                    <a href="/guest/mypage">마이페이지</a>
                    <a href="/logout">로그아웃</a>
                </c:when>
                <c:otherwise>
                    <a href="/loginForm">로그인</a>
                    <a href="/signupForm">회원가입</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</header>

<form class="search-bar mx-auto" action="/selectRoom" method="GET">
    <div class="search-option">
        <label>여행지</label>
        <input type="text" placeholder="여행지 검색" name="address" id="destination" value="${accommodations.address}">
    </div>
    <div class="search-option">
        <label>체크인</label>
        <input type="text" placeholder="날짜 추가" name="checkIn" id="checkin" value="${accommodations.checkIn}">
    </div>
    <div class="search-option">
        <label>체크아웃</label>
        <input type="text" placeholder="날짜 추가" name="checkOut" id="checkout" value="${accommodations.checkOut}">
    </div>
    <div class="search-option">
        <label>여행자</label>
        <!-- 게스트 수를 표시하는 입력 필드에서 readonly 속성 제거 -->
        <input type="number" placeholder="0명" name="maxGuest" id="guest" value="${accommodations.maxGuest != null ? accommodations.maxGuest : 0}">
        <!-- 숨겨진 필드에 실제 숫자를 저장 -->
        <input type="hidden" name="count" id="guestCount" value="${accommodations.maxGuest != null ? accommodations.maxGuest : 0}">

        <!-- 팝업 메뉴 -->
        <div id="guest-popup" class="popup">
            <div class="guest-option">
                <label>성인</label>
                <button class="minus-btn" id="person-minus">-</button>
                <span id="person-count">${accommodations.maxGuest != null ? accommodations.maxGuest : '0'}</span>
                <button class="plus-btn" id="person-plus">+</button>
            </div>
        </div>
    </div>
    <input type="submit" class="search-btn" value="검색">
</form>

<script type="text/javascript">
    $(function() {
        $('#checkin').daterangepicker({
            singleDatePicker: true,
            locale: {
                format: 'YYYY-MM-DD',
                applyLabel: "적용",
                cancelLabel: "취소",
                daysOfWeek: ["일", "월", "화", "수", "목", "금", "토"],
                monthNames: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
                firstDay: 1
            },
            minDate: moment().startOf('day'),
        });

        $('#checkout').daterangepicker({
            singleDatePicker: true,
            locale: {
                format: 'YYYY-MM-DD',
                applyLabel: "적용",
                cancelLabel: "취소",
                daysOfWeek: ["일", "월", "화", "수", "목", "금", "토"],
                monthNames: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
                firstDay: 1
            },
            minDate: moment().startOf('day'),
        });
    });

    document.getElementById("guest").addEventListener("click", function() {
        document.getElementById("guest-popup").classList.toggle("show");
    });

    // 초기값 설정
    let personCount = ${param.count != null ? param.count : 0};

    // 플러스 버튼 클릭 이벤트
    document.getElementById("person-plus").addEventListener("click", function(event) {
        event.preventDefault();  // 기본 동작 방지
        personCount++;  // 카운트 증가
        document.getElementById("person-count").innerText = personCount;  // 화면에 카운트 표시
        updateGuestText();  // 텍스트 필드 업데이트
    });

    // 마이너스 버튼 클릭 이벤트
    document.getElementById("person-minus").addEventListener("click", function(event) {
        event.preventDefault();  // 기본 동작 방지
        if (personCount > 0) {  // 카운트가 0 이상일 때만 감소
            personCount--;
            document.getElementById("person-count").innerText = personCount;  // 화면에 카운트 표시
            updateGuestText();  // 텍스트 필드 업데이트
        }
    });

    // 숫자 입력 필드의 값이 변경되었을 때 처리
    document.getElementById("guest").addEventListener("input", function() {
        let guestInput = document.getElementById("guest").value;
        // 숫자가 아닐 경우 처리
        if (isNaN(guestInput) || guestInput < 0) {
            guestInput = 0;
        }
        personCount = parseInt(guestInput, 10);
        document.getElementById("person-count").innerText = personCount;  // 화면에 카운트 표시
        updateGuestText();  // 텍스트 필드 업데이트
    });

    // 입력 필드와 숨겨진 필드를 업데이트하는 함수
    function updateGuestText() {
        document.getElementById("guest").value = personCount;
        document.getElementById("guestCount").value = personCount; // 숨겨진 필드 값 업데이트
    }

    // 클릭 외부 영역 클릭 시 팝업 닫기
    window.onclick = function(event) {
        if (!event.target.matches('.dropbtn') && !event.target.closest('#guest-popup')) {
            var dropdowns = document.getElementsByClassName("popup");
            for (var i = 0; i < dropdowns.length; i++) {
                var openDropdown = dropdowns[i];
                if (openDropdown.classList.contains('show')) {
                    openDropdown.classList.remove('show');
                }
            }
        }
    }
</script>
</body>
</html>
