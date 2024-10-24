<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
  <title>Product List</title>
</head>
<body>
<h1>Product List</h1>
<table>
  <tr>
    <th>Accommodation No</th>
    <th>title</th>
    <th>Description</th>
    <th>PricePerNight</th>
    <th>latitude</th>
    <th>longitude</th>
    <th>postcode</th>
    <th>address</th>
    <th>detailAddress</th>
    <th>maxGuest</th>
    <th>bedroomCnt</th>
    <th>bedCnt</th>
    <th>bathCnt</th>
    <th>locationNo</th>

  </tr>
  <c:if test="${not empty products}">
    <c:forEach var="product" items="${products}">
      <tr>
        <td>${product.accommodationNo}</td>
        <td>${product.title}</td>
        <td>${product.description}</td>
        <td>${product.pricePerNight}</td>
        <td>${product.latitude}</td>
        <td>${product.longitude}</td>
        <td>${product.postcode}</td>
        <td>${product.address}</td>
        <td>${product.detailAddress}</td>
        <td>${product.maxGuest}</td>
        <td>${product.bedroomCnt}</td>
        <td>${product.bedCnt}</td>
        <td>${product.bathCnt}</td>
        <td>${product.locationNo}</td>
      </tr>
    </c:forEach>
  </c:if>

</table>
</body>
</html>
