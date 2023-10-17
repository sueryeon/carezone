package carezone.checklist.service;

import java.util.List;

import carezone.checklist.VO.CheckVO;
import carezone.member.vo.FamilyVO;

public interface CheckService {

	public List<CheckVO> getChecklist(String mid) throws Exception;
	
	public int changeCheckType(CheckVO checkVO) throws Exception;
	
	public List<FamilyVO> getHomechecklist(String mno) throws Exception;
}
