package carezone.qna.service;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import carezone.qna.VO.QnaVO;
import carezone.qna.VO.ReplyqnaVO;

public interface QnaService {
	
	public int insertQna(Map<String, Object> qnaMap) throws Exception;
	
	public Map getlistQna(Map<String, Integer> pagingMap) throws DataAccessException;

	public QnaVO getDetailQna(int qarticleno) throws DataAccessException;

	public QnaVO updateQnaForm(int qarticleno) throws DataAccessException;
	
	public void updateQna(Map<String,Object> qnaMap) throws Exception;
	
	public void deleteQna(int qarticleno) throws DataAccessException;
	
	public void insertReplyQna(ReplyqnaVO reqnaVO) throws DataAccessException;
	
	public List<ReplyqnaVO> getlistReplyQna(int qrearticleno) throws DataAccessException;
	
	public void deleteReplyQna(int qreplyno) throws DataAccessException;
	
	public void updateReplyQna(ReplyqnaVO reqnaVO) throws DataAccessException;
}
