<%--
  Created by IntelliJ IDEA.
  User: jihyun
  Date: 9/21/24
  Time: 9:15 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<jsp:include page="guestSideBar.jsp" />

<style>
    /* 본문 내용을 사이드바 너비만큼 밀어내기 */
    #content {
        margin-left: 270px; /* 사이드바 너비 250px + 여유 공간 20px */
        padding: 20px;
        margin-top: 50px;
    }

    /* 테이블 스타일 */
    .table {
        margin: 0 auto;
        width: 100%;
        background-color: #fff;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        border-radius: 10px;
        overflow: hidden;
    }

    .table th, .table td {
        vertical-align: middle;
        padding: 15px;
    }

    .table th {
        background-color: #f8f9fa;
        font-weight: bold;
        text-transform: uppercase;
        color: #495057;
    }

    .table td {
        border-bottom: 1px solid #e9ecef;
    }

    .table td:last-child {
        display: flex;
        justify-content: center;
        gap: 10px;
    }

    /* 버튼 스타일 */
    .btn {
        padding: 10px 20px;
        border-radius: 25px;
        font-size: 16px;
        transition: background-color 0.3s ease;
    }

    .btn-info {
        background-color: #17a2b8;
        color: #fff;
        border: none;
    }

    .btn-info:hover {
        background-color: #138496;
    }

    .btn-primary {
        background-color: #007bff;
        color: #fff;
        border: none;
    }

    .btn-primary:hover {
        background-color: #0056b3;
    }

    .btn-secondary {
        background-color: #6c757d;
        color: #fff;
        border: none;
    }

    .btn-secondary:hover {
        background-color: #545b62;
    }

    /* 반응형 디자인: 작은 화면에서 사이드바가 접히는 방식 */
    @media (max-width: 768px) {
        #content {
            margin-left: 0; /* 작은 화면에서는 여백 제거 */
        }

        #sidebar {
            position: relative;
            width: 100%;
            height: auto;
        }

        .table td:last-child {
            display: block;
        }

        .table td button {
            width: 100%;
            margin-bottom: 10px;
        }
    }
</style>

