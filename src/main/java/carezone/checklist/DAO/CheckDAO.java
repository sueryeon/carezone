package carezone.checklist.DAO;

import java.util.List;

import carezone.checklist.VO.CheckVO;

public interface CheckDAO {
	
	public List<CheckVO> getChecklist(String mid) throws Exception;
	
	public int changeCheckType(CheckVO checkVO) throws Exception;
	
}
