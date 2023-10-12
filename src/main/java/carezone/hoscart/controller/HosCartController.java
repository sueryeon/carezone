package carezone.hoscart.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

public interface HosCartController {
	//병원 담기 insert
	public ModelAndView insertHosCart(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	//장바구니 전체 조회 select
	public ModelAndView getlistHosCart(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	//장바구니 1개 delete
	public ModelAndView deleteHosCart(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	//내 장바구니 count
	public ModelAndView countHosCart(HttpServletRequest request, HttpServletResponse response) throws Exception;
}
