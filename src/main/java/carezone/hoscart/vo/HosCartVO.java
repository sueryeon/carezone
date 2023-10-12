package carezone.hoscart.vo;

import java.util.Date;

import org.springframework.stereotype.Component;

@Component("hoscartVO")
public class HosCartVO {
	private int hcno;
	private String hcid;
	private int hchosno;
	private String hchosname;
	private String hcvccname;
	private Date hcdate;
	
	public HosCartVO() {}
	
	public HosCartVO(int hcno, String hcid) {
		this.hcno=hcno;
		this.hcid=hcid;
	}
	public HosCartVO(String hcid, int hchosno, String hchosname, String hcvccname) {
		this.hcid=hcid;
		this.hchosno=hchosno;
		this.hchosname=hchosname;
		this.hcvccname=hcvccname;
	}

	public int getHcno() {
		return hcno;
	}

	public void setHcno(int hcno) {
		this.hcno = hcno;
	}

	public String getHcid() {
		return hcid;
	}

	public void setHcid(String hcid) {
		this.hcid = hcid;
	}

	public int getHchosno() {
		return hchosno;
	}

	public void setHchosno(int hchosno) {
		this.hchosno = hchosno;
	}

	public String getHchosname() {
		return hchosname;
	}

	public void setHchosname(String hchosname) {
		this.hchosname = hchosname;
	}

	public Date getHcdate() {
		return hcdate;
	}

	public void setHcdate(Date hcdate) {
		this.hcdate = hcdate;
	}
	public String getHcvccname() {
		return hcvccname;
	}
	public void setHcvccname(String hcvccname) {
		this.hcvccname = hcvccname;
	}
	
	
}
