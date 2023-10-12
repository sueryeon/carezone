package carezone.hospital.VO;

public class searchVO {
	
	private String state;
	private String city;
	private String fullcity;
	private String vccname;
	
	public searchVO() {
		
	}
	public searchVO(String state,String vccname) {
		this.state=state;
		this.vccname=vccname;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getFullcity() {
		return fullcity;
	}
	public void setFullcity(String fullcity) {
		this.fullcity = fullcity;
	}
	public String getVccname() {
		return vccname;
	}
	public void setVccname(String vccname) {
		this.vccname = vccname;
	}
	
}
