package carezone.notice.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

public interface NoticeController {
	
	public ModelAndView getNoticeForm(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public ModelAndView insertNotice(MultipartHttpServletRequest multi, HttpServletResponse response) throws Exception;
	
	public ModelAndView getlistNotice(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public ModelAndView getDetailNotice(int qarticleno, HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public ModelAndView	updateNotice(MultipartHttpServletRequest multi, HttpServletResponse response) throws Exception;
	
	public ModelAndView	updateNoticeForm(int qarticleno,HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public ModelAndView	deleteNotice(int qarticleno,HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public List noticetopthree(HttpServletRequest request, HttpServletResponse response) throws Exception;
}
