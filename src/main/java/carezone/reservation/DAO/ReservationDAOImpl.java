package carezone.reservation.DAO;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import carezone.hoscart.vo.HosCartVO;
import carezone.member.vo.MemberVO;
import carezone.reservation.VO.ReservationVO;

@Repository("reservationDAO")
public class ReservationDAOImpl implements ReservationDAO {

	@Autowired
	private SqlSession sqlsession;

	@Override
	public MemberVO getReservationForm(String mid) throws DataAccessException {
		
		System.out.println("――――――――――――――――ReservationDAO : getReservationForm――――――――――――――――");
		
		MemberVO mVO=null;
		mVO=(MemberVO) sqlsession.selectOne("mapper.reservation.getReservationForm",mid);
		
		//테스트완료
		
		return mVO;
	}
 
	@Override
	public void insertReservation(ReservationVO rsvVO,int hosno) throws DataAccessException {
		
		System.out.println("――――――――――――――――ReservationDAO : insertReservation――――――――――――――――");
		
		String rsubname=rsvVO.getRsubname();
		if(rsubname!=null) {
			sqlsession.insert("mapper.reservation.insertReservation_family", rsvVO); //가족 예약 추가
			sqlsession.insert("mapper.checklist.insertChecklist_family", rsvVO); //가족 체크리스트 추가
		}
		else {
			sqlsession.insert("mapper.reservation.insertReservation_self", rsvVO); //본인 예약 추가
			sqlsession.insert("mapper.checklist.insertChecklist_self", rsvVO); //본인 체크리스트 추가
		}
		
		sqlsession.update("mapper.hospital.updateVccquantity",hosno);
	}
	
	
	//장바구니에서 예약하기 눌렀을때
	@Override
	public void insertReservation(ReservationVO rsvVO, int hosno, HosCartVO hcVO) throws DataAccessException {
		
		System.out.println("――――――――――――――――ReservationDAO :  장바구니에서 insertReservation――――――――――――――――");
		
		String rsubname=rsvVO.getRsubname();
		if(rsubname!=null||rsubname.length()!=0) {
			sqlsession.insert("mapper.reservation.insertReservation_family", rsvVO);
		}
		else {
			sqlsession.insert("mapper.reservation.insertReservation_self", rsvVO);
		}
		
		sqlsession.update("mapper.hospital.updateVccquantity",hosno);
		sqlsession.insert("mapper.reservation.insertReservation", rsvVO);
		
	}

	@Override
	public List<ReservationVO> getlistReservations() throws DataAccessException {
		
		System.out.println("――――――――――――――――ReservationDAO : getlistReservations 파라미터 X――――――――――――――――");
		
		List<ReservationVO> listReservations=sqlsession.selectList("mapper.reservation.getlistReservations");
		
		return listReservations;
	}
	
	@Override
	public List<ReservationVO> getlistReservations(String mid) throws DataAccessException {
		
		System.out.println("――――――――――――――――ReservationDAO : getlistReservations 파라미터 O――――――――――――――――");
		
		List<ReservationVO> listReservations=sqlsession.selectList("mapper.reservation.getlistMyReservations",mid);
		
		return listReservations;
	}

	@Override
	public int deleteReservation(int rno) throws DataAccessException {
		
		System.out.println("――――――――――――――――ReservationDAO : deleteReservation――――――――――――――――");
		
		int result=sqlsession.insert("mapper.reservation.deleteReservation", rno);
		
		return result;
	}

	@Override
	public ReservationVO findReservation(int rno) throws DataAccessException {
		
		System.out.println("――――――――――――――――ReservationDAO : findReservation――――――――――――――――");
		
		ReservationVO rsvVO=null;
		rsvVO=(ReservationVO) sqlsession.selectOne("mapper.reservation.findReservation",rno);
		
		return rsvVO;
		
	}

	@Override
	public void updateReservation(ReservationVO rsvVO) throws DataAccessException {

		System.out.println("――――――――――――――――예약DAO : 수정하기――――――――――――――――");
		
		sqlsession.update("mapper.reservation.updateReservation", rsvVO);
		System.out.println("파라미터 rsvVO rno,rhospital,rvcc : "+rsvVO.getRno());
		System.out.println(rsvVO.getRhospital());
		System.out.println(rsvVO.getRvcc()+" 입니다.");

	}

	@Override
	public ReservationVO getDetailReservation(int rno) throws DataAccessException {
		
		System.out.println("――――――――――――――――ReservationDAO : getDetailReservation――――――――――――――――");
		
		ReservationVO rsvVO=null;
		
		rsvVO=(ReservationVO) sqlsession.selectOne("mapper.reservation.getDetailReservation",rno);
		
		System.out.println("왔음.");
		return rsvVO;
	}


	
}
