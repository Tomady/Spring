package org.zerock.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.List;

@Getter
@Setter
@ToString
@AllArgsConstructor
public class ReplyPageDTO {
    private int replyCnt;
    private List<ReplyVO> list;
}
