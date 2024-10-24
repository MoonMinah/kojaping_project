<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>

<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Guest MyPage</title>

  <!-- Bootstrap CSS -->
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

  <!-- Font Awesome for icons -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">

  <style>
    @import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap');

    /* 전체 레이아웃 스타일 */
    body {
      font-family: 'Do Hyeon', Tahoma, Geneva, Verdana, sans-serif;
      margin: 0;
      padding: 0;
      background-color: #f5f5f5;
    }

    /* 사이드바 고정 스타일 */
    #sidebar {
      width: 250px;
      background: #343a40;
      color: #fff;
      height: 100vh; /* 전체 뷰포트 높이만큼 */
      position: fixed; /* 고정 위치 설정 */
      top: 0;
      left: 0;
      padding: 20px;
      box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
      display: flex;
      flex-direction: column;
      align-items: center;
    }

    /* h3 태그를 링크로 변경하여 누르면 '/'로 이동 */
    #sidebar h3 {
      margin-bottom: 40px;
      font-weight: bold;
      font-size: 26px;
      text-align: center;
    }

    #sidebar h3 a {
      color: #ff5a5f;
      text-decoration: none;
      transition: color 0.3s ease;
    }

    #sidebar h3 a:hover {
      color: #ff3a3f;
    }

    .list-unstyled {
      list-style: none;
      padding: 0;
      width: 100%;
      text-align: center;
    }

    /* 메뉴 항목 간 간격을 30px로 설정 */
    .list-unstyled li {
      margin-bottom: 30px;
    }

    /* 메뉴 항목 글씨 크기 조정 */
    .list-unstyled li a {
      color: #fff;
      text-decoration: none;
      display: block;
      padding: 10px 20px;
      border-radius: 8px;
      transition: background-color 0.3s ease, color 0.3s ease;
      font-size: 18px;
    }

    .list-unstyled li a:hover {
      background-color: #ff5a5f;
      color: #fff;
    }

    /* 선택된 메뉴에 강조 스타일 추가 */
    .list-unstyled li.active a {
      background-color: #ff5a5f;
      color: #fff;
    }

    /* 아이콘 크기 조정 */
    .list-unstyled li a i {
      margin-right: 10px;
      font-size: 20px;
    }

    /* 사이드바 하단 여백 확보 */
    #sidebar .sidebar-footer {
      margin-top: auto;
      padding-top: 20px;
      text-align: center;
    }
  </style>
</head>
<body>
<div class="wrapper">
  <!-- 사이드바 -->
  <nav id="sidebar">
    <div class="sidebar-header">
      <!-- h3 태그에 링크 적용하여 '/'로 이동 -->
      <h3><a href="/">Guest Page</a></h3>
    </div>
    <ul class="list-unstyled components">
      <li>
        <a href="/guest/mypage"><i class="fas fa-home"></i> Home</a>
      </li>
      <li>
        <a href="/guest/mypage/myInfo"><i class="fas fa-user-circle"></i> 회원정보수정</a>
      </li>
      <li>
        <a href="/guest/mypage/myReservation"><i class="fas fa-calendar-check"></i> 나의 예약 현황</a>
      </li>
    </ul>
    <!-- 로그아웃 버튼을 하단에 배치 -->
    <div class="sidebar-footer">
      <a href="/logout" class="btn btn-danger"><i class="fas fa-sign-out-alt"></i> 로그아웃</a>
    </div>
  </nav>
</div>
</body>
</html>
