<%--
  Created by IntelliJ IDEA.
  User: jihyun
  Date: 9/19/24
  Time: 12:49 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<html>
<head>
    <title>Login</title>
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
            padding: 50px; /* 폼 크기 확대 */
            border-radius: 15px;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.2);
            width: 420px; /* 폼의 너비 확장 */
        }

        h1 {
            margin-bottom: 40px;
            font-size: 32px; /* 글씨 크기 확대 */
            color: #333;
            text-align: center;
        }

        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 16px; /* 입력 필드 패딩 확대 */
            margin: 12px 0;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px; /* 글씨 크기 확대 */
            transition: border-color 0.3s ease-in-out;
        }

        input[type="text"]:focus, input[type="password"]:focus {
            border-color: #ff5a5f;
        }

        input[type="submit"], input[type="reset"] {
            width: 100%;
            padding: 16px; /* 버튼 패딩 확대 */
            background-color: #ff5a5f;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 18px; /* 버튼 글씨 크기 확대 */
            margin-top: 20px;
            transition: background-color 0.3s ease-in-out;
        }

        input[type="submit"]:hover, input[type="reset"]:hover {
            background-color: #e04b52;
        }

        .link-container {
            text-align: center;
            margin-top: 30px; /* 링크 상단 여백 조정 */
        }

        .link-container a {
            color: #ff5a5f;
            text-decoration: none;
            font-size: 16px; /* 링크 글씨 크기 확대 */
            transition: color 0.3s ease-in-out;
        }

        .link-container a:hover {
            color: #e04b52;
        }

        hr {
            margin: 30px 0; /* 수평선 여백 조정 */
            border: none;
            border-top: 1px solid #ddd;
        }
    </style>
</head>
<body>
<div class="form-container">
    <h1>로그인</h1>
    <form action="/login" method="post">
        <input type="text" name="userId" placeholder="아이디" required><br>
        <input type="password" name="password" placeholder="비밀번호" required><br>
        <input type="submit" value="로그인">
        <input type="reset" value="취소">
    </form>
    <hr>
    <div class="link-container">
        <a href="/signupForm">아직 회원이 아니신가요?</a>
    </div>
</div>
</body>
</html>
