<%--
  Created by IntelliJ IDEA.
  User: jihyun
  Date: 9/23/24
  Time: 4:53 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="hostSideBar.jsp"%>

<style>
    @import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap');

    body {
        font-family: 'Do Hyeon', sans-serif;
        background-color: #f4f4f4;
        margin: 0;
        padding: 0;
    }

    /* 컨테이너 위치와 스타일 조정 */
    .container {
        max-width: 900px;
        margin: 50px auto;
        padding: 30px;
        background-color: #fff;
        box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
        border-radius: 15px;
        position: relative;
        padding-bottom: 120px;
        margin-left: calc(270px + 320px); /* 사이드바 너비 + 여백 */
        margin-right: 20px;
        animation: fadeIn 0.5s ease-in-out;
    }

    @keyframes fadeIn {
        from {
            opacity: 0;
            transform: translateY(20px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    h1 {
        text-align: center;
        color: #ff5a5f; /* 포인트 색상 적용 */
        font-size: 28px;
        font-weight: bold;
        margin-bottom: 20px;
    }

    label {
        font-size: 1.1em;
        color: #333;
    }

    input, textarea {
        width: 100%;
        padding: 12px;
        border-radius: 8px;
        border: 1px solid #ddd;
        font-size: 1em;
        margin-top: 5px;
        margin-bottom: 20px;
        box-sizing: border-box;
        transition: border-color 0.3s ease-in-out;
    }

    input:focus, textarea:focus {
        border-color: #ff5a5f; /* 포인트 색상 적용 */
        outline: none;
    }

    textarea {
        resize: vertical; /* 세로 크기만 조정 가능 */
        rows: 10; /* 텍스트 입력 영역 크기 줄임 */
    }

    .details-wrapper {
        display: flex;
        flex-direction: column;
        gap: 15px;
    }

    .detail-item {
        display: flex;
        align-items: center;
        gap: 15px;
    }

    .detail-item span {
        width: 170px;
        text-align: left;
        font-size: 1em;
        color: #333;
    }

    .detail-item button {
        width: 40px;
        height: 40px;
        background-color: #ff5a5f; /* 포인트 색상 적용 */
        color: white;
        border: none;
        border-radius: 8px;
        cursor: pointer;
        font-size: 1.2em;
    }

    .detail-item button:hover {
        background-color: #ff3a3f;
    }

    .detail-item input {
        width: 80px;
        text-align: center;
        border: 1px solid #ddd;
        border-radius: 8px;
        padding: 10px;
    }

    button {
        display: inline-block;
        padding: 12px 30px;
        background-color: #ff5a5f; /* 포인트 색상 적용 */
        color: white;
        border: none;
        border-radius: 8px;
        cursor: pointer;
        font-size: 1em;
    }

    button:hover {
        background-color: #ff3a3f;
    }

    /* footer 스타일 (hostAmenitiesForm.jsp와 동일하게 수정) */
    .fixed-footer {
        margin-top: 20px;
        background-color: #ecf0f1;
        height: 80px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 0 20px;
        border-radius: 8px;
        position: absolute;
        bottom: 20px;
        left: 0;
        right: 0;
    }

    .fixed-footer .step {
        font-size: 1em;
        color: #666;
    }

    .fixed-footer button {
        padding: 12px 25px;
        background-color: #ff5a5f; /* 포인트 색상 */
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }

    .fixed-footer button:hover {
        background-color: #ff3a3f;
    }

    /* 반응형 디자인 */
    @media (max-width: 768px) {
        .container {
            margin-left: 20px;
            margin-right: 20px;
        }
    }
</style>

<div class="container">
    <h1>숙소에 관하여 설명해주세요.</h1>

    <form action="/host/hostPage/addSettings" method="post">
        <input type="hidden" name="postcode" value="${postcode}">
        <input type="hidden" name="address" value="${address}">
        <input type="hidden" name="detailAddress" value="${detailAddress}">
        <input type="hidden" name="extraAddress" value="${extraAddress}">
        <input type="hidden" name="latitude" value="${latitude}">
        <input type="hidden" name="longitude" value="${longitude}">
        <input type="hidden" name="locationNo" value="${locationNo}">
        <input type="hidden" name="memberNo" value="${memberNo}">
        <input type="hidden" name="amenityName" value="${amenityName}">

        <div class="form-group">
            <label for="title">숙소명</label>
            <input type="text" id="title" name="title" required>
        </div>
        <div class="form-group">
            <label for="description">숙소내용</label>
            <textarea id="description" name="description" rows="10" required></textarea>
        </div>
        <div class="form-group">
            <label for="pricePerNight">1박 가격 (원) </label>
            <input type="number" id="pricePerNight" name="pricePerNight" required min="1">
        </div>
        <div class="form-group">
            <label>숙소 세부 사항</label>
            <div class="details-wrapper">
                <!-- 최대 게스트 수 -->
                <div class="detail-item">
                    <span>최대 게스트 수</span>
                    <button type="button" onclick="changeValue('maxGuest', -1)">-</button>
                    <input type="number" id="maxGuest" name="maxGuest" value="1" readonly>
                    <button type="button" onclick="changeValue('maxGuest', 1)">+</button>
                </div>

                <!-- 침실 -->
                <div class="detail-item">
                    <span>침실</span>
                    <button type="button" onclick="changeValue('bedroomCnt', -1)">-</button>
                    <input type="number" id="bedroomCnt" name="bedroomCnt" value="1" readonly>
                    <button type="button" onclick="changeValue('bedroomCnt', 1)">+</button>
                </div>

                <!-- 침대 -->
                <div class="detail-item">
                    <span>침대</span>
                    <button type="button" onclick="changeValue('bedCnt', -1)">-</button>
                    <input type="number" id="bedCnt" name="bedCnt" value="1" readonly>
                    <button type="button" onclick="changeValue('bedCnt', 1)">+</button>
                </div>

                <!-- 욕실 -->
                <div class="detail-item">
                    <span>욕실</span>
                    <button type="button" onclick="changeValue('bathCnt', -1)">-</button>
                    <input type="number" id="bathCnt" name="bathCnt" value="1" readonly>
                    <button type="button" onclick="changeValue('bathCnt', 1)">+</button>
                </div>
            </div>
        </div>

        <!-- 고정 영역 -->
        <div class="fixed-footer">
            <button type="button" onclick="goBack()">뒤로 가기</button>
            <span class="step">단계 3/5</span>
            <button type="submit">다음</button>
        </div>
    </form>
</div>

<script>
    function changeValue(id, delta) {
        const input = document.getElementById(id);
        let currentValue = parseInt(input.value);
        let newValue = currentValue + delta;
        if (newValue >= 1) { // 최소값 1 이상 유지
            input.value = newValue;
        }
    }

    function goBack() {
        window.history.back();
    }
</script>
