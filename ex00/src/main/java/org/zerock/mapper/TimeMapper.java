package org.zerock.mapper;

import org.apache.ibatis.annotations.Select;

public interface TimeMapper {
    @Select("SELECT sysdate FROM dual")
    public String getTime();

    @Select("select sysdate from dual")
    public String getTime2();
}
