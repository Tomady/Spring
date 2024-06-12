package org.zerock.mapper;

import org.apache.ibatis.annotations.*;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO;

import java.util.List;

@Mapper
public interface ReplyMapper {
    @Insert("insert into tbl_reply(rno, bno, reply, replyer) " +
            "values(seq_reply.nextval, #{bno}, #{reply}, #{replyer})")
    public int insert(ReplyVO vo);

    @Select("select * from tbl_reply " +
            "where rno = #{rno}")
    public ReplyVO read(Long rno);

    @Delete("delete from tbl_reply " +
            "where rno = #{rno}")
    public int delete(Long rno);

    @Update("update tbl_reply " +
            "set reply = #{reply}, " +
            "updatedate = sysdate " +
            "where rno = #{rno}")
    public int update(ReplyVO reply);

//    @Select("select rno, bno, reply, replyer, replyDate, updateDate " +
//            "from tbl_reply " +
//            "where bno = #{bno} " +
//            "order by rno asc")
    @Select("select rno, bno, reply, replyer, replydate, updatedate " +
            "from (select /*+ index(tbl_reply idx_reply) */ " +
                    "rownum rn, rno, bno, reply, replyer, replyDate, updatedate " +
                    "from tbl_reply " +
                    "where bno = #{bno} " +
                    "and rno > 0 " +
                    "and rownum <= #{cri.pageNum} * #{cri.amount} " +
                 ") " +
            "where rn > (#{cri.pageNum} -1) * #{cri.amount}")
    public List<ReplyVO> getListWithPaging(@Param("cri") Criteria cri, @Param("bno") Long bno);

    @Select("select count(rno) " +
            "from tbl_reply " +
            "where bno = #{bno}")
    public int getCountByBno(Long bno);
}
