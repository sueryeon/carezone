<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%
	request.setCharacterEncoding("UTF-8");
	String contextPath=request.getContextPath();
%> 
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
<script src="http://code.jquery.com/jquery-latest.min.js"></script> 
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

}
</script>

<style>
   .black-link{
      color: black;
      text-decoration: none;
   }
   .black-link:hover{
      color: blue;
      text-decoration: underline;
   }
</style>
</head>
<body>
	<jsp:include page="../nav.jsp"/>
	<div id="join" class="container-fluid p-3 pt-4 bg-light text-dark pb-5">
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
		             	<table class="table">
							<tbody>
								<tr>
									<th scope="col">예약번호</th>
									<td>${rsvVO.rno}</td>
								</tr>
								<tr>
									<th scope="col">이름</th>
									<td>${rsvVO.rname}</td>
								</tr>
								<tr>
									<th scope="col">주민등록번호</th>
									<td>${rsvVO.rbirth1} - ${rsvVO.rbirth2}</td>
								</tr>
								<tr>
									<th scope="col">폰번호</th>
									<td>${rsvVO.rphone}</td>
								</tr>
								<tr>
									<th scope="col">예약병원</th>
									<td>${rsvVO.rhospital}</td>
								</tr>
								<tr>
									<th scope="col">예약백신</th>
									<td>${rsvVO.rvcc}</td>
								</tr>
							<tbody>
						</table>  
	           		 </div>
	         	</div>
			</div>
		</div>
	</div>  
	<jsp:include page="../footer.jsp"/>
</body>
</html>