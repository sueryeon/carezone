package carezone.common.file;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller("filecontroller")
public class FileDownloadController {
	//private static final String article_img = "C:\\board\\article_image";
	
	@RequestMapping(value="download.do",method= {RequestMethod.GET, RequestMethod.POST})
	protected void download(@RequestParam("bimgFile") String bimgFile,@RequestParam("barticleNo") String barticleNo, HttpServletRequest request , HttpServletResponse response) throws Exception{
		request.setCharacterEncoding("utf-8");
		String realPath = request.getServletContext().getRealPath("/upload");
		OutputStream os = response.getOutputStream();
		String downFile = realPath+"\\"+barticleNo+"\\"+bimgFile;
		File file = new File(downFile);
		
		response.setHeader("Cache-Control", "no-cache");
		response.addHeader("Content-disposition", "attachment; fileName="+bimgFile);
		FileInputStream in = new FileInputStream(file);
		byte[] buff = new byte[1024*8];
		while(true) {
			int count = in.read(buff);
			if(count==-1) {
				break;
			}
			os.write(buff, 0, count);
		}
		in.close();
		os.close();
	}
}
