<%--
  Created by IntelliJ IDEA.
  User: jihyun
  Date: 9/24/24
  Time: 11:11 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>500 - 서버 오류</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap');

        body {
            font-family: 'Do Hyeon', sans-serif;
            background-color: #f4f4f4;
            text-align: center;
            padding: 50px;
        }

        .container {
            background-color: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
            max-width: 600px;
            margin: auto;
        }

        h1 {
            color: #ff5a5f;
            font-size: 36px;
            margin-bottom: 20px;
        }

        p {
            color: #333;
            font-size: 18px;
            margin-bottom: 30px;
        }

        .btn-back {
            padding: 12px 25px;
            background-color: #ff5a5f;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            text-decoration: none;
        }

        .btn-back:hover {
            background-color: #ff3a3f;
        }
    </style>
</head>
<body>

<div class="container">
    <h1>서버 오류 발생 (500)</h1>
    <p>요청을 처리하는 중에 서버 오류가 발생했습니다.<br>잠시 후 다시 시도해 주세요.</p>
    <a href="javascript:history.back()" class="btn-back">돌아가기</a>
</div>

</body>
</html>