<div id="content" class="p-4"> <!-- 사이드바와의 간격을 위한 마진 추가 -->

    <header class="text-center mb-4">
        <h2 class="font-weight-bold">예약한 숙소 목록</h2>
    </header>
    <div class="reservation-list">
        <!-- 테이블 형태로 변경, 중앙 정렬 추가 -->
        <table class="table table-bordered text-center"> <!-- 테이블 텍스트 중앙 정렬 -->
            <thead class="thead-light">
            <tr>
                <th>숙소명</th>
                <th>지역</th>
                <th>주소</th>
                <th>상세주소</th>
                <th>체크인/체크아웃</th>
                <th>작업</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="reservation" items="${reservations}">
                <tr>
                    <td>${reservation.accommodation.title}</td>
                    <c:choose>
                        <c:when test="${reservation.accommodation.locationNo eq '1'}">
                            <td>서울</td>
                        </c:when>
                        <c:when test="${reservation.accommodation.locationNo eq '2'}">
                            <td>인천</td>
                        </c:when>
                        <c:when test="${reservation.accommodation.locationNo eq '3'}">
                            <td>강릉</td>
                        </c:when>
                        <c:when test="${reservation.accommodation.locationNo eq '4'}">
                            <td>속초</td>
                        </c:when>
                        <c:when test="${reservation.accommodation.locationNo eq '5'}">
                            <td>전주</td>
                        </c:when><c:when test="${reservation.accommodation.locationNo eq '6'}">
                        <td>여수</td>
                    </c:when>
                        <c:when test="${reservation.accommodation.locationNo eq '7'}">
                            <td>대전</td>
                        </c:when><c:when test="${reservation.accommodation.locationNo eq '8'}">
                        <td>경주</td>
                    </c:when>
                        <c:when test="${reservation.accommodation.locationNo eq '9'}">
                            <td>대구</td>
                        </c:when>
                        <c:when test="${reservation.accommodation.locationNo eq '10'}">
                            <td>부산</td>
                        </c:when><c:when test="${reservation.accommodation.locationNo eq '11'}">
                        <td>제주</td>
                    </c:when><c:when test="${reservation.accommodation.locationNo eq '12'}">
                        <td>서귀포</td>
                    </c:when>
                    </c:choose>
                    <td>${reservation.accommodation.address}</td>
                    <td>${reservation.accommodation.detailAddress}</td>
                    <td>${reservation.checkIn} ~ ${reservation.checkOut}</td>
                    <td>
                        <button type="button" class="btn btn-info" data-toggle="modal" data-target="#paymentModal-${reservation.reservationNo}">결제 내역 보기</button>
                        <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#reviewModal-${reservation.reservationNo}">리뷰 작성</button>
                    </td>
                </tr>

                <!-- 결제 내역 모달 -->
                <div class="modal fade" id="paymentModal-${reservation.reservationNo}" tabindex="-1" role="dialog">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">결제 내역 - ${reservation.accommodation.title}</h5>
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                            </div>
                            <div class="modal-body">
                                <c:if test="${not empty reservation.payment}">

                                    <p><strong>결제 금액:</strong> <fmt:formatNumber value="${reservation.payment.paymentAmount}" minFractionDigits="0"/>원</p>
                                    <p><strong>결제 수단:</strong> ${reservation.payment.paymentMethod}</p>
                                    <p><strong>결제 일자:</strong> ${formattedPaymentDate}</p>
                                </c:if>
                                <c:if test="${empty reservation.payment}">
                                    <p>결제 정보가 없습니다.</p>
                                </c:if>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
                            </div>
                        </div>
                    </div>
                </div>


                <!-- 리뷰 작성 모달 -->
                <div class="modal fade" id="reviewModal-${reservation.reservationNo}" tabindex="-1" role="dialog">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">리뷰 작성 - ${reservation.accommodation.title}</h5>
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                            </div>
                            <form action="/guest/mypage/submitReview" method="post">
                                <div class="modal-body">
                                    <div class="form-group">
                                        <label for="rating-${reservation.reservationNo}">별점</label>

                                        <c:if test="${not empty reservation.review}">
                                            <!-- 이미 작성된 리뷰가 있을 때 -->
                                            <select class="form-control" name="rating" id="rating-${reservation.reservationNo}" disabled>
                                                <option value="1" ${reservation.review.rating == 1 ? 'selected' : ''}>1</option>
                                                <option value="2" ${reservation.review.rating == 2 ? 'selected' : ''}>2</option>
                                                <option value="3" ${reservation.review.rating == 3 ? 'selected' : ''}>3</option>
                                                <option value="4" ${reservation.review.rating == 4 ? 'selected' : ''}>4</option>
                                                <option value="5" ${reservation.review.rating == 5 ? 'selected' : ''}>5</option>
                                            </select>
                                        </c:if>
                                        <c:if test="${empty reservation.review}">
                                            <!-- 리뷰가 없을 때 -->
                                            <select class="form-control" name="rating" id="rating-${reservation.reservationNo}">
                                                <option value="1">1</option>
                                                <option value="2">2</option>
                                                <option value="3">3</option>
                                                <option value="4">4</option>
                                                <option value="5">5</option>
                                            </select>
                                        </c:if>
                                    </div>

                                    <div class="form-group">
                                        <label for="review-${reservation.reservationNo}">리뷰 내용</label>

                                        <c:if test="${not empty reservation.review}">
                                            <!-- 이미 작성된 리뷰가 있을 때 -->
                                            <textarea class="form-control" name="comment" id="review-${reservation.reservationNo}" rows="3" readonly>${reservation.review.comment}</textarea>
                                            <p>작성일시 : ${formattedReviewDate}</p>
                                        </c:if>
                                        <c:if test="${empty reservation.review}">
                                            <!-- 리뷰가 없을 때 -->
                                            <textarea class="form-control" name="comment" id="review-${reservation.reservationNo}" rows="3"></textarea>
                                        </c:if>
                                    </div>
                                </div>

                                <div class="modal-footer">
                                    <c:if test="${not empty reservation.review}">
                                        <!-- 이미 작성된 리뷰가 있을 때 버튼 비활성화 -->
                                        <button type="submit" class="btn btn-primary" disabled>리뷰 작성 완료</button>
                                    </c:if>
                                    <c:if test="${empty reservation.review}">
                                        <!-- 리뷰가 없을 때 버튼 활성화 -->
                                        <button type="submit" class="btn btn-primary">리뷰 등록</button>
                                    </c:if>
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>


            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<!-- jQuery 및 Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
