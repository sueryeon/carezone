package carezone.board.controller;

import java.io.File;
import java.io.PrintWriter;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import carezone.board.service.BoardService;
import carezone.board.vo.BReplyVO;
import carezone.board.vo.BoardVO;



@Controller("boardController")
@RequestMapping("/board")
public class BoardControllerImpl implements BoardController {
	//private static final String article_img = "C:\\board\\article_image";
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private BoardVO boardVO;
	
	
	//게시판 페이지(전체 게시글출력)
	@Override
	@RequestMapping(value="/listBoards.do", method={RequestMethod.GET, RequestMethod.POST})
	public ModelAndView getlistBoards(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("==================controller의 getlistBoards 함수 도착=====================");
		
		String action = getViewName(request);
		System.out.println("getPathInfo() : "+action);
		//String _section = request.getParameter("section");
	    String _pagenum = request.getParameter("pagenum");
	    //int section = Integer.parseInt(((_section==null)? "1": _section));
	    int pagenum = Integer.parseInt(((_pagenum==null)? "1": _pagenum));
	   // System.out.println("section : "+section);
	    System.out.println("pagenum : "+pagenum);

	    int offset = (pagenum - 1) * 10; // 10개씩 표시되므로 페이지당 10을 곱합니다.
	    int pagesize = 10; // 페이지당 10개의 게시글을 보여줍니다.

	    Map<String, Integer> pagingMap = new HashMap<String, Integer>();
	    pagingMap.put("offset", offset);
	    pagingMap.put("pagesize", pagesize);
	    
	    System.out.println("offset : "+offset);
	    System.out.println("pagesize : "+pagesize);

	    Map articleMap = boardService.getLists(pagingMap);
	    //articleMap.put("section", section);
	    articleMap.put("pagenum", pagenum);
	    articleMap.put("pagesize", pagesize);

	    ModelAndView mav = new ModelAndView();
	    mav.addObject("boardsMap", articleMap);
	    mav.setViewName("board/listBoards"); // 뷰 이름을 직접 설정합니다.

	    return mav;
	}

	//글 작성 페이지
	
	@Override
	@RequestMapping(value="/insertBoardForm.do", method= {RequestMethod.GET})
	public ModelAndView insertBoardForm(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("===================controller의 insertBoardForm() 도착=====================");
		request.setCharacterEncoding("utf-8");
		String viewname = getViewName(request);
		ModelAndView mav = new ModelAndView();
		mav.setViewName(viewname);
		return mav;
	}
	
	//글 추가
	@Override
	@RequestMapping(value="/insertBoard.do", method = {RequestMethod.GET,RequestMethod.POST})
	public ModelAndView insertBoard(MultipartHttpServletRequest multipartRequest,HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("================controller의 insertBoard() 도착===================");
		request.setCharacterEncoding("utf-8");
		multipartRequest.setCharacterEncoding("utf-8");
		Map<String,Object> boardMap = new HashMap<String, Object>();
		Enumeration enu = multipartRequest.getParameterNames();
		while(enu.hasMoreElements()) {
			String name = (String)enu.nextElement();
			String value= multipartRequest.getParameter(name);
			System.out.println("name : "+name+", value : "+value);
			boardMap.put(name, value);
		}
		String realPath = request.getServletContext().getRealPath("/upload");		
		
		String bimgFile = upload(request,multipartRequest);
		boardMap.put("bimgFile", bimgFile);
		try {
			int barticleNo = boardService.insertBoard(boardMap);
			System.out.println("barticleNo : "+barticleNo);
			if(bimgFile!=null && bimgFile.length()!=0) {
				File srcFile = new File(realPath+"\\"+"temp"+"\\"+bimgFile);
				File destDir = new File(realPath+"\\"+barticleNo);
				FileUtils.copyFileToDirectory(srcFile, destDir, true);
			}
		}catch(Exception ee) {
			ee.printStackTrace();
		}
		
		ModelAndView mav = new ModelAndView("redirect:/board/listBoards.do");
		
		return mav;
	}
	
	

