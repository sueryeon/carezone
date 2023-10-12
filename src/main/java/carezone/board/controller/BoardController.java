package carezone.board.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import carezone.board.vo.BoardVO;

public interface BoardController {
	public ModelAndView getlistBoards(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView insertBoardForm(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView insertBoard(MultipartHttpServletRequest multipartRequest,HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView deleteBoard(int barticleNo,HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView findBoard(int barticleNo,HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView updateBoard(MultipartHttpServletRequest multipartRequest,HttpServletRequest request, HttpServletResponse response) throws Exception;


	public ModelAndView getlistBReplyBoards(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView insertBReply(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView updateBReply(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView deleteBReply(HttpServletRequest request, HttpServletResponse response) throws Exception;	
	
	public List<BoardVO> topboardList(HttpServletRequest request, HttpServletResponse response) throws Exception;
}
