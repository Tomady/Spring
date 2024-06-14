<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Insert title here</title>
    <style>
        .uploadResult {
            width: 100%;
            background-color: gray;
        }

        .uploadResult ul {
            display: flex;
            flex-flow: row;
            justify-content: center;
            align-items: center;
        }

        .uploadResult ul li {
            list-style: none;
            padding: 10px;
            align-content: center;
            text-align: center;
        }

        .uploadResult ul li img {
            width: 100px;
        }

        .uploadResult ul li span {
            color: white;
        }

        .bigPictureWrapper {
            position: absolute;
            display: none;
            justify-content: center;
            align-items: center;
            top: 0%;
            width: 100%;
            height: 100%;
            background-color: gray;
            z-index: 100;
            background: rgba(255, 255, 255, 0.5);
        }

        .bigPicture {
            position: relative;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .bigPicture img {
            width: 600px;
        }
    </style>
</head>
<body>
    <h1>Upload with Ajax</h1>

    <div class="uploadDiv">
        <input type="file" name="uploadFile" multiple>
    </div>

    <div class="uploadResult">
        <ul>

        </ul>
    </div>

    <button id="uploadBtn">Upload</button>

    <div class="bigPictureWrapper">
        <div class="bigPicture">

        </div>
    </div>
</body>

<script>
    let cloneObj = document.getElementsByClassName("uploadDiv")[0].cloneNode(true);

    document.addEventListener("DOMContentLoaded", () => {
        let uploadBtn = document.getElementById("uploadBtn");
        let bigPictureWrapper = document.getElementsByClassName("bigPictureWrapper")[0];
        let bigPicture = document.getElementsByClassName("bigPicture")[0];

        uploadBtn.addEventListener("click", (e) => {
            let formData = new FormData();
            let inputFile = document.getElementsByName("uploadFile");
            let files = inputFile[0].files;
            let fileChk = false;
    

            Array.from(files).forEach((file) => {
                if(!checkExtension(file.name, file.size)) {
                    fileChk = true;
                } else {
                    formData.append("uploadFile", file);
                }
            });

            if(!fileChk) {
                uploadFile(formData);
            }
        });

        // image click
        bigPictureWrapper.addEventListener("click", function(e) {
            bigPicture.animate({width:"0%", height: "0%"}, 1000);
            // IE에서는 화살표 함수 지원 안함.
            // setTimeout(() => {
            setTimeout(function() {
                // this.style.visibility = "hidden";
                bigPictureWrapper.style.visibility = "hidden";
            }, 1000);
        });
    });

    async function uploadFile(formData) {
        let url = "/uploadAjaxAction";
        const res = await fetch(url, {
            method: "post",
            body: formData,
        });
        
        if(res.ok) {
            let result = await res.json();
            showUploadedFile(result);
            document.getElementsByClassName("uploadDiv")[0].innerHTML = cloneObj.innerHTML;
        }
    }

    function checkExtension(fileName, fileSize) {
        let regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
        let maxSize = 5242880; // 5MB

        if(fileSize >= maxSize) {
            alert("파일 사이즈 초과");
            
            return false;
        }

        if(regex.test(fileName)) {
            alert("해당 종류의 파일은 업로드 할 수 없습니다.");

            return false;
        }

        return true;
    }

    function showUploadedFile(uploadResultArr) {
        let uploadResult = document.getElementsByClassName("uploadResult")[0].firstChild.nextSibling;
        let str = "";

        uploadResultArr.forEach((obj) => {
            if(!obj.image) {
                let fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
                str += "<li><a href='/download?fileName=" + fileCallPath + "'><img src='/resources/img/attach.png'>" + obj.fileName + "</a></li>";
            } else {
                let fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
                let originPath = obj.uploadPath + "\\" + obj.uuid + "_" + obj.fileName;
                originPath = originPath.replace(new RegExp(/\\/g), "/");
                str += "<li><a href=\"javascript:showImage(\'" + originPath + "\')\"><img src='/display?fileName=" + fileCallPath + "'></a></li>";
            }
        });
        uploadResult.innerHTML = str;
    }

    function showImage(fileCallPath) {
        let bigPictureWrapper = document.getElementsByClassName("bigPictureWrapper")[0];
        console.log("bigPictureWrapper", bigPictureWrapper);
        bigPictureWrapper.style.display = "flex";
        bigPictureWrapper.style.visibility = "visible";
        
        let bigPicture = document.getElementsByClassName("bigPicture")[0];
        bigPicture.innerHTML = "<img src='/display?fileName=" + encodeURI(fileCallPath) + "'>";
        bigPicture.animate({width:"100%", height: "100%"}, 1000);
    }
</script>
</html>