	//게시글 삭제
	@Override
	@RequestMapping(value="/deleteBoard.do", method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView deleteBoard(@RequestParam("barticleNo")int barticleNo, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("controller의 deleteBoard() 도착");
		System.out.println("삭제할 글 번호 : "+barticleNo);
		int result = boardService.deleteBoard(barticleNo);
		System.out.println("삭제 결과 : "+result);
		
		ModelAndView mav = new ModelAndView("redirect:/board/listBoards.do");
		return mav;
	}

	
	//게시글 수정 페이지
	@Override
	@RequestMapping(value="/findBoard.do", method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView findBoard(@RequestParam("barticleNo") int barticleNo, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("controller의 findBoard() 도착");
		System.out.println("수정할 글 번호 : "+barticleNo);
		BoardVO boardVO = boardService.findBoard(barticleNo);
		
		String viewName = getViewName(request);
		ModelAndView mav = new ModelAndView();
		mav.setViewName(viewName);
		mav.addObject("boardVO", boardVO);
		
		return mav;
	}

	
	//게시글 수정하기
	@Override
	@RequestMapping(value="/updateBoard.do",method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView updateBoard(MultipartHttpServletRequest multipartRequest,HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("====================controller의 updateboard 도착==================");
		request.setCharacterEncoding("utf-8");
		multipartRequest.setCharacterEncoding("utf-8");
		Map<String,Object> boardMap = new HashMap<String, Object>();
		Enumeration enu = multipartRequest.getParameterNames();
		
		while(enu.hasMoreElements()) {
			String name = (String)enu.nextElement();
			String value= multipartRequest.getParameter(name);
			System.out.println("name : "+name+", value : "+value);
			boardMap.put(name, value);
		}
		String realPath = request.getServletContext().getRealPath("/upload");
		
		String bimgFile= upload(request,multipartRequest);
		boardMap.put("bimgFile", bimgFile);
		
		String barticleNo=(String)boardMap.get("barticleNo");
	    try {
	       boardService.updateBoard(boardMap);
	       if(bimgFile!=null && bimgFile.length()!=0) {
	         File srcFile = new File(realPath+"\\"+"temp"+"\\"+bimgFile);
	         File destDir = new File(realPath+"\\"+barticleNo);
	         FileUtils.copyFileToDirectory(srcFile, destDir, true);
	         
	         String originalFileName = (String)boardMap.get("originalFileName");
	         File oldFile = new File(realPath+"\\"+barticleNo+"\\"+originalFileName);
	         oldFile.delete();
	       }
	    }catch(Exception e) {
	    	e.printStackTrace();
	    }
	       
	       
		ModelAndView mav = new ModelAndView("redirect:/board/findBoard.do?barticleNo="+barticleNo);
		return mav;
	}


	//댓글 전체 조회
	@Override
	@RequestMapping(value="listBReplys.do", method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView getlistBReplyBoards(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("=============== controller의 댓글 전체 조회 ===============");
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		String parentNo = (String) request.getParameter("brparentNo");
		if(parentNo == null) {
			String replyInfo = null;
			out.print(replyInfo);
		}
		else {
			int brparentNo = Integer.parseInt(parentNo);
			//전처리 끝
			System.out.println("brparentNo : "+brparentNo);
			List<BReplyVO> replysList = boardService.getlistBReplyBoards(brparentNo);
			//service 다녀옴
			
	
			JSONObject breplyObject = new JSONObject(); //배열 담을 object
			JSONArray breplyArray = new JSONArray(); //하나의 객체 담을 array
			
			if(replysList.size()==0) {
				System.out.println("resplysList가 null입니다.");
				String replyInfo = null;
				out.print(replyInfo);
			}
			else {
				try {
					for(int i=0; i<replysList.size(); i++) {
						BReplyVO brVO = replysList.get(i);
						System.out.println("댓글 아이디 : "+brVO.getBrid());
						
						JSONObject Breply = new JSONObject();
						Breply.put("brarticleNo", brVO.getBrarticleNo());
						Breply.put("brid", brVO.getBrid());
						Breply.put("brcontent", brVO.getBrcontent());
						Breply.put("brwriteDate", brVO.getBrwriteDate().toString());	
						
						breplyArray.put(Breply);
					}
					
					breplyObject.put("replys", breplyArray);
					String replyInfo = breplyObject.toString();
					System.out.println(replyInfo);
					out.print(replyInfo);
					
				}catch(Exception e) {
					e.printStackTrace();
				}
			}	
		}	
		return null;
	}

	//댓글 1개 insert
	@Override
	@RequestMapping(value="/insertBReply.do", method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView insertBReply(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("===========controller의 insertBReply() 도착============");
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String breplyjson = request.getParameter("breplyjson");
		int brparentNo = 0;
		String brid = "";
		String brcontent="";
		
		//JSONParser rpParser = new JSONParser(breplyjson);
		//JSONObject rpObject = (JSONObject) rpParser.parse(breplyjson);
		String brno = request.getParameter("brparentNo").toString();
		brparentNo = Integer.parseInt(brno);
		brid = request.getParameter("brid").toString();
		brcontent = request.getParameter("brcontent").toString();
			
		BReplyVO breplyVO = new BReplyVO(brparentNo, brid, brcontent);
		int result = boardService.insertBReply(breplyVO);
		
		return null;
	}
	
	
	//댓글 1개 update
	@Override
	@RequestMapping(value="/updateBReply.do", method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView updateBReply(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("====== 댓글 update controller =======");
		int brarticleNo = Integer.parseInt(request.getParameter("brarticleNo").toString());
		String brcontent = request.getParameter("brcontent").toString();
		System.out.println("brarticleNo : "+brarticleNo);
		System.out.println("brcontnet : "+brcontent);
		BReplyVO brVO = new BReplyVO();
		brVO.setBrarticleNo(brarticleNo);
		brVO.setBrcontent(brcontent);
		
		int result = boardService.updateBReply(brVO);
		System.out.println("댓글 update 결과 : "+result);
		
		return null;
	}

	
	//댓글 1개 delete
	@Override
	@RequestMapping(value="deleteBReply.do",method= {RequestMethod.GET,RequestMethod.POST})
	public ModelAndView deleteBReply(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("====== 댓글 1개 삭제 controller ========");
		int brarticleNo = Integer.parseInt(request.getParameter("brarticleNo").toString());
		System.out.println("댓글 삭제할 댓글번호 : "+brarticleNo);
		
		int result = boardService.deleteBReply(brarticleNo);
		System.out.println("댓글 1개 삭제 결과 :"+result);
		return null;
	}

	
	//최신 게시글 3개 select
	@Override
	@ResponseBody
	@RequestMapping(value="/topboardlist.do",method= {RequestMethod.GET})
	public List<BoardVO> topboardList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("===============controller의 최신 게시글 3개 select controller 도착================");
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		//PrintWriter out = response.getWriter();
		//서비스로 이동
		List<BoardVO> topBoardList = boardService.gettopBoardList();
		for(int i=0; i<topBoardList.size(); i++) {
			BoardVO boardVO = topBoardList.get(i);
			System.out.println("날짜 : "+boardVO.getBwriteDate());
		}
		
		return topBoardList;
	}
	
	
	//imgfilename
	private String upload(HttpServletRequest request,MultipartHttpServletRequest multiRequest) throws Exception{
		String imgFilename = null;
		String realPath = request.getServletContext().getRealPath("/upload");
		Iterator<String> fileNames = multiRequest.getFileNames();
		while(fileNames.hasNext()) {
			String fileName = fileNames.next();
			MultipartFile mFile = multiRequest.getFile(fileName);
			imgFilename = mFile.getOriginalFilename();
			File file = new File(realPath+"\\"+"temp"+"\\"+fileName);
			if(mFile.getSize()!=0) {
				if(!file.exists()) {
					file.getParentFile().mkdirs();
					mFile.transferTo(new File(realPath+"\\"+"temp"+"\\"+imgFilename));
				}
			}
		}
		return imgFilename;
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
