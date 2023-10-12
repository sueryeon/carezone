package carezone.vaccine.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;



@Controller("vaccineController")
@RequestMapping("/vaccine")
public class VaccineControllerImpl implements VaccineController {


	@Override
	@RequestMapping(value="/listVcc.do",method= {RequestMethod.GET})
	public ModelAndView getlistVcc(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("백신 정보 controller");
		String viewname = getViewName(request);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName(viewname);
		
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
