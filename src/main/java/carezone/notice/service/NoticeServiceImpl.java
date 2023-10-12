package carezone.notice.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import carezone.notice.DAO.NoticeDAO;
import carezone.notice.VO.NoticeVO;
import carezone.qna.VO.QnaVO;


@Service("noticeService")
public class NoticeServiceImpl implements NoticeService {

	@Autowired
	private NoticeDAO noticeDAO;

	@Override
	public int insertNotice(Map<String, Object> noticeMap) throws Exception {
		
		System.out.println("------------------공지사항 서비스 : insertNotice-------------------");
		
		return noticeDAO.insertNotice(noticeMap);
		
	}

	/*@Override
	public List<NoticeVO> getlistNotice() throws DataAccessException {
		
		System.out.println("------------------공지사항 서비스 : insertNotice-------------------");
		
		List<NoticeVO> listNotice=noticeDAO.getlistNotice();
		
		return listNotice;
	}*/
	
	@Override
	public Map getlistNotice(Map<String, Integer> pagingMap) throws DataAccessException {
		
		System.out.println("------------------공지사항 서비스 : insertNotice-------------------");
		
		Map articlesMap = new HashMap();
		List<NoticeVO> listNotice= noticeDAO.getlistNotice(pagingMap);
		int totalArticles=noticeDAO.getAlltotalArticels();
		
		articlesMap.put("listNotice", listNotice);
		articlesMap.put("totalArticles", totalArticles);

		return articlesMap;
	}

	@Override
	public NoticeVO getDetailNotice(int narticleno) throws DataAccessException {

		System.out.println("------------------공지사항 서비스 : getDetailNotice-------------------");
		
		NoticeVO noticeVO=noticeDAO.getDetailNotice(narticleno);
		
		return noticeVO;
	}

	@Override
	public NoticeVO updateNoticeForm(int narticleno) throws DataAccessException {

		System.out.println("------------------공지사항 서비스 : updateNoticeForm-------------------");
		
		NoticeVO noticeVO=noticeDAO.updateNoticeForm(narticleno);
		
		return noticeVO;
	}

	@Override
	public void updateNotice(Map<String, Object> noticeMap) throws Exception {
		
		System.out.println("------------------공지사항 서비스 : updateNotice-------------------");
		
		noticeDAO.updateNotice(noticeMap);
	}

	@Override
	public void deleteNotice(int narticleno) throws DataAccessException {
		
		System.out.println("------------------공지사항 서비스 : deleteNotice-------------------");
		
		noticeDAO.deleteNotice(narticleno);
	}
	
	public List noticetopthree() throws Exception {
		
		List topthree=noticeDAO.noticetopthree();
		
		
		return topthree;
	}
	
}
