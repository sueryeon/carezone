<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약하기</title>
<c:set var="memVO" value="${memVO}"/>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.min.js" integrity="sha384-Rx+T1VzGupg4BHQYs2gCW9It+akI2MM/mndMCy36UVfodzcJcF0GGLxZIzObiEfa" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
	document.addEventListener('DOMContentLoaded', function() {
	    const mvcinsertform = document.querySelector('.a-mvcinsertform');
	    const mvclistform = document.querySelector('.a-mvclistform');
	    const fvcinsertform = document.querySelector('.a-fvcinsertform');
	    const fvclistform = document.querySelector('.a-fvclistform');
	    const hopitalform = document.querySelector('.a-hopitalform');
	
	    mvcinsertform.classList.add('active'); // 초기 링크를 활성화 상태로 표시
	    
	    hopitalform.addEventListener('click', function() {
	        hopitalform.classList.add('active'); //링크 활성화
	        mvcinsertform.classList.remove('active'); // 다른 링크 비활성화
	        mvclistform.classList.remove('active'); // 다른 링크 비활성화
	        fvcinsertform.classList.remove('active'); // 다른 링크 비활성화
	        fvclistform.classList.remove('active'); // 다른 링크 비활성화
	    });
	    
	    mvcinsertform.addEventListener('click', function() {
	    	mvcinsertform.classList.add('active'); //링크 활성화
	    	hopitalform.classList.remove('active'); // 다른 링크 비활성화
	        mvclistform.classList.remove('active'); // 다른 링크 비활성화
	        fvcinsertform.classList.remove('active'); // 다른 링크 비활성화
	        fvclistform.classList.remove('active'); // 다른 링크 비활성화
	    });
	    
	    mvclistform.addEventListener('click', function() {
	    	mvclistform.classList.add('active'); //링크 활성화
	    	hopitalform.classList.remove('active'); // 다른 링크 비활성화
	    	mvcinsertform.classList.remove('active'); // 다른 링크 비활성화
	        fvcinsertform.classList.remove('active'); // 다른 링크 비활성화
	        fvclistform.classList.remove('active'); // 다른 링크 비활성화
	    });
	    
	    fvcinsertform.addEventListener('click', function() {
	    	fvclistform.classList.add('active'); //링크 활성화
	        mvcinsertform.classList.remove('active'); // 다른 링크 비활성화
	        mvclistform.classList.remove('active'); // 다른 링크 비활성화
	        hopitalform.classList.remove('active'); // 다른 링크 비활성화
	        fvclistform.classList.remove('active'); // 다른 링크 비활성화
	    });
	    
	    fvclistform.addEventListener('click', function() {
	    	fvclistform.classList.add('active'); //링크 활성화
	        mvcinsertform.classList.remove('active'); // 다른 링크 비활성화
	        mvclistform.classList.remove('active'); // 다른 링크 비활성화
	        fvcinsertform.classList.remove('active'); // 다른 링크 비활성화
	        hopitalform.classList.remove('active'); // 다른 링크 비활성화
	    });
	});
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
								    <li class="list-group-item a-mvcinsertform active"><a class="vcc-alink" href="${contextPath}/reservation/getreservationForm.do">본인 예방접종 예약</a></li>
								    <li class="list-group-item a-mvclistform"><a class="vcc-alink" href="${contextPath}/reservation/getlistMyReservations.do">본인 예방접종 관리</a></li>
								    <li class="list-group-item a-fvcinsertform"><a class="vcc-alink" href="${contextPath}/reservation/getFamreservationForm.do">가족 예방접종 예약</a></li>
								    <li class="list-group-item a-fvclistform"><a class="vcc-alink" href="${contextPath}/reservation/getlistFamReservations.do">가족 예방접종 관리</a></li>
								    <li class="list-group-item a-hopitalform"><a class="vcc-alink" href="${contextPath}/hospital/getlistHospital.do">지정 의료기관 찾기</a></li>
							   </ul>
		                   </div>
                        </div>
                    </div>
                </div>
			</div>
			<!-- 오른쪽 -->
			<div class="right ms-4" style="width: 80%;" >
				<h3 class="border-bottom border-2 border-secondary-subtle pb-3 mt-4 pt-5 mb-0"><strong>본인 예방접종 예약</strong></h3>
				<div class="right-box mt-4 mb-4" >
					<main class="form-sign mt-4">
						<form action="<%=request.getContextPath()%>/reservation/insertReservation.do" method="post">
							<input type="hidden" name="hcno" value="${hcno }">
							<input type="hidden" name="hosno" value="${hosVO.hosno}">
							<input type="hidden" name="rname" value="${memVO.mname }">
							<input type="hidden" name="rbirth1" value="${memVO.mbirth1 }">
							<input type="hidden" name="rbirth2" value="${memVO.mbirth2 }">
							<input type="hidden" name="rphone" value="${memVO.mphone }">
							
							<div class="m-auto">
								<!-- 이름 -->
								<div class="mb-3" style="width:100%;">
									<label for="rname" class="subtitle-label form-label" style="width:100%;">이름</label>
									<input type="text" class="name-input form-control" id="rname" name="rname" value="${memVO.mname}" disabled style="width:150px;">	
								</div>
								<!-- 생년월일 -->
								<div class="mb-3" style="width:100%;">
									<label for="rbirth1" class="subtitle-label form-label" style="width:100%;">생년월일</label>
									<div class="birthinput-box" style="display:flex;">
										<input type="text" class="form-control me-2" id="rbirth1" name="rbirth1" value="${memVO.mbirth1}" disabled style="width:150px;">
										-
										<input type="text" class="form-control ms-2 me-2" name="rbirth2" value="${memVO.mbirth2}" disabled style="width:35px;">
										<div class="col-auto lh-lg">●●●●●●</div>
									</div>
								</div>
								<!-- 휴대폰 번호 -->
								<div class="mb-3" style="width:100%;">
									<label for="rphone" class="subtitle-label form-label" style="width:100%;">전화번호</label>
									<input type="text" class="name-input form-control" id="rphone" name="rphone" value="${memVO.mphone}" disabled style="width:150px;">	
								</div>
								<!-- 병원 이름 -->
								<div class="mb-3" style="width:100%;">
									<label for="rhospital" class="subtitle-label form-label" style="width:100%;">병원</label>
									<input type="text" class="name-input form-control" id="rhospital" name="rhospital" value="${hosVO.hosname}" style="width:208px;">	
								</div>
								<!-- 백신 이름 -->
								<div class="mb-3" style="width:100%;">
									<label for="rvcc" class="subtitle-label form-label" style="width:100%;">백신</label>
									<input type="text" class="name-input form-control" id="rvcc" name="rvcc" value="${hosVO.vccname}" style="width:208px;">	
								</div>
								
								<!-- 예약 날짜 -->
								<div class="mb-3" style="width:100%;">
									<label for="rdate" class="subtitle-label form-label" style="width:100%;">예약날짜</label>
									<input type="text" class="name-input form-control" id="rdate" name="rdate" style="width:208px;">	
								</div>
							</div>
							<div class="d-flex justify-content-center mt-4">
								<button type="submit" class="btn btn-primary">예약하기</button>
							</div>
						</form>
					</main>
				</div>
				
				
			</div>
		</div>
	</div>
	<jsp:include page="../footer.jsp"/>
</body>
</html>