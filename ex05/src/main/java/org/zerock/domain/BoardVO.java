package org.zerock.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.Date;
import java.util.List;

@Setter
@Getter
@ToString
public class BoardVO {
    private int bno;
    private String title;
    private String content;
    private String writer;
    private Date regdate;
    private Date updatedate;

    private int replyCnt;

    private List<BoardAttachVO> attachList;
}
