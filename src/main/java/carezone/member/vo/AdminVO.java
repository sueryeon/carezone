package carezone.member.vo;

import org.springframework.stereotype.Component;

@Component("adminVO")
public class AdminVO {
	private int adno;
	private String adid;
	private String adpwd;
	private String adname;
	private String adbirth;
	
	public AdminVO() {}
	public AdminVO(String adid, String adpwd) {
		this.adid=adid;
		this.adpwd=adpwd;
	}
	public AdminVO(String adid, String adpwd, String adname) {
		this.adid=adid;
		this.adpwd=adpwd;
		this.adname=adname;
	}
	public int getAdno() {
		return adno;
	}
	public void setAdno(int adno) {
		this.adno = adno;
	}
	public String getAdid() {
		return adid;
	}
	public void setAdid(String adid) {
		this.adid = adid;
	}
	public String getAdpwd() {
		return adpwd;
	}
	public void setAdpwd(String adpwd) {
		this.adpwd = adpwd;
	}
	public String getAdname() {
		return adname;
	}
	public void setAdname(String adname) {
		this.adname = adname;
	}
	public String getAdbirth() {
		return adbirth;
	}
	public void setAdbirth(String adbirth) {
		this.adbirth = adbirth;
	}
	
	
}
