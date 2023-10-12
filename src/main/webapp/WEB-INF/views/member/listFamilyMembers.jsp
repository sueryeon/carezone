<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String contextPath = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가족 조회</title>
<!--<c:set var="familyList" value="${familyList }"></c:set>-->
<link rel="stylesheet" href="../resources/CSS/findMember.css">
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
				<h3 class="border-bottom border-2 border-secondary-subtle text-start pb-3 mt-4 pt-5 mb-0"><strong>마이페이지</strong></h3>
				<div class="right-box mt-4 mb-4">
					<c:choose>
					    <c:when test="${!empty familyList}">
					        <c:forEach var="family" items="${familyList}">
					            <!-- <div class="card" style="width: 28rem;"> -->
					            <div class="card mb-4" style="width: 48%; float: left; margin-right: 2%;">
					                <div class="card-body" style="height:200px;">
					                    <h5 class="card-title">${family.fname} 님</h5>
					                    <h6 class="card-subtitle mb-2 text-body-secondary">생년월일 : ${family.fbirth1 }</h6>
					                    <h6 class="card-subtitle mb-2 text-body-secondary">전화번호 : ${family.fphone }</h6>
					                    <h6 class="card-subtitle mb-2 text-body-secondary">주소</h6>
					                    <p class="card-text">${family.faddr }</p>
					                    <a href="<%=contextPath%>/member/findFamilyMember.do?fid=${family.fid}" class="card-link">수정하기</a>
					                    <a href="<%=contextPath%>/member/deleteFamilyMember.do?fid=${family.fid}&fno=${family.fno}" class="card-link">삭제하기</a>
					                </div>
					            </div>
					        </c:forEach>
					    </c:when>
					    <c:when test="${empty familyList}">
					        등록된 가족이 없습니다.
					    </c:when>
					</c:choose>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="../footer.jsp"/>
</body>
</html>