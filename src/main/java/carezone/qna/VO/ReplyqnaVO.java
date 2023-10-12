package carezone.qna.VO;

import java.util.Date;

public class ReplyqnaVO {
	
	private int qreplyno;
	private int qrearticleno;
	private String qreid;
	private String qrecontent;
	private Date qrewritedate;
	
	public ReplyqnaVO() {
		
	}
	
	public ReplyqnaVO(int qreplyno,String qrecontent) {
		
		this.qreplyno=qreplyno;
		this.qrecontent=qrecontent;
		
	}
	
	public ReplyqnaVO(int qrearticleno,String qreid,String qrecontent) {
		
		this.qrearticleno=qrearticleno;
		this.qreid=qreid;
		this.qrecontent=qrecontent;
		
	}
	
	public int getQreplyno() {
		return qreplyno;
	}
	public void setQreplyno(int qreplyno) {
		this.qreplyno = qreplyno;
	}
	public int getQrearticleno() {
		return qrearticleno;
	}
	public void setQrearticleno(int qrearticleno) {
		this.qrearticleno = qrearticleno;
	}
	public String getQreid() {
		return qreid;
	}
	public void setQreid(String qreid) {
		this.qreid = qreid;
	}
	public String getQrecontent() {
		return qrecontent;
	}
	public void setQrecontent(String qrecontent) {
		this.qrecontent = qrecontent;
	}
	public Date getQrewritedate() {
		return qrewritedate;
	}
	public void setQrewritedate(Date qrewritedate) {
		this.qrewritedate = qrewritedate;
	}
}
