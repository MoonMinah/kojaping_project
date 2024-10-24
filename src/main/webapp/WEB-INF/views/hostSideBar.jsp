<%--
  Created by IntelliJ IDEA.
  User: jihyun
  Date: 9/22/24
  Time: 5:29 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>

<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Host MyPage</title>

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

    .wrapper {
      display: flex;
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

    /* h3 태그 고정 */
    #sidebar h3 {
      color: #ff5a5f;
      margin-bottom: 40px;
      font-weight: bold;
      font-size: 26px;
      text-align: center;
    }

    .list-unstyled {
      list-style: none;
      padding: 0;
      width: 100%;
      text-align: center;
    }

    .list-unstyled li {
      margin-bottom: 30px;
    }

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

    .list-unstyled li.active a {
      background-color: #ff5a5f;
      color: #fff;
    }

    .list-unstyled li a i {
      margin-right: 10px;
      font-size: 20px;
    }

    #sidebar .sidebar-footer {
      margin-top: auto;
      padding-top: 20px;
      text-align: center;
    }
  </style>
</head>
<body>
<div class="wrapper">
  <nav id="sidebar">
    <div class="sidebar-header">
      <h3>Host Page</h3>
    </div>
    <ul class="list-unstyled components">
      <li>
        <a href="/host/hostPage"><i class="fas fa-home"></i> Home</a>
      </li>
      <li>
        <a href="/host/hostPage/myAccommodations"><i class="fas fa-user-circle"></i> 내가 등록한 숙소</a>
      </li>
      <li>
        <a href="/host/hostPage/location"><i class="fas fa-calendar-check"></i> 나의 숙소 등록</a>
      </li>
    </ul>
    <div class="sidebar-footer">
      <a href="/logout" class="btn btn-danger"><i class="fas fa-sign-out-alt"></i> 로그아웃</a>
    </div>
  </nav>
