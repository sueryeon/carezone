package carezone.reservation.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import carezone.hoscart.vo.HosCartVO;
import carezone.member.vo.MemberVO;
import carezone.reservation.DAO.ReservationDAO;
import carezone.reservation.VO.ReservationVO;

@Service("reservationService")
public class ReservationServiceImpl implements ReservationService {
	
	@Autowired
	private ReservationDAO reservationDAO;

	@Override
	public MemberVO getReservationForm(String mid) throws DataAccessException {
		
		System.out.println("-------------------ReservationService : getReservationForm-------------------");
		
		MemberVO mVO=null;
		mVO=reservationDAO.getReservationForm(mid);
		
		return mVO;
	}

	@Override
	public void insertReservation(ReservationVO rsvVO,int hosno) throws DataAccessException {
		
		System.out.println("-------------------ReservationService : insertReservation-------------------");
		
		reservationDAO.insertReservation(rsvVO,hosno);
	}
	
	
	//장바구니에서 예약하기 눌렀을 때
	@Override
	public void insertReservation(ReservationVO rsvVO, int hosno, HosCartVO hcVO) throws DataAccessException {
		System.out.println("-------------------ReservationService : 장바구니에서 insertReservation-------------------");
		reservationDAO.insertReservation(rsvVO, hosno, hcVO);
	}
	
	//관리자가 보는 회원 전체 예약 리스트
	@Override
	public List<ReservationVO> getlistReservations() throws DataAccessException {
		
		System.out.println("-------------------ReservationService : getlistReservations 파라미터 X-------------------");
		
			List<ReservationVO> listReservations=null;
			listReservations=reservationDAO.getlistReservations();
			
		return listReservations;
		
	}
	
	//본인 예약 리스트
	@Override
	public List<ReservationVO> getlistReservations(String mid) throws DataAccessException {
		
		System.out.println("-------------------ReservationService : getlistReservations 파라미터 O-------------------");
		
		List<ReservationVO> listReservations=null;
		listReservations=reservationDAO.getlistReservations(mid);
		
		return listReservations;
		
	}

	@Override
	public int deleteReservation(int rno) throws DataAccessException {
		
		System.out.println("-------------------ReservationService : deleteReservation-------------------");
		
		return reservationDAO.deleteReservation(rno);
	}

	@Override
	public ReservationVO findReservation(int rno) throws DataAccessException {
		
		System.out.println("-------------------ReservationService : findReservation-------------------");
		
		ReservationVO rsvVO=null;
		rsvVO=reservationDAO.findReservation(rno);
		
		return rsvVO;
		
	}

	@Override
	public int updateReservation(ReservationVO rsvVO) throws DataAccessException {
		
		System.out.println("-------------------ReservationService : deleteReservation-------------------");
		
		return reservationDAO.updateReservation(rsvVO);
		
	}

	@Override
	public ReservationVO getDetailReservation(int rno) throws DataAccessException {

		System.out.println("-------------------ReservationService : getDetailReservation-------------------");
		
		ReservationVO rsvVO=null;
		rsvVO=reservationDAO.getDetailReservation(rno);
		
		return rsvVO;
		
	}



}
