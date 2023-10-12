package carezone.hospital.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import carezone.hospital.DAO.HospitalDAO;
import carezone.hospital.VO.HospitalVO;

@Service("hospitalService")
public class HospitalServiceImpl implements HospitalService {

	@Autowired
	private HospitalDAO hospitalDAO;
	
	@Override
	public void insertHospital(HospitalVO hosVO) throws Exception {
		
		System.out.println("------------------병원 서비스 : insertHospital-------------------");
		
		hospitalDAO.insertHospital(hosVO);
	}

	/*@Override
	public List<HospitalVO> searchHospital(String vccname,String state,String city,String fullcity) throws Exception {
		
		System.out.println("------------------병원 서비스 : searchHospital-------------------");
		
		List<HospitalVO> hospitalList=hospitalDAO.searchHospital(vccname);
		List<HospitalVO> newhospitalList=new ArrayList<HospitalVO>();
		HospitalVO hosVO=new HospitalVO();
		
		if(hospitalList!=null) {
			for(int i=0; i<hospitalList.size(); i++) {
				hosVO=hospitalList.get(i);
				String hosaddr=hosVO.getHosaddr();
				String[] hosaddrArr=hosaddr.split(" ");

				if(hosaddrArr[0].equals(state)) //경상남도 일치할때
				{
					if(city!=null&&city.length()!=0)  //경상남도에 시 검색했을때
					{
						//System.out.println("시 파라미터가 널이아닐때 "+i+"번째 "+hosVO.getHosaddr());
						//System.out.println("시 파라미터가 널이아닐때 :  "+"'"+city+"'");
						if(hosaddrArr[1].equals(city)) 
						{
							if(fullcity!=null&&fullcity.length()!=0) //경상남도 창원시인데 동이 있을때 
							{
								int bigin=hosaddr.lastIndexOf(fullcity);
								int end=hosaddr.lastIndexOf(fullcity)+(fullcity.length());
								if(bigin>0)
								{
									String FullCity=hosaddr.substring(bigin,end); 
									if(FullCity.equals(fullcity)) //동이 일치할때 
									{
										newhospitalList.add(hosVO);
									}
								}
								else //동이일치하지않을때 
								{
									//경상남도 창원시 인데 동은 있는데 동이 일치하지않을때 . 
								}

							}
							else // 동이 널일때 
							{
								newhospitalList.add(hosVO);//경상남도 창원시까지 일치하고 동이 null 일때 
							}
						}
						else//경상남도 에 파라미터 시는 있는데 창원이아닐때  
						{
							//newhospitalList.add(hosVO);//
						}

					}
					else//경상남도이긴한데 시가 없을때
					{
						newhospitalList.add(hosVO);
					}
					
				}
				else {
					System.out.println("no");
				}
			}

			for(int i=0; i<newhospitalList.size(); i++) {
				HospitalVO VO=newhospitalList.get(i);
				String VOaddr=VO.getHosaddr();
				int VOq=VO.getVccquantity();
				
				System.out.println("new list : "+i+"번째 "+VOaddr+"/"+VOq);
			}
			return newhospitalList;
		}
		else
			return null;
	}*/
	
	@Override
	public Map<String, Object> searchHospital(Map<String, Object> pagingMap, String vccname,String state,String city,String fullcity) throws Exception {
		
		System.out.println("------------------병원 서비스 : searchHospital-------------------");
		
		
		Map<String, Object> articlesMap = hospitalDAO.searchHospital(pagingMap,vccname,state,city,fullcity);
		
		return articlesMap;
	}
}
