package carezone.member.vo;

public class FamilyVO {
	private int fid;
	private int fno;
	private String fname;
	private String fbirth1;
	private String fphone;
	private String faddr;
	
	public FamilyVO() {}
	public FamilyVO(int fno, String fname, String fbirth1, String fphone, String faddr) {
		this.fno=fno;
		this.fname=fname;
		this.fbirth1=fbirth1;
		this.fphone=fphone;
		this.faddr=faddr;
	}

	public int getFid() {
		return fid;
	}

	public void setFid(int fid) {
		this.fid = fid;
	}

	public int getFno() {
		return fno;
	}

	public void setFno(int fno) {
		this.fno = fno;
	}

	public String getFname() {
		return fname;
	}

	public void setFname(String fname) {
		this.fname = fname;
	}

	public String getFbirth1() {
		return fbirth1;
	}

	public void setFbirth1(String fbirth1) {
		this.fbirth1 = fbirth1;
	}

	public String getFphone() {
		return fphone;
	}

	public void setFphone(String fphone) {
		this.fphone = fphone;
	}

	public String getFaddr() {
		return faddr;
	}

	public void setFaddr(String faddr) {
		this.faddr = faddr;
	}

	
	
}
