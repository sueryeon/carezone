package carezone.hospital.DAO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import carezone.hospital.VO.HospitalVO;

@Repository("hospitalDAO")
public class HospitalDAOImpl implements HospitalDAO {
	
	@Autowired
	private SqlSession sqlsession;

	@Override
	public void insertHospital(HospitalVO hosVO) throws Exception {
		
		System.out.println("――――――――――Qna DAO : insertQna――――――――――");
		
		sqlsession.insert("mapper.hospital.insertHospital", hosVO);
		
	}

	/*@Override
	public List searchHospital(String vccname) throws Exception {
		
		System.out.println("――――――――――Qna DAO : searchHospital――――――――――");
		
		if(vccname!=null&&vccname.length()!=0) {
			
			List<HospitalVO> hospitalList=sqlsession.selectList("mapper.hospital.searchHospital1",vccname);
			return hospitalList;
		}
		else {

			List<HospitalVO> hospitalList=sqlsession.selectList("mapper.hospital.searchHospital2");
			return hospitalList;
		}
		
	}*/
	
	@Override
	public Map<String, Object> searchHospital(Map<String, Object> pagingMap,String vccname,String state,String city,String fullcity) throws Exception {
		
		System.out.println("――――――――――Qna DAO : searchHospital――――――――――");
		Map<String, Object> articlesMap = new HashMap<String, Object>();
		List<HospitalVO> hospitalList=null;
		int totalArticles=0;
		
		if(vccname.length()!=0) {
			
			System.out.println("백신있을때");
			pagingMap.put("vccname", vccname);
			
			if(state.length()!=0) {
				
				if(city.length()!=0) {
					
					if(fullcity.length()!=0)/*동까지 다있을때*/ {

						System.out.println("경상남도 시군구 동까지 있을때");
						pagingMap.put("state", state);
						pagingMap.put("city", city);
						pagingMap.put("fullcity", fullcity);
						hospitalList=sqlsession.selectList("mapper.hospital.search_vccname_state_city_fullcity",pagingMap);
						System.out.println("리스트는 들고옴");
						totalArticles=sqlsession.selectOne("mapper.hospital.All_vccname_state_city_fullcity", pagingMap);
						
						articlesMap.put("hospitalList", hospitalList);
						articlesMap.put("totalArticles", totalArticles);
						
						return articlesMap;
						
					}
					else/*시/군/구만 있을때*/ {
						System.out.println("경상남도 시군구까지 있을때");
						pagingMap.put("state", state);
						pagingMap.put("city", city);
						hospitalList=sqlsession.selectList("mapper.hospital.search_vccname_state_city",pagingMap);
						System.out.println("리스트는 들고옴");
						totalArticles=sqlsession.selectOne("mapper.hospital.All_vccname_state_city", pagingMap);
						
						articlesMap.put("hospitalList", hospitalList);
						articlesMap.put("totalArticles", totalArticles);
						
						return articlesMap;
						
					}
				}
				else/*경상남도만 있을때.*/ {
					
					System.out.println("경상남도까지만 있을때");
					pagingMap.put("state", state);
					hospitalList=sqlsession.selectList("mapper.hospital.search_vccname_state",pagingMap);
					System.out.println("리스트는 들고옴");
					totalArticles=sqlsession.selectOne("mapper.hospital.All_vccname_state", pagingMap);
					
					articlesMap.put("hospitalList", hospitalList);
					articlesMap.put("totalArticles", totalArticles);
					
					return articlesMap;
				}
			}
			else{
				System.out.println("경상남도 없음. 에러");
				
				return null;
			}
			
		}
		else{
			
			System.out.println("백신없을때");
			
			if(state.length()!=0) {
				
				if(city.length()!=0) {
					
					if(fullcity.length()!=0)/*동까지 다있을때*/ {

						System.out.println("경상남도 시군구 동까지 있을때");
						pagingMap.put("state", state);
						pagingMap.put("city", city);
						pagingMap.put("fullcity", fullcity);
						hospitalList=sqlsession.selectList("mapper.hospital.search_state_city_fullcity",pagingMap);
						totalArticles=sqlsession.selectOne("mapper.hospital.All_state_city_fullcity", pagingMap);
						
						articlesMap.put("hospitalList", hospitalList);
						articlesMap.put("totalArticles", totalArticles);
						
						return articlesMap;
						
					}
					else/*시/군/구만 있을때*/ {
						
						pagingMap.put("state", state);
						String st=(String) pagingMap.get("state");
						pagingMap.put("state", state);
						pagingMap.put("city", city);
						System.out.println("경상남도 시군구까지 있을때"+city+"/ "+st);
						hospitalList=sqlsession.selectList("mapper.hospital.search_state_city",pagingMap);
						totalArticles=sqlsession.selectOne("mapper.hospital.All_state_city", pagingMap);
						
						articlesMap.put("hospitalList", hospitalList);
						articlesMap.put("totalArticles", totalArticles);
						
						return articlesMap;
					}
				}
				else/*경상남도만 있을때.*/ {
					
					System.out.println("경상남도까지만 있을때"+state);
					
					pagingMap.put("state", state);
					hospitalList=sqlsession.selectList("mapper.hospital.search_state",pagingMap);
					totalArticles=sqlsession.selectOne("mapper.hospital.All_state", pagingMap);
					
					articlesMap.put("hospitalList", hospitalList);
					articlesMap.put("totalArticles", totalArticles);
					
					return articlesMap;
					
				}
			}
			else {
				System.out.println("경상남도 없음. 에러");
				
				return null;
			}

		}
		
	}
	

}
