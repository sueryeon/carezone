package carezone.board.service;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import carezone.board.vo.BReplyVO;
import carezone.board.vo.BoardVO;


public interface BoardService {
	public Map<String, Integer> getLists(Map<String, Integer> pagingMap) throws DataAccessException;
	public List<BoardVO> getlistBoards() throws DataAccessException;
	public int insertBoard(Map boardMap) throws DataAccessException;
	public BoardVO findBoard(int barticleNo) throws DataAccessException;
	public int updateBoard(Map boardMap) throws DataAccessException;
	public int deleteBoard(int barticleNo) throws DataAccessException;

	//댓글
	public List<BReplyVO> getlistBReplyBoards(int brparentNo) throws DataAccessException;
	public int insertBReply(BReplyVO breplyVO) throws DataAccessException;
	public int updateBReply(BReplyVO breplyVO) throws DataAccessException;
	public int deleteBReply(int brarticleNo) throws DataAccessException;
	
	//최신글 3개
	public List<BoardVO> gettopBoardList() throws DataAccessException;
}
