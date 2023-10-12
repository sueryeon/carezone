package carezone.checklist.service;

import java.util.List;

import carezone.checklist.VO.CheckVO;

public interface CheckService {

	public List<CheckVO> getChecklist(String mid) throws Exception;
	
	public int changeCheckType(CheckVO checkVO) throws Exception;
	
}
