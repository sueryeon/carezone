<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
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
<script src="https://kit.fontawesome.com/d6d515867a.js" crossorigin="anonymous"></script>
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

//병원 도시리스트가져오는 메서드 여기서부터
function stateList(){
		
		var selectState=document.getElementById("state").value;
		var selectCity=document.getElementById("city");
		
		if(selectState===""){
			selectCity.innerHTML = "<option value=''>시/군/구</option>";
		}
		else{
			
			$.ajax({
				type:"post",
				url:"${contextPath}/hospital/selectstate.do",
				async:"true",
				data:{'state':selectState},
				success:function(data,textStatus){
					
					selectCity.innerHTML = "<option value=''>시/군/구</option>";
					var state=JSON.parse(data);
					var cities=state[selectState];
					
					for(var i=0; i<cities.length; i++){
						
						var key=cities[i];
						var value=cities[i];
						var option = document.createElement("option");
	                    option.value = key;
	                    option.text = value;
	                    selectCity.appendChild(option);
	                    
	                    //console.log(key+" : "+value);
					}
				},
				error:function(data,textStatus){
					
				},
				complete:function(data,textStatus){
					
				}
			});
		}
	}
	
	function cityList(){
		var selectCity=document.getElementById("city").value;
		var selectFullCity=document.getElementById("fullcity");
		
		if(selectCity===""){
			selectFullCity.innerHTML = "<option value=''>읍/면/동</option>";
		}
		else{
			
			$.ajax({
				type:"post",
				url:"${contextPath}/hospital/selectcity.do",
				async:"true",
				data:{'city':selectCity},
				success:function(data,textStatus){
					
					selectFullCity.innerHTML = "<option value=''>읍/면/동</option>";
					//console.log(data);
					var city=JSON.parse(data);
					var fullcities=city[selectCity];
	
					for(var i=0; i<fullcities.length; i++){
						
						var key=fullcities[i];
						var value=fullcities[i];
						var option = document.createElement("option");
	                    option.value = key;
	                    option.text = value;
	                    selectFullCity.appendChild(option);
					}
				},
				error:function(data,textStatus){
					
				},
				complete:function(data,textStatus){
					
				}
			});
		}
	}
//여기까지

