package org.zerock.domain;

import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

@Data
public class TodoDTO {
    private String title;

    @DateTimeFormat(pattern = "yyyy/MM/dd")
    private Data dueDate;
}
