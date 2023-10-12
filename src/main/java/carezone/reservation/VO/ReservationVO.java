 package carezone.reservation.VO;

import java.util.Date;

public class ReservationVO {
	
	private int rno;
	private String rid;
	private String rname;
	private String rbirth1;
	private int rbirth2;
	private String rphone;
	private String rhospital;
	private String rvcc;
	private Date rdate;
	private Date rwritedate;
	private String rsubname;
	private String rsubbirth1;
	private String rsubphone;
	
	public ReservationVO() {
		
	}
	
	public ReservationVO(String rid,String rname,String rbirth1,int rbirth2,String rphone) {
		
		//getReservationForm
		this.rid=rid;
		this.rname=rname;
		this.rbirth1=rbirth1;
		this.rbirth2=rbirth2;
		this.rphone=rphone;
	}

	public ReservationVO(int rno, String rhospital,String rvcc,Date rdate) {
		
		//updateReservation
		this.rno=rno;
		this.rhospital=rhospital;
		this.rvcc=rvcc;
		this.rdate=rdate;
	}
	
	public ReservationVO(int rno,String rid,String rname,String rbirth1,int rbirth2,String rphone,String rhospital,String rvcc,Date rdate) {
		
		//findReservation
		this.rno=rno;
		this.rid=rid;
		this.rname=rname;
		this.rbirth1=rbirth1;
		this.rbirth2=rbirth2;
		this.rphone=rphone;
		this.rhospital=rhospital;
		this.rvcc=rvcc;
		this.rdate=rdate;
	}
	
	public ReservationVO(String rid,String rname,String rbirth1,int rbirth2,String rphone,String rhospital,String rvcc,Date rdate) {
		
		//insertReservation-self
		this.rid=rid;
		this.rname=rname;
		this.rbirth1=rbirth1;
		this.rbirth2=rbirth2;
		this.rphone=rphone;
		this.rhospital=rhospital;
		this.rvcc=rvcc;
		this.rdate=rdate;
	}
	
	public ReservationVO(String rid,String rname,String rbirth1,int rbirth2,String rphone,String rsubname,String rsubbirth1,String rsubphone,String rhospital,String rvcc,Date rdate) {
		
		//insertReservation-family
		this.rid=rid;
		this.rname=rname;
		this.rbirth1=rbirth1;
		this.rbirth2=rbirth2;
		this.rphone=rphone;
		this.rsubname=rsubname;
		this.rsubbirth1=rsubbirth1;
		this.rsubphone=rsubphone;
		this.rhospital=rhospital;
		this.rvcc=rvcc;
		this.rdate=rdate;
	}
	
	public ReservationVO(String rid,String rname,String rbirth1,int rbirth2,String rphone,String rhospital,String rvcc,Date rdate,String rsubname,String rsubbirth1) {
		
		//getDetailReservation
		this.rid=rid;
		this.rname=rname;
		this.rbirth1=rbirth1;
		this.rbirth2=rbirth2;
		this.rphone=rphone;
		this.rhospital=rhospital;
		this.rvcc=rvcc;
		this.rdate=rdate;
		this.rsubname=rsubname;
		this.rsubbirth1=rsubbirth1;

	}

	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getRname() {
		return rname;
	}
	public void setRname(String rname) {
		this.rname = rname;
	}
	public String getRbirth1() {
		return rbirth1;
	}
	public void setRbirth1(String rbirth1) {
		this.rbirth1 = rbirth1;
	}
	public int getRbirth2() {
		return rbirth2;
	}
	public void setRbirth2(int rbirth2) {
		this.rbirth2 = rbirth2;
	}
	public String getRphone() {
		return rphone;
	}
	public void setRphone(String rphone) {
		this.rphone = rphone;
	}
	public String getRhospital() {
		return rhospital;
	}
	public void setRhospital(String rhospital) {
		this.rhospital = rhospital;
	}
	public String getRvcc() {
		return rvcc;
	}
	public void setRvcc(String rvcc) {
		this.rvcc = rvcc;
	}
	public Date getRdate() {
		return rdate;
	}
	public void setRdate(Date rdate) {
		this.rdate = rdate;
	}
	public String getRsubname() {
		return rsubname;
	}
	public void setRsubname(String rsubname) {
		this.rsubname = rsubname;
	}
	public String getRsubbirth1() {
		return rsubbirth1;
	}
	public void setRsubbirth1(String rsubbirth1) {
		this.rsubbirth1 = rsubbirth1;
	}

	public int getRno() {
		return rno;
	}

	public void setRno(int rno) {
		this.rno = rno;
	}

	public Date getRwritedate() {
		return rwritedate;
	}

	public void setRwritedate(Date rwritedate) {
		this.rwritedate = rwritedate;
	}

	public String getRsubphone() {
		return rsubphone;
	}

	public void setRsubphone(String rsubphone) {
		this.rsubphone = rsubphone;
	}
	
}
