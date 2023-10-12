package carezone.hoscart.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import carezone.hoscart.vo.HosCartVO;

@Repository("hoscartDAO")
public class HosCartDAOImpl implements HosCartDAO {
	
	@Autowired
	private SqlSession sqlSession;

	//장바구니 1개 insert
	@Override
	public int insertHosCart(HosCartVO hcVO) throws DataAccessException {
		System.out.println("---- dao의 insertHosCart() 도착 ----");
		int result = sqlSession.insert("mapper.hoscart.insertMyHosCart", hcVO);
		return result;
	}

	//회원의 장바구니 전체 select
	@Override
	public List<HosCartVO> getlistHosCart(String hcid) throws DataAccessException {
		System.out.println("---- dao의 getlistHosCart() 도착 ----");
		List<HosCartVO> hoscartList = sqlSession.selectList("mapper.hoscart.selectMyHosCart",hcid);
		return hoscartList;
	}

	@Override
	public int deleteHosCart(HosCartVO hcVO) throws DataAccessException {
		System.out.println("---- dao의 getdeleteHosCart() 도착 ----");
		int result = sqlSession.delete("mapper.hoscart.deleteMyHosCart",hcVO);
		return result;
	}

	@Override
	public int countHosCart(String hcid) throws DataAccessException {
		System.out.println("---- dao의 countHosCart() 도착 ----");
		int result = sqlSession.selectOne("mapper.hoscart.countMyHosCart",hcid);
		return result;
	}

}
