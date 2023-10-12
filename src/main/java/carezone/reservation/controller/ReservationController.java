package carezone.reservation.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.web.servlet.ModelAndView;
import carezone.reservation.VO.ReservationVO;

public interface ReservationController {
	
	public ModelAndView getlistReservations(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView getReservationForm(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView insertReservation(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView deleteReservation(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView findReservation(int rno, HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView updateReservation(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView getDetailReservation(int rno, HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public ModelAndView getFamilyrsvForm(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
}
