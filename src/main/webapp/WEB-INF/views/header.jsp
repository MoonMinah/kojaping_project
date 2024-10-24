<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%><!-- JSTL -->

<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Product List</title>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
  <link rel="stylesheet" href="path-to-fontawesome.css"> <!-- FontAwesome for icons -->
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
      font-family: 'Do Hyeon', sans-serif;
      margin: 0;
      padding: 0;
      background-color: #f5f5f5;
    }

    header {
      font-family: 'Do Hyeon', sans-serif;
      background-color: #ffffff;
      padding: 20px 40px;
      display: flex;
      justify-content: space-between; /* 로고와 메뉴를 양쪽에 배치 */
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

    header h1 a {
      color: #ff5a5f;
      text-decoration: none;
      transition: color 0.3s ease;
    }

   header h1 a:hover {
      color: #ff3a3f;
    }

    /* 드롭다운 메뉴 스타일 */
    .dropdown {
      position: relative;
      display: inline-block;
    }

    .dropbtn {
      background-color: #ff5a5f;
      color: white;
      padding: 10px 20px;
      font-size: 16px;
      border: none;
      border-radius: 20px;
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
      box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.2);
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
      width: 100%; /* 검색바가 헤더 너비만큼 채우도록 설정 */
      transition: transform 0.3s ease, width 0.3s ease;
    }

    .search-bar:hover {
      transform: scale(1);
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
      font-size: 14px;
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

    /* 팝업 메뉴 스타일 */
    #location-popup {
      display: none;
      position: absolute;
      background-color: white;
      box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
      padding: 20px;
      border-radius: 10px;
      z-index: 1000;
      top: 100%;
      left: 0;
      width: 80%;  /* 팝업 창을 넓게 */
      max-height: 400px;
      overflow-y: auto;
      box-sizing: border-box;
    }

    #location-popup.show {
      display: block;
    }

    .location-list {
      display: flex;
      flex-wrap: wrap; /* 여러 줄로 나누기 */
      justify-content: flex-start; /* 왼쪽 정렬 */
      gap: 10px; /* 항목 사이에 간격 추가 */
    }

    .location-item {
      flex: 1 1 20%; /* 각 항목이 전체 너비의 20%를 차지 */
      max-width: calc(25%); /* 4개씩 배치되도록 너비 설정 */
      margin: 5px 0;
      padding: 10px;
      cursor: pointer;
      text-align: center;
      background-color: #f1f1f1;
      border-radius: 8px;
      transition: background-color 0.3s ease;
    }

    .location-item:hover {
      background-color: #e0e0e0;
    }

    .location-title {
      font-size: 18px;
      font-weight: bold;
      margin-bottom: 10px;
      text-align: center;
    }

    hr{
      text-align: center;
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

    .product-card {
      border: 1px solid #ddd;
      border-radius: 5px;
      margin: 20px;
      padding: 20px;
      background-color: #f9f9f9;
      transition: box-shadow 0.3s ease;
    }

    .product-card:hover {
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }

    /* 인기 장소 스타일 */
    #popular-places {
      margin-top: 50px;
    }

    #popular-places h2 {
      margin-bottom: 40px;
      font-size: 28px;
    }

    .card-img-top {
      width: 100%;
      height: auto;
    }

    .card-title {
      font-size: 20px;
      font-weight: bold;
    }

    .card-text {
      font-size: 14px;
      color: gray;
    }

    .card a {
      color: blue;
      text-decoration: none;
      font-size: 14px;
    }

    .card a:hover {
      text-decoration: underline;
    }

    .float-right {
      float: right;
    }
  </style>

  <!-- jQuery를 로드합니다. -->
<%--  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>--%>
  <script>
    $(document).ready(function() {
      $('#searchAddress').on('input', function() {
        var query = $(this).val();
        if (query.length >= 1) {
          $.ajax({
            url: '/searchAddress',  // 검색 요청을 보낼 URL
            method: 'GET',
            data: { query: query },
            success: function(data) {
              $('#address-popup').html('');  // 기존 내용을 비움
              $.each(data, function(index, address) {
                $('#address-popup').append('<div>' + address + '</div>');  // 결과 추가
              });
              $('#address-popup').show();
            }
          });
        } else {
          $('#address-popup').hide();  // 입력이 없으면 팝업 닫음
        }
      });

      $.ajax({
        url: "/guest/guestInfo",
        method: 'GET',
        success: function(sessionId) {
          if (sessionId) {
            // 세션 ID가 존재하는 경우에 마이페이지와 로그아웃을 보여줌
            $('.dropdown-content').html('<a href="/guest/mypage">마이페이지</a><a href="/logout">로그아웃</a>');
          } else {
            // 세션 ID가 없는 경우에 로그인과 회원가입을 보여줌
            $('.dropdown-content').html('<a href="/loginForm">로그인</a><a href="/signupForm">회원가입</a>');
          }
        },
        error: function() {
          console.log("Failed to fetch session information.");
        }
      })
    });

    function searchAddress() {
      var query = document.getElementById("addressQuery").value;
      $.ajax({
        url: '/accommodations/searchAddress',
        type: 'GET',
        data: { query: query },
        success: function(data) {
          // 검색 결과 처리
          console.log(data);
        }
      });
    }
  </script>

</head>

<body>

<header>
  <h1><a href="/">Kojaping</a></h1>
  <!-- 검색바를 중앙에 배치 -->
  <form class="search-bar" action="/selectRoom" method="GET">
    <div class="search-option">
      <label>여행지</label>
      <input type="text" placeholder="여행지 검색" name="destination" id="destination" value="${param.destination}">
      <div id="location-popup" class="popup">
        <div class="location-title">여행지</div>
        <hr>
        <div class="location-list">
          <c:forEach var="location" items="${locations}">
            <div class="location-item" onclick="selectLocation('${location.locationName}')">${location.locationName}</div>
          </c:forEach>
        </div>
      </div>
    </div>
    <div class="search-option">
      <label>체크인</label>
      <input type="text" placeholder="날짜 추가" name="checkIn" id="checkin" value="${param.checkIn}">
    </div>
    <div class="search-option">
      <label>체크아웃</label>
      <input type="text" placeholder="날짜 추가" name="checkOut" id="checkout" value="${param.checkOut}">
    </div>
    <div class="search-option">
      <label>여행자</label>
      <input type="text" placeholder="게스트 추가" name="count" id="guest" readonly value="${param.count}">
      <div id="guest-popup" class="popup">
        <div class="guest-option">
          <label>성인</label>
          <button class="minus-btn" id="person-minus">-</button>
          <span id="person-count">${param.count != null ? param.count : '0'}</span>
          <button class="plus-btn" id="person-plus">+</button>
        </div>
      </div>
    </div>
    <input type="submit" class="search-btn" value="검색">
  </form>
  <div class="dropdown">
    <button class="dropbtn">메뉴</button>
    <div class="dropdown-content">
      <c:choose>
        <c:when test="${not empty pageContext.request.userPrincipal}">
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