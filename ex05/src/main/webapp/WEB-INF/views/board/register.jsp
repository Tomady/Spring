<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!-- add header -->
<%@ include file="../includes/header.jsp" %>
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

<div id="wrapper">
    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">Board Register</h1>
            </div>
            <!-- /.col-lg-12 -->
        </div>
        <!-- /.row -->
        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-heading">Board Register</div>
                    <!-- /.panel-heading -->
                    <div class="panel-body">
                        <form role="form" action="/board/register" method="post">
                            <div class="form-group">
                                <label>Title</label>
                                <input class="form-control" name="title">
                            </div>
                            <div class="form-group">
                                <label>Content</label>
                                <textarea class="form-control" rows="3" name="content"></textarea>
                            </div>
                            <div class="form-group">
                                <label>Writer</label>
                                <input class="form-control" name="writer">
                            </div>
                            <button id="btnSubmit" type="submit" class="btn btn-default">Submit Button</button>
                            <button type="reset" class="btn btn-default">Reset Button</button>
                        </form>
                    </div>
                    <!-- end panel-body -->
                </div>
                <!-- end panel-body -->
            </div>
            <!-- end panel -->
        </div>
        <!-- /.row -->
        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-heading">File Attach</div>
                    <!-- /.panel-heading -->
                    <div class="panel-body">
                        <div class="form-group uploadDiv">
                            <input id="uploadFile" type="file" name="uploadFile" multiple>
                        </div>
                        <div id="uploadResult" class="uploadResult">
                            <ul>

                            </ul>
                        </div>
                    </div>
                    <!-- end panel-body -->
                </div>
                <!-- end panel -->
            </div>
            <!-- end col-lg-12 -->
        </div>
        <!-- end row -->
    </div>
    <!-- page-wrapper -->
</div>
<!-- wrapper -->
<!-- add footer -->
<%@ include file="../includes/footer.jsp" %>

<script>
    let regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
    let maxSize = 5242880; // 5MB

    document.addEventListener("DOMContentLoaded", () => {
        let formObj = document.forms[0];
        let submitBtn = document.getElementById("btnSubmit");
        let uploadFile = document.getElementById("uploadFile");
        let uploadResult = document.getElementById("uploadResult");

        // add submit button event
        submitBtn.addEventListener("click", (e) => {
            e.preventDefault();

            let str = "";
            let uploadResultLi = uploadResult.children[0].children;
            let appendDiv = document.createElement("div");

            Array.from(uploadResultLi).forEach((obj, idx) => {
                str += "<input type='hidden' name='attachList[" + idx + "].fileName' value='" + obj.dataset.filename + "'>";
                str += "<input type='hidden' name='attachList[" + idx + "].uuid' value='" + obj.dataset.uuid + "'>";
                str += "<input type='hidden' name='attachList[" + idx + "].uploadPath' value='" + obj.dataset.path + "'>";
                str += "<input type='hidden' name='attachList[" + idx + "].fileType' value='" + obj.dataset.type + "'>";
            });
            
            appendDiv.innerHTML = str;
            formObj.append(appendDiv);
            formObj.submit();
        });

        // add file input event
        uploadFile.addEventListener("change", (e) => {
            let formData = new FormData();
            let files = uploadFile.files;
            let fileChk = false;

            Array.from(files).forEach((file) => {
                if(!checkExtension(file.name, file.size)) {
                    fileChk = true;

                    return;
                } else {
                    formData.append("uploadFile", file);
                }
            });

            if(!fileChk) {
                uploadAjaxAction(formData);
            } else {
                return false;
            }
        });

        // add uploadResult event
        uploadResult.addEventListener("click", function() {
            let deleteBtn = this.getElementsByTagName("button")[0];
            console.log(deleteBtn);

            if(deleteBtn != null) {
                let targetFile = deleteBtn.dataset.file;
                let type = deleteBtn.dataset.type;
                let targetLi = deleteBtn.closest("li");
                let data = {
                    fileName: targetFile,
                    type: type,
                };
                let formBody = [];

                for(let prop in data) {
                    let encodedKey = encodeURIComponent(prop);
                    let encodedValue = encodeURIComponent(data[prop]);
                    formBody.push(encodedKey + "=" + encodedValue);
                }
                formBody = formBody.join("&");

                let result = deleteFile(formBody);

                result.then(() => {
                    targetLi.remove();
                }).catch(() => {
                    alert("삭제 실패");
                });
            }
        });
    });

    // check file
    function checkExtension(fileName, fileSize) {
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

    // show upload result
    function showUploadResult(uploadResultArr) {
        if(!uploadResultArr || uploadResultArr.length == 0) {
            return;
        }

        let uploadUL = document.getElementsByClassName("uploadResult")[0].firstChild.nextSibling;
        let str = "";

        // image type
        uploadResultArr.forEach((obj) => {
            console.log("obj", obj);

            if(obj.image) {
                let fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);

                str += "<li data-path='" + obj.uploadPath + "' data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "' data-type='" + obj.image + "'>";
                str += "<div>";
                str += "<span> " + obj.fileName + " </span>";
                str += "<button type='button' data-file=\'" + fileCallPath + "\' data-type='image' class='btn btn-warning btn-circle'>";
                str += "<i class='fa fa-times'></i>";
                str += "</button><br>";
                str += "<img src='/display?fileName=" + fileCallPath + "'>";
                str += "</div>";
                str += "</li>";
            } else {
                let fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
                let fileLink = fileCallPath.replace(new RegExp(/\\/g), "/");

                str += "<li data-path='" + obj.uploadPath + "' data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "' data-type='" + obj.image + "'>";
                str += "<div>";
                str += "<span> " + obj.fileName + "</span>";
                str += "<button type='button' data-file=\'" + fileCallPath + "\' data-type='file' class='btn btn-warning btn-circle'>";
                str += "<i class='fa fa-times'></i>"
                str += "</button><br>";
                str += "<img src='/resources/img/attach.png'>";
                str += "</div>";
                str += "</li>";
            }
        });
        uploadUL.innerHTML = uploadUL.innerHTML + str;
    }

    // ajax uploadAjaxAction
    async function uploadAjaxAction(data) {
        let url = "/uploadAjaxAction";
        let res = await fetch(url, {
            method: "post",
            body: data
        });

        if(res.ok) {
            let result = await res.json();
            console.log(result);
            showUploadResult(result);
        }
    }

    // ajax deleteFile
    async function deleteFile(data) {
        let url = "/deleteFile";
        let res = await fetch(url, {
            method: "post",
            headers: {
                "Content-Type": "application/x-www-form-urlencoded"
            },
            body: data
        });

        if(res.ok) {
            let result = await res.text();
            alert(result);
        } else {
            return Promise.reject("삭제 실패");
        }
    }
</script>
