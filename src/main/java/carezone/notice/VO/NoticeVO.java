package carezone.notice.VO;

import java.util.Date;

public class NoticeVO {
	
	private int narticleno;
	private String nid;
	private String ntitle;
	private String ncontent;
	private String nimgfile;
	private Date nwritedate;
	private boolean topnotice;
	public int getNarticleno() {
		return narticleno;
	}
	public void setNarticleno(int narticleno) {
		this.narticleno = narticleno;
	}
	public String getNid() {
		return nid;
	}
	public void setNid(String nid) {
		this.nid = nid;
	}
	public String getNtitle() {
		return ntitle;
	}
	public void setNtitle(String ntitle) {
		this.ntitle = ntitle;
	}
	public String getNcontent() {
		return ncontent;
	}
	public void setNcontent(String ncontent) {
		this.ncontent = ncontent;
	}
	public String getNimgfile() {
		return nimgfile;
	}
	public void setNimgfile(String nimgfile) {
		this.nimgfile = nimgfile;
	}
	public Date getNwritedate() {
		return nwritedate;
	}
	public void setNwritedate(Date nwritedate) {
		this.nwritedate = nwritedate;
	}
	public boolean isTopnotice() {
		return topnotice;
	}
	public void setTopnotice(boolean topnotice) {
		this.topnotice = topnotice;
	}
	
	
}
