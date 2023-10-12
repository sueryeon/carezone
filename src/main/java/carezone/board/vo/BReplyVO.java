package carezone.board.vo;

import java.util.Date;

public class BReplyVO {
	private int brarticleNo;
	private int brparentNo;
	private String brid;
	private String brcontent;
	private Date brwriteDate;
	
	public BReplyVO() {}
	
	public BReplyVO(int brparentNo, String brid, String brcontent) {
		this.brparentNo=brparentNo;
		this.brid=brid;
		this.brcontent=brcontent;
	}

	public int getBrarticleNo() {
		return brarticleNo;
	}

	public void setBrarticleNo(int brarticleNo) {
		this.brarticleNo = brarticleNo;
	}

	public int getBrparentNo() {
		return brparentNo;
	}

	public void setBrparentNo(int brparentNo) {
		this.brparentNo = brparentNo;
	}

	public String getBrid() {
		return brid;
	}

	public void setBrid(String brid) {
		this.brid = brid;
	}

	public String getBrcontent() {
		return brcontent;
	}

	public void setBrcontent(String brcontent) {
		this.brcontent = brcontent;
	}

	public Date getBrwriteDate() {
		return brwriteDate;
	}

	public void setBrwriteDate(Date brwriteDate) {
		this.brwriteDate = brwriteDate;
	}
	
	
}
