package carezone.qna.DAO;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import carezone.qna.VO.QnaVO;
import carezone.qna.VO.ReplyqnaVO;

@Repository("qnaDAO")
public class QnaDAOImpl implements QnaDAO {
	
	@Autowired
	private SqlSession sqlsession;

	@Override
	public int insertQna(Map<String, Object> qnaMap) throws Exception {
		
		System.out.println("――――――――――Qna DAO : insertQna――――――――――");
		
		sqlsession.insert("mapper.qna.insertQna",qnaMap);
		int qarticleno=selectNewQarticleno();
		
		return qarticleno;
	}

	

	/*public Map getlistQna(Map<String, Integer> pagingMap) throws DataAccessException {
		
		System.out.println("――――――――――Qna DAO : getlistQna――――――――――");
		
		List<QnaVO> listQna=sqlsession.selectList("mapper.qna.getlistQna");
		
		return articlesMap;
	}*/
	

	@Override
	public List<QnaVO> getAllListQna(Map<String, Integer> pagingMap) throws DataAccessException {

		System.out.println("――――――――――Qna DAO : getAllListQna――――――――――");
		
		List<QnaVO> AllListQna=sqlsession.selectList("mapper.qna.getAllListQna",pagingMap);
		
		return AllListQna;
	}


	@Override
	public int getAlltotalArticels() throws DataAccessException {
		
		System.out.println("――――――――――Qna DAO : getAlltotalArticels――――――――――");
		
		int totalArticles=sqlsession.selectOne("mapper.qna.getAlltotalArticels");
		
		return totalArticles;
	}
	
	@Override
	public QnaVO getDetailQna(int qarticleno) throws DataAccessException {
		
		System.out.println("――――――――――Qna DAO : getDetailQna――――――――――");
		
		QnaVO qnaVO=(QnaVO) sqlsession.selectOne("mapper.qna.getDetailQna", qarticleno);
		
		return qnaVO;
	}

	@Override
	public QnaVO updateQnaForm(int qarticleno) throws DataAccessException {
		
		System.out.println("――――――――――Qna DAO : findQna――――――――――");
		
		QnaVO qnaVO=(QnaVO) sqlsession.selectOne("mapper.qna.updateQnaForm",qarticleno);
		
		return qnaVO;
	}
	
	@Override
	public void updateQna(Map<String, Object> qnaMap) throws Exception {
		
		System.out.println("――――――――――Qna DAO : updateQna――――――――――");
		
		sqlsession.update("mapper.qna.updateQna", qnaMap);
		
	}

	@Override
	public void deleteQna(int qarticleno) throws DataAccessException {
		
		System.out.println("――――――――――Qna DAO : deleteQna――――――――――");
		
		sqlsession.update("mapper.qna.deleteQna", qarticleno);

	}

	@Override
	public void insertReplyQna(ReplyqnaVO reqnaVO) throws DataAccessException {
		
		System.out.println("――――――――――Qna 댓글 DAO : insertReplyQna――――――――――");
		
		sqlsession.insert("mapper.replyqna.insertReplyQna", reqnaVO);

	}
	
	@Override
	public List<ReplyqnaVO> getlistReplyQna(int qrearticleno) throws DataAccessException {
		
		System.out.println("――――――――――Qna 댓글 DAO : getlistReplyQna――――――――――");
		
		List<ReplyqnaVO> listReplyQna=sqlsession.selectList("mapper.replyqna.getlistReplyQna", qrearticleno);
		
		return listReplyQna;
	}
	
	@Override
	public void deleteReplyQna(int qreplyno) throws DataAccessException {
		
		System.out.println("――――――――――Qna 댓글 DAO : deleteReplyQna――――――――――");
		
		sqlsession.delete("mapper.replyqna.deleteReplyQna", qreplyno);
	}
	
	private int selectNewQarticleno() throws DataAccessException {
		
		System.out.println("RE : selectNewQarticleno ");
		
		
		return (int) sqlsession.selectOne("mapper.qna.selectNewQarticleno");
	}

	@Override
	public void updateReplyQna(ReplyqnaVO reqnaVO) throws DataAccessException {
		
		System.out.println("――――――――――Qna 댓글 DAO : updateReplyQna――――――――――");
		
		sqlsession.insert("mapper.replyqna.updateReplyQna", reqnaVO);

	}

}