//병원 검색 메서드 여기서부터
	function fn_search(_pagenum){
		
		var originalState=document.getElementById("state").value;
		var originalCity=document.getElementById("city").value;
		var originalFullcity=document.getElementById("fullcity").value;
		var originalVccname=document.getElementById("vccname").value;
		var pagenum=_pagenum;
		
		$.ajax({
	        type:"POST",
	        url:"${contextPath}/hospital/searchHospital.do",
	        data: {
	        	
	            state: originalState,
	            city: originalCity,
	            fullcity: originalFullcity,
	            vccname: originalVccname,
	            pagenum:pagenum
	            
	        },
	        success: function (data, textStatus) {
	        	
	        	$('#state').val(originalState);
	        	$('#city').val(originalCity);
	        	$('#fullcity').val(originalFullcity);
	        	$('#vccname').val(originalVccname);
				
	        	fn_afterSearch(data,originalVccname);
	
	        },
	        error: function (data, textStatus) {
	            console.error("오류 발생: " + textStatus);
	        }
	    });
	}

	function fn_afterSearch(data,originalVccname) {
		
		var originalVccname=document.getElementById("vccname").value;
		var result="";
		var pageresult="";
		var totalArticles=data.totalArticles;
		var list=data.hospitalList;
		
		console.log(list);
		if(list.length!==0){
			
			for(var i=0; i<data.hospitalList.length; i++){
				var VO=list[i];
				console.log(VO);
				result += '<tr class="findtr"><td class="hosname">'+VO.hosname+'</td>';
				result += '<td>'+VO.hoscall+'</td>';
				result += '<td>'+VO.hosaddr+'</td>';
				
				if(VO.vccquantity===0||VO.vccquantity==="0"){
					
					result += '<td>예약불가능</td>';
					result += "<td><input type='radio' name='radio' disabled>";
					result += '</td></tr>';
				}
				else if(VO.vccquantity>0){
					result += '<td>예약가능</td>';
					result += "<td><input type='hidden' name='hos_no' class='findhidden' value="+VO.hosno+"><input type='radio' name='radio'>";
					result += '</td></tr>';
					
				}	
			}
			
			result+="<tr><td colspan=6 id='pagebody'></td></tr>";
			$("#tbody").html(result);
		}
		else{
			result+="<tr><td colspan=6 >조회된 결과가 없습니다.</td></tr>";
				$("#tbody").html(result);
		}
		
		if(totalArticles>100){
			console.log("totalArticles : "+totalArticles);
			for(var i=1; i<11; i++){
				
				if(data.pagesize>1&&i==1){
					pageresult+= "<a class='no_uline ms-2 me-2' href='#' onClick='fn_search("+(((data.pagesize-1)*10)+1)+")'>&nbsp; pre</a>";
				}
				pageresult+="<a class='no_uline ms-2 me-2' href='#' onClick='fn_search("+i+")'>"+i+"</a>";
				if(i==10){
					pageresult+="<a class='no_uline ms-2 me-2' href='#' onClick='fn_search("+((data.pagesize*10)+1)+")'>&nbsp; next</a>";
				}
			}
			console.log("pageresult : "+pageresult);
			
			$("#pagebody").html(pageresult);
		}
		else if(totalArticles==100){
			for(var i=1; i<11; i++){
				pageresult+="<a class='no_uline ms-2 me-2' href='#'>"+i+"</a>";
			}
			
			$("#pagebody").html(pageresult);
		}
		else if(totalArticles<100){
			for(var i=1; i<((totalArticles/10)+1); i++){
				if(i==data.pagenum){
					pageresult+="<a class='no_uline ms-2 me-2' href='#' onClick='fn_search("+i+")'>"+i+"</a>";
				}
				else{
					pageresult+="<a class='no_uline ms-2 me-2' href='#' onClick='fn_search("+i+")'>"+i+"</a>";
					
				}
			}
			console.log(pageresult);
			$("#pagebody").html(pageresult);
		}
		
		
	}
//병원 검색 여기까지

//선택된 병원 필드창에 넣기
function fn_filed_fill(obj){
		var choose_hospital = document.querySelector('input[type="radio"]:checked'); //체크된 라디오박스 셀렉
		var hosname="";
		var hosno="";
		var vccname=document.getElementById("vccname").value;
		

	        if (choose_hospital) {
	            // 선택된 라디오 버튼 앞의 텍스트를 가져옵니다.
	            var trElement = choose_hospital.closest('.findtr'); //가까이있는 클래스 셀렉 
	            var hiddenInput = trElement.querySelector('.findhidden');//그 중에서 또셀렉 
	            
	            
	            if (hiddenInput) {
	                hosno = hiddenInput.value;
	                console.log("가져온데이터"+hosno);
	            }
	            
	            if (trElement) {
	                var hosnameElement = trElement.querySelector('.hosname'); //티알 셀렉된거중에서 병원이름 클래스셀렉 
	                
	                if (hosnameElement) {
	                    hosname = hosnameElement.textContent.trim();
	                }
	            }
	        }
		var rhospital=document.getElementById("rhospital");
		var rvcc=document.getElementById("rvcc");
		var hos__no1=document.getElementById("hos__no1");

		
		rhospital.value=hosname;
		rvcc.value=vccname;
		hos__no1.value=hosno;
		
		var closeModalButton = document.querySelector('[data-bs-dismiss="modal"]'); //모달창 닫기 
	    if (closeModalButton) {
	        closeModalButton.click();
	    }
	}
//필드창 채우기 여기까지

//날짜 필드 Null check
function fn_reservation_submit(obj){
	var date=document.getElementById("rdate").val;
	
	if(!date){
		alert("날짜를 입력해주세요.");
	}
	else{
		obj.submit();
	}
}
//날짜 필드 여기까지 

