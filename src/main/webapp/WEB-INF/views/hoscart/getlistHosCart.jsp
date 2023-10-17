<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String contextPath = request.getContextPath(); %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.min.js" integrity="sha384-Rx+T1VzGupg4BHQYs2gCW9It+akI2MM/mndMCy36UVfodzcJcF0GGLxZIzObiEfa" crossorigin="anonymous"></script>
<link rel="stylesheet" href="../resources/CSS/reservationForm.css">
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
	
	var memlist = document.getElementById("memlist");
	var adlist = document.getElementById("adlist");
	var hoslist = document.getElementById("hoslist");
	
	if((isLogin=="true"&&isAdminLogin=="false")||(isLogin=="true"&&isAdminLogin.length==0)){

		member_menu.style.display="block";
		admin_menu.style.display="none";
		memlist.style.display="block";
		adlist.style.display="none";
		hoslist.style.display="none";
	}
	else if((isAdminLogin=="true"&&isLogin=="false")||(isAdminLogin=="true"&&isLogin.length==0)){

		member_menu.style.display="none";
		admin_menu.style.display="block";
		memlist.style.display="none";
		adlist.style.display="block";
		hoslist.style.display="block";
	}
	else{
		member_menu.style.display="block";
		admin_menu.style.display="none";
	}
	
	//관리자가 로그인했을 때
	var step1 = document.getElementById("step1");
	var step2 = document.getElementById("step2");
	var step2_preBtn = document.getElementById("step2_preBtn");
	if(isAdminLogin=="true"){
		step1.style.display="none";
		step2.style.display="block";
		step2_preBtn.style.display="none";
	}

}
</script>
</head>
<body>
	<jsp:include page="../nav.jsp"/>
	<div class="container-fluid p-3 pt-4 bg-light text-dark pb-5">
		<div class="wrap-container d-flex justify-content-between">
			<!-- 왼쪽 -->
			<div class="left me-4" style="width: 20%;">
				<!-- 왼쪽 회원 서비스 -->
				<div class="hosform-leftwrap-container">
					<div class="hosleft-box">
						<div class="hosservice-box">
							<div class="hosservice form-control">
	                           예방접종 관리
	                        </div>
	                        <div class="card hos-service-box mt-2">
			                  	<ul class="list-group list-group-flush">
								    <li class="list-group-item a-mvcinsertform"><a class="vcc-alink" href="${contextPath}/reservation/getreservationForm.do">예방접종 예약</a></li>
								    <li class="list-group-item a-mvclistform" id="memlist"><a class="vcc-alink" href="${contextPath}/reservation/getlistMyReservations.do">예방접종 예약 관리</a></li>
								    <li class="list-group-item a-mvclistform" id="adlist"><a class="vcc-alink" href="${contextPath}/reservation/getlistReservations.do">예방접종 예약 관리</a></li>
								    <li class="list-group-item a-hopitalform"><a class="vcc-alink" href="${contextPath}/hospital/getlistHospital.do">지정 의료기관 찾기</a></li>
							   		<li class="list-group-item a-hopitalform" id="hoslist"><a class="vcc-alink" href="${contextPath}/hospital/gethospitalForm.do">지정 의료기관 관리</a></li>
							   </ul>
		                   </div>
                        </div>
                    </div>
                </div>
			</div>
			<!-- 오른쪽 -->
			<div class="right ms-4" style="width: 80%;" >
				<div id="step1">
					<h3 class="border-bottom border-2 border-secondary-subtle pb-3 mt-4 pt-5 mb-0"><strong>본인 인증</strong></h3>
					<div class="right-box mt-4 mb-4" >
						<div class="m-auto mt-3 m-0">
							<table class="table">
								<thead>
									<tr>
										<th scope="col">병원 이름</th>
										<th scope="col">백신 이름</th>
										<th scope="col">예약하기</th>
										<th scope="col">삭제하기</th>
									</tr>
								</thead>
								<tbody>
									<c:choose>
										<c:when test="${!empty memVO }">
											<c:choose>
												<c:when test="${!empty hoscartList}">
													<c:forEach var="hoscart" items="${hoscartList }">
														<tr>
															<td>${hoscart.hchosname }</td>
															<td>${hoscart.hcvccname }</td>
															<td><a href="<%=contextPath%>/reservation/getreservationForm.do?hcno=${hoscart.hcno}&hosname=${hoscart.hchosname }&vccname=${hoscart.hcvccname }&hos_no=${hoscart.hchosno}">예약</a></td>
															<td><a href="<%=contextPath%>/hoscart/deleteMyHosCart.do?hcno=${hoscart.hcno}">삭제</a></td>
														</tr>
													</c:forEach>
												</c:when>
												<c:when test="${empty hoscartList }">
													
												</c:when>
											</c:choose>
										</c:when>
										<c:when test="${empty memVO }">
											<tr>
												<td colspan="4">장바구니가 비었습니다.</td>
											</tr>
										</c:when>
									</c:choose>
								</tbody>
							</table>
						</div>
					</div>	
				</div>

			</div>
		</div>
	</div>
	<jsp:include page="../footer.jsp"/>

</body>
</html>