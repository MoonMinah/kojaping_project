<%--
  Created by IntelliJ IDEA.
  User: jihyun
  Date: 9/19/24
  Time: 12:49 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>회원가입</title>
  <style>
    @import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap');

    body {
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
      margin: 0;
      font-family: 'Do Hyeon', sans-serif;
      background: linear-gradient(135deg, #ff9a9e 0%, #ff5a5f 100%);
    }

    .form-container {
      background-color: white;
      padding: 50px;
      border-radius: 15px;
      box-shadow: 0 8px 24px rgba(0, 0, 0, 0.2);
      width: 400px;
    }

    h1 {
      margin-bottom: 40px;
      font-size: 32px;
      color: #333;
      text-align: center;
    }

    .form-section {
      display: none;
    }

    .form-section.active {
      display: block;
    }

    input[type="text"], input[type="password"], input[type="email"], input[type="tel"] {
      width: 100%; /* 입력 필드 너비를 버튼과 동일하게 100%로 설정 */
      padding: 16px;
      margin: 12px 0;
      border: 1px solid #ddd;
      border-radius: 5px;
      font-size: 16px;
      box-sizing: border-box;
      transition: border-color 0.3s ease-in-out;
    }

    input[type="text"]:focus, input[type="password"]:focus, input[type="email"]:focus, input[type="tel"]:focus {
      border-color: #ff5a5f;
    }

    input[type="submit"], input[type="reset"] {
      width: 100%; /* 버튼의 너비를 100%로 설정 */
      padding: 16px;
      background-color: #ff5a5f;
      color: white;
      border: none;
      border-radius: 5px;
      cursor: pointer;
      font-size: 18px;
      margin-top: 20px;
      transition: background-color 0.3s ease-in-out;
    }

    input[type="submit"]:hover, input[type="reset"]:hover {
      background-color: #e04b52;
    }

    .toggle-container {
      display: flex;
      justify-content: space-between;
      margin-bottom: 30px;
      background-color: #ddd;
      border-radius: 50px;
      position: relative;
      padding: 5px;
    }

    .toggle-btn {
      flex: 1;
      padding: 12px 0;
      text-align: center;
      cursor: pointer;
      position: relative;
      z-index: 1;
      font-size: 18px;
      transition: color 0.3s ease-in-out;
    }

    .toggle-btn.active {
      color: white;
    }

    .slider {
      position: absolute;
      top: 0;
      left: 0;
      width: 50%;
      height: 100%;
      background-color: #ff5a5f;
      border-radius: 50px;
      transition: transform 0.3s ease-in-out;
      z-index: 0;
    }

    #hostButton.active ~ .slider {
      transform: translateX(100%);
    }

    .error-message {
      color: red;
      font-size: 14px;
      margin-top: 5px;
    }

    .hidden {
      display: none;
    }
  </style>
  <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
  <script>
    $(document).ready(function() {
      // 기본 게스트 폼 활성화
      $('#guestForm').addClass('active');
      $('#guestButton').addClass('active');

      // 토글 버튼 클릭 시 처리
      $('.toggle-btn').click(function() {
        var role = $(this).attr('id').replace('Button', '');

        // 폼 전환
        $('.form-section').removeClass('active');
        $('#' + role + 'Form').addClass('active');

        // 폼 필드 초기화
        $('#' + role + 'Form').find('input[type="text"], input[type="password"], input[type="email"], input[type="tel"]').val('');

        // 버튼 활성화 전환
        $('.toggle-btn').removeClass('active');
        $(this).addClass('active');
      });
    });
  </script>
</head>
<body>
<div class="form-container">
  <h1>회원가입</h1>

  <!-- 슬라이드 토글 버튼 -->
  <div class="toggle-container">
    <div id="guestButton" class="toggle-btn active">게스트 회원</div>
    <div id="hostButton" class="toggle-btn">호스트 회원</div>
    <div class="slider"></div>
  </div>

  <!-- 게스트 회원 폼 -->
  <div id="guestForm" class="form-section active">
    <form action="/signupOk" method="post">
      <input type="hidden" name="roleNo" value="1">
      <input type="text" name="userId" placeholder="아이디" value="${member.userId}" required>
      <c:if test="${not empty valid_userId}">
        <div class="error-message">${valid_userId}</div>
      </c:if>
      <input type="password" name="password" placeholder="비밀번호" value="${member.password}" required>
      <c:if test="${not empty valid_password}">
        <div class="error-message">${valid_password}</div>
      </c:if>
      <input type="text" name="userName" placeholder="이름" value="${member.userName}" required>
      <c:if test="${not empty valid_userName}">
        <div class="error-message">${valid_userName}</div>
      </c:if>
      <input type="email" name="email" placeholder="이메일" value="${member.email}" required>
      <c:if test="${not empty valid_email}">
        <div class="error-message">${valid_email}</div>
      </c:if>
      <input type="tel" name="phone" placeholder="전화번호" value="${member.phone}" required>
      <c:if test="${not empty valid_phone}">
        <div class="error-message">${valid_phone}</div>
      </c:if>
      <input type="submit" value="회원가입">
      <input type="reset" value="취소">
    </form>
  </div>

  <!-- 호스트 회원 폼 -->
  <div id="hostForm" class="form-section">
    <form action="/signupOk" method="post">
      <input type="hidden" name="roleNo" value="2">
      <input type="text" name="userId" placeholder="아이디" value="${member.userId}" required>
      <c:if test="${not empty valid_userId}">
        <div class="error-message">${valid_userId}</div>
      </c:if>
      <input type="password" name="password" placeholder="비밀번호" value="${member.password}" required>
      <c:if test="${not empty valid_password}">
        <div class="error-message">${valid_password}</div>
      </c:if>
      <input type="text" name="userName" placeholder="이름" value="${member.userName}" required>
      <c:if test="${not empty valid_userName}">
        <div class="error-message">${valid_userName}</div>
      </c:if>
      <input type="email" name="email" placeholder="이메일" value="${member.email}" required>
      <c:if test="${not empty valid_email}">
        <div class="error-message">${valid_email}</div>
      </c:if>
      <input type="tel" name="phone" placeholder="전화번호" value="${member.phone}" required>
      <c:if test="${not empty valid_phone}">
        <div class="error-message">${valid_phone}</div>
      </c:if>
      <input type="submit" value="회원가입">
      <input type="reset" value="취소">
    </form>
  </div>
</div>
</body>
</html>
