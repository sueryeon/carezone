package carezone.qna.DAO;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.dao.DataAccessException;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import carezone.qna.VO.QnaVO;
import carezone.qna.VO.ReplyqnaVO;

public interface QnaDAO {
	

	public int insertQna(Map<String, Object> qnaMap) throws Exception;
	
	/*public Map getlistQna(Map<String, Integer> pagingMap) throws DataAccessException;*/
	
	public List<QnaVO> getAllListQna(Map<String, Integer> pagingMap) throws DataAccessException;

	public int getAlltotalArticels() throws DataAccessException;
	
	public QnaVO getDetailQna(int qarticleno) throws DataAccessException;
	
	public QnaVO updateQnaForm(int qarticleno) throws DataAccessException;
	
	public void updateQna(Map<String,Object> qnaMap) throws Exception;
	
	public void deleteQna(int qarticleno) throws DataAccessException;

	public void insertReplyQna(ReplyqnaVO reqnaVO) throws DataAccessException;
	
	public List<ReplyqnaVO> getlistReplyQna(int qrearticleno) throws DataAccessException;
	
	public void deleteReplyQna(int qreplyno) throws DataAccessException;
	
	public void updateReplyQna(ReplyqnaVO reqnaVO) throws DataAccessException;
	
	
}
