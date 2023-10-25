package carezone.reservation.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import carezone.hoscart.vo.HosCartVO;
import carezone.hospital.VO.HospitalVO;
import carezone.member.vo.AdminVO;
import carezone.member.vo.MemberVO;
import carezone.reservation.VO.ReservationVO;
import carezone.reservation.service.ReservationService;

@Controller("reservationController")
@RequestMapping("/reservation")
public class ReservationControllerImpl implements ReservationController {
	
	@Autowired
	private ReservationService reservationService;
	 
	private ReservationVO rsvVO;
	
	@Override
	@RequestMapping(value={"/getlistReservations.do","/getlistMyReservations.do"}, method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView getlistReservations(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("=======================예약컨트롤러 : 예약리스트가져오기=======================");
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		String action = (String) request.getParameter("action");
		System.out.println("Reserv.do의 action : "+action);
		
		ModelAndView mav=new ModelAndView();
		String viewName=getViewName(request);
		System.out.println("viewname : "+viewName);
		List<ReservationVO> listReservations;
		HttpSession session = request.getSession();
		
		
		if(viewName.equals("/reservation/getlistMyReservations")) {
			System.out.println("회원의 예약 내역 조회");
			MemberVO memVO = (MemberVO) session.getAttribute("memVO");
			String mid = memVO.getMid();
			listReservations=reservationService.getlistReservations(mid);
			if(action==null) {
				mav.setViewName(viewName);
				mav.addObject("listReservations", listReservations);
			}
			else if(action.equals("mypage")) {
				String viewname = "/reservation/myReservList";
				mav.setViewName(viewname);
				mav.addObject("listReservations", listReservations);
			}
			
		}
		else if(viewName.equals("/reservation/getlistReservations")) {
			System.out.println("관리자의 회원 전체 예약 내역 조회");
			listReservations=reservationService.getlistReservations();
			if(action==null) {
				mav.setViewName(viewName);
				mav.addObject("listReservations", listReservations);
			}
			else if(action.equals("adpage")) {
				String viewname = "/reservation/adReservList";
				mav.setViewName(viewname);
				mav.addObject("listReservations", listReservations);
			}
		}
		return mav;
	}
	
	@Override
	@RequestMapping(value="/getreservationForm.do", method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView getReservationForm(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("=======================예약컨트롤러 : 예약폼가져오기=======================");
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		String viewName=getViewName(request);
		ModelAndView mav=new ModelAndView();
		
		String hc_no = (String) request.getParameter("hcno");
		if(hc_no==null) {
			String hosname=request.getParameter("hosname");
			String vccname=request.getParameter("vccname");
			String hos_no = (String)request.getParameter("hosno");
			int hosno=0;
			if(hos_no != null) {
				hosno=Integer.parseInt(request.getParameter("hosno"));
			}
			else {
				System.out.println("hosno : null");
			}
			System.out.println(hosname+" / "+vccname+" / "+hosno);
			//----------------------------------------------전처리▲
			HospitalVO hosVO=new HospitalVO(hosno,hosname,vccname);
			//----------------------------------------------서비스 메서드 실행▲
			
			if(hosname!=null&&vccname!=null) {
				mav.addObject("hosVO", hosVO);
				
			}
			else {
				System.out.println("병원 선택 안했을 때");
			}
			mav.setViewName(viewName);
			
			//----------------------------------------------mav 세팅▲
			
			return mav;
			
		}
		else {
			int hcno = Integer.parseInt(hc_no);
			System.out.println("hcno : "+hcno);
			
			String hosname=request.getParameter("hosname");
			String vccname=request.getParameter("vccname");
			String hos_no = (String)request.getParameter("hosno");
			int hosno=0;
			if(hos_no != null) {
				hosno=Integer.parseInt(request.getParameter("hosno"));
			}
			else {
				System.out.println("hosno : null");
			}
			System.out.println(hosname+" / "+vccname+" / "+hosno);
			//----------------------------------------------전처리▲
			HospitalVO hosVO=new HospitalVO(hosno,hosname,vccname);
			//----------------------------------------------서비스 메서드 실행▲
			
			if(hosname!=null&&vccname!=null) {
				mav.addObject("hosVO", hosVO);
				
			}
			else {
				System.out.println("병원 선택 안했을 때");
			}
			mav.addObject("hcno",hcno);
			mav.setViewName(viewName);
			
			//----------------------------------------------mav 세팅▲
			
			return mav;
		}
	}
	
	@Override
	@RequestMapping(value="/insertReservation.do", method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView insertReservation(HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		System.out.println("======================예약컨트롤러 : insert=======================");
		
		String hc_no = (String) request.getParameter("hcno");
		System.out.println("장바구니 길이 : "+hc_no.length());
		String action=request.getParameter("action");
		
		System.out.println("action 값 : "+action);
		HttpSession session = request.getSession();
		MemberVO memVO = (MemberVO) session.getAttribute("memVO");
		
		if(action.equals("family")) {
			
			String rid=memVO.getMid();
			String rname=request.getParameter("rname");
			String rbirth1=memVO.getMbirth1();
			int rbirth2=memVO.getMbirth2();
			String rphone=request.getParameter("rphone");
			String rsubname=request.getParameter("rsubname");
			String rsubbirth1=request.getParameter("rsubbirth1");
			String rsubphone=request.getParameter("rsubphone");
			String rhospital=request.getParameter("rhospital");
			String rvcc=request.getParameter("rvcc");
			String rdate1=request.getParameter("rdate");
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			Date rdate = dateFormat.parse(rdate1);
			int hosno=Integer.parseInt(request.getParameter("hos__no"));
			
			System.out.println("rsubbirth1 : "+rsubbirth1);
			
			ReservationVO rVO=new ReservationVO(rid,rname,rbirth1,rbirth2,rphone,rsubname,rsubbirth1,rsubphone,rhospital,rvcc,rdate);
			
			if(hc_no==null||hc_no.length()==0) {
				
				reservationService.insertReservation(rVO,hosno);
				ModelAndView mav=new ModelAndView("redirect:/reservation/getlistMyReservations.do?mid="+rid);
				return mav;
			}
			else {
				
				int hcno = Integer.parseInt(hc_no);
				HosCartVO hcVO = new HosCartVO(hcno, memVO.getMid());
				reservationService.insertReservation(rVO,hosno,hcVO);
				ModelAndView mav=new ModelAndView("redirect:/reservation/getlistMyReservations.do?mid="+rid);
				return mav;
			}
		}
		else if(action.equals("self")) {

			System.out.println("분기점 본인예약일때");
			String rid=memVO.getMid();
			String rname=request.getParameter("rname");
			String rbirth1=request.getParameter("rbirth1");
			System.out.println("rid : "+rid);
			int rbirth2=Integer.parseInt(request.getParameter("rbirth2"));
			String rphone=request.getParameter("rphone");
			String rhospital=request.getParameter("rhospital");
			String rvcc=request.getParameter("rvcc");
			String rdate1=request.getParameter("rdate");
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			Date rdate = dateFormat.parse(rdate1);			
			int hosno=Integer.parseInt(request.getParameter("hos__no"));
			System.out.println("rhospital : "+rhospital);
			
			ReservationVO rVO=new ReservationVO(rid,rname,rbirth1,rbirth2,rphone,rhospital,rvcc,rdate);
			
			if(hc_no==null||hc_no.length()==0) {
				
				System.out.println("분기점 장바구니 아닐때");
				reservationService.insertReservation(rVO,hosno);
				ModelAndView mav=new ModelAndView("redirect:/reservation/getlistMyReservations.do?mid="+rid);
				return mav;
			}
			else {
				System.out.println("분기점 장바구니 일때");
				int hcno = Integer.parseInt(hc_no);
				
				HosCartVO hcVO = new HosCartVO(hcno, memVO.getMid());
				reservationService.insertReservation(rVO,hosno,hcVO);
				ModelAndView mav=new ModelAndView("redirect:/reservation/getlistMyReservations.do?mid="+rid);
				return mav;
			}
		}
		else {
			System.out.println("완전오류");
			return null;
		}
	}
	
	

	@Override
	@RequestMapping(value="/deleteReservation.do", method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView deleteReservation(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("======================예약컨트롤러 : 삭제=======================");
		
		request.setCharacterEncoding("UTF-8");
		int result=0;
		int rno=Integer.parseInt(request.getParameter("rno")); //캐스팅안해도되나??????
		//----------------------------------------------전처리▲
		
		result=reservationService.deleteReservation(rno);
		//----------------------------------------------서비스 메서드 실행▲
		
		ModelAndView mav=new ModelAndView("redirect:/reservation/getlistReservations.do");
		//----------------------------------------------mav 세팅▲

		return mav;
	}

	@Override
	@RequestMapping(value="/findReservation.do", method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView findReservation(@RequestParam("rno") int rno,HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("=======================예약컨트롤러 : 수정폼 가져오기=======================");
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		String viewName=getViewName(request);
		ModelAndView mav=new ModelAndView();
		//----------------------------------------------전처리▲
		
		rsvVO=reservationService.findReservation(rno);
		//----------------------------------------------서비스 메서드 실행▲
		
		mav.addObject("rsvVO", rsvVO);
		mav.setViewName(viewName);
		//----------------------------------------------mav 세팅▲
		
		return mav;
	}

	@Override
	@RequestMapping(value="/updateReservation.do", method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView updateReservation(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("=======================예약컨트롤러 : 수정하기=======================");
		
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		MemberVO memVO = (MemberVO) session.getAttribute("memVO");
		AdminVO adVO=(AdminVO) session.getAttribute("adVO");
		
		if(memVO.getMid()!=null||memVO.getMid().length()!=0) {
			
			System.out.println("분기점 회원일때 수정하기");

			int rno=Integer.parseInt(request.getParameter("rno"));
			String rhospital=request.getParameter("rhospital");
			String rvcc=request.getParameter("rvcc");
			String rdate1=request.getParameter("rdate");
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	        Date rdate = dateFormat.parse(rdate1);
			System.out.println("수정된 파라미터 rno : "+rno);
			System.out.println("rhospital : "+rhospital);
			System.out.println("rvcc : "+rvcc);
			System.out.println("rdate : "+rdate);
			
	        rsvVO=new ReservationVO(rno,rhospital,rvcc,rdate);
			//----------------------------------------------전처리▲
			
			reservationService.updateReservation(rsvVO);
			ModelAndView mav=new ModelAndView("redirect:/reservation/getDetailReservation.do?rno="+rno);
			
			return mav;
			
		}
		else if(adVO.getAdid()!=null||adVO.getAdid().length()!=0) {
			System.out.println("분기점 관리자일때 수정하기");
				
			int rno=Integer.parseInt(request.getParameter("rno"));
			System.out.println("rno"+rno);
			String rhospital=request.getParameter("rhospital");
			String rvcc=request.getParameter("rvcc");
			String rdate1=request.getParameter("rdate");
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	        Date rdate = dateFormat.parse(rdate1);
			
	        rsvVO=new ReservationVO(rno,rhospital,rvcc,rdate);
			//----------------------------------------------전처리▲
			
			reservationService.updateReservation(rsvVO);

			ModelAndView mav=new ModelAndView("redirect:/reservation/getDetailReservation.do?rno="+rno);
			
			return mav;
		}
		else {
			System.out.println("session is null error");
			return null;
		}
		
	}
	
	@Override
	@RequestMapping(value="/getDetailReservation.do", method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView getDetailReservation(@RequestParam("rno") int rno, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		String viewName=getViewName(request);
		ModelAndView mav=new ModelAndView();
		//----------------------------------------------전처리▲
		
		rsvVO=reservationService.getDetailReservation(rno);
		//----------------------------------------------서비스 메서드 실행▲
		
		mav.addObject("rsvVO", rsvVO);
		mav.setViewName(viewName);
		//----------------------------------------------mav 세팅▲
		
		return mav;

	}
	
	private String getViewName(HttpServletRequest request) throws Exception{
		
		String contextPath=request.getContextPath();
		String uri=request.getRequestURI();
		int begin=0;
		int end=0;
		
		if(!((contextPath==null)||("".equals(contextPath)))) {
			begin=contextPath.length();
		}
		
		if(uri.indexOf(";")!=-1) {
			end=uri.indexOf(";");
		}
		else if(uri.indexOf("?")!=-1) {
			end=uri.indexOf("?");
		}
		else {
			end=uri.length();
		}
		
		String fileName=uri.substring(begin,end);
		if(fileName.indexOf(".")!=-1) {
			fileName=fileName.substring(0,fileName.lastIndexOf("."));
		}
		/*if(fileName.indexOf("/")!=-1) {
			fileName=fileName.substring(fileName.lastIndexOf("/"),fileName.length());
		}*/
		
		return fileName;
	}

	/*@Override
	@RequestMapping(value="/getFamilyrsvForm.do", method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView getFamilyrsvForm(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("=======================ReservationController : getFamilyrsvForm=======================");
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		String viewName=getViewName(request);
		ModelAndView mav=new ModelAndView();
		
		String hc_no = (String) request.getParameter("hcno");
		if(hc_no==null) {
			String hosname=request.getParameter("hosname");
			String vccname=request.getParameter("vccname");
			String hos_no = (String)request.getParameter("hosno");
			int hosno=0;
			if(hos_no != null) {
				hosno=Integer.parseInt(request.getParameter("hosno"));
			}
			else {
				System.out.println("hosno : null");
			}
			System.out.println(hosname+" / "+vccname+" / "+hosno);
			//----------------------------------------------전처리▲
			HospitalVO hosVO=new HospitalVO(hosno,hosname,vccname);
			//----------------------------------------------서비스 메서드 실행▲
			
			if(hosname!=null&&vccname!=null) {
				mav.addObject("hosVO", hosVO);
				
			}
			else {
				System.out.println("병원 선택 안했을 때");
			}
			mav.setViewName(viewName);
			
			//----------------------------------------------mav 세팅▲
			
			return mav;
			
		}
		else {
			int hcno = Integer.parseInt(hc_no);
			System.out.println("hcno : "+hcno);
			
			String hosname=request.getParameter("hosname");
			String vccname=request.getParameter("vccname");
			String hos_no = (String)request.getParameter("hosno");
			int hosno=0;
			if(hos_no != null) {
				hosno=Integer.parseInt(request.getParameter("hosno"));
			}
			else {
				System.out.println("hosno : null");
			}
			System.out.println(hosname+" / "+vccname+" / "+hosno);
			//----------------------------------------------전처리▲
			HospitalVO hosVO=new HospitalVO(hosno,hosname,vccname);
			//----------------------------------------------서비스 메서드 실행▲
			
			if(hosname!=null&&vccname!=null) {
				mav.addObject("hosVO", hosVO);
				
			}
			else {
				System.out.println("병원 선택 안했을 때");
			}
			mav.addObject("hcno",hcno);
			mav.setViewName(viewName);
			
			//----------------------------------------------mav 세팅▲
			
			return mav;
		}
	}*/



}
