package org.zerock.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;

@Controller
@Slf4j
public class UploadController {

    @GetMapping("/uploadForm")
    public void uploadForm() {
        log.info("upload form");
    }

    @PostMapping("/uploadFormAction")
    public void uploadFormPost(MultipartFile[] uploadFile, Model model) {
        String uploadFolder = "E:\\5.study\\upload";

        for(MultipartFile multipartFile : uploadFile) {
            log.info("-------------------------------");
            log.info("Upload File Name: " + multipartFile.getOriginalFilename());
            log.info("Upload File Size : " + multipartFile.getSize());

            File saveFile = new File(uploadFolder, multipartFile.getOriginalFilename());

            try {
                multipartFile.transferTo(saveFile);
            } catch (Exception e) {
                log.error(e.getMessage());
            }
        }
    }

    @GetMapping("/uploadAjax")
    public void uploadAjax() {
        log.info("upload ajax");
    }

    @PostMapping("/uploadAjaxAction")
    public void uploadAjaxPost(MultipartFile[] uploadFile) {
        log.info("update ajax post........");

        String uploadFolder = "E:\\5.study\\upload";

        // make folder
        File uploadPath = new File(uploadFolder, getFolder());
        log.info("upload path: " + uploadPath);

        if(!uploadPath.exists()) {
            // make yyyy/MM/dd folder
            uploadPath.mkdirs();
        }

        for(MultipartFile multipartFile : uploadFile) {
            String uploadFileName = multipartFile.getOriginalFilename();

            log.info("-----------------------------");
            log.info("Upload File Name: " + uploadFileName);
            log.info("Upload file Size: " + multipartFile.getSize());

            // IE has file path
            uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);

            log.info("only file name: " + uploadFileName);

//            File saveFile = new File(uploadFolder, uploadFileName);
            File saveFile = new File(uploadPath, uploadFileName);

            try {
                multipartFile.transferTo(saveFile);
            } catch (Exception e) {
                log.error(e.getMessage());
            }
        }
    }

    private String getFolder() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date date = new Date();
        String str = sdf.format(date);

        return str.replace("-", File.separator);
    }
}
