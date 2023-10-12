package carezone.member.dao;

import java.util.List;

import org.springframework.dao.DataAccessException;

import carezone.member.vo.AdminVO;
import carezone.member.vo.FamilyVO;
import carezone.member.vo.MemberVO;

public interface MemberDAO {
	//회원 관련 메서드
	public List<MemberVO> getlistMembers()throws DataAccessException;
	public String getIdCheck(String checkid) throws DataAccessException;
	public String getPhoneCheck(String checkphone) throws DataAccessException;
	public int insertMember(MemberVO memberVO) throws DataAccessException;
	public MemberVO findMember(String mid) throws DataAccessException;
	public int updateMember(MemberVO memberVO) throws DataAccessException;
	public int updateAdmin(AdminVO adminVO) throws DataAccessException;
	public int deleteMember(String mid) throws DataAccessException;
	public String findMyId(MemberVO memberVO) throws DataAccessException;
	public int findMyPwd(MemberVO memberVO) throws DataAccessException;
	public int newMyPwd(MemberVO memberVO) throws DataAccessException;
	public String memcheck(MemberVO memberVO) throws DataAccessException;
	
	//회원의 가족 관련 메서드
	public MemberVO getFamForm(String mid) throws DataAccessException;
	public String getfPhoneCheck(String checkfphone) throws DataAccessException;
	public List<FamilyVO> getlistFamilyMembers(int fno)throws DataAccessException;
	public int insertFamilyMember(FamilyVO familyVO) throws DataAccessException;
	public FamilyVO findFamilyMember(int fid) throws DataAccessException;
	public int updateFamilyMember(FamilyVO familyVO) throws DataAccessException;
	public int deleteFamilyMember(int fid) throws DataAccessException;
	
	//로그인
	public MemberVO getLogin(MemberVO memberVO) throws DataAccessException;
	
	//관리자 로그인
	public AdminVO getAdminLogin(AdminVO adminVO) throws DataAccessException;
	public AdminVO findAdmin(String adid) throws DataAccessException;
}
