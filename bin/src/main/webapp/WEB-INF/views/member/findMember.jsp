<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String contextPath = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.min.js" integrity="sha384-Rx+T1VzGupg4BHQYs2gCW9It+akI2MM/mndMCy36UVfodzcJcF0GGLxZIzObiEfa" crossorigin="anonymous"></script>
<script>

	window.onload=function(){
		
		var isLogin = "${isLogin}";
		var isAdminLogin = "${isAdminLogin}";
		console.log("isAdminLogin : "+isAdminLogin);
		console.log("isLogin : "+isLogin);
		console.log("${memVO.mid}");
		if(isLogin==""){
			console.log("공백입니다.");
		}
	
		var member_menu = document.getElementById("member_menu");
		var admin_menu = document.getElementById("admin_menu");
		
		if((isLogin=="true"&&isAdminLogin=="false")||(isLogin=="true"&&isAdminLogin.length==0)){
			member_menu.style.display="block";
			admin_menu.style.display="none";
		}
		else if((isAdminLogin=="true"&&isLogin=="false")||(isAdminLogin=="true"&&isLogin.length==0)){
	
			member_menu.style.display="none";
			admin_menu.style.display="block";
		}
		else{
	
			member_menu.style.display="block";
			admin_menu.style.display="none";
		}
	
	}
	function inputemail(){
	    var memail2 = document.getElementById("memail2");
	    var selectEmail = document.getElementById("memailSelect").value;
	    memail2.value = selectEmail;
	}
	
	function fn_updateMember(){
		var mpwd = document.getElementById("mpwd");
		var mname = document.getElementById("mname");
		var memail1 = document.getElementById("memail1");
		var memail2 = document.getElementById("memail2");
		var mphone = document.getElementById("mphone");
		var maddr = document.getElementById("maddr");
		var memailSelect = document.getElementById("memailSelect");
		mpwd.disabled=false;
		mname.disabled=false;
		memail1.disabled=false;
		memail2.disabled=false;
		mphone.disabled=false;
		maddr.disabled=false;
		memailSelect.disabled=false;
		
		var updateClick = document.getElementById("updateClick");
		var updateMember = document.getElementById("updateMember");
		var updateCancel = document.getElementById("updateCancel");
		updateClick.style.display="none";
		updateMember.style.display="block";
		updateCancel.style.display="block";
		
		//memailSelect.style.display="block";
	}
	
	function fn_updateAdmin(){
		var adpwd = document.getElementById("adpwd");
		var adname = document.getElementById("adname");
		adpwd.disabled=false;
		adname.disabled=false;
		
		var adupdateBtn = document.getElementById("adupdateBtn");
		var updateAdmin = document.getElementById("updateAdmin");
		var adupdateCancel = document.getElementById("adupdateCancel");
		adupdateBtn.style.display="none";
		updateAdmin.style.display="block";
		adupdateCancel.style.display="block";
	}
	
	function fn_adupdateCancel(){
		var adpwd = document.getElementById("adpwd");
		var adname = document.getElementById("adname");
		adpwd.disabled=true;
		adname.disabled=true;
		
		var adupdateBtn = document.getElementById("adupdateBtn");
		var updateAdmin = document.getElementById("updateAdmin");
		var adupdateCancel = document.getElementById("adupdateCancel");
		adupdateBtn.style.display="block";
		updateAdmin.style.display="none";
		adupdateCancel.style.display="none";
	}
	
	function fn_updateCancel(){
		var mpwd = document.getElementById("mpwd");
		var mname = document.getElementById("mname");
		var memail1 = document.getElementById("memail1");
		var memail2 = document.getElementById("memail2");
		var mphone = document.getElementById("mphone");
		var maddr = document.getElementById("maddr");
		var memailSelect = document.getElementById("memailSelect");
		mpwd.disabled=true;
		mname.disabled=true;
		memail1.disabled=true;
		memail2.disabled=true;
		mphone.disabled=true;
		maddr.disabled=true;
		memailSelect.disabled=true;
		
		var updateClick = document.getElementById("updateClick");
		var updateMember = document.getElementById("updateMember");
		var updateCancel = document.getElementById("updateCancel");
		updateClick.style.display="block";
		updateMember.style.display="none";
		updateCancel.style.display="none";
	}

