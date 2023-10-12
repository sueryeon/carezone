package carezone.notice.controller;

import java.io.File;
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
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import carezone.member.vo.AdminVO;
import carezone.notice.VO.NoticeVO;
import carezone.notice.service.NoticeService;

@Controller("noticeController")
@RequestMapping("/notice")
public class NoticeContorllerImpl implements NoticeController {
	
	@Autowired
	private NoticeService noticeService;
	
	private NoticeVO noticeVO;
	private String viewName=null;
	private String 	NOTICE_IMG_REPO="c:\\notice\\notice_img";
	
	@Override
	@RequestMapping(value=("/getNoticeForm.do"), method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView getNoticeForm(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		System.out.println("=======================공지사항 컨트롤러 : getNoticeForm=======================");
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		viewName=getViewName(request);
		
		HttpSession session=request.getSession();
		AdminVO adVO=(AdminVO) session.getAttribute("adVO");
		String adid=adVO.getAdid();
		
		if(adid!=null&&adid.length()!=0) {
			ModelAndView mav=new ModelAndView(viewName);
			return mav;
		}
		
		else {
			
			System.out.println("관리자 권한이 없습니다.");
			return null;
			
		}
		
		
	}

	@Override
	@RequestMapping(value=("/insertNotice.do"), method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView insertNotice(MultipartHttpServletRequest multi, HttpServletResponse response) throws Exception {
		
		System.out.println("=======================공지사항 컨트롤러 : insertNotice=======================");
		
		multi.setCharacterEncoding("UTF-8");
		viewName=getViewName(multi);
		Map<String, Object> noticeMap = new HashMap<String, Object>();
		
		Enumeration enu=multi.getParameterNames();
		while(enu.hasMoreElements()) {
			
			String name=(String) enu.nextElement();
			String value=multi.getParameter(name);
			
			noticeMap.put(name, value);
		}
		
		String nimgfile=insert(multi);
		noticeMap.put("nimgfile", nimgfile);
		int narticleno=0;
		//----------------------------------------------전처리▲

		try {
			narticleno=noticeService.insertNotice(noticeMap);
			
			if(nimgfile!=null&&nimgfile.length()!=0) {
				File srcFile = new File(NOTICE_IMG_REPO+"\\temp\\"+nimgfile);
				File destDir = new File(NOTICE_IMG_REPO+"\\temp\\"+narticleno);
				
				FileUtils.copyFileToDirectory(srcFile, destDir, true);
			}
		}
		catch(Exception e) {
			
			File srcFile = new File(NOTICE_IMG_REPO+"\\temp\\"+nimgfile);
			srcFile.delete();
			
			e.printStackTrace();
		}
		//----------------------------------------------서비스 메서드 실행▲
		
		ModelAndView mav=new ModelAndView("redirect:/notice/getDetailNotice.do?narticleno="+narticleno);
		//----------------------------------------------mav 세팅▲
		
		return mav;
	}

	/*@Override
	@RequestMapping(value={"/getlistNotice.do"}, method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView getlistNotice(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("=======================공지사항 컨트롤 : getlistNotice=======================");
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		String viewName=getViewName(request);
		ModelAndView mav=new ModelAndView(viewName);
		
		List<NoticeVO> listNotice=noticeService.getlistNotice();
		
		mav.addObject("listNotice", listNotice);
		
		return mav;
		
	}*/
	
	@Override
	@RequestMapping(value={"/getlistNotice.do"}, method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView getlistNotice(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("=======================공지사항 컨트롤 : getlistNotice=======================");
		
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
		
	    Map<String, Integer> articlesMap = noticeService.getlistNotice(pagingMap);
	    
	    articlesMap.put("pagenum", pagenum);
	    articlesMap.put("pagesize", pagesize);
		
	    mav.addObject("articlesMap", articlesMap);
		
	    
		return mav;
		
	}

	@Override
	@RequestMapping(value={"/getDetailNotice.do"}, method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView getDetailNotice(@RequestParam("narticleno") int narticleno, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		System.out.println("=======================공지사항 컨트롤 : getDetailNotice=======================");
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		String viewName=getViewName(request);
		ModelAndView mav=new ModelAndView(viewName);
		
		noticeVO=noticeService.getDetailNotice(narticleno);
		
		mav.addObject("noticeVO",noticeVO);
		
		return mav;
	}

	@Override
	public ModelAndView updateNotice(MultipartHttpServletRequest multi, HttpServletResponse response) throws Exception {
		
		System.out.println("=======================공지사항 컨트롤 : updateNotice=======================");
		
		multi.setCharacterEncoding("UTF-8");
		viewName=getViewName(multi);
		Map<String, Object> noticeMap = new HashMap<String, Object>();
		
		Enumeration enu=multi.getParameterNames();
		while(enu.hasMoreElements()) {
			
			String name=(String) enu.nextElement();
			String value=multi.getParameter(name);
			
			noticeMap.put(name, value);
		}
		
		String nimgfile=insert(multi);
		noticeMap.put("qimgfile", nimgfile);
		
		//----------------------------------------------전처리▲
		
		int narticleno=Integer.parseInt((String) noticeMap.get("qarticleno"));
		System.out.println(narticleno);
		
		try {
			noticeService.updateNotice(noticeMap);
			
			if(nimgfile!=null&&nimgfile.length()!=0) {
				File srcFile = new File(NOTICE_IMG_REPO+"\\temp\\"+nimgfile);
				File destDir = new File(NOTICE_IMG_REPO+"\\temp\\"+narticleno);
				
				FileUtils.copyFileToDirectory(srcFile, destDir, true);
				
				String originalFileName=(String) noticeMap.get("originalFileName");
				File oldFile=new File(NOTICE_IMG_REPO+"\\"+narticleno+"\\"+originalFileName);
				oldFile.delete();
				
			}
		}
		catch(Exception e) {
			
			File srcFile = new File(NOTICE_IMG_REPO+"\\temp\\"+nimgfile);
			srcFile.delete();
			
			e.printStackTrace();
		}
		//----------------------------------------------서비스 메서드 실행▲
		
		ModelAndView mav=new ModelAndView("redirect:/notice/getDetailNotice.do?narticleno="+narticleno);
		//----------------------------------------------mav 세팅▲
		
		return mav;
	}

	@Override
	@RequestMapping(value={"/updateNoticeForm.do"}, method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView updateNoticeForm(@RequestParam("narticleno") int narticleno, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		System.out.println("=======================공지사항 컨트롤 : updateNoticeForm=======================");
		System.out.println("글 수정 번호 : "+narticleno);
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		viewName=getViewName(request);
		ModelAndView mav=new ModelAndView(viewName);

		//----------------------------------------------전처리▲
		noticeVO=noticeService.updateNoticeForm(narticleno);
		//----------------------------------------------서비스 메서드 실행▲
		
		mav.addObject("noticeVO", noticeVO);
		//----------------------------------------------mav 세팅▲
		return mav;
	}

	@Override
	@RequestMapping(value={"/deleteNotice.do"}, method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView deleteNotice(int narticleno, HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		System.out.println("=======================공지사항 컨트롤 : deleteNotice=======================");
		
		request.setCharacterEncoding("UTF-8");
		//----------------------------------------------전처리▲
		
		try {
			noticeService.deleteNotice(narticleno);
			File destDir = new File(NOTICE_IMG_REPO+"\\"+narticleno);
			FileUtils.deleteDirectory(destDir);
		}
		catch(Exception e) {
			
			e.printStackTrace();
		}
		//----------------------------------------------서비스 메서드 실행▲
		
		ModelAndView mav=new ModelAndView("redirect:/notice/getlistNotice.do");
		//----------------------------------------------mav 세팅▲
		return mav;
		
	}
	
	private String insert(MultipartHttpServletRequest multi) throws Exception {
		
		System.out.println("RE : insert ");
		
		String nimgfile= null;
		Iterator<String> fileNames = multi.getFileNames();
		
		while(fileNames.hasNext()){
			
			String fileName = fileNames.next();
			MultipartFile nFile = multi.getFile(fileName);
			nimgfile=nFile.getOriginalFilename();
			File file = new File(NOTICE_IMG_REPO +"\\temp\\" + fileName);
			
			if(nFile.getSize()!=0){ 
				
				if(!file.exists()){ 
					file.getParentFile().mkdirs(); 
					nFile.transferTo(new File(NOTICE_IMG_REPO +"\\temp\\"+nimgfile));
				}
			}
			
		}
		
		return nimgfile;
		
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
	
	@Override
	@ResponseBody
	@RequestMapping(value={"/noticetopthree.do"}, method= {RequestMethod.GET, RequestMethod.POST},produces= {MediaType.APPLICATION_JSON_VALUE})
	public List noticetopthree(HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		List topthree=noticeService.noticetopthree();
		
		NoticeVO notice1=(NoticeVO) topthree.get(1);
		System.out.println(notice1.getNwritedate());
		
		return topthree;
	}
}
