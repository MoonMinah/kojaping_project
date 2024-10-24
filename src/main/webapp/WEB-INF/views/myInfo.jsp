<%--
  Created by IntelliJ IDEA.
  User: jihyun
  Date: 9/21/24
  Time: 9:11 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<style>
  /* 본문 내용을 사이드바 너비만큼 밀어내기 */
  #content {
    margin-left: 270px; /* 사이드바 너비 250px + 여유 공간 20px */
    padding: 20px;
    margin-top: 50px;
  }

  /* 테이블 스타일링 */
  .table {
    margin: 0 auto;
    max-width: 600px;
    background-color: #fff;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    border-radius: 10px;
    border: none; /* 테이블 테두리 제거 */
    overflow: hidden;
  }

  .table td, .table th {
    padding: 15px;
    vertical-align: middle;
    border-bottom: 1px solid #e9ecef;
  }

  .table th {
    background-color: #f8f9fa; /* 헤더 배경 */
    font-weight: bold;
  }

  .table td input {
    width: 100%;
    padding: 8px;
    border: 1px solid #ccc;
    border-radius: 4px;
  }

  /* 버튼 스타일 (우선순위 높이기 위해 !important 사용) */
  .btn {
    padding: 10px 20px !important;
    border-radius: 25px !important;
    font-size: 16px !important;
    transition: all 0.3s ease !important;
  }

  .btn-primary {
    background-color: #007bff !important;
    color: #fff !important;
    border: none !important;
  }

  .btn-primary:hover {
    background-color: #0056b3 !important;
  }

  .btn-danger {
    background-color: #dc3545 !important;
    color: #fff !important;
    border: none !important;
  }

  .btn-danger:hover {
    background-color: #c82333 !important;
  }

  .btn-secondary {
    background-color: #6c757d !important;
    color: #fff !important;
    border: none !important;
  }

  .btn-secondary:hover {
    background-color: #545b62 !important;
  }

  /* 카드 스타일 */
  .mypage-info {
    background-color: #fff;
    padding: 20px;
    border-radius: 15px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    max-width: 700px;
    margin: 0 auto;
  }

  /* 반응형 디자인 */
  @media (max-width: 768px) {
    #content {
      margin-left: 0;
    }

    #sidebar {
      position: relative;
      width: 100%;
      height: auto;
    }

    .btn {
      width: 100% !important;
      margin-bottom: 10px !important;
    }
  }

  @media (max-width: 576px) {
    .table td input {
      width: 100%;
      padding: 8px;
    }
  }

</style>

<%
  String contextPath = request.getContextPath();
%>
<jsp:include page="guestSideBar.jsp" />

<div id="content" class="p-4"> <!-- 사이드바와의 간격을 위한 마진 추가 -->

  <header class="text-center mb-4">
    <h2 class="font-weight-bold">나의 정보</h2>
    <p class="text-muted">회원 정보를 수정하거나 탈퇴할 수 있습니다.</p>
  </header>

  <c:if test="${not empty message}">
    <script>
      alert('${message}');
    </script>
  </c:if>

  <div class="mypage-info">
    <form action="<%=contextPath%>/guest/mypage/update" method="post">
      <table class="table table-hover text-center"> <!-- 테이블 텍스트 중앙 정렬 -->
        <thead>
        <tr>
          <th colspan="2">회원 정보</th>
        </tr>
        </thead>
        <tbody>
        <tr>
          <td>아이디</td>
          <td><input type="text" name="userId" value="${loginMember.userId}" readonly></td>
        </tr>
        <tr>
          <td>패스워드</td>
          <td><input type="password" name="password" value="${loginMember.password}"></td>
        </tr>
        <tr>
          <td>이름</td>
          <td><input type="text" name="userName" value="${loginMember.userName}"></td>
        </tr>
        <tr>
          <td>이메일</td>
          <td><input type="email" name="email" value="${loginMember.email}"></td>
        </tr>
        <tr>
          <td>전화번호</td>
          <td><input type="tel" name="phone" value="${loginMember.phone}"></td>
        </tr>
        <tr>
          <td colspan="2">
            <button type="submit" class="btn btn-primary">회원수정</button>
            <button type="button" class="btn btn-danger" onclick="deleteMember()">회원탈퇴</button>
          </td>
        </tr>
        </tbody>
      </table>
    </form>
  </div>
</div>


<!-- jQuery 및 Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>
  function deleteMember() {
    if (confirm("정말로 회원탈퇴를 하시겠습니까?")) {
      location.href="<%=contextPath%>/guest/mypage/delete";
    }
  }
</script>
