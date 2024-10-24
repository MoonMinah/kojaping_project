
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="header.jsp" />

<%--<head>
    <title>숙소 목록</title>
    <!-- Bootstrap을 추가하여 스타일 적용 -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        .card-custom {
            margin-bottom: 20px;
        }
        .price-old {
            text-decoration: line-through;
            color: red;
        }
        .price-new {
            font-weight: bold;
            color: #30b127;
        }
    </style>
</head>--%>
<body>
<div class="container">
    <h1>숙소 목록</h1>
    <div class="row">
        <c:forEach var="accommodation" items="${accommodations}">
            <div class="col-md-4">
                <div class="card card-custom">


                    <img src="${accommodation.imageUrls[0]}" class="card-img-top" alt="숙소 이미지">

                    <div class="card-body">
                        <h5 class="card-title">${accommodation.title}</h5>

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
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>

