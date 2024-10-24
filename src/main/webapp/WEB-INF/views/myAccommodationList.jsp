<%--
  Created by IntelliJ IDEA.
  User: jihyun
  Date: 9/22/24
  Time: 3:51 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="hostSideBar.jsp"%>

<%
    String contextPath = request.getContextPath();
%>

<style>
    @import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap');

    /* 전체 레이아웃 스타일 */
    body {
        margin: 0;
        padding: 0;
        font-family: 'Do Hyeon', sans-serif;
        background-color: #f5f5f5;
    }

    /* content 영역 페이지 너비와 같게 */
    #content {
        margin-left: 270px; /* 사이드바 너비 */
        padding: 40px;
        background-color: #f9f9f9;
        min-height: 100vh;
        width: calc(100% - 270px); /* 사이드바 제외한 페이지 전체 너비 */
        box-sizing: border-box;
    }

    h1 {
        font-size: 28px;
        color: #ff5a5f;
        font-weight: bold;
        margin-bottom: 40px;
    }

    /* 숙소 카드 디자인 */
    .product-card {
        display: flex;
        align-items: center;
        gap: 20px;
        border: 1px solid #ddd;
        padding: 20px;
        margin-bottom: 20px;
        border-radius: 12px;
        background-color: white;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        transition: transform 0.3s ease, box-shadow 0.3s ease;
        max-width: 100%;
    }

    .product-card:hover {
        transform: scale(1.02);
        box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2);
    }

    .image-section {
        flex: 0 0 200px; /* 고정 너비 */
    }

    .image-section img {
        width: 100%;
        height: 200px;
        border-radius: 8px;
        object-fit: cover;
    }

    .text-section {
        flex: 1; /* 남은 공간을 차지 */
        display: flex;
        flex-direction: column;
        justify-content: center;
    }

    .text-section h5 {
        font-size: 22px;
        color: #333;
        margin-bottom: 10px;
    }

    .text-section p {
        font-size: 16px;
        color: #555;
        margin-bottom: 8px;
    }

    /* 버튼 그룹을 세로 가운데 정렬 */
    .button-group {
        display: flex;
        flex-direction: column;
        justify-content: center; /* 세로 가운데 정렬 */
        align-items: center;
        gap: 10px;
        flex-shrink: 0;
    }

    .button-group button {
        width: 160px;
        padding: 10px 20px;
        font-size: 14px;
        border-radius: 25px;
        transition: background-color 0.3s ease;
    }

    .btn-info {
        background-color: #ff5a5f;
        color: white;
        border: none;
    }

    .btn-info:hover {
        background-color: #ff3a3f;
    }

    .btn-primary {
        background-color: #6c5ce7;
        color: white;
        border: none;
    }

    .btn-primary:hover {
        background-color: #5b46d1;
    }

    /* 반응형 디자인 */
    @media (max-width: 768px) {
        #content {
            margin-left: 0;
            padding: 20px;
            width: 100%;
        }

        .product-card {
            flex-direction: column;
            align-items: center;
        }

        .button-group {
            flex-direction: row;
            gap: 15px;
            justify-content: center;
        }
    }
</style>

   <!-- 페이지 콘텐츠 -->
<div id="content">
    <div class="container">
        <h1 class="my-4">내가 등록한 숙소</h1>
        <c:if test="${not empty message}">
            <div class="alert alert-success">${message}</div>
        </c:if>

        <c:choose>
            <c:when test="${not empty accommodations}">
                <div class="row">
                    <c:forEach var="accommodation" items="${accommodations}">
                        <div class="col-md-12">
                            <div class="product-card">

                                <!-- 이미지 섹션 -->
                                <div class="image-section">
                                    <img class="product-image" src="${accommodation.imageUrls.get(0)}" alt="${accommodation.title}" style="width:200px;height:200px;">
                                </div>

                                <!-- 텍스트 섹션 -->
                                <div class="text-section">
                                    <h5>${accommodation.title}</h5>
                                    <p>가격: ${accommodation.pricePerNight} / 박</p>
                                    <p>주소: ${accommodation.address}</p>
                                    <p>최대 인원수: ${accommodation.maxGuest}명</p>
                                    <p>방갯수: ${accommodation.bedroomCnt}개</p>
                                    <p>침대갯수: ${accommodation.bedCnt}개</p>
                                </div>

                                <!-- 버튼 그룹 섹션 -->
                                <div class="button-group">
<%--                                    <button type="button" class="btn btn-info" data-toggle="modal" data-target="#paymentModal-1">결제 내역 보기</button>--%>
                                    <button type="button" class="btn btn-primary" onclick="deleteAccommodation('${accommodation.accommodationNo}')">숙소 삭제</button>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <h1>등록된 숙소가 없습니다.</h1>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<script>
    function deleteAccommodation(accommodationNo) {
        if(confirm("정말 등록된 숙소 정보를 삭제하시겠습니까?")) {
            location.href = "<%=contextPath%>/host/hostPage/delete?accommodationNo=" + accommodationNo;
        }
    }
</script>