<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="hostSideBar.jsp" %>
<html>
<head>
    <title>Title</title>
</head>
<body>

<!-- 페이지 콘텐츠 -->
<div id="content">
    <div class="container">
        <h1> 삭제하고자 하는 숙소를 선택해주세요 </h1>

        <!-- 등록된 숙소가 없을 때 -->
        <c:if test="${noAccommodations}">
            <p>등록된 숙소가 없습니다. 숙소를 등록해보세요!</p>
        </c:if>

        <!-- 이미지 리스트가 존재할 경우 -->
        <c:if test="${not empty imageList}">
            <div class="image-container">
                <c:forEach var="image" items="${imageList}">
                    <img src="${image}" alt="숙소 사진" onclick="confirmDelete('${image}')"/>
                </c:forEach>
            </div>
            <!-- 삭제 폼 -->
            <form id="deleteForm" action="/host/hostPage/deleteAccommodation" method="post">
                <input type="hidden" id="imageUrlInput" name="imageUrl"/>
            </form>
        </c:if>
    </div>
</div>

<script>
    // 삭제 확인 함수
    function confirmDelete(imageUrl) {
        if (confirm('이 숙소를 삭제하시겠습니까?')) {
            document.getElementById('imageUrlInput').value = imageUrl;
            document.getElementById('deleteForm').submit();
        }
    }
</script>

</body>
</html>
