package carezone.board.dao;

import java.util.List;
import java.util.Map;


import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import carezone.board.vo.BReplyVO;
import carezone.board.vo.BoardVO;

@Repository("boardDAO")
public class BoardDAOImpl implements BoardDAO {
	
	@Autowired
	private SqlSession sqlSession;
	
	//페이징 게시판
	@Override
	public List getLists(Map<String, Integer> pagingMap) throws DataAccessException {
		System.out.println("BoardDAOImpl의 getLists 도착");
		BoardVO bVO = new BoardVO();
		int offset = (Integer) pagingMap.get("offset");
		System.out.println("section : "+offset);
		List<BoardVO> boardList = sqlSession.selectList("mapper.board.selectAllBoard",pagingMap);
		if(boardList.size()==0) {
			System.out.println("null입니다.");
			
		} 
		else {
			for(int i=0; i<boardList.size(); i++) {
				bVO = boardList.get(i);
				System.out.println("boardVO articleNo : "+bVO.getBarticleNo());
			}
		}
		
		return boardList;
	}
	
	
	//전체 글 수 조회
	@Override
	public int getcountArticleNo() throws DataAccessException {
		int countArticleNo = sqlSession.selectOne("mapper.board.countArticleNo");
		return countArticleNo;
	}



	//전체 게시글 select
	@Override
	public List<BoardVO> getlistBoards() throws DataAccessException {
		System.out.println("BoardDAOImpl의 getlistBoards() 도착");
		BoardVO boardVO = new BoardVO();
		List<BoardVO> boardsList = sqlSession.selectList("mapper.board.selectAllBoardList");
		
		if(boardsList.size()==0) {
			System.out.println("boardsList = null입니다.");
		}
		else {
			for(int i=0; i<boardsList.size(); i++) {
				boardVO = boardsList.get(i);
				System.out.println("boardVO의 articleNo :"+boardVO.getBarticleNo());
			}
		}
		
		return boardsList;
	}

	//게시글 1개 insert
	@Override
	public int insertBoard(Map boardMap) throws DataAccessException {
		System.out.println("BoardDAOImpl의 insertBoard() 도착");
		int result = sqlSession.insert("mapper.board.insertBoard", boardMap);
		int barticleNo = (int) sqlSession.selectOne("mapper.board.selectBarticleNo");
		return barticleNo;
	}

	//게시글 1개 select
	@Override
	public BoardVO findBoard(int barticleNo) throws DataAccessException {
		System.out.println("BoardDAOImpl의 findBoard() 도착");
		BoardVO boardVO = (BoardVO) sqlSession.selectOne("mapper.board.selectBoard", barticleNo);
		return boardVO;
	}

	//게시글 1개 update
	@Override
	public int updateBoard(Map boardMap) throws DataAccessException {
		System.out.println("BoardDAO의 updateBoard() 도착");
		int result = sqlSession.update("mapper.board.updateBoard", boardMap);
		return result;
	}

	//게시글 1개 삭제
	@Override
	public int deleteBoard(int barticleNo) throws DataAccessException {
		System.out.println("BoardDAO의 deleteBoard() 도착");
		System.out.println("삭제할 글 번호 : "+barticleNo);
		int result = sqlSession.delete("mapper.board.deleteBoard",barticleNo);
		return result;
	}

	//게시글의 댓글 조회
	@Override
	public List<BReplyVO> getlistBReplyBoards(int brparentNo) throws DataAccessException {
		System.out.println("BoardDAO의 getlistBReplyBoards() 도착");
		System.out.println("댓글의 게시판 번호 : "+brparentNo);
		List<BReplyVO> replysList = sqlSession.selectList("mapper.board.selectBReply",brparentNo);
		return replysList;
	}

	//댓글 1개 insert
	@Override
	public int insertBReply(BReplyVO breplyVO) throws DataAccessException {
		System.out.println("boardDAO의 insertBReply() 도착");
		System.out.println("댓글 쓴 회원 : "+breplyVO.getBrid());
		int result = sqlSession.insert("mapper.board.insertBReply", breplyVO);
		return result;
	}

	//댓글 1개 update
	@Override
	public int updateBReply(BReplyVO breplyVO) throws DataAccessException {
		System.out.println("--- boardDAO의 updateBReply() ---");
		System.out.println("댓글 수정 brarticleNo : "+breplyVO.getBrarticleNo());
		int result = sqlSession.update("mapper.board.updateBReply", breplyVO);
		return result;
	}

	//댓글 1개 delete
	@Override
	public int deleteBReply(int brarticleNo) throws DataAccessException {
		System.out.println("--- boardDAO deleteBReply() 도착 ---");
		System.out.println("삭제할 댓글 번호 : "+brarticleNo);
		
		int result = sqlSession.delete("mapper.board.deleteBReply", brarticleNo);
		return result;
	}


	
	//게시판 최신글 3개
	@Override
	public List<BoardVO> gettopBoardList() throws DataAccessException {
		System.out.println("--- boardDAO gettopBoardList() 도착 ---");
		List<BoardVO> topBoardList = sqlSession.selectList("mapper.board.topBoard");
		System.out.println("database 다녀옴");
		
		return topBoardList;
	}


}
