package carezone.member.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.origin.SystemEnvironmentOrigin;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import carezone.member.vo.AdminVO;
import carezone.member.vo.FamilyVO;
import carezone.member.vo.MemberVO;

@Repository("memberDAO")
public class MemberDAOImpl implements MemberDAO {
	@Autowired
	private SqlSession sqlSession;
	
	
	//관리자 로그인 
	@Override
	public AdminVO getAdminLogin(AdminVO adminVO) throws DataAccessException {
		System.out.println("MemberDAO의 getAdminLogin() 도착");
		AdminVO adVO = sqlSession.selectOne("mapper.member.adminLogin",adminVO);
		return adVO;
	}


	//회원 로그인
	@Override
	public MemberVO getLogin(MemberVO memberVO) throws DataAccessException {
		System.out.println("MemberDAOImpl의 getLogin() 도착");
		MemberVO memVO = sqlSession.selectOne("mapper.member.loginMember",memberVO);
		return memVO;
	}
	
	
	//아이디 중복 확인
	@Override
	public String getIdCheck(String checkid) throws DataAccessException {
		String mid = checkid;
		String result = (String) sqlSession.selectOne("mapper.member.checkId", mid);
		return result;
	}

	//휴대폰 중복 확인
	@Override
	public String getPhoneCheck(String checkphone) throws DataAccessException {
		String mphone = checkphone;
		String result = (String) sqlSession.selectOne("mapper.member.checkPhone",mphone);
		return result;
	}


	//예약전 본인인증하기
	@Override
	public String memcheck(MemberVO memberVO) throws DataAccessException {
		System.out.println("MemberDAO의 memcheck() 도착");
		String result = sqlSession.selectOne("mapper.member.memcheck",memberVO);
		return result;
	}


	//회원 전체 조회
	@Override
	public List<MemberVO> getlistMembers() throws DataAccessException {
		System.out.println("MemberDAO의 getlistMembers() 도착");
		List<MemberVO> membersList = null;
		membersList = sqlSession.selectList("mapper.member.selectAllMemberList");
		if(membersList.size()==0) {
			System.out.println("membersList는 null 입니다.");
		}
		return membersList;
	}
	


	//회원 추가
	@Override
	public int insertMember(MemberVO memberVO) throws DataAccessException {
		System.out.println("memberDAOImpl의 insertMember() 도착");
		int result=0;
		result = sqlSession.insert("mapper.member.insertMember",memberVO);
		return result;
	}
	
	//회원 1명 조회 후 수정 폼
	@Override
	public MemberVO findMember(String mid) throws DataAccessException {
		System.out.println("memberDAOImpl의 findMember() 도착");
		System.out.println("serviceImpl에서 가져온 아이디 : "+mid);
		MemberVO memVO = (MemberVO) sqlSession.selectOne("mapper.member.findMember", mid);
		System.out.println("아이디 : "+memVO.getMid());
		return memVO;
	}
	
	
	//관리자 1명 조회 후  수정 폼
	@Override
	public AdminVO findAdmin(String adid) throws DataAccessException {
		System.out.println("memberDAOImpl의 findAdmin() 도착");
		System.out.println("serviceImpl에서 가져온 아이디 : "+adid);
		AdminVO adVO = sqlSession.selectOne("mapper.member.findAdmin", adid);
		return adVO;
	}


	//회원 수정
	@Override
	public int updateMember(MemberVO memberVO) throws DataAccessException {
		System.out.println("MemberDAOImpl의 updateMember() 도착");
		System.out.println("수정할 아이디 : "+memberVO.getMid());
		int result = sqlSession.update("mapper.member.updateMember", memberVO);
		return result;
	}
	
	//관리자 수정
	@Override
	public int updateAdmin(AdminVO adminVO) throws DataAccessException {
		System.out.println("MemberDAOImpl의 updateMember() 도착");
		System.out.println("수정할 아이디 : "+adminVO.getAdid());
		int result = sqlSession.update("mapper.member.updateAdmin", adminVO);
		return result;
	}
	
	
	
