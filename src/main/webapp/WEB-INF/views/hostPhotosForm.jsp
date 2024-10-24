<%--
  Created by IntelliJ IDEA.
  User: jihyun
  Date: 9/23/24
  Time: 6:33 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@include file="hostSideBar.jsp"%>

<div class="container">
    <div class="bg-pan-top">
        <h1 class="tracking-in-expand"> 숙소 사진 등록 </h1>
        <form id="imageUploadForm" onsubmit="submitForm(event)" method="post" enctype="multipart/form-data">
            <input type="hidden" name="postcode" value="${postcode}">
            <input type="hidden" name="address" value="${address}">
            <input type="hidden" name="detailAddress" value="${detailAddress}">
            <input type="hidden" name="extraAddress" value="${extraAddress}">
            <input type="hidden" name="latitude" value="${latitude}">
            <input type="hidden" name="longitude" value="${longitude}">
            <input type="hidden" name="locationNo" value="${locationNo}">
            <input type="hidden" name="memberNo" value="${memberNo}">
            <input type="hidden" name="amenityName" value="${amenityName}">
            <input type="hidden" name="title" value="${title}">
            <input type="hidden" name="description" value="${description}">
            <input type="hidden" name="pricePerNight" value="${pricePerNight}">
            <input type="hidden" name="maxGuest" value="${maxGuest}">
            <input type="hidden" name="bedroomCnt" value="${bedroomCnt}">
            <input type="hidden" name="bedCnt" value="${bedCnt}">
            <input type="hidden" name="bathCnt" value="${bathCnt}">

            <p class="note">사진은 최대 10장까지 등록이 가능합니다.</p>
            <label for="images" class="custom-file-upload">사진 선택하기</label>
            <input type="file" name="images" id="images" multiple onchange="previewPhotos(event)">

            <!-- 사진 프리뷰를 스크롤 가능하게 -->
            <div id="photo-preview" class="photos-preview"></div>

            <!-- 하단 고정 영역 추가 -->
            <div class="fixed-footer">
                <button type="button" class="back-btn" onclick="goBack()">뒤로 가기</button>
                <span class="step-indicator">단계 4/5</span>
                <button type="submit" class="next-btn">다음</button>
            </div>
        </form>
    </div>
</div>

