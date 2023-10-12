package carezone.board.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import carezone.board.dao.BoardDAO;
import carezone.board.vo.BReplyVO;
import carezone.board.vo.BoardVO;

@Service("boardService")
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	private BoardDAO boardDAO;
	
	//페이징 게시글 select
	@Override
	public Map<String, Integer> getLists(Map<String, Integer> pagingMap) throws DataAccessException {
		System.out.println("---- BoardServiceImpl의 getLists() 도착 ----");
		Map articleMap = new HashMap();
		List<BoardVO> boardList = boardDAO.getLists(pagingMap); //글 목록 조회
		int countArticleNo = boardDAO.getcountArticleNo(); //전체 글 수 조회
		
		System.out.println("DAO 다녀옴");
		System.out.println("전체 글 수 조회 : "+countArticleNo);
		articleMap.put("boardList", boardList);
		articleMap.put("countArticleNo", countArticleNo);
		 
		return articleMap;
	}

	//전체 게시글 select 안쓰는거.
	@Override
	public List<BoardVO> getlistBoards() throws DataAccessException {
		System.out.println("BoardServiceImpl의 getlistBoards() 도착");
		List<BoardVO> boardsList = boardDAO.getlistBoards();
		
		return boardsList;
	}

	//게시글 1개 insert
	@Override
	public int insertBoard(Map boardMap) throws DataAccessException {
		System.out.println("BoardServiceImpl의 insertBoard() 도착");
		int barticleNo = boardDAO.insertBoard(boardMap);
		return barticleNo;
	}

	//게시글 1개 select
	@Override
	public BoardVO findBoard(int barticleNo) throws DataAccessException {
		System.out.println("BoardServiceImpl의 findBoard() 도착");
		BoardVO boardVO = boardDAO.findBoard(barticleNo);
		
		return boardVO;
	}

	//게시글 1개 update
	@Override
	public int updateBoard(Map boardMap) throws DataAccessException {
		System.out.println("BoardServiceImpl의 updateBoard() 도착");
		int result = boardDAO.updateBoard(boardMap);
		
		return result;
	}

	//게시글 1개 삭제
	@Override
	public int deleteBoard(int barticleNo) throws DataAccessException {
		System.out.println("boardService의 deleteBoard() 도착");
		System.out.println("삭제할 글 번호 : "+barticleNo);
		int result = boardDAO.deleteBoard(barticleNo);
		return result;
	}

	//게시글의 댓글 조회
	@Override
	public List<BReplyVO> getlistBReplyBoards(int brparentNo) throws DataAccessException {
		System.out.println("boardServiceImpl의 getlistBReplyBoards() 도착");
		System.out.println("댓글단 게시판 번호 : "+brparentNo);
		List<BReplyVO> replysList = boardDAO.getlistBReplyBoards(brparentNo);
		
		return replysList;
	}

	//댓글 1개 insert
	@Override
	public int insertBReply(BReplyVO breplyVO) throws DataAccessException {
		System.out.println("boardService의 insertBReply() 도착");
		System.out.println("댓글 단 회원 아이디 : "+breplyVO.getBrid());
		
		int result = boardDAO.insertBReply(breplyVO);
		return result;
	}

	//댓글 1개 update
	@Override
	public int updateBReply(BReplyVO breplyVO) throws DataAccessException {
		System.out.println("--- boardservice updateBReplyVO ---");
		System.out.println("댓글 수정 barticleNo : "+breplyVO.getBrarticleNo());
		int result = boardDAO.updateBReply(breplyVO);
		return result;
	}

	//댓글 1개 delete
	@Override
	public int deleteBReply(int brarticleNo) throws DataAccessException {
		System.out.println("--- boardservice deleteBReply() 도착 ---");
		System.out.println("삭제할 댓글 : "+brarticleNo);
		
		int result = boardDAO.deleteBReply(brarticleNo);
		return result;
	}

	
	//게시판 최신글 3개 select
	@Override
	public List<BoardVO> gettopBoardList() throws DataAccessException {
		System.out.println("--- boardservice gettopBoardList() 도착 ---");
		List<BoardVO> topBoardList = boardDAO.gettopBoardList();
		return topBoardList;
	}
	

}
