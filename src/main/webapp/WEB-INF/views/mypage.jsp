<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<jsp:include page="guestSideBar.jsp" />

<style>
    /* 페이지 중앙 정렬을 위한 기본 스타일 */
    body {
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: 100vh; /* 뷰포트 전체 높이 */
        margin: 0;
    }

    /* container 스타일 - 정사각형으로 처리 */
    .container {
        font-family: 'Do Hyeon', sans-serif;
        width: 600px; /* 가로 너비와 세로 높이를 동일하게 설정 */
        height: 600px;
        background-color: #fff;
        box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
        border-radius: 12px;
        display: flex;
        justify-content: center; /* 이미지 중앙 정렬 */
        align-items: center; /* 이미지 중앙 정렬 */
        padding: 30px; /* 이미지와의 간격을 위한 패딩 추가 */
        margin-left: calc(270px + 10px); /* 사이드바 너비 + 여백 */
        margin-right: 20px;
    }

    /* 이미지 스타일 */
    .container img {
        max-width: 100%; /* 이미지가 container를 넘지 않도록 조정 */
        max-height: 100%; /* 이미지의 최대 높이 설정 */
        object-fit: contain; /* 이미지가 컨테이너 안에서 비율에 맞게 조정되도록 */
    }
</style>

<div class="container">
    <img src="/images/kojaping_logo.png" alt="Kojaping Logo">
</div>