<style>
    @import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap');

    h1 {
        text-align: center;
        color: #ff5a5f; /* 포인트 색상 적용 */
        margin-top: 20px;
        font-family: 'Do Hyeon', sans-serif;
    }

    /* 컨테이너 위치와 스타일 */
    .container {
        font-family: 'Do Hyeon', sans-serif;
        max-width: 900px;
        margin: 50px auto;
        padding: 30px;
        background-color: #fff;
        box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
        border-radius: 12px;
        position: relative;
        padding-bottom: 150px; /* fixed-footer와 겹치지 않도록 여유 공간 추가 */
        margin-left: calc(270px + 320px); /* 사이드바 너비 + 여백 */
        margin-right: 20px;
        min-height: 700px; /* 세로 영역을 넉넉하게 */
    }

    /* 사진 프리뷰에 스크롤 적용 */
    .photos-preview {
        display: flex;
        flex-wrap: wrap;
        gap: 10px;
        max-height: 400px;
        overflow-y: auto;
        padding: 10px;
        background-color: #f9f9f9;
        border-radius: 10px;
    }

    .photo-container {
        position: relative;
        display: inline-block;
    }

    .photo-container img {
        max-width: 150px;
        max-height: 150px;
        border-radius: 5px;
    }

    input[type="file"] {
        display: none;
    }

    .custom-file-upload {
        display: inline-block;
        padding: 10px 20px;
        background-color: #ff5a5f; /* 포인트 색상 적용 */
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        text-align: center;
        font-size: 16px;
        margin: 10px;
    }

    .custom-file-upload:hover {
        background-color: #ff3a3f;
    }

    .note {
        font-size: 14px;
        color: #666;
        text-align: center;
        margin-bottom: 10px;
    }

    .delete-icon {
        position: absolute;
        top: 5px;
        right: 5px;
        background: rgba(0, 0, 0, 0.6);
        border-radius: 50%;
        color: white;
        padding: 5px;
        cursor: pointer;
        font-size: 12px;
        width: 24px;
        height: 24px;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .bg-pan-top {
        -webkit-animation: bg-pan-top 8s infinite alternate;
        animation: bg-pan-top 8s infinite alternate;
    }

    @-webkit-keyframes bg-pan-top {
        0% { background-color: #b4d3e6; }
        100% { background-color: #cfe6e8; }
    }

    @keyframes bg-pan-top {
        0% { background-color: #b4d3e6; }
        100% { background-color: #cfe6e8; }
    }

    .tracking-in-expand {
        -webkit-animation: tracking-in-expand 0.7s cubic-bezier(0.215, 0.610, 0.355, 1.000) both;
        animation: tracking-in-expand 0.7s cubic-bezier(0.215, 0.610, 0.355, 1.000) both;
    }

    @-webkit-keyframes tracking-in-expand {
        0% {
            letter-spacing: -0.5em;
            opacity: 0;
        }
        40% {
            opacity: 0.6;
        }
        100% {
            opacity: 1;
        }
    }

    @keyframes tracking-in-expand {
        0% {
            letter-spacing: -0.5em;
            opacity: 0;
        }
        40% {
            opacity: 0.6;
        }
        100% {
            opacity: 1;
        }
    }

    /* 하단 고정 영역 스타일 (fixed-footer를 container 내부로 수정) */
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
        bottom: 20px; /* container 내부에 위치하게 수정 */
        left: 0;
        right: 0;
    }

    .back-btn, .next-btn {
        padding: 12px 25px;
        background-color: #ff5a5f;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        font-size: 16px;
    }

    .back-btn:hover, .next-btn:hover {
        background-color: #ff3a3f;
    }

    .step-indicator {
        font-size: 1em;
        color: #666;
    }

    /* 반응형 디자인 */
    @media (max-width: 768px) {
        .container {
            margin-left: 20px;
            margin-right: 20px;
        }
    }
</style>

<script>
    let photoCount = 0;
    const maxPhotos = 10;
    let fileList = [];  // 선택된 파일을 임시로 저장

    function previewPhotos(event) {
        const files = event.target.files;
        const previewContainer = document.getElementById('photo-preview');

        if (photoCount + files.length > maxPhotos) {
            alert(`최대 ${maxPhotos}개의 사진만 업로드할 수 있습니다.`);
            return;
        }

        Array.from(files).forEach(file => {
            if (photoCount >= maxPhotos) return;

            fileList.push(file);

            const reader = new FileReader();
            reader.onload = function (e) {
                const photoContainer = document.createElement('div');
                photoContainer.classList.add('photo-container');

                const img = document.createElement('img');
                img.src = e.target.result;
                photoContainer.appendChild(img);

                const deleteIcon = document.createElement('span');
                deleteIcon.classList.add('delete-icon');
                deleteIcon.innerHTML = '🗑';
                deleteIcon.onclick = () => {
                    photoContainer.remove();
                    fileList = fileList.filter(f => f.name !== file.name);
                    photoCount--;
                };
                photoContainer.appendChild(deleteIcon);

                previewContainer.appendChild(photoContainer);
                photoCount++;
            };
            reader.readAsDataURL(file);
        });
    }

    function submitForm(event) {
        event.preventDefault();

        const formData = new FormData();
        fileList.forEach(file => {
            formData.append('images', file);
        });

        document.querySelectorAll('input[type=hidden]').forEach(input => {
            formData.append(input.name, input.value);
        });

        fetch('/host/hostPage/addPhotos', {
            method: 'POST',
            body: formData
        })
            .then(response => {
                if (response.ok) {
                    window.location.href = "/host/hostPage/myAccommodations";
                } else {
                    alert("이미지 업로드 실패");
                }
            })
            .catch(error => {
                console.error("Error:", error);
            });
    }

    function goBack() {
        window.history.back();
    }
</script>

