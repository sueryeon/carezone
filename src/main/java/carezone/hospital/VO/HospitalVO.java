package carezone.hospital.VO;

public class HospitalVO {
	
	private int hosno;
	private String hosname;
	private String hoscall;
	private String hosaddr;
	private String vccname;
	private int vccquantity;
	
	public HospitalVO() {
		
	}
	
	public HospitalVO(int hosno,String hosname,String vccname) {
		this.hosno=hosno;
		this.hosname=hosname;
		this.vccname=vccname;
	}
	public HospitalVO(String hosname,String hosaddr,String vccname) {
		this.hosname=hosname;
		this.hosaddr=hosaddr;
		this.vccname=vccname;
	}
	public HospitalVO(String hosname,String hoscall,String hosaddr,String vccname) {
		this.hosname=hosname;
		this.hoscall=hoscall;
		this.hosaddr=hosaddr;
		this.vccname=vccname;
	}
	
	public int getHosno() {
		return hosno;
	}
	public void setHosno(int hosno) {
		this.hosno = hosno;
	}
	public String getHosname() {
		return hosname;
	}
	public void setHosname(String hosname) {
		this.hosname = hosname;
	}
	public String getHoscall() {
		return hoscall;
	}
	public void setHoscall(String hoscall) {
		this.hoscall = hoscall;
	}
	public String getHosaddr() {
		return hosaddr;
	}
	public void setHosaddr(String hosaddr) {
		this.hosaddr = hosaddr;
	}
	public String getVccname() {
		return vccname;
	}
	public void setVccname(String vccname) {
		this.vccname = vccname;
	}
	public int getVccquantity() {
		return vccquantity;
	}
	public void setVccquantity(int vccquantity) {
		this.vccquantity = vccquantity;
	}
	
}
