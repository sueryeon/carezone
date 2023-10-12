package carezone.checklist.VO;

import java.util.Date;

public class CheckVO {
	
	private int ckno;
	private String ckid;
	private String ckname;
	private String ckhosname;
	private String ckvccname;
	private Date ckrdate;
	private String ckdescription;
	private boolean ckboolean;
	
	public CheckVO() {
		
	}
	
	public CheckVO(int ckno,String ckid,boolean ckboolean) {
		this.ckno=ckno;
		this.ckid=ckid;
		this.ckboolean=ckboolean;
		
	}
	
	public int getCkno() {
		return ckno;
	}
	public void setCkno(int ckno) {
		this.ckno = ckno;
	}
	public String getCkid() {
		return ckid;
	}
	public void setCkid(String ckid) {
		this.ckid = ckid;
	}
	public String getCkhosname() {
		return ckhosname;
	}
	public void setCkhosname(String ckhosname) {
		this.ckhosname = ckhosname;
	}
	public String getCkvccname() {
		return ckvccname;
	}
	public void setCkvccname(String ckvccname) {
		this.ckvccname = ckvccname;
	}
	public Date getCkrdate() {
		return ckrdate;
	}
	public void setCkrdate(Date ckrdate) {
		this.ckrdate = ckrdate;
	}
	public String getCkdescription() {
		return ckdescription;
	}
	public void setCkdescription(String ckdescription) {
		this.ckdescription = ckdescription;
	}
	public String getCkname() {
		return ckname;
	}
	public void setCkname(String ckname) {
		this.ckname = ckname;
	} 

	public boolean isCkboolean() {
		return ckboolean;
	}

	public void setCkboolean(boolean ckboolean) {
		this.ckboolean = ckboolean;
	}
	
}
