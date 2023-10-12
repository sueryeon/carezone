package carezone.hoscart.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import carezone.hoscart.dao.HosCartDAO;
import carezone.hoscart.vo.HosCartVO;

@Service("hoscartService")
public class HosCartServiceImpl implements HosCartService {

	@Autowired
	private HosCartDAO hoscartDAO;
	
	//장바구니 1개 insert
	@Override
	public int insertHosCart(HosCartVO hcVO) throws DataAccessException {
		System.out.println("---- service의 insertHosCart() 도착 ----");
		int result = hoscartDAO.insertHosCart(hcVO);
		return result;
	}

	//회원의 장바구니 전체 select
	@Override
	public List<HosCartVO> getlistHosCart(String hcid) throws DataAccessException {
		System.out.println("---- service의 getlistHosCart() 도착 ----");
		List<HosCartVO> hoscartList = hoscartDAO.getlistHosCart(hcid);
		return hoscartList;
	}

	//회원의 장바구니에서 1개 delete
	@Override
	public int deleteHosCart(HosCartVO hcVO) throws DataAccessException {
		System.out.println("---- service의 getdeleteHosCart() 도착 ----");
		int result = hoscartDAO.deleteHosCart(hcVO);
		
		return result;
	}

	//회원의 장바구니 count
	@Override
	public int countHosCart(String hcid) throws DataAccessException {
		System.out.println("---- service의 countHosCart() 도착 ----");
		int result = hoscartDAO.countHosCart(hcid);
		
		return result;
	}

	
}
