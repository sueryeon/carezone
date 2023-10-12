package carezone.checklist.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import carezone.checklist.DAO.CheckDAO;
import carezone.checklist.VO.CheckVO;

@Service("checklistService")
public class CheckServiceImpl implements CheckService {
	
	@Autowired
	private CheckDAO checkDAO;

	@Override
	public List<CheckVO> getChecklist(String mid) throws Exception {
		
		System.out.println("-------------------체크리스트 서비스 : getChecklist-------------------");
		
		List<CheckVO> checklist=checkDAO.getChecklist(mid);
		
		return checklist;
	}

	@Override
	public int changeCheckType(CheckVO checkVO) throws Exception {
		
		System.out.println("-------------------체크리스트 서비스 : changeCheckType-------------------");
		
		int listType=checkDAO.changeCheckType(checkVO);
		
		return listType;
	}
	
	
	
}
