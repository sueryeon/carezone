package carezone.notice.DAO;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import carezone.notice.VO.NoticeVO;


@Repository("noticeDAO")
public class NoticeDAOImpl implements NoticeDAO {

	@Autowired
	private SqlSession sqlsession;

	@Override
	public int insertNotice(Map<String, Object> noticeMap) throws Exception {

		System.out.println("――――――――――공지사항 DAO : insertNotice――――――――――");
		
		sqlsession.insert("mapper.notice.insertNotice",noticeMap);
		int narticleno=selectNewNarticleno();
		
		return narticleno;
	}
	
	private int selectNewNarticleno() throws DataAccessException {
		
		System.out.println("RE : selectNewNarticleno ");
		
		
		return (int) sqlsession.selectOne("mapper.notice.selectNewNarticleno");
	}

	
	@Override
	public List<NoticeVO> getlistNotice(Map<String, Integer> pagingMap) throws DataAccessException {
		
		System.out.println("――――――――――공지사항 DAO : getlistNotice――――――――――");
		
		List<NoticeVO> listNotice=sqlsession.selectList("mapper.notice.getlistNotice",pagingMap);
		
		System.out.println(listNotice.size());
		return listNotice;
	}
	

	@Override
	public int getAlltotalArticels() throws DataAccessException {
		
		System.out.println("――――――――――공지사항 DAO : getAlltotalArticels――――――――――");
		
		int totalArticles=sqlsession.selectOne("mapper.notice.getAlltotalArticels");
		
		return totalArticles;
	}


	@Override
	public NoticeVO getDetailNotice(int narticleno) throws DataAccessException {
		
		System.out.println("――――――――――공지사항 DAO : getDetailNotice――――――――――");
		
		NoticeVO noticeVO=(NoticeVO) sqlsession.selectOne("mapper.notice.getDetailNotice", narticleno);
		
		return noticeVO;
	}

	@Override
	public NoticeVO updateNoticeForm(int narticleno) throws DataAccessException {
		
		System.out.println("――――――――――공지사항 DAO : updateNoticeForm――――――――――");
		
		NoticeVO noticeVO=(NoticeVO) sqlsession.selectOne("mapper.notice.updateNoticeForm",narticleno);
		
		return noticeVO;
	}

	@Override
	public void updateNotice(Map<String, Object> noticeMap) throws Exception {
		
		System.out.println("――――――――――공지사항 DAO : updateNotice――――――――――");
		
		sqlsession.update("mapper.notice.updateNotice", noticeMap);
	}

	@Override
	public void deleteNotice(int narticleno) throws DataAccessException {
		
		System.out.println("――――――――――공지사항 DAO : deleteNotice――――――――――");
		
		sqlsession.update("mapper.notice.updateNotice", narticleno);

	}

	public List noticetopthree() throws Exception {
		
		List topthree=sqlsession.selectList("mapper.notice.noticetopthree");
		
		
		return topthree;
	}
	
}
