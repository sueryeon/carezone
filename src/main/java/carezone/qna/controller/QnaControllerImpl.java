package carezone.qna.controller;

import java.io.File;
import java.io.PrintWriter;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import carezone.member.vo.AdminVO;
import carezone.member.vo.MemberVO;
import carezone.qna.VO.QnaVO;
import carezone.qna.VO.ReplyqnaVO;
import carezone.qna.service.QnaService;

@Controller("qnaController")
@RequestMapping("/qna")
public class QnaControllerImpl implements QnaController {
	
	@Autowired
	private QnaService qnaservice;
	
	private QnaVO qnaVO;
	private String viewName=null;
	
	//private String 	QNA_IMG_REPO="c:\\qna\\qna_img";
	
	@Override
	@RequestMapping(value=("/getqnaForm.do"), method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView getQnaForm(@RequestParam(value="mid", required = false) String qid,HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		System.out.println("=======================qna 컨트롤러 : getQnaForm=======================");
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		viewName=getViewName(request);
		ModelAndView mav=new ModelAndView(viewName);

		//----------------------------------------------전처리▲

		//	mav.addObject("qid", qid);
		//----------------------------------------------mav 세팅▲
		return mav;
		
	}

	@Override
	@RequestMapping(value={"/insertQna.do"}, method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView insertQna(MultipartHttpServletRequest multi, HttpServletResponse response) throws Exception {
		
		System.out.println("=======================qna 컨트롤러 : insertQna=======================");
		
		multi.setCharacterEncoding("UTF-8");
		viewName=getViewName(multi);
		Map<String, Object> qnaMap = new HashMap<String, Object>();
		String QNA_IMG_REPO = multi.getServletContext().getRealPath("/qna");	
		
		Enumeration enu=multi.getParameterNames();
		while(enu.hasMoreElements()) {
			String name=(String) enu.nextElement();
			String value=multi.getParameter(name);
			qnaMap.put(name, value);
		}
		
		String qimgfile=insert(multi);
		qnaMap.put("qimgfile", qimgfile);
		qnaMap.put("qparentno", 0);
		
		//----------------------------------------------전처리▲
		
		int qarticleno=0;
		
		try {
			qarticleno=qnaservice.insertQna(qnaMap);
			
			if(qimgfile!=null&&qimgfile.length()!=0) {
				File srcFile = new File(QNA_IMG_REPO+"\\temp\\"+qimgfile);
				File destDir = new File(QNA_IMG_REPO+"\\temp\\"+qarticleno);
				
				FileUtils.copyFileToDirectory(srcFile, destDir, true);
			}
		}
		catch(Exception e) {
			
			File srcFile = new File(QNA_IMG_REPO+"\\temp\\"+qimgfile);
			srcFile.delete();
			
			e.printStackTrace();
		}
		//----------------------------------------------서비스 메서드 실행▲
		
		ModelAndView mav=new ModelAndView("redirect:/qna/getDetailQna.do?qarticleno="+qarticleno);
		//----------------------------------------------mav 세팅▲
		
		return mav;
	}

	@Override
	@RequestMapping(value={"/getlistQna.do"}, method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView getlistQna(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("=======================qna 컨트롤러 : getlistQna=======================");
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		String viewName=getViewName(request);
		ModelAndView mav=new ModelAndView(viewName);
		
		String _pagenum = request.getParameter("pagenum");
		int pagenum = Integer.parseInt(((_pagenum==null)? "1": _pagenum));
		
		int offset = (pagenum - 1) * 10;
		int pagesize = 10;
		
		Map<String, Integer> pagingMap = new HashMap<String, Integer>();
	    pagingMap.put("offset", offset);
	    pagingMap.put("pagesize", pagesize);
		
	    Map<String, Integer> articlesMap = qnaservice.getlistQna(pagingMap);
	    
	    articlesMap.put("pagenum", pagenum);
	    articlesMap.put("pagesize", pagesize);
		
	    mav.addObject("qnaMap", articlesMap);
		
		return mav;
	}
	
	
	@Override
	@RequestMapping(value={"/getDetailQna.do"}, method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView getDetailQna(@RequestParam("qarticleno") int qarticleno, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("=======================qna 컨트롤러 : getDetailQna=======================");
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		String viewName=getViewName(request);
		ModelAndView mav=new ModelAndView(viewName);
		
		qnaVO=qnaservice.getDetailQna(qarticleno);
		
		mav.addObject("qnaVO",qnaVO);
		
		return mav;
	}
	
	@Override
	@RequestMapping(value={"/updateQna.do"}, method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView updateQna(MultipartHttpServletRequest multi, HttpServletResponse response) throws Exception {
		
		System.out.println("=======================qna 컨트롤러 : updateQna=======================");
		
		multi.setCharacterEncoding("UTF-8");
		viewName=getViewName(multi);
		Map<String, Object> qnaMap = new HashMap<String, Object>();
		String QNA_IMG_REPO = multi.getServletContext().getRealPath("/qna");
		Enumeration enu=multi.getParameterNames();
		while(enu.hasMoreElements()) {
			
			String name=(String) enu.nextElement();
			String value=multi.getParameter(name);
			
			qnaMap.put(name, value);
		}
		
		String qimgfile=insert(multi);
		qnaMap.put("qimgfile", qimgfile);
		
		//----------------------------------------------전처리▲
		
		int qarticleno=Integer.parseInt((String) qnaMap.get("qarticleno"));
		System.out.println(qarticleno);
		
		try {
			qnaservice.updateQna(qnaMap);
			
			if(qimgfile!=null&&qimgfile.length()!=0) {
				File srcFile = new File(QNA_IMG_REPO+"\\temp\\"+qimgfile);
				File destDir = new File(QNA_IMG_REPO+"\\temp\\"+qarticleno);
				
				FileUtils.copyFileToDirectory(srcFile, destDir, true);
				
				String originalFileName=(String) qnaMap.get("originalFileName");
				File oldFile=new File(QNA_IMG_REPO+"\\"+qarticleno+"\\"+originalFileName);
				oldFile.delete();
				
			}
		}
		catch(Exception e) {
			
			File srcFile = new File(QNA_IMG_REPO+"\\temp\\"+qimgfile);
			srcFile.delete();
			
			e.printStackTrace();
		}
		//----------------------------------------------서비스 메서드 실행▲
		
		ModelAndView mav=new ModelAndView("redirect:/qna/getDetailQna.do?qarticleno="+qarticleno);
		//----------------------------------------------mav 세팅▲
		
		return mav;
		
	}
	
	@Override
	@RequestMapping(value={"/updateQnaForm.do"}, method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView updateQnaForm(@RequestParam("qarticleno") int qarticleno,HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("=======================qna 컨트롤러 : updateQnaForm=======================");
		System.out.println("글 수정 번호 : "+qarticleno);
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		viewName=getViewName(request);
		ModelAndView mav=new ModelAndView(viewName);

		//----------------------------------------------전처리▲
		qnaVO=qnaservice.updateQnaForm(qarticleno);
		//----------------------------------------------서비스 메서드 실행▲
		
		mav.addObject("qnaVO", qnaVO);
		//----------------------------------------------mav 세팅▲
		return mav;

	}
	
	@Override
	@RequestMapping(value={"/deleteQna.do"}, method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView deleteQna(int qarticleno, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		System.out.println("=======================qna 컨트롤러 : deleteQna=======================");
		String QNA_IMG_REPO = request.getServletContext().getRealPath("/qna");
		request.setCharacterEncoding("UTF-8");
		//----------------------------------------------전처리▲
		
		try {
			qnaservice.deleteQna(qarticleno);
			File destDir = new File(QNA_IMG_REPO+"\\"+qarticleno);
			FileUtils.deleteDirectory(destDir);
		}
		catch(Exception e) {
			
			e.printStackTrace();
		}
		//----------------------------------------------서비스 메서드 실행▲
		
		ModelAndView mav=new ModelAndView("redirect:/qna/getlistQna.do");
		//----------------------------------------------mav 세팅▲
		return mav;

	}

	@Override
	@RequestMapping(value={"/insertReplyQna.do"}, method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView insertReplyQna(@RequestParam("Qarticleno") int qrearticleno,@RequestParam("Qrecontent") String qrecontent,HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("=======================qna 댓글 컨트롤러 : insertReplyQna=======================");
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		HttpSession session = request.getSession();
		AdminVO adVO = (AdminVO) session.getAttribute("adVO");
		if(adVO==null) {
			System.out.println("관리자 null");
		}
		else {
			
			ReplyqnaVO reqnaVO=new ReplyqnaVO(qrearticleno,adVO.getAdid(),qrecontent);
			//----------------------------------------------전처리▲
			qnaservice.insertReplyQna(reqnaVO);
			//----------------------------------------------서비스 메서드 실행▲
			System.out.println("댓글 insert 성공");
		}
		return null;
	}

	@Override
	@RequestMapping(value={"/getlistReplyQna.do"}, method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView getlistReplyQna(@RequestParam("qrearticleno") int qrearticleno,HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("=======================qna 댓글 컨트롤러 : getlistReplyQna=======================");
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		//----------------------------------------------전처리▲
		
		List<ReplyqnaVO> listReplyQna=qnaservice.getlistReplyQna(qrearticleno);
		//----------------------------------------------서비스 메서드 실행▲
		HttpSession session = request.getSession();
		AdminVO adVO = (AdminVO) session.getAttribute("adVO");
		MemberVO memVO = (MemberVO) session.getAttribute("memVO");
		
		
		if(adVO==null && memVO==null) {
			System.out.println("null입니다.");
		}
		
		else if(adVO==null && memVO!=null) {
			for(int i=0; i<listReplyQna.size(); i++) {
				ReplyqnaVO reqnaVO=listReplyQna.get(i);
				int qreplyno= reqnaVO.getQreplyno();
				String qreid=reqnaVO.getQreid();
				String qrecontent=reqnaVO.getQrecontent();
				Date qrewritedate=reqnaVO.getQrewritedate();
				
				PrintWriter out=response.getWriter();
					out.println("<li style='list-style-type:none'>"
							+ "<tr><td width='150' align='center' bgcolor='#FF9933'>"
							+ "<input type='hidden' name='qrearticleno' id='qrearticleno' value='"+qrearticleno+"'/>"+qreid
							+ "</td><td>"
							+ "<textarea rows='5' cols='80' name='qrecontent' id='qrecontent"+qreplyno+"' style='resize:none' disabled>"+qrecontent+"</textarea>"
							+ "</td><td>"
							+ "<input type='hidden' name='qreplyno' id='qreplyno"+qreplyno+"' value='"+qreplyno+"'/>"
							+ "</td><td>"
							+ "</td></tr></li>");
				}
		}
		else if(adVO!=null || memVO ==null) {
			for(int i=0; i<listReplyQna.size(); i++) {
				
				ReplyqnaVO reqnaVO=listReplyQna.get(i);
				int qreplyno= reqnaVO.getQreplyno();
				String qreid=reqnaVO.getQreid();
				String qrecontent=reqnaVO.getQrecontent();
				Date qrewritedate=reqnaVO.getQrewritedate();
				
				PrintWriter out=response.getWriter();
				out.println("<li style='list-style-type:none'>"
						+ "<tr><td width='150' align='center' bgcolor='#FF9933'>"
						+ "<input type='hidden' name='qrearticleno' id='qrearticleno' value='"+qrearticleno+"'/>"+qreid
						+ "</td><td>"
						+ "<textarea rows='5' cols='80' name='qrecontent' id='qrecontent"+qreplyno+"' style='resize:none' disabled>"+qrecontent+"</textarea>"
						+ "</td><td>"
						+ "<input type='hidden' name='qreplyno' id='qreplyno"+qreplyno+"' value='"+qreplyno+"'/>"
						+ "</td><td>"
						+ "<input type='button' id='modify"+qreplyno+"' onClick='fn_modify("+qreplyno+")' value='수정'/>"
						+ "<input type='button' id='update"+qreplyno+"' onClick='fn_update("+qreplyno+")' value='등록' style='display:none'/>"
						+ "<input type='button' id='back"+qreplyno+"' onClick='fn_back("+qreplyno+")' value='취소' style='display:none'/>"
						+ "<input type='button' id='delete"+qreplyno+"' onClick='fn_delete("+qreplyno+")' value='삭제'/>"
						+ "</td></tr></li>");
				
				}
			}
			return null;
		}
	
	@Override
	@RequestMapping(value={"/deleteReplyQna.do"}, method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView deleteReplyQna(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("=======================qna 댓글 컨트롤러 : deleteReplyQna=======================");
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		int qreplyno=Integer.parseInt(request.getParameter("qreply_no"));
		//----------------------------------------------전처리▲
		
		qnaservice.deleteReplyQna(qreplyno);
		//----------------------------------------------서비스 메서드 실행▲
		
		return null;
	}

	@Override
	@RequestMapping(value={"/updateReplyQna.do"}, method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView updateReplyQna(@RequestParam("qreplyno") int qreplyno,@RequestParam("qrecontent") String qrecontent,HttpServletRequest request, HttpServletResponse response) throws Exception {

		System.out.println("=======================qna 댓글 컨트롤러 : updateReplyQna=======================");
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		ReplyqnaVO reqnaVO=new ReplyqnaVO(qreplyno,qrecontent);
		//----------------------------------------------전처리▲
			
		qnaservice.updateReplyQna(reqnaVO);
		//----------------------------------------------서비스 메서드 실행▲s

		return null;
	}

	
	private String insert(MultipartHttpServletRequest multi) throws Exception {
		
		System.out.println("RE : insert ");
		
		String qimgfile= null;
		Iterator<String> fileNames = multi.getFileNames();
		String QNA_IMG_REPO = multi.getServletContext().getRealPath("/qna");
		while(fileNames.hasNext()){
			
			String fileName = fileNames.next();
			MultipartFile qFile = multi.getFile(fileName);
			qimgfile=qFile.getOriginalFilename();
			File file = new File(QNA_IMG_REPO +"\\temp\\" + fileName);
			
			if(qFile.getSize()!=0){ 
				
				if(!file.exists()){ 
					file.getParentFile().mkdirs(); 
					qFile.transferTo(new File(QNA_IMG_REPO +"\\temp\\"+qimgfile));
				}
			}
			
		}
		
		return qimgfile;
		
	}

	private String getViewName(HttpServletRequest request) throws Exception{
		
		System.out.println("RE : getViewName ");
		
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
