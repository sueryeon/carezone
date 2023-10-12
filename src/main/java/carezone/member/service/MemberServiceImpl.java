package carezone.member.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import carezone.member.dao.MemberDAO;
import carezone.member.vo.AdminVO;
import carezone.member.vo.FamilyVO;
import carezone.member.vo.MemberVO;

@Service("memberService")
public class MemberServiceImpl implements MemberService {
	@Autowired
	private MemberDAO memberDAO;
	
	
	//관리자 로그인
	@Override
	public AdminVO getAdminLogin(AdminVO adminVO) throws DataAccessException {
		System.out.println("MemberServiceImpl의 getAdminLogin() 도착");
		AdminVO adVO = memberDAO.getAdminLogin(adminVO);
		return adVO;
	}

	//회원 로그인
	@Override
	public MemberVO getLogin(MemberVO memberVO) throws DataAccessException {
		System.out.println("MemberServiceImpl의 getLogin() 도착");
		MemberVO memVO = memberDAO.getLogin(memberVO);
		return memVO;
	}
	
	
	//휴대폰 중복 확인
	@Override
	public String getPhoneCheck(String checkphone) throws DataAccessException {
		System.out.println("dao 휴대폰 중복 확인 함수 도착");
		String result = memberDAO.getPhoneCheck(checkphone);
		return result;
	}



	//아이디 중복 확인
	@Override
	public String getIdCheck(String checkid) throws DataAccessException {
		String result = memberDAO.getIdCheck(checkid);
		return result;
	}

	
	//회원 전체 조회
	@Override
	public List<MemberVO> getlistMembers() throws DataAccessException {
		System.out.println("MemberServiceImpl의 getlistMembers() 도착");
		List<MemberVO> membersList = null;
		membersList = memberDAO.getlistMembers();
		return membersList;
	}

	//회원 추가
	@Override
	public int insertMember(MemberVO memberVO) throws DataAccessException {
		System.out.println("MemberServiceImpl insertMember() 도착");
		int result;
		result = memberDAO.insertMember(memberVO);
		return result;
	}

	//회원 1명 조회 후 수정 폼
	@Override
	public MemberVO findMember(String mid) throws DataAccessException {
		System.out.println("MemberServiceImpl findMember() 도착");
		System.out.println("MemberDAOImpl 의 findMember()로 가져갈 id : "+mid);
		MemberVO memberVO = new MemberVO();
		memberVO = memberDAO.findMember(mid);
		return memberVO;
	}
	
	
	
	//관리자 1명 조회 후 수정 폼
	@Override
	public AdminVO findAdmin(String adid) throws DataAccessException {
		System.out.println("MemberServiceImpl findAdmin() 도착");
		System.out.println("관리자 아이디 : "+adid);
		AdminVO adVO = memberDAO.findAdmin(adid);
		return adVO;
	}



	//회원 수정
	@Override
	public int updateMember(MemberVO memberVO) throws DataAccessException {
		System.out.println("MemberServiceImpl의 updateMember() 도착");
		System.out.println("MemberDAOImpldml updateMember로 가져갈 id : "+memberVO.getMid());
		int result = memberDAO.updateMember(memberVO);
		return result;
	}
	
	//관리자 수정
	@Override
	public int updateAdmin(AdminVO adminVO) throws DataAccessException {
		System.out.println("MemberServiceImpl의 updateMember() 도착");
		System.out.println("MemberDAOImpldml updateMember로 가져갈 id : "+adminVO.getAdid());
		int result = memberDAO.updateAdmin(adminVO);
		return result;
	}

	//회원 삭제
	@Override
	public int deleteMember(String mid) throws DataAccessException {
		System.out.println("MemberServiceImpl의 deleteMember() 도착");
		System.out.println("삭제할 아이디 : "+mid);
		int result = memberDAO.deleteMember(mid);
		return result;
	}
	
	
	//예약 전 본인인증
	@Override
	public String memcheck(MemberVO memberVO) throws DataAccessException {
		System.out.println("MemberServiceImpl의 memcheck() 도착");
		String result = memberDAO.memcheck(memberVO);
		return result;
	}

	//아이디 찾기
	@Override
	public String findMyId(MemberVO memberVO) throws DataAccessException{
		System.out.println("MemberServiceImpl의 findMyId() 도착");
		String mid = memberDAO.findMyId(memberVO);
		return mid;
	}

	
	//비밀번호 본인인증	
	@Override
	public int findMyPwd(MemberVO memberVO) throws DataAccessException {
		System.out.println("MemberServiceImpl의 findMyPwd() 도착");
		int result = memberDAO.findMyPwd(memberVO);
		return result;
	}


	//비밀번호 재설정하기
	@Override
	public int newMyPwd(MemberVO memberVO) throws DataAccessException {
		System.out.println("MemberServiceImpl의 newMyPwd() 도착");
		
		int result = memberDAO.newMyPwd(memberVO);
		return result;
	}



	/*===============================가족 관련 메서드=============================*/
	//회원의 가족 추가 폼
	@Override
	public MemberVO getFamForm(String mid) throws DataAccessException {
		System.out.println("MemberServiceImpl getFamForm() 도착");
		System.out.println("MemberDAOImpl 의 getFamForm()로 가져갈 id : "+mid);
		MemberVO memberVO = new MemberVO();
		memberVO = memberDAO.findMember(mid);
		return memberVO;
	}

	//회원 가족 전체 조회
	@Override
	public List<FamilyVO> getlistFamilyMembers(int fno) throws DataAccessException {
		System.out.println("MemberServiceImpl의 getlistFamilyMembers() 도착");
		System.out.println("가족 조회하는 회원의 num : "+fno);
		List<FamilyVO> familyList = memberDAO.getlistFamilyMembers(fno);
		
		return familyList;
	}

	//회원 가족 추가
	@Override
	public int insertFamilyMember(FamilyVO familyVO) throws DataAccessException {
		System.out.println("MemberService의 insertFamilyMember() 도착");
		System.out.println("controller에서 가져온 가족의 이름"+familyVO.getFname());
		int result = memberDAO.insertFamilyMember(familyVO);

		return result;
	}
	
	//가족 휴대폰 중복 검사
	@Override
	public String getfPhoneCheck(String checkfphone) throws DataAccessException {
		System.out.println("memberService의 가족 휴대폰 중복 검사 함수 도착");
		String result = memberDAO.getfPhoneCheck(checkfphone);
		return result;
	}



	//회원 가족 1명 조회 후 수정 폼
	@Override
	public FamilyVO findFamilyMember(int fid) throws DataAccessException {
		System.out.println("MemberServiceImpl의 findFamilyMember() 도착");
		FamilyVO familyVO = memberDAO.findFamilyMember(fid);
		return familyVO;
	}

	

	//회원 가족 수정
	@Override
	public int updateFamilyMember(FamilyVO familyVO) throws DataAccessException {
		System.out.println("MemberServiceImpl의 updateFamilyMember() 도착");
		System.out.println("수정 주소 : "+familyVO.getFaddr());
		int result = memberDAO.updateFamilyMember(familyVO);
		return result;
	}

	//회원 가족 삭제
	@Override
	public int deleteFamilyMember(int fid) throws DataAccessException {
		System.out.println("MemberServiceImpl의 deleteFamilyMember() 도착");
		System.out.println("삭제할 가족 fid : "+fid);
		int result = memberDAO.deleteFamilyMember(fid);
		return result;
	}
	
	
	
}
