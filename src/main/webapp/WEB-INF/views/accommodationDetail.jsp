<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="ko">
<head>
  <title>숙소 상세 페이지</title>
  <!-- Bootstrap 추가 -->
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <style>
    .price-old {
      text-decoration: line-through;
      color: red;
    }
    .price-new {
      font-weight: bold;
      color: #30b127;
    }
    .room-images img {
      width: 100%;
      height: auto;
    }
    .reservation-box {
      border: 1px solid #ddd;
      padding: 20px;
      border-radius: 10px;
      background-color: #f9f9f9;
    }
  </style>
</head>
<body>
<div class="container">
  <!-- 이미지 슬라이드 -->
  <div class="room-images my-4">
    <div id="roomImagesCarousel" class="carousel slide" data-ride="carousel">
      <div class="carousel-inner">
        <!-- 첫 번째 이미지 active 처리 -->
        <c:forEach var="imageUrl" items="${accommodation.imageUrls}" varStatus="status">
          <div class="carousel-item ${status.index == 0 ? 'active' : ''}">
            <img src="${imageUrl}" class="d-block w-100" alt="숙소 이미지 ${status.index + 1}">
          </div>
        </c:forEach>
      </div>

      <!-- 슬라이드 제어 버튼 -->
      <a class="carousel-control-prev" href="#roomImagesCarousel" role="button" data-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="sr-only">Previous</span>
      </a>
      <a class="carousel-control-next" href="#roomImagesCarousel" role="button" data-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="sr-only">Next</span>
      </a>
    </div>
  </div>

  <!-- 숙소 설명과 예약 정보 -->
  <div class="row">
    <div class="col-md-8">
      <h1>${accommodation.title}</h1>
      <p>설명: ${accommodation.description}</p>
      <p>주소: ${accommodation.address}, ${accommodation.detailAddress}</p>
      <p>위치: ${location.locationName}</p>
      <p>침실 수: ${accommodation.bedroomCnt}</p>
      <p>최대 게스트 수: ${accommodation.maxGuest}</p>
      <p>에어컨, 와이파이, 전용 욕실 포함</p>
    </div>

    <div class="col-md-4 reservation-box">
      <h3>가격</h3>

      <p> <span class="price-new"><fmt:formatNumber value="${accommodation.pricePerNight}" minFractionDigits="0"/>원</span> / 박</p>

      <h3>예약 정보</h3>
      <form action="reservation" method="post" <%--onsubmit="return checkLogin('${sessionId}')"--%>>
        <input type="hidden" name="accommodationNo" value="${accommodation.accommodationNo}">
        체크인 날짜: <input type="date" name="checkin" class="form-control"><br>
        체크아웃 날짜: <input type="date" name="checkout" class="form-control"><br>
        인원 선택:
        <select name="guests" class="form-control">
          <option value="1">게스트 1명</option>
          <option value="2">게스트 2명</option>
          <option value="3">게스트 3명</option>
          <option value="4">게스트 4명</option>
          <!-- 추가 옵션 -->
        </select><br>
        <button type="submit" class="btn btn-primary btn-block">예약하기</button>
      </form>
    </div>
  </div>
</div>
<script>
  /*function checkLogin(isLoggedIn) {
    console.log("로그인된 사용자 : " + isLoggedIn);
    if (!isLoggedIn) {
      if (confirm("로그인이 필요합니다. 로그인 페이지로 이동하시겠습니까?")) {
        window.location.href = '/loginForm?redirect=' + encodeURIComponent(window.location.href);
        return false; // 폼 제출을 중단하고 로그인 페이지로 이동
      } else {
        return false; // 폼 제출 중단
      }
    }
    return true; // 로그인된 상태이면 폼 제출
  }*/
</script>


<!-- Bootstrap JS 추가 -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
