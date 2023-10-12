package carezone.qna.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import carezone.qna.DAO.QnaDAO;
import carezone.qna.VO.QnaVO;
import carezone.qna.VO.ReplyqnaVO;


@Service("qnaService")
public class QnaServiceImpl implements QnaService {
	
	@Autowired
	private QnaDAO qnaDAO;

	@Override
	public int insertQna(Map<String, Object> qnaMap) throws Exception {
		
		System.out.println("------------------qna 서비스 : insertQna-------------------");
		
		return qnaDAO.insertQna(qnaMap);
	}

	@Override
	public Map getlistQna(Map<String, Integer> pagingMap) throws DataAccessException {
		
		System.out.println("------------------qna 서비스 : getlistQna-------------------");
		
		//Map listQna=qnaDAO.getlistQna(pagingMap);
		Map articlesMap = new HashMap();
		List<QnaVO> AllListQna= qnaDAO.getAllListQna(pagingMap);
		int totalArticles=qnaDAO.getAlltotalArticels();
		
		articlesMap.put("AllListQna", AllListQna);
		articlesMap.put("totalArticles", totalArticles);

		return articlesMap;
	}

	@Override
	public QnaVO getDetailQna(int qarticleno) throws DataAccessException {
		
		System.out.println("------------------qna 서비스 : getDetailQna-------------------");
		
		QnaVO qnaVO=qnaDAO.getDetailQna(qarticleno);
		
		return qnaVO;
	}


	@Override
	public QnaVO updateQnaForm(int qarticleno) throws DataAccessException {
		
		System.out.println("------------------qna 서비스 : updateQnaForm-------------------");
		
		QnaVO qnaVO=qnaDAO.updateQnaForm(qarticleno);
		
		return qnaVO;
	}

	@Override
	public void updateQna(Map<String, Object> qnaMap) throws Exception {
		
		System.out.println("------------------qna 서비스 : updateQna-------------------");
		
		qnaDAO.updateQna(qnaMap);
		
	}

	@Override
	public void deleteQna(int qarticleno) throws DataAccessException {
		
		System.out.println("------------------qna 서비스 : deleteQna-------------------");
		
		qnaDAO.deleteQna(qarticleno);
		
	}

	@Override
	public void insertReplyQna(ReplyqnaVO reqnaVO) throws DataAccessException {
		
		System.out.println("------------------qna 댓글 서비스 : insertReplyQna-------------------");
		
		qnaDAO.insertReplyQna(reqnaVO);

	}

	@Override
	public List<ReplyqnaVO> getlistReplyQna(int qrearticleno) throws DataAccessException {
		
		System.out.println("------------------qna 댓글 서비스 : getlistReplyQna-------------------");
		
		List<ReplyqnaVO> listReplyQna=qnaDAO.getlistReplyQna(qrearticleno);
		
		return listReplyQna;
	}

	@Override
	public void deleteReplyQna(int qreplyno) throws DataAccessException {
		
		System.out.println("------------------qna 댓글 서비스 : deleteReplyQna-------------------");
		
		qnaDAO.deleteReplyQna(qreplyno);
	}

	@Override
	public void updateReplyQna(ReplyqnaVO reqnaVO) throws DataAccessException {
		
		System.out.println("------------------qna 댓글 서비스 : updateReplyQna-------------------");
		
		qnaDAO.updateReplyQna(reqnaVO);
	}
	
}
