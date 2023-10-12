package carezone.checklist.DAO;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import carezone.checklist.VO.CheckVO;

@Repository("checkDAO")
public class CheckDAOImpl implements CheckDAO {

	@Autowired
	private SqlSession sqlsession;

	@Override
	public List<CheckVO> getChecklist(String mid) throws Exception {

		System.out.println("――――――――――――――――체크리스트 DAO : getChecklist――――――――――――――――");
		
		List<CheckVO> checklist=sqlsession.selectList("mapper.checklist.getChecklist", mid);
		
		return checklist;
	}

	@Override
	public int changeCheckType(CheckVO checkVO) throws Exception {

		System.out.println("――――――――――――――――체크리스트 DAO : changeCheckType――――――――――――――――");
		
		sqlsession.update("mapper.checklist.updateCheckType", checkVO); // 체크박스 값 업데이트 
		
		int listType=sqlsession.selectOne("mapper.checklist.selectCheckType", checkVO); // 업데이트 후 가져오기.
		
		return listType;
	}
	
	
}
