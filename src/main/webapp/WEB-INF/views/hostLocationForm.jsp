<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="hostSideBar.jsp"%>

<style>
    @import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap');

    h2 {
        text-align: center;
        color: #ff5a5f; /* 포인트 색상 적용 */
        font-size: 28px;
        font-weight: bold;
    }

    /* 컨테이너 영역 조정 */
    .container {
        font-family: 'Do Hyeon', sans-serif;
        max-width: 800px;
        margin: 50px auto;
        padding: 30px;
        background-color: #ffffff;
        box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
        border-radius: 12px;
        min-height: 800px;
        position: relative;
        margin-left: calc(270px + 320px); /* 사이드바 너비 270px + 추가 여백 320px */
        margin-right: 20px;
    }

    form {
        display: flex;
        flex-direction: column;
        gap: 15px;
    }

    input[type="text"], input[type="button"] {
        width: 100%;
        padding: 14px;
        border: 1px solid #bdc3c7;
        border-radius: 6px;
        box-sizing: border-box;
        font-size: 1em;
    }

    input[type="button"] {
        background-color: #ff5a5f;
        color: white;
        cursor: pointer;
        font-weight: bold;
        border: none;
        transition: background-color 0.3s ease;
    }

    input[type="button"]:hover {
        background-color: #ff3a3f;
    }

    #map {
        width: 100%;
        height: 400px;
        margin-top: 20px;
        margin-bottom: 100px;
        border-radius: 10px;
        visibility: hidden;
        position: relative;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    }

    .fixed-footer {
        position: absolute;
        bottom: 20px;
        left: 0;
        width: 100%;
        background-color: #ecf0f1;
        height: 80px;
        box-shadow: 0 -2px 5px rgba(0, 0, 0, 0.1);
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 0 20px;
        box-sizing: border-box;
        border-radius: 8px;
    }

    /* 뒤로가기 버튼 스타일 */
    .fixed-footer button:first-child {
        padding: 12px 25px;
        background-color: #95a5a6; /* 부드러운 그레이 색상 */
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }

    .fixed-footer button:first-child:hover {
        background-color: #7f8c8d; /* 호버 시 더 어두운 그레이 색상 */
    }

    /* 다음 버튼 스타일 */
    .fixed-footer button:last-child {
        padding: 12px 25px;
        background-color: #ff5a5f; /* 포인트 색상 */
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }

    .fixed-footer button:last-child:hover {
        background-color: #ff3a3f; /* 호버 시 색상 변경 */
    }

    .note {
        font-size: 1.0em;
        color: #7f8c8d;
        text-align: center;
        margin-bottom: 10px;
    }

    /* 모달 스타일 */
    .modal {
        display: none;
        position: fixed;
        z-index: 1;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        overflow: auto;
        background-color: rgba(0, 0, 0, 0.6);
    }

    .modal-content {
        background-color: #ffffff;
        margin: 10% auto;
        padding: 30px;
        border: 1px solid #888;
        width: 80%;
        max-width: 600px;
        border-radius: 12px;
    }

    .close {
        color: #aaa;
        float: right;
        font-size: 28px;
        font-weight: bold;
    }

    .close:hover,
    .close:focus {
        color: #ff5a5f;
        text-decoration: none;
        cursor: pointer;
    }
</style>

<div class="container">
    <h2>숙소 위치는 어디인가요?</h2>
    <p class="note">주소는 게스트의 예약이 확정된 이후에 공개됩니다.</p>
    <form action="/host/hostPage/addLocation" method="post">
        <div class="form-group">
            <input type="button" onclick="openModal()" value="주소 검색">
        </div>

        <div id="resultForm" style="display:none;">
            <div class="form-group">
                <input type="text" id="postcode" name="postcode" placeholder="우편번호" readonly>
            </div>
            <div class="form-group">
                <input type="text" id="address" name="address" placeholder="주소" readonly>
            </div>
            <div class="form-group">
                <input type="text" id="detailAddress" name="detailAddress" placeholder="상세주소">
            </div>
            <div class="form-group">
                <input type="text" id="extraAddress" name="extraAddress" placeholder="참고항목" readonly>
            </div>
            <div class="form-group">
                <input type="hidden" id="latitude" name="latitude">
                <input type="hidden" id="longitude" name="longitude">
            </div>
        </div>

        <div id="map"></div> <!-- 지도 컨테이너 -->

        <div class="fixed-footer">
            <button type="button" onclick="goBack()">뒤로 가기</button>
            <button type="submit">다음</button>
        </div>
    </form>
</div>

<!-- 모달 -->
<div id="addressModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeModal()">&times;</span>
        <h2>주소 검색</h2>
        <div id="postcodeSearch"></div>
    </div>
</div>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0000&libraries=services"></script>
<script>
    var mapContainer = document.getElementById('map'),
        mapOption = {
            center: new daum.maps.LatLng(37.537187, 127.005476),
            level: 5
        };

    var map = new daum.maps.Map(mapContainer, mapOption);
    var geocoder = new daum.maps.services.Geocoder();
    var marker = new daum.maps.Marker({
        position: new daum.maps.LatLng(37.537187, 127.005476),
        map: map
    });

    function openModal() {
        var modal = document.getElementById("addressModal");
        modal.style.display = "block";
        new daum.Postcode({
            oncomplete: function (data) {
                document.getElementById('resultForm').style.display = 'block';
                document.getElementById('postcode').value = data.zonecode;
                document.getElementById('address').value = data.address;

                geocoder.addressSearch(data.address, function (results, status) {
                    if (status === daum.maps.services.Status.OK) {
                        var result = results[0];
                        var coords = new daum.maps.LatLng(result.y, result.x);

                        // 지도 보이기
                        mapContainer.style.visibility = "visible"; // 지도를 보이도록 설정

                        // 지도 리사이즈 이벤트 트리거
                        daum.maps.event.trigger(map, 'resize');
                        map.setCenter(coords); // 지도의 중심을 검색된 좌표로 설정
                        marker.setPosition(coords); // 마커 위치 업데이트

                        // 추가 리사이즈 (이미지 깨짐 방지)
                        setTimeout(function() {
                            daum.maps.event.trigger(map, 'resize');
                            map.setCenter(coords); // 지도의 중심을 다시 설정
                        }, 100);

                        document.getElementById("latitude").value = result.y;
                        document.getElementById("longitude").value = result.x;
                    }
                });

                // 주소 및 참고 항목 설정
                var addr = '';
                var extraAddr = '';

                if (data.userSelectedType === 'R') {
                    addr = data.roadAddress;
                    if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                        extraAddr += data.bname;
                    }
                    if (data.buildingName !== '' && data.apartment === 'Y') {
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    if (extraAddr !== '') {
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    document.getElementById("extraAddress").value = extraAddr;
                } else {
                    addr = data.jibunAddress;
                    document.getElementById("extraAddress").value = '';
                }

                document.getElementById('postcode').value = data.zonecode;
                document.getElementById("address").value = addr;
                closeModal(); // 주소 선택 후 모달 닫기
            }
        }).embed(document.getElementById('postcodeSearch'));
    }

    function closeModal() {
        var modal = document.getElementById("addressModal");
        modal.style.display = "none";
    }

    function goBack() {
        window.history.back();
    }
</script>

