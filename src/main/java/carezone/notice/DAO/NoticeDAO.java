package carezone.notice.DAO;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import carezone.notice.VO.NoticeVO;

public interface NoticeDAO {

	public int insertNotice(Map<String, Object> noticeMap) throws Exception;
	
	public List<NoticeVO> getlistNotice(Map<String, Integer> pagingMap) throws DataAccessException;
	
	public int getAlltotalArticels() throws DataAccessException;

	public NoticeVO getDetailNotice(int narticleno) throws DataAccessException;

	public NoticeVO updateNoticeForm(int narticleno) throws DataAccessException;
	
	public void updateNotice(Map<String,Object> noticeMap) throws Exception;
	
	public void deleteNotice(int narticleno) throws DataAccessException;
	
	public List noticetopthree() throws Exception;
	
}
