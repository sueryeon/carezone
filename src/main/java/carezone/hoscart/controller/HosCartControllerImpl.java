package carezone.hoscart.controller;

import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import carezone.hoscart.service.HosCartService;
import carezone.hoscart.vo.HosCartVO;
import carezone.member.vo.MemberVO;

@Controller("hoscartController")
@RequestMapping("/hoscart")
public class HosCartControllerImpl implements HosCartController {

	@Autowired
	private HosCartService hoscartService;
	
	//장바구니 1개 insert
	@Override
	@RequestMapping(value="/inserthosCart.do",method= {RequestMethod.GET,RequestMethod.POST})
	public ModelAndView insertHosCart(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("=========== controller의 insertHosCart() 도착 ==============");
		 ModelAndView mav = new ModelAndView();
		 
		 
		//전처리
		String hchos_no = (String) request.getParameter("hchosno");
		HttpSession session = request.getSession();
		MemberVO memVO = (MemberVO) session.getAttribute("memVO");
		if(memVO!=null) {
			int hchosno = Integer.parseInt(hchos_no);						//병원 코드
			String hchosname = (String) request.getParameter("hchosname");	//병원 이름
			String hcid = memVO.getMid();									//회원 아이디
			String hcvccname = (String) request.getParameter("hcvccname");		//백신 이름
			
			System.out.println("병원 코드 : "+hchosno+", 병원 이름 : "+hchosname+", 회원 아이디 : "+hcid+", 백신 이름 : "+hcvccname);
			HosCartVO hcVO = new HosCartVO(hcid,hchosno,hchosname,hcvccname);
			
			//서비스 전달
			int result = hoscartService.insertHosCart(hcVO);
			System.out.println("result : "+result);


		   
		   // mav.addObject("message",message);
		    mav.setViewName("redirect:/hospital/getlistHospital.do");	    
		    return mav;
		}
		else {
			mav.setViewName("redirect:/hospital/getlistHospital.do");
			return mav;
		}
		
		
	}

	//장바구니 전체 select
	@Override
	@RequestMapping(value="/getlistHosCart.do",method= {RequestMethod.GET,RequestMethod.POST})
	public ModelAndView getlistHosCart(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("========== controller의 getlistHosCart() 도착 ===========");
		

		HttpSession session = request.getSession();
		MemberVO memVO = (MemberVO) session.getAttribute("memVO");
		ModelAndView mav = new ModelAndView();
		String viewName = getViewName(request);
		
		
		if(memVO != null) {
			//세션에 있는 회원 객체의 아이디
			String hcid = memVO.getMid();
			//서비스로 전달
			List<HosCartVO> hoscartList = hoscartService.getlistHosCart(hcid);
			//전달 후
			
			mav.addObject("hoscartList", hoscartList);
			mav.setViewName(viewName);
			return mav;
		}
		else {
			mav.setViewName(viewName);
			return mav;
		}
	}
	
	
	//내 장바구니 1개 delete
	@Override
	@RequestMapping(value="/deleteMyHosCart.do",method= {RequestMethod.GET,RequestMethod.POST})
	public ModelAndView deleteHosCart(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("========== controller의 getdeleteHosCart() 도착 ===========");
		HttpSession session = request.getSession();
		MemberVO memVO = (MemberVO) session.getAttribute("memVO");
		String hcid = memVO.getMid();	//회원 아이디
		int hcno = Integer.parseInt((String) request.getParameter("hcno"));
		System.out.println("회원 아이디 : "+hcid+", 삭제할 번호 : "+hcno);
		HosCartVO hcVO = new HosCartVO(hcno, hcid);
		
		//서비스로 전달
		int result = hoscartService.deleteHosCart(hcVO);
		//서비스, dao 전달 결과
		System.out.println("삭제 결과 : "+result);
		
		ModelAndView mav = new ModelAndView("redirect:/hoscart/getlistHosCart.do");
		
		return mav;
	}
	
	

	@Override
	@RequestMapping(value="/countMyHosCart.do",method= {RequestMethod.GET})
	public ModelAndView countHosCart(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("========== controller의 getdeleteHosCart() 도착 ===========");
		HttpSession session = request.getSession();
		MemberVO memVO = (MemberVO) session.getAttribute("memVO");
		if(memVO!=null) {
			String hcid = memVO.getMid();	//회원 아이디
			
			//서비스 이동
			int result = hoscartService.countHosCart(hcid);
			System.out.println("카운트 결과 : "+result);
			
			//서비스 다녀옴
			PrintWriter out = response.getWriter();
			out.println(result);
		}
		else {
			System.out.println("null");
		}
		return null;
	}

	//뷰name
	private String getViewName(HttpServletRequest request) throws Exception{
		System.out.println("getViewName 함수 도착");
		String contextPath = request.getContextPath();
		System.out.println("contextPath : "+contextPath);

		String pathinfo = request.getPathInfo();
		System.out.println("pathinfo : "+pathinfo);
		
		String uri = (String) request.getAttribute("javax.servlet.include.request_uri");
		System.out.println("uri : "+uri);
		
		if(uri == null || uri.trim().equals("")) {
			uri=request.getRequestURI();
			System.out.println("uri : "+uri);
		}

		
		int begin = 0;
		if(!((contextPath==null)||("".equals(contextPath)))) {
			begin = contextPath.length();
			System.out.println("begin : "+begin);
		}
		
		int end;
		if(uri.indexOf(";")!= -1) {
			end=uri.indexOf(";");
		}
		else if(uri.indexOf("?")!= -1) {
			end=uri.indexOf("?");
		}
		else {
			end=uri.length();
		}
		System.out.println("end : "+end);
		
		String fileName=uri.substring(begin, end);
		if(fileName.indexOf(".")!=-1) {
			fileName=fileName.substring(0,fileName.lastIndexOf("."));
		}
		/*
		 * if(fileName.lastIndexOf("/")!=-1) {
		 * fileName=fileName.substring(fileName.lastIndexOf("/")+1,fileName.length()); }
		 */
		System.out.println("fileName : "+fileName);
		
		return fileName;
	}
}
