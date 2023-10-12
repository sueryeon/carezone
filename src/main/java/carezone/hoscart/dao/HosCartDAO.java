package carezone.hoscart.dao;

import java.util.List;

import org.springframework.dao.DataAccessException;

import carezone.hoscart.vo.HosCartVO;

public interface HosCartDAO {
	//장바구니 insert
	public int insertHosCart(HosCartVO hcVO) throws DataAccessException;
	//장바구니 전체 select
	public List<HosCartVO> getlistHosCart(String hcid) throws DataAccessException; 
	//내 장바구니 1개 delete
	public int deleteHosCart(HosCartVO hcVO) throws DataAccessException;
	//내 장바구니 count
	public int countHosCart(String hcid) throws DataAccessException;
}
