package carezone.hospital.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import carezone.hospital.VO.HospitalVO;

public interface HospitalController {
	
	public ModelAndView gethospitalForm(HttpServletRequest request, HttpServletResponse response) throws Exception;

	public ModelAndView insertHospital(MultipartHttpServletRequest multi, HttpServletResponse response) throws Exception;
	
	public ModelAndView getlistHospital(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	//public List<HospitalVO> searchHospital(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public Map<String, Object> searchHospital(HttpServletRequest request, HttpServletResponse response) throws Exception;

}
