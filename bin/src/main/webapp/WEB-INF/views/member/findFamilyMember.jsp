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
<link rel="stylesheet" href="../resources/CSS/findMember.css">
<title>가족 수정</title>
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

	function fn_famupdateCancel(){
		calcelUrl = "<%=contextPath%>/member/listFamilyMembers.do";
		window.location.href=calcelUrl;
	}
</script>
</head>
<body>
	<jsp:include page="../nav.jsp"/>
	<div class="container-fluid p-3 pt-4 bg-light text-dark pb-5">
		<div class="wrap-container d-flex justify-content-between">
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
							    <li class="list-group-item al-mypgform"><a class="qna-alink" href="<%=contextPath%>/member/findMember.do?action=member">회원정보 수정</a></li>
							    <li class="list-group-item al-myrsvlistform"><a class="qna-alink" href="<%=contextPath%>/reservation/getlistMyReservations.do?action=mypage">나의 예약 내역</a></li>
							    <li class="list-group-item al-mflistform active"><a class="qna-alink" href="<%=contextPath%>/member/listFamilyMembers.do">가족 조회</a></li>
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
				<h3 class="border-bottom border-2 border-secondary-subtle text-start pb-3 mt-4 pt-5 mb-0"><strong>가족 수정</strong></h3>
				<div class="right-box mt-4 mb-4">
					<form action="<%=contextPath%>/member/updateFamilyMember.do" method="post">
						<input type="hidden" name="fid" id="fid" value="${famVO.fid }">
						<input type="hidden" name="fno" id="fno" value="${famVO.fno}">
						<div class="mb-3">
							<label for="fname" class="form-label">이름</label>
							<input type="text" class="form-control" placeholder="이름" id="fname" name="fname" value="${famVO.fname }" style="width:245px;">
						</div>
						<div class="mb-3">
							<label for="fbirth1" class="form-label">생년월일</label>
							<input type="text" class="form-control" id="fbirth1" name="fbirth1" placeholder="ex)970807" value="${famVO.fbirth1}" disabled style="width:245px;">
						</div>
						<div class="mb-3">
							<label for="fphone" class="form-label">전화번호</label>
							<input type="text" class="form-control" id="fphone" name="fphone" value="${famVO.fphone }" style="width:245px;">

						</div>
						<div class="mb-4">
							<label for="faddr" class="form-label">주소</label>
							<input type="text" class="form-control" id="faddr" name="faddr" placeholder="1234 Main St" value="${famVO.faddr }" style="width:245px;">
						</div>
						<div class="famupdateBtn" style="display:flex;">
							<button type="submit" class="btn btn-primary me-2">수정하기</button>
							<button type="button" class="btn btn-primary" onClick="fn_famupdateCancel()">취소</button>
						</div>
						
					</form>					
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="../footer.jsp"/>
	
</body>
</html>