	//회원 삭제
	@Override
	public int deleteMember(String mid) throws DataAccessException {
		System.out.println("MemberDAOImpl의 deleteMember() 도착");
		System.out.println("삭제할 아이디 : "+mid);
		int result = sqlSession.delete("mapper.member.deleteMember", mid);
		return result;
	}
	
	@Override
	public String findMyId(MemberVO memberVO) throws DataAccessException{
		System.out.println("MemberDAOImpl의 findMyId() 도착");
		String mid = sqlSession.selectOne("mapper.member.findMyId",memberVO);
		System.out.println("database 다녀옴");
		System.out.println("dao에서 mid : "+mid);
		return mid;
	}
	
	//비밀번호 본인인증	
	@Override
	public int findMyPwd(MemberVO memberVO) throws DataAccessException {
		System.out.println("MemberDAOImpl의 findMyId() 도착");
		int result = sqlSession.selectOne("mapper.member.findMyPwd",memberVO);
		return result;
	}

	
	//비밀번호 재설정
	@Override
	public int newMyPwd(MemberVO memberVO) throws DataAccessException {
		System.out.println("MemberDAOImpl의 newMyPwd() 도착");
		int result = sqlSession.update("mapper.member.newMyPwd", memberVO);
		return result;
	}	
	
	
	/*===============================가족 관련 메서드=============================*/
	
	
	



	//회원의 가족 추가 폼
	@Override
	public MemberVO getFamForm(String mid) throws DataAccessException {
		System.out.println("memberDAOImpl의 getFamForm() 도착");
		System.out.println("serviceImpl에서 가져온 아이디 : "+mid);
		MemberVO memVO = (MemberVO) sqlSession.selectOne("mapper.member.findMember", mid);
		System.out.println("아이디 : "+memVO.getMid());
		return memVO;
	}

	//회원 가족 전체 조회
	@Override
	public List<FamilyVO> getlistFamilyMembers(int fno) throws DataAccessException {
		System.out.println("MemberDAOImpl의 getlistFamilyMembers() 도착");
		System.out.println("가족 조회하는 회원의 number : "+fno);
		List<FamilyVO> familyList = sqlSession.selectList("mapper.member.selectAllFamilyList", fno);
		if(familyList.size()==0) {
			System.out.println("familyList는 null입니다.");
		}
		return familyList;
	}

	//회원 가족 추가
	@Override
	public int insertFamilyMember(FamilyVO familyVO) throws DataAccessException {
		System.out.println("MemberDAOImpl의 insertFamilyMember() 도착");
		System.out.println("service에서 가져온 가족의 이름 : "+familyVO.getFname());
		int result = sqlSession.insert("mapper.member.insertFamilyMember", familyVO);
		
		return result;
	}
	
	
	//가족 번호 중복 검사
	@Override
	public String getfPhoneCheck(String checkfphone) throws DataAccessException {
		System.out.println("memberDAO의 가족 폰번호 중복 검사 함수 도착");
		String fphone = checkfphone;
		String result = sqlSession.selectOne("mapper.member.checkfPhone",fphone);
		return result;
	}


	//회원 가족 1명 조회 후 수정 폼
	@Override
	public FamilyVO findFamilyMember(int fid) throws DataAccessException {
		System.out.println("MemberDAOImpl의 findFamilyMember() 도착");
		FamilyVO familyVO = (FamilyVO) sqlSession.selectOne("mapper.member.findFamilyMember",fid);
		return familyVO;
	}

	//회원 가족 수정
	@Override
	public int updateFamilyMember(FamilyVO familyVO) throws DataAccessException {
		System.out.println("MemberDAOImpl의 updateFamilyMember() 도착");
		System.out.println("수정 주소 : "+familyVO.getFaddr());
		int result = sqlSession.update("mapper.member.updateFamilyMember", familyVO);
		return result;
	}

	//회원 가족 삭제
	@Override
	public int deleteFamilyMember(int fid) throws DataAccessException {
		System.out.println("MemberDAOImpl의 deleteFamilyMember() 도착");
		System.out.println("삭제할 가족의 fid = "+fid);
		int result = sqlSession.delete("mapper.member.deleteFamilyMember", fid);
		return result;
	}

	
	
}
