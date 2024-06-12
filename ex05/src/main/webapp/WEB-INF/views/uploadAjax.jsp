<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Insert title here</title>
</head>
<body>
    <h1>Upload with Ajax</h1>

    <div class="uploadDiv">
        <input type="file" name="uploadFile" multiple>
    </div>
    <button id="uploadBtn">Upload</button>
</body>
<script>
    document.addEventListener("DOMContentLoaded", () => {
        let uploadBtn = document.getElementById("uploadBtn");
        console.log(uploadBtn);

        let regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
        let maxSize = 5242880; // 5MB
    
        uploadBtn.addEventListener("click", (e) => {
            let formData = new FormData();
            let inputFile = document.getElementsByName("uploadFile");
            let fileChk = true;
            let files = inputFile[0].files;
    
            console.log(files);

            Array.from(files).forEach(file => {
                if(!checkExtension(file.name, file.size, regex, maxSize)) {
                    fileChk = false;
                    
                    return false;
                }
                formData.append("uploadFile", file);
            });

            if(fileChk) {
                uploadFile(formData);
            }
        });
    });

    async function uploadFile(formData) {
        let url = "/uploadAjaxAction";
        const res = await fetch(url, {
            method: "post",
            body: formData
        });
        
        if(res.ok) {
            alert("Uploaded");
        }
    }

    function checkExtension(fileName, fileSize, regex, maxSize) {
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
</script>
</html>