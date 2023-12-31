package carezone.reservation.DAO;

import java.util.List;

import org.springframework.dao.DataAccessException;

import carezone.hoscart.vo.HosCartVO;
import carezone.member.vo.MemberVO;
import carezone.reservation.VO.ReservationVO;

public interface ReservationDAO {
	
	public MemberVO getReservationForm(String mid) throws DataAccessException;
	
	public void insertReservation(ReservationVO rsvVO,int hosno) throws DataAccessException;
	
	public void insertReservation(ReservationVO rsvVO,int hosno, HosCartVO hcVO) throws DataAccessException;
	
	public List<ReservationVO> getlistReservations() throws DataAccessException;
	
	public List<ReservationVO> getlistReservations(String mid) throws DataAccessException;
	
	public int deleteReservation(int rno) throws DataAccessException;
	
	public ReservationVO findReservation(int rno) throws DataAccessException;
	
	public void updateReservation(ReservationVO rsvVO) throws DataAccessException;
	
	public ReservationVO getDetailReservation(int rno) throws DataAccessException;
	
}
