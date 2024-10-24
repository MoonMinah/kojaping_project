<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="header.jsp" />

<!-- Main Content -->
<div class="container">
    <h1 class="my-4 text-center">Room List</h1>
    <div class="row">
        <c:forEach var="accommodation" items="${accommodations}">
            <div class="col-md-4 mb-4">
                <div class="card h-100">

                    <!-- 이미지 출력 -->
                    <c:choose>
                        <c:when test="${not empty accommodation.imageUrls}">
                            <img src="${accommodation.imageUrls[0]}" class="card-img-top" alt="숙소 이미지" style="max-height: 200px; object-fit: cover;">
                        </c:when>
                        <c:otherwise>
                            <img src="/images/default_image.jpg" class="card-img-top" alt="기본 이미지" style="max-height: 200px; object-fit: cover;">
                        </c:otherwise>
                    </c:choose>

                    <div class="card-body">
                        <h5 class="card-title">${accommodation.title}</h5>
                        <p class="card-text">Address: ${accommodation.address}</p>
                        <p class="card-text">Max Guests: ${accommodation.maxGuest}</p>

                        <!-- 가격 포맷팅 -->
                        <p class="card-text">
                            <span class="price-new"><fmt:formatNumber value="${accommodation.pricePerNight}" minFractionDigits="0"/>원/박</span>
                        </p>

                        <a href="/accommodationDetail?accommodationNo=${accommodation.accommodationNo}" class="btn btn-primary">상세 보기</a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<!-- Bootstrap JS 추가 -->
<%--<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>--%>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script type="text/javascript">
    document.getElementById("destination").addEventListener("click", function() {
        document.getElementById("location-popup").classList.toggle("show");
    });

    function selectLocation(locationName) {
        document.getElementById("destination").value = locationName;
        document.getElementById("location-popup").classList.remove("show");
    }

    $(function() {
        $('#checkin').daterangepicker({
            singleDatePicker: true,
            locale: {
                format: 'YYYY-MM-DD',
                applyLabel: "적용",
                cancelLabel: "취소",
                daysOfWeek: ["일", "월", "화", "수", "목", "금", "토"],
                monthNames: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
                firstDay: 1
            },
            minDate: moment().startOf('day'),
        });

        $('#checkout').daterangepicker({
            singleDatePicker: true,
            locale: {
                format: 'YYYY-MM-DD',
                applyLabel: "적용",
                cancelLabel: "취소",
                daysOfWeek: ["일", "월", "화", "수", "목", "금", "토"],
                monthNames: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
                firstDay: 1
            },
            minDate: moment().startOf('day'),
        });
    });

    document.getElementById("guest").addEventListener("click", function() {
        document.getElementById("guest-popup").classList.toggle("show");
    });

    let personCount = ${param.count != null ? param.count : 0};

    document.getElementById("person-plus").addEventListener("click", function(event) {
        event.preventDefault();
        personCount++;
        document.getElementById("person-count").innerText = personCount;
        updateGuestText();
    });

    document.getElementById("person-minus").addEventListener("click", function(event) {
        event.preventDefault();
        if (personCount > 0) {
            personCount--;
            document.getElementById("person-count").innerText = personCount;
            updateGuestText();
        }
    });

    function updateGuestText() {
        document.getElementById("guest").value = `${personCount}명`;
        document.getElementById("count").value = personCount;
    }

    // 클릭 외부 영역 클릭 시 드롭다운 닫기
    window.onclick = function(event) {
        if (!event.target.matches('.dropbtn')) {
            var dropdowns = document.getElementsByClassName("dropdown-content");
            for (var i = 0; i < dropdowns.length; i++) {
                var openDropdown = dropdowns[i];
                if (openDropdown.classList.contains('show')) {
                    openDropdown.classList.remove('show');
                }
            }
        }
    }
</script>

<style>
    h1 {
        text-align: center;
        margin-bottom: 30px;
    }

    /* 카드 스타일 */
    .card {
        border: none;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }

    .card-body {
        padding: 15px;
    }

    .image-gallery img {
        max-height: 200px;
        object-fit: cover;
    }

    .price-new {
        font-weight: bold;
        color: #30b127;
    }

    .card-custom {
        margin-bottom: 20px;
    }
</style>
