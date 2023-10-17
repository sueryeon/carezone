<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.min.js" integrity="sha384-Rx+T1VzGupg4BHQYs2gCW9It+akI2MM/mndMCy36UVfodzcJcF0GGLxZIzObiEfa" crossorigin="anonymous"></script>

<link rel="stylesheet" href="../resources/CSS/reservationForm.css">
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
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
								    <li class="list-group-item a-hopitalform active" id="hoslist"><a class="vcc-alink" href="${contextPath}/hospital/gethospitalForm.do">지정 의료기관 관리</a></li>
							   </ul>
		                   </div>
                        </div>
                    </div>
                </div>
			</div>
						<!-- 오른쪽 -->
			<div class="right ms-4" style="width: 80%;" >
				<div id="step1">
					<h3 class="border-bottom border-2 border-secondary-subtle pb-3 mt-4 pt-5 mb-0"><strong>지정 의료기관 관리</strong></h3>
					<div class="right-box mt-4 mb-4" >
						<div class="m-auto mt-3 m-0">
							<form action="${contextPath}/hospital/insertHospital.do" method="post" enctype="multipart/form-data">
								<select name="vccname" class="form-select form-select-sm me-4">
									<option value="1" selected disabled>접종가능 백신을 선택하세요.</option>
									<option value="결핵(BCG,피내용)"/>결핵(BCG,피내용)</option>
									<option value="B형간염(HepB)">B형간염(HepB)</option>
									<option value="디프테리아/파상풍/백일해(DTaP)">디프테리아/파상풍/백일해(DTaP)</option>
									<option value="디프테리아/파상풍/백일해/폴리오(DTaP-IPV)">디프테리아/파상풍/백일해/폴리오(DTaP-IPV)</option>
									<option value="디프테리아/파상풍/백일해/폴리오/Hib(DTaP-IPV/Hib)">디프테리아/파상풍/백일해/폴리오/Hib(DTaP-IPV/Hib)</option>
									<option value="파상풍/디프테리아/백일해(Tdap)">파상풍/디프테리아/백일해(Tdap)</option>
									<option value="파상풍/디프테리아(Td)">파상풍/디프테리아(Td)</option>
									<option value="폴리오(IPV)">폴리오(IPV)</option>
									<option value="b형헤모필루스인플루엔자">b형헤모필루스인플루엔자</option>
									<option value="페렴구균(PCV 10가)">페렴구균(PCV 10가)</option>
									<option value="페렴구균(PCV 13가)">페렴구균(PCV 13가)</option>
									<option value="페렴구균(PPSV 23가)">페렴구균(PPSV 23가)</option>
									<option value="로타바이러스(로타릭스)">로타바이러스(로타릭스)</option>
									<option value="로타바이러스(로타텍)">로타바이러스(로타텍)</option>
									<option value="홍역/유행성이하선염/풍진(MMR)">홍역/유행성이하선염/풍진(MMR)</option>
									<option value="수두(VAR)">수두(VAR)</option>
									<option value="A형간염(HepA)">A형간염(HepA)</option>
									<option value="일본뇌염(불활성화 백신,베로세포 유래)">일본뇌염(불활성화 백신,베로세포 유래)</option>
									<option value="일본뇌염(약독화 생백신,씨디제박스)">일본뇌염(약독화 생백신,씨디제박스)</option>
								</select><br>
								<!-- 병원 엑셀파일 : <input type="file" name="hosFile"><br>-->
								<div class="mb-3">
									<label for="formFileSm" class="form-label">병원 엑셀파일</label>
									<input class="form-control form-control-sm" id="formFileSm" type="file" name="hosFile">
								</div>
								<input type="submit" value="올리기" class="btn btn-primary"><br>
							</form>
						</div>
					</div>
				</div>
				
			</div>
		</div>
	</div>
	<jsp:include page="../footer.jsp"/>
</body>
</html>