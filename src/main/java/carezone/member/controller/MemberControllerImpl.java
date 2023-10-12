package carezone.member.controller;

import java.io.PrintWriter;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;

import carezone.member.service.MemberService;
import carezone.member.vo.AdminVO;
import carezone.member.vo.FamilyVO;
import carezone.member.vo.MemberVO;

@Controller("memberController")
public class MemberControllerImpl implements MemberController {
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	MailSender sender;


	//관리자 로그인 페이지 이동
	@Override
	@RequestMapping(value="/member/adminLoginForm.do", method= {RequestMethod.GET})
	public ModelAndView getAdminLoginForm(@RequestParam(value="result", required = false) String result, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		System.out.println("controller의 관리자 로그인 페이지");
		String viewName = getViewName(request);
		ModelAndView mav = new ModelAndView();
		mav.addObject("result",result);
		mav.setViewName(viewName);
		return mav;
	}


	//관리자 로그인
	@Override
	@RequestMapping(value="/member/adminLogin.do",method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView getAdminLogin(AdminVO adminVO, RedirectAttributes reAttr, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		System.out.println("controller의 getAdminLogin() 도착");
		ModelAndView mav = new ModelAndView();
		
		AdminVO adVO = memberService.getAdminLogin(adminVO);
		
		mav.setViewName("redirect:/");
		
		if(adVO!=null) {
			HttpSession session = request.getSession();
			session.setAttribute("adVO", adVO);
			session.setAttribute("isAdminLogin", true);
			mav.setViewName("redirect:/");
		}
		else {
			reAttr.addAttribute("inputid", adminVO.getAdid());
			reAttr.addAttribute("result", "loginFailed"); //로그인 실패시 실패메시지 바로 전달
			mav.setViewName("redirect:/member/adminLoginForm.do");
		}
		return mav;
	}



	//로그인 폼	
	@Override
	@RequestMapping(value="/member/loginForm.do", method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView getLoginForm(@RequestParam(value="result", required = false) String result,HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("controller의 getLoginForm() 도착");
		request.setCharacterEncoding("utf-8");
		String viewName = getViewName(request);
		ModelAndView mav = new ModelAndView();
		mav.addObject("result", result);
		mav.setViewName(viewName);		
		return mav;
	}
	

	//로그인	
	@Override
	@RequestMapping(value="/member/memberLogin.do", method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView getLogin(@ModelAttribute("memberVO") MemberVO memberVO, RedirectAttributes reAttr, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		System.out.println("controller의 getLogin() 도착");
		String action = (String) request.getParameter("action");
		System.out.println("action : "+action);
		
		MemberVO memVO = memberService.getLogin(memberVO);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:/");
		if(action.equals("reserv")) {
			if(memVO!=null) {
				HttpSession session = request.getSession();
				session.setAttribute("memVO", memVO);
				session.setAttribute("isLogin", true);
				mav.setViewName("redirect:/reservation/getreservationForm.do");
			}
			else {
				reAttr.addAttribute("inputid", memberVO.getMid());
				reAttr.addAttribute("result", "loginFailed"); //로그인 실패시 실패메시지 바로 전달
				mav.setViewName("redirect:/member/loginForm.do");
			}
		}
		else if(action.equals("myreserv")) {
			if(memVO!=null) {
				HttpSession session = request.getSession();
				session.setAttribute("memVO", memVO);
				session.setAttribute("isLogin", true);
				mav.setViewName("redirect:/reservation/getlistMyReservations.do?mid="+memVO.getMid());
			}
			else {
				reAttr.addAttribute("inputid", memberVO.getMid());
				reAttr.addAttribute("result", "loginFailed"); //로그인 실패시 실패메시지 바로 전달
				mav.setViewName("redirect:/member/loginForm.do");
			}
		}
		else if(action.equals("board")) {
			if(memVO!=null) {
				HttpSession session = request.getSession();
				session.setAttribute("memVO", memVO);
				session.setAttribute("isLogin", true);
				mav.setViewName("redirect:/board/insertBoardForm.do");
			}
			else {
				reAttr.addAttribute("inputid", memberVO.getMid());
				reAttr.addAttribute("result", "loginFailed"); //로그인 실패시 실패메시지 바로 전달
				mav.setViewName("redirect:/member/loginForm.do");
			}
		}
		else if(action.equals("insertcart")) {
			if(memVO!=null) {
				HttpSession session = request.getSession();
				session.setAttribute("memVO", memVO);
				session.setAttribute("isLogin", true);
				mav.setViewName("redirect:/hospital/getlistHospital.do");
			}
			else {
				reAttr.addAttribute("inputid", memberVO.getMid());
				reAttr.addAttribute("result", "loginFailed"); //로그인 실패시 실패메시지 바로 전달
				mav.setViewName("redirect:/member/loginForm.do");
			}
		}
		else {
			if(memVO!=null) {
				HttpSession session = request.getSession();
				session.setAttribute("memVO", memVO);
				session.setAttribute("isLogin", true);
				mav.setViewName("redirect:/");
			}
			else {
				reAttr.addAttribute("inputid", memberVO.getMid());
				reAttr.addAttribute("result", "loginFailed"); //로그인 실패시 실패메시지 바로 전달
				mav.setViewName("redirect:/member/loginForm.do");
			}
		}
		
		/*
		if(memVO!=null) {
			HttpSession session = request.getSession();
			session.setAttribute("memVO", memVO);
			session.setAttribute("isLogin", true);
			mav.setViewName("redirect:/");
		}
		else {
			reAttr.addAttribute("inputid", memberVO.getMid());
			reAttr.addAttribute("result", "loginFailed"); //로그인 실패시 실패메시지 바로 전달
			mav.setViewName("redirect:/member/loginForm.do");
		}*/
		return mav;
	}

	



	//로그아웃
	@Override
	@RequestMapping(value="/member/logout.do", method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView getlogout(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		session.setAttribute("isLogin", false);
		session.setAttribute("isAdminLogin", false);
		session.removeAttribute("adVO");
		session.removeAttribute("memVO");
		mav.setViewName("redirect:/");
		return mav;
	}

	//회원가입 폼
	@Override
	@RequestMapping(value="/member/memberForm.do", method= {RequestMethod.GET})
	public ModelAndView getForm(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("form 함수 도착");
		String viewName = getViewName(request);
		ModelAndView mav = new ModelAndView();
		mav.setViewName(viewName);
		return mav;
	}
	



	//회원조회
	@Override
	@RequestMapping(value="/member/listMembers.do", method= {RequestMethod.GET})
	public ModelAndView getlistMembers(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("ModelAndView getlistMembers 함수 도착");
		String viewName = getViewName(request);
		List<MemberVO> membersList = memberService.getlistMembers();
		ModelAndView mav = new ModelAndView(viewName);
		mav.addObject("membersList",membersList);
		
		return mav;
	}

	//회원가입
	@Override
	@RequestMapping(value="/member/insertMember.do", method= {RequestMethod.POST})
	public ModelAndView insertMember(@ModelAttribute("memberVO") MemberVO memberVO, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("ModelAndView insertMember 함수 도착");
		request.setCharacterEncoding("utf-8");
		System.out.println("회원 이름 : "+memberVO.getMname());
		int result = memberService.insertMember(memberVO);
		ModelAndView mav = new ModelAndView("redirect:/");
		
		return mav;
	}
	
	
	//회원 아이디 중복 확인
	@Override
	@RequestMapping(value="/member/midcheck.do", method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView getIdCheck(@RequestParam("checkid") String checkid, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		System.out.println("==========controller의 아이디 중복 확인 함수 도착=============");
		String result = memberService.getIdCheck(checkid);
		System.out.println("중복 검사 결과 : "+result);
		PrintWriter out = response.getWriter();
		out.print(result);
		return null;
	}

	//회원 휴대폰 중복 확인
	@Override
	@RequestMapping(value="/member/mphonecheck.do",method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView getPhoneCheck(String checkphone, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		System.out.println("===========controller의 휴대폰 중복 확인 함수 도착===============");
		String result = memberService.getPhoneCheck(checkphone);
		System.out.println("중복 검사 결과 : "+result);
		PrintWriter out = response.getWriter();
		out.print(result);
		return null;
	}
	
	//이메일 인증하기
	@Override
	@RequestMapping(value="/member/emailcheck.do", method= {RequestMethod.POST})
	public String getEmailCheck(HttpServletRequest request, HttpServletResponse response)throws Exception {
		System.out.println("controller의 이메일 인증하기");
		String memail1 = (String) request.getParameter("memail1");
		String memail2 = (String) request.getParameter("memail2");
		String email = memail1+"@"+memail2;
		int num = sendMail(email,memail1);
		System.out.println("이메일 전송 후 conroller emailcheck.do로 돌아옴");
		String checkNum = Integer.toString(num);
		System.out.println("checknum : "+checkNum);
		PrintWriter out = response.getWriter();
		out.println(checkNum);
			
		return null;
	}
	
	//이메일 전송 함수
	public int sendMail(String email,String memail1) {
		System.out.println("이메일 전송 함수()");
		
		Random random = new Random();
		int checkNum = random.nextInt(888888)+111111;
		System.out.println("checknum : "+checkNum);
		String host ="http://localhost:8080/proCareZone/member/emcheck";
		String from = "CareZone@gmail.com";
		String content = "인증 코드는 " + checkNum + " 입니다.\n"
				 +"해당 인증 코드를 인증 코드 확인란에 기입하여 주세요.";
		
		SimpleMailMessage message = new SimpleMailMessage();
		message.setTo(email);
		message.setSubject("전달 메시지");
		message.setText(content);
		message.setFrom("CareZone@gmail.com");
		sender.send(message);
		System.out.println("이메일 전송 완료");
		
		return checkNum;
	}

	
	
	//회원 1명 조회 후 수정 폼
	@Override
	@RequestMapping(value="/member/findMember.do", method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView findMember(@RequestParam("action") String action, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("ModelAndView findMember 함수 도착");
		request.setCharacterEncoding("utf-8");
		String viewName = getViewName(request);
		System.out.println("findMember() action : "+action);
		HttpSession session = request.getSession();
		if(action.equals("member")) {
			MemberVO memberVO = (MemberVO) session.getAttribute("memVO");
			MemberVO memVO = memberService.findMember(memberVO.getMid());		
			ModelAndView mav = new ModelAndView(viewName);
			mav.addObject("memVO",memVO);
			return mav;
		}
		else if(action.equals("admin")) {
			AdminVO adminVO = (AdminVO) session.getAttribute("adVO");
			AdminVO adVO = memberService.findAdmin(adminVO.getAdid());
			ModelAndView mav = new ModelAndView(viewName);
			mav.addObject("adVO", adVO);
			return mav;
		}
		
		return null;
		
	}

	//회원 수정
	@Override
	@RequestMapping(value="/member/updateMember.do", method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView updateMember(String action,HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("ModelAndView findMembers 함수 도착");
		request.setCharacterEncoding("utf-8");
		ModelAndView mav = new ModelAndView();
		if(action.equals("member")) {
			System.out.println("회원의 마이페이지 수정");
			
			//전처리
			String mid = (String) request.getParameter("mid");
			String mpwd = (String)request.getParameter("mpwd");
			String mname = (String)request.getParameter("mname");
			String memail1 = (String) request.getParameter("memail1");
			String memail2 = (String) request.getParameter("memail2");
			String mphone = (String) request.getParameter("mphone");
			String maddr = (String) request.getParameter("maddr");
			
			//서비스 전달
			MemberVO memberVO = new MemberVO(mid,mpwd,mname,memail1,memail2,mphone,maddr);
			
			//서비스 전달 후
			int result = memberService.updateMember(memberVO);
			System.out.println("회원 수정 결과 :"+result);
			mav.setViewName("redirect:/member/findMember.do?action=member");
			return mav;
			
		}
		
		else if(action.equals("admin")) {
			System.out.println("관리자의 마이페이지 수정");
			//전처리
			String adid = (String) request.getParameter("adid");
			String adpwd = (String) request.getParameter("adpwd");
			String adname = (String) request.getParameter("adname");
			AdminVO adminVO = new AdminVO(adid,adpwd,adname);
			
			//서비스 전달
			int result = memberService.updateAdmin(adminVO);
			
			//서비스 전달 후
			System.out.println("관리자 수정 결과 : "+result);
			mav.setViewName("redirect:/member/findMember.do?action=admin");
			return mav;
		}
		
		return null;
	}

	//회원 삭제
	@Override
	@RequestMapping(value="/member/deleteMember.do", method= {RequestMethod.GET})
	public ModelAndView deleteMember(@RequestParam("mid") String mid,HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MemberControllerImpl의 deleteMember() 도착");
		request.setCharacterEncoding("utf-8");
		System.out.println("삭제할 아이디 : "+mid);
		int result = memberService.deleteMember(mid);
		System.out.println("MemberControllerImpl의 result : "+result);
		ModelAndView mav = new ModelAndView("redirect:/member/listMembers.do");
		return mav;
	}
	
	//아이디 찾기 페이지 이동 메서드
	@Override
	@RequestMapping(value="/member/findMyIdForm.do",method= {RequestMethod.GET})
	public ModelAndView getfindMIForm(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MemberControllerImpl의 getfindMCForm() 도착");
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		ModelAndView mav = new ModelAndView();
		String viewname = getViewName(request);
		mav.setViewName(viewname);
		return mav;
	}	
	
	//아이디 찾기
	@RequestMapping(value="/member/findMyId.do",method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView findMyId(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MemberControllerImpl의 getfindMCForm() 도착");
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		ModelAndView mav = new ModelAndView();
		String viewname = getViewName(request);
		
		String mname = (String) request.getParameter("mname");
		String memail1 = (String)request.getParameter("memail1");
		String memail2 = (String) request.getParameter("memail2");
		System.out.println("찾기 정보 : "+mname+", "+memail1+", "+memail2);
		MemberVO memberVO = new MemberVO(mname,memail1,memail2);
		String mid = memberService.findMyId(memberVO);
		System.out.println("회원 찾기 한 아이디 : "+mid);
		
		mav.addObject("mid",mid);
		mav.setViewName(viewname);
		
		return mav;
	}	
	
	//비밀번호 찾기 페이지
	@Override
	@RequestMapping(value="/member/findMyPwdForm.do",method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView getfindMPForm(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MemberControllerImpl의 getfindMPForm() 도착");
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		ModelAndView mav = new ModelAndView();
		String viewname = getViewName(request);
		mav.setViewName(viewname);
		
		return mav;
	}	
	
	
	//예약에서 본인인증하기
	@Override
	@RequestMapping(value="/member/memcheck.do",method= {RequestMethod.GET,RequestMethod.POST})
	public String getMemCheck(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MemberControllerImpl의 getMemCheck() 도착");
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		String mname=(String) request.getParameter("mname");
		String memail1 = (String) request.getParameter("memail1");
		String memail2 = (String)request.getParameter("memail2");
		
		MemberVO memberVO = new MemberVO(mname,memail1,memail2);
		String result = memberService.memcheck(memberVO);
		
		PrintWriter out = response.getWriter();
		out.print(result);
		 
		return null;
	}


	//본인인증 후 비밀번호 재설정 페이지로 이동
	@Override
	@RequestMapping(value="/member/findMyPwd.do",method= {RequestMethod.GET,RequestMethod.POST})
	public ModelAndView findMyPwd(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MemberControllerImpl의 findMyPwd() 도착");
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		String viewname = getViewName(request);
		
		String mname = (String) request.getParameter("mname");
		String mid = (String) request.getParameter("mid");
		String memail1 = (String) request.getParameter("memail1");
		String memail2 = (String) request.getParameter("memail2");
		System.out.println("meamil2 : "+memail2);
		MemberVO memberVO = new MemberVO(mname,mid,memail1,memail2);
		int result = memberService.findMyPwd(memberVO);
		String count = "";
		if(result==1) {
			count = "tru";
			System.out.println("true입니다.");
		}
		else {
			count = "fals";
			System.out.println("false입니다.");
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName(viewname);
		mav.addObject("count", count);
		mav.addObject("memail1", memail1);
		mav.addObject("memail2",memail2);
		return mav;
	}	
	
	
	//비밀번호 재설정하기
	@Override
	@RequestMapping(value="/member/NewMyPwd.do",method= {RequestMethod.GET,RequestMethod.POST})
	public ModelAndView newMyPwd(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MemberControllerImpl의 newMyPwd() 도착");
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String memail1 = (String)request.getParameter("memail1");
		String memail2 = (String) request.getParameter("memail2");
		String mpwd = (String)request.getParameter("mpwd");
		
		MemberVO memberVO = new MemberVO();
		memberVO.setMemail1(memail1);
		memberVO.setMemail2(memail2);
		memberVO.setMpwd(mpwd);
		int result = memberService.newMyPwd(memberVO);
		System.out.println("비밀번호 변경 결과 : "+result);
		
		ModelAndView mav = new ModelAndView("redirect:/member/loginForm.do");
		
		return mav;
	}
	
	
	
	/*==================================================가족 관련 메서드===================================================*/





	//가족 추가 폼
	@Override
	@RequestMapping(value="/member/FamFormMember.do", method= {RequestMethod.GET})
	public ModelAndView getFamForm(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("controller의 FamFormMember.do 도착");
		request.setCharacterEncoding("utf-8");
		String viewName = getViewName(request);
		ModelAndView mav = new ModelAndView(viewName);
		//mav.addObject("memVO",memVO);
		return mav;
	}

	//가족 전체 조회
	   @Override
	   @RequestMapping(value="/member/listFamilyMembers.do", method= {RequestMethod.GET, RequestMethod.POST})
	   public ModelAndView getlistFamilyMembers(HttpServletRequest request, HttpServletResponse response)
	         throws Exception {
	      System.out.println("controller getlistFamilyMembers() 도착");
	      request.setCharacterEncoding("utf-8");
	      response.setContentType("text/html; charset=UTF-8");
	      int fno=0;
	      
	      String ajax=request.getParameter("action");
	      String _mno=request.getParameter("mno");
	      
	      System.out.println("mno:"+_mno);
	      
	      if((ajax==null&&_mno!=null)||(ajax==null&&_mno==null)) {
	         
	         System.out.println("주희가 만든 가족리스트불러오기.");
	         HttpSession session = request.getSession();
	         MemberVO memVO = (MemberVO) session.getAttribute("memVO");
	         
	         fno = memVO.getMno();
	         List<FamilyVO> familyList = memberService.getlistFamilyMembers(fno);
	         
	         String viewName = getViewName(request);
	         ModelAndView mav = new ModelAndView(viewName);
	         mav.addObject("familyList", familyList);
	         
	         return mav;
	         
	      }
	      else if(ajax!=null&&_mno!=null) {
	         
	         System.out.println("예약페이지에서 가족정보 불러오기 메서드");
	         int mno=Integer.parseInt(_mno);
	         PrintWriter out=response.getWriter();
	         fno=mno;
	         List<FamilyVO> familyList = memberService.getlistFamilyMembers(fno);
	         System.out.println("서비스 갔다가 옴. 사이즈"+familyList.size());
	         Gson gson = new Gson();

	           String json_familyList = gson.toJson(familyList);
	          System.out.println(json_familyList);
	         out.println(json_familyList);
	         
	         return null;
	      }
	      else {
	         System.out.println("ajax는 null 이 아닌데 _mno가 null 입니다. 완전 오류입니다.");
	         return null;
	      }
	      

	   }

	//가족 추가
	@Override
	@RequestMapping(value="/member/insertFamilyMember.do", method= {RequestMethod.POST})
	public ModelAndView insertFamilyMember(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("controller insertFamilyMember () 도착");
		request.setCharacterEncoding("utf-8");
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		MemberVO memberVO = (MemberVO) session.getAttribute("memVO");
		if(memberVO!=null) {
			//전처리
			int fno = memberVO.getMno();
			String fname = (String)request.getParameter("fname");
			String fbirth1 = (String) request.getParameter("fbirth1");
			String fphone = (String) request.getParameter("fphone");
			String faddr = (String)request.getParameter("faddr");
			FamilyVO famVO = new FamilyVO(fno,fname,fbirth1,fphone,faddr);
			
			//서비스 전달
			int result = memberService.insertFamilyMember(famVO);
			
			//서비스 전달 후
			System.out.println("가족 추가 결과 : "+result);
			mav.setViewName("redirect:/member/listFamilyMembers.do");
			return mav;
		}
		else {
			System.out.println("회원 없음");
			return null;
		}
		
		/*
		int fno = (Integer.parseInt(request.getParameter("fno")));
		String fname = request.getParameter("fname");
		String fbirth1 = request.getParameter("fbirth1");
		String fphone = request.getParameter("fphone");
		String faddr = request.getParameter("faddr");
		FamilyVO familyVO = new FamilyVO(fno,fname,fbirth1,fphone,faddr);
		System.out.println("fno = mno : "+fno);
		int result = memberService.insertFamilyMember(familyVO);
		
		ModelAndView mav = new ModelAndView("redirect:/member/findMember.do?mid="+mid);*/
	}
	
	
	//가족 휴대폰 중복 검사
	@Override
	@RequestMapping(value="member/fphonecheck.do",method= {RequestMethod.POST})
	public ModelAndView getfPhoneCheck(String checkfphone, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		System.out.println("=========controller 가족 휴대폰 중복 확인 함수 도착 ============");
		String result = memberService.getfPhoneCheck(checkfphone);
		PrintWriter out = response.getWriter();
		out.print(result);
		return null;
	}


	//가족 1명 조회 후 수정 폼
	@Override
	@RequestMapping(value="/member/findFamilyMember.do", method= {RequestMethod.GET})
	public ModelAndView findFamilyMember(@RequestParam("fid") int fid, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("controller의 findFamilyMember() 도착");
		FamilyVO familyVO = memberService.findFamilyMember(fid);
		String viewName = getViewName(request);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName(viewName);
		mav.addObject("famVO", familyVO);
		
		return mav;
	}

	//가족 수정
	@Override
	@RequestMapping(value="/member/updateFamilyMember.do", method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView updateFamilyMember(@ModelAttribute("familyVO") FamilyVO familyVO, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("controller의 updateFamilyMember() 도착");
		int mno = Integer.parseInt(request.getParameter("fno"));
		System.out.println("수정 주소 : "+familyVO.getFaddr());
		int result = memberService.updateFamilyMember(familyVO);
		System.out.println("수정 결과 : "+result);
		ModelAndView mav = new ModelAndView("redirect:/member/listFamilyMembers.do?mno="+mno);
		return mav;
	}
	
	//가족 삭제
	@Override
	@RequestMapping(value="/member/deleteFamilyMember.do", method= {RequestMethod.GET})
	public ModelAndView deleteFamilyMember(@RequestParam("fid") int fid,@RequestParam("fno") int mno, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("controller의 deleteFamilyMember() 도착");
		System.out.println("삭제할 가족 fid : "+fid);
		System.out.println("회원 번호 : "+mno);
		int result = memberService.deleteFamilyMember(fid);
		
		ModelAndView mav = new ModelAndView("redirect:/member/listFamilyMembers.do?mno="+mno);
		return mav;
	}

	//view name
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
