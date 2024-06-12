package org.zerock.service;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.mapper.BoardMapper;

import java.util.List;

@Slf4j
@Service
@AllArgsConstructor
public class BoardServiceImpl implements BoardService {
    private BoardMapper mapper;

    @Override
    public void register(BoardVO board) {
        log.info("board Register......." + board);

        mapper.insertSelectKey(board);
    }

    @Override
    public BoardVO get(int bno) {
        log.info("board Get......." + bno);

        return mapper.read(bno);
    }

    @Override
    public boolean modify(BoardVO board) {
        log.info("board Modify......." + board);

        return mapper.update(board) == 1;
    }

    @Override
    public boolean remove(int bno) {
        log.info("board Remove......." + bno);

        return mapper.delete(bno) == 1;
    }

//    @Override
//    public List<BoardVO> getList() {
//        log.info("getList.......");
//
//        return mapper.getList();
//    }

    @Override
    public List<BoardVO> getList(Criteria cri) {
        log.info("get List with criteria: " + cri);

        return mapper.getListWithPaging(cri);
    }

    @Override
    public int getTotal(Criteria cri) {
        log.info("get total count");

        return mapper.getTotalCount(cri);
    }
}