</script>
<link rel="stylesheet" href="../resources/CSS/findMember.css">
<title>마이페이지</title>
</head>
<body>
<div>
	<jsp:include page="../nav.jsp"/>
		<div class="container-fluid p-3 pt-4 bg-light text-dark pb-5">
		<div class="wrap-container d-flex justify-content-between">
			<c:choose>
				<c:when test="${!empty memVO }">
					<!-- 회원 로그인 -->
					<div class="left me-4" style="width: 20%;">
						<!-- 왼쪽 회원 서비스 -->
						<div class="leftwrap-container">
		                  <div class="mypgleft-box">
		                     <div class="mypgservice-box">
		                        <div class="mypgservice form-control">
		                           마이페이지
		                        </div>
		                        <div class="card mypg-service-box mt-2">
		                        	<ul class="list-group list-group-flush">
									    <li class="list-group-item al-mypgform active"><a class="qna-alink" href="<%=contextPath%>/member/findMember.do?action=member">회원정보 수정</a></li>
									    <li class="list-group-item al-myrsvlistform"><a class="qna-alink" href="<%=contextPath%>/reservation/getlistMyReservations.do?action=mypage">나의 예약 내역</a></li>
									    <li class="list-group-item al-mflistform"><a class="qna-alink" href="<%=contextPath%>/member/listFamilyMembers.do">가족 조회</a></li>
									    <li class="list-group-item al-mfinsertform"><a class="qna-alink" href="<%=contextPath%>/member/FamFormMember.do">가족 추가</a></li>
								   		<li class="list-group-item al-mfrsvlistform"><a class="qna-alink" href="<%=contextPath%>/reservation/getlistFamReservations.do">가족 예약 내역</a></li>
								   </ul>    
		                        </div>
		                     </div>
		                  </div>
		               </div>
					</div>
					<!-- 오른쪽 -->
					<div class="right ms-4" style="width: 80%;" >
						<h3 class="border-bottom border-2 border-secondary-subtle text-start pb-3 mt-4 pt-5 mb-0"><strong>마이페이지</strong></h3>
						<div class="right-box mt-4 mb-4">
							<main class="form-sign mt-4" style="display:block;">
								<form action="<%=contextPath%>/member/updateMember.do?action=member" method="post">
									<div class="m-auto">
										<!-- 아이디  -->
										<div class="mb-3" style="width:100%;">
											<label for="mid" class="subtitle-label form-label" style="width:100%;">아이디</label>
											<input type="text" class="form-control" name="mid" value="${memVO.mid }" disabled style="width:150px;">
										</div>
										<!-- 비밀번호 -->
										<div class="mb-3" style="width:100%;">
											<label for="mpwd" class="form-label">비밀번호</label>
											<input type="password" class="form-control" id="mpwd" name="mpwd" value="${memVO.mpwd }" disabled style="width:150px;">
										</div>
										<!-- 이름 -->
										<div class="mb-3" style="width:100%;">
											<label for="mname" class="form-label">이름</label>
											<input type="text" class="form-control" placeholder="이름" id="mname" name="mname" value="${memVO.mname }" disabled style="width:150px;">
										</div>
										<!-- 생년월일 -->
										<div class="mb-3" style="width:100%;">
											<label for="mbirth1" class="subtitle-label form-label" style="width:100%;">생년월일</label>
											<div class="birthinput-box" style="display:flex;">
												<input type="text" class="form-control me-2" id="rbirth1" name="mbirth1" value="${memVO.mbirth1}" disabled style="width:150px;">
												-
												<input type="text" class="form-control ms-2 me-2" name="mbirth1" value="${memVO.mbirth2}" disabled style="width:35px;">
												<div class="col-auto lh-lg">●●●●●●</div>
											</div>
										</div>
										<!-- 이메일 -->
										<div class="mb-3" style="width:100%;">
											<label for="memail1" class="subtitle-label form-label" style="width:100%;">이메일</label>
											<div class="birthinput-box" style="display:flex;">
												<input type="text" class="form-control me-2" id="memail1" name="memail1" value="${memVO.memail1}" disabled style="width:150px;">
												<div class="col-auto lh-lg">@</div>
												<input type="text" class="form-control ms-2 me-2" id="memail2" name="memail2" value="${memVO.memail2}" disabled style="width:150px;">
												<div class="col-auto">
												 	<label class="visually-hidden" for="memailSelect">Preference</label>
												    <select class="form-select" id="memailSelect" onchange="inputemail();" disabled>
												    	<option selected value="">직접 입력</option>
												    	<option id="naver.com" value="naver.com">naver.com</option>
												    	<option id="gmail.com" value="gmail.com">gmail.com</option>
												    	<option id="daum.com" value="daum.com">daum.net</option>
												    </select>
												 </div>
											</div>
										</div>
										<!-- 휴대폰 번호 -->
										<div class="mb-3" style="width:100%;">
											<label for="mphone" class="form-label">휴대폰번호</label>
											<div class="col-1">
												<input type="text" class="form-control" id="mphone" name="mphone" value="${memVO.mphone }" style="width:150px;" disabled>
											</div>
										</div>
										<!-- 주소 -->
										<div class="mb-3" style="width:100%;">
											<div class="col-4">
												<label for="maddr" class="form-label">주소</label>
												<input type="text" class="form-control" id="maddr" name="maddr" placeholder="1234 Main St" value="${memVO.maddr }" disabled>
											</div>
										</div>
										<!-- 버튼 -->
										<div class="mb-3" style="width:100%;">
											<button type="button" class="btn btn-primary" id="updateClick" onClick="fn_updateMember()" style="display:block;">수정하기</button>
											<div class="mb-3 d-flex" style="width:100%;">
												<button type="submit" class="btn btn-primary me-2" id="updateMember" style="display:none;">수정반영하기</button>
												<button type="button" class="btn btn-primary" id="updateCancel" oncLick="fn_updateCancel()" style="display:none;">취소</button>
											</div>
										</div>
									</div>
								</form>
								
							</main>
						</div>				
					</div>
				</c:when>
				

				<c:when test="${!empty adVO}">
					<!-- 관리자 로그인 -->
					<div class="left me-4" style="width: 20%;">
						<!-- 왼쪽 회원 서비스 -->
						<div class="leftwrap-container">
		                  <div class="mypgleft-box">
		                     <div class="mypgservice-box">
		                        <div class="mypgservice form-control">
		                           관리자 페이지
		                        </div>
		                        <div class="card mypg-service-box mt-2">
		                        	<ul class="list-group list-group-flush">
									    <li class="list-group-item al-mypgform active"><a class="qna-alink" href="<%=contextPath%>/member/findMember.do?action=admin">회원정보 수정</a></li>
									    <li class="list-group-item al-myrsvlistform"><a class="qna-alink" href="<%=contextPath%>/reservation/getlistReservations.do?action=adpage">회원 예약 내역</a></li>
								   </ul>    
		                        </div>
		                     </div>
		                  </div>
		               </div>
					</div>
					<div class="right ms-4" style="width: 80%;" >
						<h3 class="border-bottom border-2 border-secondary-subtle text-start pb-3 mt-4 pt-5 mb-0"><strong>관리자 페이지</strong></h3>
						<div class="right-box mt-4 mb-4">
							<main class="form-sign mt-4" style="display:block;">
								<form action="<%=contextPath%>/member/updateMember.do?action=admin" method="post">
									<div class="m-auto">
										<!-- 아이디  -->
										<div class="mb-3" style="width:100%;">
											<label for="adminid" class="subtitle-label form-label" style="width:100%;">아이디</label>
											<input type="text" class="form-control" id="adminid" name="adminid" value="${adVO.adid}" disabled style="width:150px;">
										</div>
										
										<!-- 비밀번호 -->
										<div class="mb-3" style="width:100%;">
											<label for="adpwd" class="subtitle-label form-label" style="width:100%;">비밀번호</label>
											<input type="password" class="form-control" id="adpwd" name="adpwd" value="${adVO.adpwd }" disabled style="width:150px;">
										</div>
										
										<!-- 이름 -->
										<div class="mb-3" style="width:100%;">
											<label for="adname" class="subtitle-label form-label" style="width:100%;">이름</label>
											<input type="text" class="form-control" id="adname" name="adname" value="${adVO.adname}" disabled style="width:150px;">
										</div>
										
										<!-- 생년월일 -->
										<div class="mb-3" style="width:100%;">
											<label for="adminbirth" class="subtitle-label form-label" style="width:100%;">생년월일</label>
											<div class="birthinput-box" style="display:flex;">
												<input type="text" class="form-control me-2" id="rbirth1" name="mbirth1" value="${adVO.adbirth}" disabled style="width:150px;">
												-
												<div class="col-auto lh-lg ms-2">●●●●●●●</div>
											</div>
										</div>
									</div>
									<div style="display:flex;">
										<button type="button" class="btn btn-primary" id="adupdateBtn" onClick="fn_updateAdmin()" style="display:block;">수정하기</button>
										<div class="adbtn-box" style="display:flex;">
											<button type="submit" class="btn btn-primary me-2" id="updateAdmin" style="display:none;">수정반영하기</button>
											<button type="button" class="btn btn-primary" id="adupdateCancel" onClick="fn_adupdateCancel()" style="display:none;">취소</button>
										</div>
										
									</div>
								</form>
							</main>
						</div>
					</div>	
				</c:when>
			</c:choose>
		</div>
	</div>
	
	
	<jsp:include page="../footer.jsp"/>
</div>
</body>
</html>