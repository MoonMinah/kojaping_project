<%--
  Created by IntelliJ IDEA.
  User: jihyun
  Date: 9/22/24
  Time: 11:58 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="hostSideBar.jsp"%>

<style>
    @import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap');

    /* 제목 스타일 */
    h1 {
        text-align: center;
        color: #ff5a5f; /* 포인트 색상 적용 */
        font-size: 28px;
        font-weight: bold;
        margin-bottom: 20px;
    }

    h2 {
        color: #ff5a5f;
        font-size: 22px;
        text-align: center;
        margin: 40px 0 20px 0;
        position: relative;
    }

    /* h2 태그에 분기선 느낌을 줄 수 있는 디자인 */
    .divider-container {
        display: flex;
        align-items: center;
        margin: 40px 0 20px 0;
    }

    .divider {
        flex-grow: 1;
        height: 1px;
        background-color: #ddd;
    }

    .divider-text {
        margin: 0 15px;
        font-size: 22px;
        color: #ff5a5f;
        font-weight: bold;
    }

    /* 컨테이너 영역 위치와 스타일 조정 */
    .container {
        font-family: 'Do Hyeon', sans-serif;
        max-width: 900px;
        margin: 50px auto;
        padding: 30px;
        background-color: white;
        box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
        border-radius: 12px;
        position: relative;
        padding-bottom: 100px;
        margin-left: calc(270px + 320px); /* 사이드바 너비 + 여백 */
        margin-right: 20px;
    }

    /* 정보 텍스트 스타일 */
    .info {
        text-align: center;
        margin-bottom: 20px;
        font-size: 1.0em;
        color: #666;
    }

    /* 그리드 레이아웃 */
    .facilities-grid {
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        gap: 20px;
    }

    /* 편의시설 스타일 */
    .facility {
        text-align: center;
        padding: 15px;
        border: 1px solid #ddd;
        border-radius: 8px;
        transition: box-shadow 0.3s;
        background-color: #fff;
        cursor: pointer;
    }

    .facility:hover {
        box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
    }

    .facility label {
        display: flex;
        flex-direction: column;
        align-items: center;
        width: 100%;
        cursor: pointer;
    }

    .facility i {
        font-size: 24px;
        color: #5b46d1; /* 체크된 경우 아이콘 색상 변경 */
        transition: color 0.3s;
    }

    .facility input[type="checkbox"] {
        display: none; /* 기본 체크박스 숨기기 */
    }

    .facility input[type="checkbox"]:checked + i {
        color: #ff5a5f; /* 포인트 색상 적용 */
    }

    .facility-label {
        font-size: 1.1em;
        color: #333;
        margin-top: 5px;
    }

    /* 버튼 스타일 */
    button {
        display: inline-block;
        padding: 12px 25px;
        background-color: #ff5a5f;
        color: white;
        border: none;
        border-radius: 25px;
        cursor: pointer;
        transition: background-color 0.3s ease;
        font-size: 16px;
    }

    button:hover {
        background-color: #ff3a3f;
    }

    /* 푸터 스타일 */
    .footer {
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

    .footer .step {
        font-size: 1em;
        color: #666;
    }

    .footer button {
        padding: 12px 25px;
        background-color: #ff5a5f;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }

    .footer button:hover {
        background-color: #ff3a3f;
    }

    /* 반응형 디자인 */
    @media (max-width: 768px) {
        .container {
            margin-left: 20px;
            margin-right: 20px;
        }

        .facilities-grid {
            grid-template-columns: repeat(2, 1fr);
        }
    }
</style>


<div class="container">
    <h1>숙소 편의시설 정보를 추가하세요</h1>
    <p class="info">여기에 추가하려는 편의시설이 보이지 않더라도 걱정하지 마세요! 숙소를 등록한 후에 편의시설을 추가할 수 있습니다.</p>

    <form action="/host/hostPage/addAmenities" method="post">
        <input type="hidden" name="postcode" value="${postcode}">
        <input type="hidden" name="address" value="${address}">
        <input type="hidden" name="detailAddress" value="${detailAddress}">
        <input type="hidden" name="extraAddress" value="${extraAddress}">
        <input type="hidden" name="latitude" value="${latitude}">
        <input type="hidden" name="longitude" value="${longitude}">
        <input type="hidden" name="locationNo" value="${locationNo}">
        <input type="hidden" name="memberNo" value="${memberNo}">

        <div class="divider-container">
            <div class="divider"></div>
            <div class="divider-text">다음 인기 편의시설이 있나요?</div>
            <div class="divider"></div>
        </div>
        <div class="facilities-grid">
            <div class="facility">
                <label for="wifi" class="facility-label">
                    <input type="checkbox" name="amenityName" id="wifi" value="wifi">
                    <i class="fa-solid fa-wifi"></i>
                    <span>와이파이</span>
                </label>
            </div>
            <div class="facility">
                <label for="tv" class="facility-label">
                    <input type="checkbox" name="amenityName" id="tv" value="tv">
                    <i class="fa-solid fa-tv"></i>
                    <span>TV</span>
                </label>
            </div>
            <div class="facility">
                <label for="kitchen" class="facility-label">
                    <input type="checkbox" name="amenityName" id="kitchen" value="kitchen">
                    <i class="fa-solid fa-fire-burner"></i>
                    <span>주방</span>
                </label>
            </div>
            <div class="facility">
                <label for="laundry" class="facility-label">
                    <input type="checkbox" name="amenityName" id="laundry" value="laundry">
                    <i class="fa-solid fa-jug-detergent"></i>
                    <span>세탁기</span>
                </label>
            </div>
            <div class="facility">
                <label for="freeParking" class="facility-label">
                    <input type="checkbox" name="amenityName" id="freeParking" value="freeParking">
                    <i class="fa-solid fa-car"></i>
                    <span>무료 주차</span>
                </label>
            </div>
            <div class="facility">
                <label for="paidParking" class="facility-label">
                    <input type="checkbox" name="amenityName" id="paidParking" value="paidParking">
                    <i class="fa-solid fa-car-side"></i>
                    <span>유료 주차</span>
                </label>
            </div>
            <div class="facility">
                <label for="airConditioning" class="facility-label">
                    <input type="checkbox" name="amenityName" id="airConditioning" value="airConditioning">
                    <i class="fa-solid fa-wind"></i>
                    <span>에어컨</span>
                </label>
            </div>
            <div class="facility">
                <label for="workspace" class="facility-label">
                    <input type="checkbox" name="amenityName" id="workspace" value="workspace">
                    <i class="fa-solid fa-house-laptop"></i>
                    <span>업무 공간</span>
                </label>
            </div>
        </div>

        <div class="divider-container">
            <div class="divider"></div>
            <div class="divider-text">특별히 내세울 만한 편의시설이 있나요?</div>
            <div class="divider"></div>
        </div>
        <div class="facilities-grid">
            <div class="facility">
                <label for="pool" class="facility-label">
                    <input type="checkbox" name="amenityName" id="pool" value="pool">
                    <i class="fa-solid fa-person-swimming"></i>
                    <span>수영장</span>
                </label>
            </div>
            <div class="facility">
                <label for="hotTub" class="facility-label">
                    <input type="checkbox" name="amenityName" id="hotTub" value="hotTub">
                    <i class="fa-solid fa-bath"></i>
                    <span>대형 욕조</span>
                </label>
            </div>
            <div class="facility">
                <label for="bbq" class="facility-label">
                    <input type="checkbox" name="amenityName" id="bbq" value="bbq">
                    <i class="fa-solid fa-fire-burner"></i>
                    <span>바비큐 그릴</span>
                </label>
            </div>
            <div class="facility">
                <label for="outdoorDining" class="facility-label">
                    <input type="checkbox" name="amenityName" id="outdoorDining" value="outdoorDining">
                    <i class="fa-solid fa-utensils"></i>
                    <span>야외 식사 공간</span>
                </label>
            </div>
            <div class="facility">
                <label for="tableTennis" class="facility-label">
                    <input type="checkbox" name="amenityName" id="tableTennis" value="tableTennis">
                    <i class="fa-solid fa-table-tennis-paddle-ball"></i>
                    <span>탁구</span>
                </label>
            </div>
            <div class="facility">
                <label for="guitar" class="facility-label">
                    <input type="checkbox" name="amenityName" id="guitar" value="guitar">
                    <i class="fa-solid fa-guitar"></i>
                    <span>기타</span>
                </label>
            </div>
            <div class="facility">
                <label for="sportsEquipment" class="facility-label">
                    <input type="checkbox" name="amenityName" id="sportsEquipment" value="sportsEquipment">
                    <i class="fa-solid fa-basketball"></i>
                    <span>운동 기구</span>
                </label>
            </div>
        </div>

        <div class="divider-container">
            <div class="divider"></div>
            <div class="divider-text">다음과 같은 안전 관련 물품이 있나요?</div>
            <div class="divider"></div>
        </div>

        <div class="facilities-grid">
            <div class="facility">
                <label for="fireAlarm" class="facility-label">
                    <input type="checkbox" name="amenityName" id="fireAlarm" value="fireAlarm">
                    <i class="fa-solid fa-fire"></i>
                    <span>화재 경보기</span>
                </label>
            </div>
            <div class="facility">
                <label for="firstAidKit" class="facility-label">
                    <input type="checkbox" name="amenityName" id="firstAidKit" value="firstAidKit">
                    <i class="fa-solid fa-suitcase-medical"></i>
                    <span>구급 상자</span>
                </label>
            </div>
            <div class="facility">
                <label for="fireExtinguisher" class="facility-label">
                    <input type="checkbox" name="amenityName" id="fireExtinguisher" value="fireExtinguisher">
                    <i class="fa-solid fa-fire-extinguisher"></i>
                    <span>소화기</span>
                </label>
            </div>
            <div class="facility">
                <label for="carbonMonoxideAlarm" class="facility-label">
                    <input type="checkbox" name="amenityName" id="carbonMonoxideAlarm" value="carbonMonoxideAlarm">
                    <i class="fa-solid fa-triangle-exclamation"></i>
                    <span>일산화탄소 경보기</span>
                </label>
            </div>
        </div>

        <div class="footer">
            <button type="button" onclick="goBack()">뒤로 가기</button>
            <span class="step">단계 2/5</span>
            <button type="submit">다음</button>
        </div>
    </form>
</div>

<script>
    function goBack() {
        window.history.back();
    }
</script>