</script>
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
					<h3 class="border-bottom border-2 border-secondary-subtle pb-3 mt-4 pt-5 mb-0"><strong>예약 수정하기</strong></h3>
					<div class="right-box mt-4 mb-4" >
						<form action="<%=request.getContextPath()%>/reservation/updateReservation.do?rno=${rsvVO.rno}" method="post">
							<div class="m-auto">
							<c:choose>
								<c:when test="${empty rsvVO.rsubname}">
									<!-- 이름 -->
									<div class="mb-3" style="width:100%;">
										<label for="rname" class="subtitle-label form-label" style="width:100%;">이름</label>
										<input type="text" class="name-input form-control" id="rname" name="rname" value="${rsvVO.rname}" disabled style="width:150px;">	
									</div>
									<!-- 생년월일 -->
									<div class="mb-3" style="width:100%;">
										<label for="rbirth1" class="subtitle-label form-label" style="width:100%;">생년월일</label>
										<input type="text" class="form-control me-2" id="rbirth1" name="rbirth1" value="${rsvVO.rbirth1}" disabled style="width:150px;">
									</div>
									<!-- 휴대폰 번호 -->
									<div class="mb-3" style="width:100%;">
										<label for="rphone" class="subtitle-label form-label" style="width:100%;">전화번호</label>
										<input type="text" class="name-input form-control" id="rphone" name="rphone" value="${rsvVO.rphone}" disabled style="width:150px;">	
									</div>
								</c:when>
								<c:otherwise>
									<!-- 이름 -->
									<div class="mb-3" style="width:100%;">
										<label for="rname" class="subtitle-label form-label" style="width:100%;">이름</label>
										<input type="text" class="name-input form-control" id="rsubname" name="rsubname" value="${rsvVO.rsubname}" disabled style="width:150px;">	
									</div>
									<!-- 생년월일 -->
									<div class="mb-3" style="width:100%;">
										<label for="rbirth1" class="subtitle-label form-label" style="width:100%;">생년월일</label>
										<input type="text" class="form-control me-2" id="rsubbirth1" name="rsubbirth1" value="${rsvVO.rsubbirth1}" disabled style="width:150px;">
									</div>
									<!-- 휴대폰 번호 -->
									<div class="mb-3" style="width:100%;">
										<label for="rphone" class="subtitle-label form-label" style="width:100%;">전화번호</label>
										<input type="text" class="name-input form-control" id="rsubphone" name="rsubphone" value="${rsvVO.rsubphone}" disabled style="width:150px;">	
									</div>
								</c:otherwise>
							</c:choose>
							<div class="d-flex">
								<!-- 병원 이름 -->
								<div class="mb-3" style="width:35%;">
									<label for="rhospital" class="subtitle-label form-label" style="width:100%;">예약병원</label>
									<input type="hidden" name="hos__no" id="hos__no1" value=""/> 
									<input type="text" class="name-input form-control" id="rhospital" name="rhospital" value="${rsvVO.rhospital}" style="width:208px;" readonly>	
								</div>
								<!-- 백신 이름 -->
								<div class="mb-3" style="width:35%;">
									<label for="rvcc" class="subtitle-label form-label" style="width:100%;">예약백신</label>
									<input type="text" class="name-input form-control" id="rvcc" name="rvcc" value="${rsvVO.rvcc}" style="width:208px;" readonly>	
								</div>
								<div style="width:30%;">
									<!-- Button trigger modal -->
									<label for="search" class="subtitle-label form-label" style="width:100%;">검색</label>
									<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">
									  <i class="fa-solid fa-magnifying-glass"></i>
									</button>
									
									<!-- Modal -->
									<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
									  <div class="modal-dialog modal-dialog-scrollable modal-dialog-centered modal-lg">
									    <div class="modal-content">
									      <div class="modal-header">
									        <h1 class="modal-title fs-5" id="exampleModalLabel">예약된 병원 및 백신 수정하기</h1>
									        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
									      </div>
									      <div class="modal-body">
									        <h3 class="border-bottom border-2 border-secondary-subtle pb-3 pt-3 mb-0"><strong>지정 의료기관 찾기</strong></h3>
											<form action="${contextPath}/hospital/searchHospital.do">
												<table class="table">
												  <tbody>
												    <tr>
												      <th colspan=1 scope="row">지역</th>
												      <td conlspan=5 class="d-flex">
													      <select class="form-select form-select-sm me-4" style="width: 25%;" aria-label="Small select example" name="state" id="state" title="시/도를 선택하세요." onchange="stateList()">
																<option value="" selected disabled>시/도</option>
																<option value="서울특별시">서울특별시</option>
																<option value="부산광역시">부산광역시</option>
																<option value="대구광역시">대구광역시</option>
																<option value="인천광역시">인천광역시</option>
																<option value="광주광역시">광주광역시</option>
																<option value="대전광역시">대전광역시</option>
																<option value="울산광역시">울산광역시</option>
																<option value="세종특별자치시">세종특별자치시</option>
																<option value="경기도">경기도</option>
																<option value="충청북도">충청북도</option>
																<option value="충청남도">충청남도</option>
																<option value="전라북도">전라북도</option>
																<option value="전라남도">전라남도</option>
																<option value="경상북도">경상북도</option>
																<option value="경상남도">경상남도</option>
																<option value="제주특별자치도">제주특별자치도</option>
																<option value="강원특별자치도">강원특별자치도</option>
															</select>
															<select	class="form-select form-select-sm me-4" style="width: 25%;" aria-label="Small select example" name="city" id="city" title="시/군/구를 선택하세요." onchange="cityList()">
																<option value=''>시/군/구</option>
															</select>
															<select	class="form-select form-select-sm" style="width: 25%;" aria-label="Small select example" name="fullcity" id="fullcity" title="시/군/구를 선택하세요.">
																<option value=''>읍/면/동</option>
															</select>
												      </td>
												    </tr>
												    <tr>
												      <th colspan=1 scope="row">백신</th>
												      <td colspan=5 class="d-flex">
													      <select class="form-select form-select-sm me-4" style="width: 70%;" aria-label="Small select example" name="vccname" id="vccname">
																<option value="">접종가능 백신을 선택하세요.</option>
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
															</select>
															<input type="button" class="btn btn-primary"  id="btn_search" onClick="fn_search(1)" value="검색">
												      </td>
												    </tr>
												  </tbody>
												</table>
												<div class="text-center">
													<table class="table">
														<thead>
															<tr>
																<th class="col-sm-2.5" scope="col">병/의원명</th>
																<th class="col-sm-1.5" scope="col">전화번호</th>
																<th class="col-sm-5" scope="col">주소</th>
																<th class="col-sm-1.5" scope="col">예약가능여부</th>
																<th class="col-sm-1" scope="col">선택</th>
															</tr>
														</thead>
														<tbody id="tbody">
															<tr>
																<td colspan=6 >원하시는 지역을 선택 후 검색하시면 결과를 확인하실 수 있습니다.</td>
															</tr>
															<tr>
																<td colspan="6" id="pagebody">
																</td>
															</tr>
														</tbody>
													</table>
												</div>
											</form>
									      </div>
									      <div class="modal-footer">
									        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
									        <button type="button" class="btn btn-primary" onClick="fn_filed_fill()">병원 및 백신 수정하기</button>
									      </div>
									    </div>
									  </div>
									</div>
								</div>
							</div>
								<!-- 예약 날짜 -->
								<div class="mb-3" style="width:100%;">
									<label for="rdate" class="subtitle-label form-label" style="width:100%;">예약날짜</label>
									<input type="date" class="name-input form-control" id="rdate" name="rdate" style="width:208px;" required>	
								</div>
							</div>
							<div class="d-flex justify-content-center mt-4">
								<button type="button" class="btn btn-primary me-4" onClick="fn_step3_pre()">취소</button>
								<button type="submit" class="btn btn-primary">수정하기</button>
							</div>
						</form>			
	           		</div>
	         	</div>
			</div>
		</div>
	</div>  
	<jsp:include page="../footer.jsp"/>
</body>
</html>