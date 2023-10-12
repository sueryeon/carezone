package carezone.hospital.DAO;

import java.util.List;
import java.util.Map;

import carezone.hospital.VO.HospitalVO;

public interface HospitalDAO {

	public void insertHospital(HospitalVO hosVO) throws Exception;
	
	public Map<String, Object> searchHospital(Map<String, Object> pagingMap,String vccname,String state,String city,String fullcity) throws Exception;
	
}
