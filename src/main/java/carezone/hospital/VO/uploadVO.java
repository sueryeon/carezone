package carezone.hospital.VO;

import java.util.Date;

public class uploadVO {
	
	private String filename;
	private Date filedate;
	
	public uploadVO() {
		
	}
	public uploadVO(String filename,Date filedate) {
		this.filename=filename;
		this.filedate=filedate;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public Date getFiledate() {
		return filedate;
	}
	public void setFiledate(Date filedate) {
		this.filedate = filedate;
	}

	
}
