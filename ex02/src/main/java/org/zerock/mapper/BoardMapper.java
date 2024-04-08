package org.zerock.mapper;

import org.apache.ibatis.annotations.*;
import org.zerock.domain.BoardVO;

import java.util.List;

public interface BoardMapper {

    @Select("select * from tbl_board " +
            "where bno > 0")
    public List<BoardVO> getList();

    @Insert("insert into tbl_board(bno, title, content, writer) " +
            "values(seq_board.nextval, #{title}, #{content}, #{writer})")
    public void insert(BoardVO board);

    @SelectKey(statement = "select seq_board.nextval from dual", keyProperty = "bno", before = true, resultType = long.class)
    @Insert("insert into tbl_board(bno, title, content, writer)" +
            "values(#{bno}, #{title}, #{content}, #{writer})")
    public void insertSelectKey(BoardVO board);

    @Select("select * from tbl_board " +
            "where bno = #{bno}")
    public BoardVO read(Long bno);

    @Delete("delete from tbl_board " +
            "where bno = #{bno}")
    public int delete(Long bno);

    @Update("update tbl_board " +
            "set title = #{title}, content = #{content}, writer = #{writer}, updateDate = sysdate " +
            "where bno = #{bno}")
    public int update(BoardVO board);
}
