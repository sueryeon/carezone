package carezone.checklist.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

import carezone.member.vo.FamilyVO;

public interface CheckController {

	public ModelAndView getChecklist(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public ModelAndView insertChecklist(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public void changeCheckType(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public void getTypes(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public List<FamilyVO> getHomechecklist(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
}
