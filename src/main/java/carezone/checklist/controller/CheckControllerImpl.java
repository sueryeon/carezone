package carezone.checklist.controller;

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

import carezone.checklist.VO.CheckVO;
import carezone.checklist.service.CheckService;
import carezone.member.vo.MemberVO;

@Controller("checkController")
@RequestMapping("/checklist")
public class CheckControllerImpl implements CheckController {
	
	@Autowired
	private CheckService checkService;
	
	private CheckVO checkVO;
	
	@Override
	@RequestMapping(value={"/getChecklist.do"}, method= {RequestMethod.GET, RequestMethod.POST}) //체크리스트 가져오는 메서드
	public ModelAndView getChecklist(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("=======================체크리스트 컨트롤러 : getChecklist=======================");
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		String viewName=getViewName(request);
		HttpSession session = request.getSession();
		MemberVO memVO=(MemberVO) session.getAttribute("memVO");
		String mid=memVO.getMid();
		List<CheckVO> checklist=checkService.getChecklist(mid);
		ModelAndView mav=new ModelAndView(viewName);
		//----------------------------------------------전처리▲
		
		System.out.println(checklist.size());
		
		if(mid!=null||mid.length()!=0) {
			
			
			if(checklist!=null||checklist.size()!=0) {

				
				mav.addObject("checklist",checklist);
				
			}

			return mav;
			
		}
		else {
			System.out.println("에러");
			
			return null;
		}

	}

	@Override
	public ModelAndView insertChecklist(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	@RequestMapping(value={"/changeCheckType.do"}, method= {RequestMethod.GET, RequestMethod.POST}) //체크된 목록 변경 메서드
	public void changeCheckType(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("=======================체크리스트 컨트롤러 : changeCheckType=======================");
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out=response.getWriter();
		HttpSession session = request.getSession();
		MemberVO memVO=(MemberVO) session.getAttribute("memVO");
		String mid=memVO.getMid();
		
		boolean type=Boolean.parseBoolean(request.getParameter("type"));
		int ckno=Integer.parseInt(request.getParameter("ckno"));
		System.out.println(mid+" / "+type+" / "+ckno);
		
		checkVO=new CheckVO(ckno,mid,type);
		
		int listType=checkService.changeCheckType(checkVO);
		
		out.print(listType);
	}
	
	@Override
	public void getTypes(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("=======================체크리스트 컨트롤러 : getTypes=======================");
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out=response.getWriter();
		HttpSession session = request.getSession();
		MemberVO memVO=(MemberVO) session.getAttribute("memVO");
		String mid=memVO.getMid();
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




}
