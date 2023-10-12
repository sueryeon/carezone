package carezone.qna.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

public interface QnaController {

	public ModelAndView getQnaForm(String qid,HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public ModelAndView insertQna(MultipartHttpServletRequest multi, HttpServletResponse response) throws Exception;
	
	public ModelAndView getlistQna(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public ModelAndView getDetailQna(int qarticleno, HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public ModelAndView	updateQna(MultipartHttpServletRequest multi, HttpServletResponse response) throws Exception;
	
	public ModelAndView	updateQnaForm(int qarticleno,HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public ModelAndView	deleteQna(int qarticleno,HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public ModelAndView	insertReplyQna(int qrearticleno, String qrecontent,HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public ModelAndView	getlistReplyQna(int qrearticleno,HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public ModelAndView	deleteReplyQna(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public ModelAndView	updateReplyQna(int qreplyno, String qrecontent, HttpServletRequest request, HttpServletResponse response) throws Exception;
}
