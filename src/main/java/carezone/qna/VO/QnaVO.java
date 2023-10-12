package carezone.qna.VO;

import java.util.Date;

public class QnaVO {
	private int qarticleno;
	private int qparentno;
	private String qid;
	private int qpwd;
	private String qtitle;
	private String qcontent;
	private String qimgfile;
	private Date qwritedate;
	
	public int getQarticleno() {
		return qarticleno;
	}
	public void setQarticleno(int qarticleno) {
		this.qarticleno = qarticleno;
	}
	public int getQparentno() {
		return qparentno;
	}
	public void setQparentno(int qparentno) {
		this.qparentno = qparentno;
	}
	public String getQid() {
		return qid;
	}
	public void setQid(String qid) {
		this.qid = qid;
	}
	public int getQpwd() {
		return qpwd;
	}
	public void setQpwd(int qpwd) {
		this.qpwd = qpwd;
	}
	public String getQtitle() {
		return qtitle;
	}
	public void setQtitle(String qtitle) {
		this.qtitle = qtitle;
	}
	public String getQcontent() {
		return qcontent;
	}
	public void setQcontent(String qcontent) {
		this.qcontent = qcontent;
	}
	public String getQimgfile() {
		return qimgfile;
	}
	public void setQimgfile(String qimgfile) {
		this.qimgfile = qimgfile;
	}
	public Date getQwritedate() {
		return qwritedate;
	}
	public void setQwritedate(Date qwritedate) {
		this.qwritedate = qwritedate;
	}
	
	
}
