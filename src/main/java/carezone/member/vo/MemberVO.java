package carezone.member.vo;

import org.springframework.stereotype.Component;

@Component("memberVO")
public class MemberVO {
	private int mno;
	private String mid;
	private String mpwd;
	private String mname;
	private String mbirth1;
	private int mbirth2; 
	private String memail1;
	private String memail2;
	private String mphone;
	private String maddr;
	
	
	public MemberVO() {}
	public MemberVO(String mid, String mpwd) {
		this.mid=mid;
		this.mpwd=mpwd;
	}
	
	
	public MemberVO(String mname, String memail1, String memail2) {
		this.mname=mname;
		this.memail1=memail1;
		this.memail2=memail2;
	}
	
	public MemberVO(String mname,String mid, String memail1, String memail2) {
		this.mname=mname;
		this.mid=mid;
		this.memail1=memail1;
		this.memail2=memail2;
	}
	
	public MemberVO(String mid, String mpwd, String mname, String memail1, String memail2, String mphone, String maddr) {
		this.mid=mid;
		this.mpwd=mpwd;
		this.mname=mname;
		this.memail1=memail1;
		this.memail2=memail2;
		this.mphone=mphone;
		this.maddr=maddr;
	}

	public int getMno() {
		return mno;
	}
	public void setMno(int mno) {
		this.mno = mno;
	}
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	public String getMpwd() {
		return mpwd;
	}
	public void setMpwd(String mpwd) {
		this.mpwd = mpwd;
	}
	public String getMname() {
		return mname;
	}
	public void setMname(String mname) {
		this.mname = mname;
	}
	public String getMbirth1() {
		return mbirth1;
	}
	public void setMbirth1(String mbirth1) {
		this.mbirth1 = mbirth1;
	}
	public int getMbirth2() {
		return mbirth2;
	}
	public void setMbirth2(int mbirth2) {
		this.mbirth2 = mbirth2;
	}
	public String getMemail1() {
		return memail1;
	}
	public void setMemail1(String memail1) {
		this.memail1 = memail1;
	}
	public String getMemail2() {
		return memail2;
	}
	public void setMemail2(String memail2) {
		this.memail2 = memail2;
	}
	public String getMphone() {
		return mphone;
	}
	public void setMphone(String mphone) {
		this.mphone = mphone;
	}
	public String getMaddr() {
		return maddr;
	}
	public void setMaddr(String maddr) {
		this.maddr = maddr;
	}
	
	
}
