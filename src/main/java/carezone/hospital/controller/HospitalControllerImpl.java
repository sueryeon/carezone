package carezone.hospital.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import carezone.hospital.VO.HospitalVO;
import carezone.hospital.service.HospitalService;


@Controller("hospitalController")
@RequestMapping("/hospital")
public class HospitalControllerImpl implements HospitalController {
	
	@Autowired
	private HospitalService hospitalService;
	private String viewName=null;
	private HospitalVO hosVO;
	//private String HOSPITAL_REPO="C:\\hospital";
	private String HOSPITAL_REPO="/Users/lily/Desktop";
	@Override
	@RequestMapping(value={"/gethospitalForm.do"}, method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView gethospitalForm(HttpServletRequest request, HttpServletResponse response) throws Exception {

		System.out.println("=======================병원 컨트롤러 : gethospitalForm=======================");
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		viewName=getViewName(request);

		//----------------------------------------------전처리▲
		
		ModelAndView mav=new ModelAndView(viewName);
		//----------------------------------------------mav 세팅▲
		return mav;
		
	}

	@Override
	@RequestMapping(value={"/insertHospital.do"}, method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView insertHospital(MultipartHttpServletRequest multi, HttpServletResponse response)
			throws Exception {
		
		try {
			
			System.out.println("=======================병원 컨트롤러 : insertHospital=======================");
			
			multi.setCharacterEncoding("UTF-8");
			String hospitalFile=insert(multi);
			
            FileInputStream excelFile = new FileInputStream(new File(HOSPITAL_REPO +"\\temp\\"+hospitalFile));
            System.out.println(excelFile);
            
            HSSFWorkbook workbook = new HSSFWorkbook(excelFile);
            HSSFSheet sheet = workbook.getSheetAt(0);
            int rowCount = sheet.getPhysicalNumberOfRows();

            
            for (int i = 1; i < rowCount; i++) {
            	
            	HSSFRow row = sheet.getRow(i);
                
                if (row != null) {
                	
                    int cellCount = row.getPhysicalNumberOfCells();
                    String hosname=null;
                	String hoscall=null;
                	String hosaddr=null;
                	String vccname=null;
                	
                    for (int j = 1; j < cellCount; j++) {

                    	HSSFCell cell = row.getCell(j);
                        
                        if (cell != null) {

                        	if(j==1) {
                        		hosname=cell.getStringCellValue();
                        	}
                        	else if(j==2) {
                        		hoscall=cell.getStringCellValue();
                        	}
                        	else if(j==3) {
                        		hosaddr=cell.getStringCellValue();
                        	}
                        	vccname=multi.getParameter("vccname");
                        	
                        }
                    }

                    if((hosname==null&&hoscall==null&&hosaddr==null)||(hosname.equals("")&&hoscall.equals("")&&hosaddr.equals(""))) {
                    	 break;
                    }
                    else {
                        hosVO=new HospitalVO(hosname,hoscall,hosaddr,vccname);  
                        hospitalService.insertHospital(hosVO);
                    }
                }
            }
            ModelAndView mav=new ModelAndView("redirect:/hospital/gethospitalForm.do");
            
            return mav;
        } 
		catch (IOException e) {
        	
        	e.printStackTrace();
        	
        	return null;
        }

		
	}
	
	@Override
	@RequestMapping(value={"/getlistHospital.do"}, method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView getlistHospital(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("=======================병원 컨트롤러 : getlistHospital=======================");

		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		viewName=getViewName(request);
		//----------------------------------------------전처리▲

		ModelAndView mav=new ModelAndView(viewName);
		//----------------------------------------------mav 세팅▲
		return mav;
	}
	
	
	/*@Override
	@ResponseBody
	@RequestMapping(value={"/searchHospital.do"}, method= {RequestMethod.GET, RequestMethod.POST},produces= {MediaType.APPLICATION_JSON_VALUE})
	public List<HospitalVO> searchHospital(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("=======================병원 컨트롤러 : searchHospital=======================");
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		String state=request.getParameter("state");
		String city=request.getParameter("city");
		String fullcity=request.getParameter("fullcity");
		String vccname=request.getParameter("vccname");
		//----------------------------------------------전처리▲
		
		List<HospitalVO> hospitalList=hospitalService.searchHospital(vccname,state,city,fullcity);
		
		return hospitalList;
	}*/
	
	@Override
	@ResponseBody
	@RequestMapping(value={"/searchHospital.do"}, method= {RequestMethod.GET, RequestMethod.POST},produces= {MediaType.APPLICATION_JSON_VALUE})
	public Map<String, Object> searchHospital(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("=======================병원 컨트롤러 : searchHospital=======================");
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		String state=request.getParameter("state");
		String city=request.getParameter("city");
		String fullcity=request.getParameter("fullcity");
		String vccname=request.getParameter("vccname");
		//----------------------------------------------전처리▲
		
		String _pagenum =(String) request.getParameter("pagenum");
		System.out.println("pagenum" +_pagenum);
		System.out.println("vccname" +vccname);
		System.out.println("vccname length" +vccname.length());
		int pagenum = Integer.parseInt(((_pagenum==null)? "1": _pagenum));
		
		
		int offset = (pagenum - 1) * 10;
		int pagesize = 10;
		
		Map<String, Object> pagingMap = new HashMap<String, Object>();
	    pagingMap.put("offset", offset);
	    pagingMap.put("pagesize", pagesize);
		//----------------------------------------------페이징전처리▲
		
	    Map<String, Object> articlesMap=hospitalService.searchHospital(pagingMap,vccname,state,city,fullcity);
	    articlesMap.put("pagenum", pagenum);
	    articlesMap.put("pagesize", pagesize);
	    
	    System.out.println("articlesMap"+articlesMap);
	    
		return articlesMap;
	}
	
	private String insert(MultipartHttpServletRequest multi) throws Exception {
		
		System.out.println("RE : insert ");
		
		String hospitalFile= null;
		Iterator<String> fileNames = multi.getFileNames();
		int count=1;
		
		while(fileNames.hasNext()){
			
			String fileName = fileNames.next();
			MultipartFile mFile = multi.getFile(fileName);
			hospitalFile=mFile.getOriginalFilename();
			String baseName = hospitalFile.substring(0, hospitalFile.lastIndexOf('.'));
	        String extension = hospitalFile.substring(hospitalFile.lastIndexOf('.'));
			
			//File file = new File(HOSPITAL_REPO +"\\temp\\" + fileName);
			File file = new File(HOSPITAL_REPO +"\\temp\\" + hospitalFile);
			if(mFile.getSize()!=0){ 
				
				if(!file.exists()){ 
					
					file.getParentFile().mkdirs();
					mFile.transferTo(file);
				}
				else{

					hospitalFile = baseName+"("+count+")"+extension;
		            count++;
		            mFile.transferTo(new File(HOSPITAL_REPO+"\\temp\\"+hospitalFile));
			            
				}
			}
			
		}
		
		return hospitalFile;
		
	}
	
	@RequestMapping(value={"/selectstate.do"}, method= {RequestMethod.GET, RequestMethod.POST},produces = "application/text; charset=UTF-8")
	private void selectstate(HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		try {
			System.out.println("RE : selectstate ");

			PrintWriter out=response.getWriter();
			String line=null;
			String StateName=request.getParameter("state");
			JSONObject State=new JSONObject();
			JSONArray Cities=new JSONArray();
			//-----------------------전처리 및 필요한 변수설정
			
			String save=request.getServletContext().getRealPath("./resources/시군구");
			File directory = new File(save);
			File[] states=directory.listFiles();
			//-----------------------파일저장폴더 경로 가져오고 파일들 가져오기
			
			if (states != null) {

	            for (File state : states) {

	                String FileName=state.getName();
	                String ext = FileName.substring(FileName.lastIndexOf("."));
	                String stateFileName=FileName.substring(0,FileName.length()-ext.length());
	                
	                if(stateFileName.equals("경상남도")&&StateName.equals("경상남도")) {
	                	
	                	BufferedReader br = new BufferedReader(new FileReader(state));
	                	
	                	while((line = br.readLine())!= null) {
	                		 // <option> 요소에서 텍스트 내용을 추출하는 정규 표현식 패턴
	                		 String pattern = "<option[^>]*>(.*?)</option>";
	                	        
	                	        // 정규 표현식을 사용하여 매치되는 문자열을 찾음
	                	        Pattern regex = Pattern.compile(pattern);
	                	        Matcher matcher = regex.matcher(line);
	                	        
	                	        if (matcher.find()) {
	                	        	// 매치되는 첫 번째 그룹(텍스트 내용)을 반환
	                	        	String city=matcher.group(1);
	                	        	Cities.put(city);
	                	        }//매칭된 요소 리스트에넣기
                		}//while문 반복
	                	State.put(StateName, Cities);
	               }//해당하는 도 이면 실행
	           }// 파일하나씩 제어문 실행하기
	        }
			else {
	            System.out.println("디렉토리 내 파일이 존재하지 않습니다.");
	        }
			out.print(State);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value={"/selectcity.do"}, method= {RequestMethod.GET, RequestMethod.POST},produces = "application/text; charset=UTF-8")
	private void selectcity(HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		try {
			System.out.println("RE : selectcity ");

			PrintWriter out=response.getWriter();
			String CityName=request.getParameter("city");
			JSONObject City=new JSONObject();
			JSONArray Fullcities=null;
			//-----------------------전처리 및 필요한 변수설정
			
			String save=request.getServletContext().getRealPath("./resources/동읍면");
			File directory = new File(save);
			File[] cities=directory.listFiles();
			//-----------------------파일저장폴더 경로 가져오고 파일들 가져오기
			
			if (cities != null) {

	            for (File city : cities) {

	                String FileName=city.getName();
	                String ext = FileName.substring(FileName.lastIndexOf("."));
	                String cityFileName=FileName.substring(0,FileName.length()-ext.length());
	                
	                if(cityFileName.equals("거제시")&&CityName.equals("거제시")) {
	                	Fullcities=jsonmaker(city,CityName);
	                	City.put(CityName, Fullcities);
	                	}//해당하는 도 이면 실행
	                else if(cityFileName.equals("거창군")&&CityName.equals("거창군")) {
	                	Fullcities=jsonmaker(city,CityName);
	                	City.put(CityName, Fullcities);
	                }
	                else if(cityFileName.equals("고성군")&&CityName.equals("고성군")) {
	                	Fullcities=jsonmaker(city,CityName);
	                	City.put(CityName, Fullcities);
	                }
	                else if(cityFileName.equals("김해시")&&CityName.equals("김해시")) {
	                	Fullcities=jsonmaker(city,CityName);
	                	City.put(CityName, Fullcities);
	                }
	                else if(cityFileName.equals("남해군")&&CityName.equals("남해군")) {
	                	Fullcities=jsonmaker(city,CityName);
	                	City.put(CityName, Fullcities);
	                }
	                else if(cityFileName.equals("밀양시")&&CityName.equals("밀양시")) {
	                	Fullcities=jsonmaker(city,CityName);
	                	City.put(CityName, Fullcities);
	                }
	                else if(cityFileName.equals("사천시")&&CityName.equals("사천시")) {
	                	Fullcities=jsonmaker(city,CityName);
	                	City.put(CityName, Fullcities);
	                }
	                else if(cityFileName.equals("산청군")&&CityName.equals("산청군")) {
	                	Fullcities=jsonmaker(city,CityName);
	                	City.put(CityName, Fullcities);
	                }
	                else if(cityFileName.equals("양산시")&&CityName.equals("양산시")) {
	                	Fullcities=jsonmaker(city,CityName);
	                	City.put(CityName, Fullcities);
	                }
	                else if(cityFileName.equals("의령군")&&CityName.equals("의령군")) {
	                	Fullcities=jsonmaker(city,CityName);
	                	City.put(CityName, Fullcities);
	                }
	                else if(cityFileName.equals("진주시")&&CityName.equals("진주시")) {
	                	Fullcities=jsonmaker(city,CityName);
	                	City.put(CityName, Fullcities);
	                }
	                else if(cityFileName.equals("창녕군")&&CityName.equals("창녕군")) {
	                	Fullcities=jsonmaker(city,CityName);
	                	City.put(CityName, Fullcities);
	                }
	                else if(cityFileName.equals("창원시")&&CityName.equals("창원시")) {
	                	Fullcities=jsonmaker(city,CityName);
	                	City.put(CityName, Fullcities);
	                }
	                else if(cityFileName.equals("통영시")&&CityName.equals("통영시")) {
	                	Fullcities=jsonmaker(city,CityName);
	                	City.put(CityName, Fullcities);
	                }
	                else if(cityFileName.equals("하동군")&&CityName.equals("하동군")) {
	                	Fullcities=jsonmaker(city,CityName);
	                	City.put(CityName, Fullcities);
	                }
	                else if(cityFileName.equals("함안군")&&CityName.equals("함안군")) {
	                	Fullcities=jsonmaker(city,CityName);
	                	City.put(CityName, Fullcities);
	                }
	                else if(cityFileName.equals("함양군")&&CityName.equals("함양군")) {
	                	Fullcities=jsonmaker(city,CityName);
	                	City.put(CityName, Fullcities);
	                }
	                else if(cityFileName.equals("합천군")&&CityName.equals("합천군")) {
	                	Fullcities=jsonmaker(city,CityName);
	                	City.put(CityName, Fullcities);
	                }
	           }// 파일하나씩 제어문 실행하기
	        }
			else {
	            System.out.println("디렉토리 내 파일이 존재하지 않습니다.");
	        }
			out.print(City);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	private JSONArray jsonmaker(File state,String CityNo) throws Exception{
		
		System.out.println("RERE : selectstate ");
		
		JSONArray Fullcities=new JSONArray();
		String line=null;
		BufferedReader br = new BufferedReader(new FileReader(state));
    	
    	while((line = br.readLine())!= null) {
    		 // <option> 요소에서 텍스트 내용을 추출하는 정규 표현식 패턴
    		 String pattern = "<option[^>]*>(.*?)</option>";
    	        
    	        // 정규 표현식을 사용하여 매치되는 문자열을 찾음
    	        Pattern regex = Pattern.compile(pattern);
    	        Matcher matcher = regex.matcher(line);
    	        
    	        if (matcher.find()) {
    	        	// 매치되는 첫 번째 그룹(텍스트 내용)을 반환
    	        	String fullcity=matcher.group(1);
    	        	Fullcities.put(fullcity);
    	        }//매칭된 요소 리스트에넣기
		}//while문 반복
    	System.out.println(Fullcities);
    	br.close();
    	
    	return Fullcities;
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
