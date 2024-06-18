package org.zerock.mapper;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.zerock.domain.BoardAttachVO;

import java.util.List;

public interface BoardAttachMapper {

    @Insert("insert into tbl_attach(uuid, uploadpath, filename, filetype, bno " +
            "values(#{uuid}, #{uploadPath}, #{fileName}, #{fileType}, #{bno}")
    public void insert(BoardAttachVO vo);

    @Delete("delete from tbl_attach " +
            "where uuid = #{uuid}")
    public void delete(String uuid);

    @Select("select * from tbl_attach " +
            "where bno = #{bno}")
    public List<BoardAttachVO> findByBno(Long bno);
}
