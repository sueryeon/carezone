package carezone.board.vo;


import java.util.Date;

import org.springframework.stereotype.Component;

@Component("boardVO")
public class BoardVO {
	private int barticleNo;
	private String bid;
	private String btitle;
	private String bcontent;
	private String bimgFile;
	private Date bwriteDate;
	
	public BoardVO() {}

	public int getBarticleNo() {
		return barticleNo;
	}

	public void setBarticleNo(int barticleNo) {
		this.barticleNo = barticleNo;
	}

	public String getBid() {
		return bid;
	}

	public void setBid(String bid) {
		this.bid = bid;
	}

	public String getBtitle() {
		return btitle;
	}

	public void setBtitle(String btitle) {
		this.btitle = btitle;
	}

	public String getBcontent() {
		return bcontent;
	}

	public void setBcontent(String bcontent) {
		this.bcontent = bcontent;
	}

	public String getBimgFile() {
		return bimgFile;
	}

	public void setBimgFile(String bimgFile) {
		this.bimgFile = bimgFile;
	}

	public Date getBwriteDate() {
		return bwriteDate;
	}

	public void setBwriteDate(Date bwriteDate) {
		this.bwriteDate = bwriteDate;
	}
	
	
}
