<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">

//네비바js 여기서부터 
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
//네비바 js 여기까지

//지역검색 필드 가져오기 여기서부터
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

//지역검색 후 리스트 가져오기 
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
		var AdminLogin = "${isAdminLogin}";
		var originalVccname=document.getElementById("vccname").value;
		var result="";
		var pageresult="";
		var totalArticles=data.totalArticles;
		var list=data.hospitalList;
		
		console.log(list);
		if(list.length!==0){
			if(AdminLogin=="true"){
				for(var i=0; i<data.hospitalList.length; i++){
					var VO=list[i];
					console.log(VO);
					result += '<tr><td class="hosname">'+VO.hosname+'</td>';
					result += '<td>'+VO.hoscall+'</td>';
					result += '<td>'+VO.hosaddr+'</td>';
					
					if(VO.vccquantity===0||VO.vccquantity==="0"){
						
						result += '<td>예약불가능</td>';
						result += "<td><a href='#' onclick='fn_alert(); return false;'>";
						result += '예약</a></td>';
						//result += "<td><a href='#' onclick='fn_cart_alert(); return false;'>담기</a></td></tr>";
					}
					else if(VO.vccquantity>0){
						result += '<td>예약가능</td>';
						result += "<td><a href='${contextPath}/reservation/getreservationForm.do?hosname="+VO.hosname+"&vccname="+originalVccname+"&hosno="+VO.hosno+"'>";
						result += '예약</a></td>';
						//result += '<td><a href="#" onClick="fn_inserthosCart('+VO.hosno+','+VO.hosname+')">담기</a></td></tr>';
					}
					else if(VO.vccquantity===null){
						result += '<td>백신을 선택해주세요.</td>';
						result += "<td><a href='#' onclick='fn_alert()'; return false;>";
						result += '예약</a></td>';
					}
				}
			}
			else{
				for(var i=0; i<data.hospitalList.length; i++){
					var VO=list[i];
					console.log(VO);
					result += '<tr><td class="hosname">'+VO.hosname+'</td>';
					result += '<td>'+VO.hoscall+'</td>';
					result += '<td>'+VO.hosaddr+'</td>';
					
					if(VO.vccquantity===0||VO.vccquantity==="0"){
						
						result += '<td>예약불가능</td>';
						result += "<td><a href='#' onclick='fn_alert(); return false;'>";
						result += '예약</a></td>';
						result += "<td><a href='#' onclick='fn_cart_alert(); return false;'>담기</a></td></tr>";
					}
					else if(VO.vccquantity>0){
						result += '<td>예약가능</td>';
						result += "<td><a href='${contextPath}/reservation/getreservationForm.do?hosname="+VO.hosname+"&vccname="+originalVccname+"&hosno="+VO.hosno+"'>";
						result += '예약</a></td>';
						result += '<td><a href="#" onClick="fn_inserthosCart('+VO.hosno+', \''+VO.hosname+'\')">담기</a></td></tr>';
					}
					else if(VO.vccquantity===null){
						result += '<td>백신을 선택해주세요.</td>';
						result += "<td><a href='#' onclick='fn_alert()'; return false;>";
						result += '예약</a></td>';
					}
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
//병원검색 리스트 펼치기 여기까지 


	function fn_alert(){
		
		alert("예약이 불가능합니다.");
	}
	
	function fn_cart_alert(){
		alert("재고가 부족하여 담기가 불가능합니다.");
	}
	
	
	function fn_inserthosCart(hosno,hosname){
		
		console.log("왔다.");
		var action = "insertcart"
		var isLogin = "${isLogin}";
		var isAdminLogin = "${isAdminLogin}";
		if(isLogin.length==0||isLogin=="false"){
			console.log("비회원일 때");
			if(confirm("로그인 후 진행해 주세요")){
				var loginurl = "${contextPath}/member/loginForm.do?action=" + action;
	            window.location.href = loginurl;
			}
		}
		else{
			var hchosno = hosno;
			var hchosname = hosname;
			var hcvccname = document.getElementById("vccname").value;
			$.ajax({
				url:"${contextPath}/hoscart/inserthosCart.do",
				type:"post",
				data:{
					hchosno:hchosno,
					hchosname:hchosname,
					hcvccname:hcvccname
				},
				success:function(data,textStatus){
					alert('내 관심백신에 담겼습니다.');
					//location.reload();
					 var HcCount = document.getElementById("HcCount");
					 $.ajax({
							url:"${contextPath}/hoscart/countMyHosCart.do",
							type:"get",
							success:function(data,textStatus){
								var count = data;
								if(count != null){
									HcCount.style.display="block";
									HcCount.innerText = count;
								}
								else{
									HcCount.style.display="none";
								}
							},
							error:function(data,textStatus){},
							complete:function(data,textStatus){}
						});
				},
				error:function(data,textStatus){},
				complete:function(data,textStatus){}
			});	
		}
		
	}
	
	document.addEventListener('DOMContentLoaded', function() {
	    const mvcinsertform = document.querySelector('.a-mvcinsertform');
	    const mvclistform = document.querySelector('.a-mvclistform');
	    const hopitalform = document.querySelector('.a-hopitalform');
	
	    hopitalform.classList.add('active'); // 초기 링크를 활성화 상태로 표시
	    
	    hopitalform.addEventListener('click', function() {
	        hopitalform.classList.add('active'); //링크 활성화
	        mvcinsertform.classList.remove('active'); // 다른 링크 비활성화
	        mvclistform.classList.remove('active'); // 다른 링크 비활성화

	    });
	    
	    mvcinsertform.addEventListener('click', function() {
	    	mvcinsertform.classList.add('active'); //링크 활성화
	    	hopitalform.classList.remove('active'); // 다른 링크 비활성화
	        mvclistform.classList.remove('active'); // 다른 링크 비활성화

	    });
	    
	    mvclistform.addEventListener('click', function() {
	    	mvclistform.classList.add('active'); //링크 활성화
	    	hopitalform.classList.remove('active'); // 다른 링크 비활성화
	    	mvcinsertform.classList.remove('active'); // 다른 링크 비활성화

	    });
	    

	});
//병원예약 및 담기 js 여기까지

</script>
<link rel="stylesheet" href="../resources/CSS/listHospital.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.min.js" integrity="sha384-Rx+T1VzGupg4BHQYs2gCW9It+akI2MM/mndMCy36UVfodzcJcF0GGLxZIzObiEfa" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
							    <li class="list-group-item a-hopitalform active"><a class="vcc-alink" href="${contextPath}/hospital/getlistHospital.do">지정 의료기관 찾기</a></li>
							    <li class="list-group-item a-hopitalform" id="hoslist"><a class="vcc-alink" href="${contextPath}/hospital/gethospitalForm.do">지정 의료기관 관리</a></li>
							    
						   </ul>
	                   </div>
                       </div>
                   </div>
               </div>
		</div>
		<div class="right ms-4" style="width: 80%;" >
			<h3 class="border-bottom border-2 border-secondary-subtle pb-3 mt-4 pt-5 mb-0"><strong>지정 의료기관 찾기</strong></h3>
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
							<input type="button" class="btn btn-primary "  id="btn_search" onClick="fn_search(1)" value="검색">
				      </td>
				    </tr>
				  </tbody>
				</table>
				<div class="text-center">
					<table class="table">
						<thead>
							<tr>
								<th class="col-sm-2" scope="col">병/의원명</th>
								<th class="col-sm-1.5" scope="col">전화번호</th>
								<th class="col-sm-5" scope="col">주소</th>
								<th class="col-sm-1.5" scope="col">예약가능여부</th>
								<th class="col-sm-1" scope="col">예약</th>
								<th class="col-sm-1" scope="col" id="hscartbtn">담기</th>
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
	</div>
</div>
	<jsp:include page="../footer.jsp"/>
</body>
</html>