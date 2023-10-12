package carezone.member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import carezone.member.vo.AdminVO;
import carezone.member.vo.FamilyVO;
import carezone.member.vo.MemberVO;

public interface MemberController {
	//회원 관련 메서드
	public ModelAndView getForm(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView getIdCheck(String checkid, HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView getPhoneCheck(String checkphone, HttpServletRequest request, HttpServletResponse response) throws Exception;
	public String getEmailCheck(HttpServletRequest request, HttpServletResponse response)throws Exception;
	public ModelAndView getlistMembers(HttpServletRequest request, HttpServletResponse response)throws Exception;
	public ModelAndView insertMember(MemberVO memberVO,HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView findMember(String action, HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView updateMember(String action,HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView deleteMember(String mid,HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView getfindMIForm(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView findMyId(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView getfindMPForm(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView findMyPwd(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView newMyPwd(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public String getMemCheck(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	//회원의 가족 관련 메서드
	public ModelAndView getFamForm(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView getfPhoneCheck(String checkfphone,HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView getlistFamilyMembers(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView insertFamilyMember(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView findFamilyMember(int fid,HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView updateFamilyMember(FamilyVO familyVO, HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView deleteFamilyMember(int fid,int fno,HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	//로그인
	public ModelAndView getLoginForm(String result, HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView getLogin(MemberVO memberVO, RedirectAttributes reAttr, HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView getlogout(HttpServletRequest request, HttpServletResponse response)throws Exception;
	
	//관리자 로그인
	public ModelAndView getAdminLoginForm(String result, HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView getAdminLogin(AdminVO adminVO, RedirectAttributes reAttr, HttpServletRequest request, HttpServletResponse response) throws Exception;
	
}
