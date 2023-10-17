<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<% String contextPath = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script><meta charset="UTF-8">
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.min.js" integrity="sha384-Rx+T1VzGupg4BHQYs2gCW9It+akI2MM/mndMCy36UVfodzcJcF0GGLxZIzObiEfa" crossorigin="anonymous"></script>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<title>Insert title here</title>
<c:set var="memVO" value="${memVO}"/>
<c:set var="adVO" value="${adVO}"/>
<style type="text/css">
*{
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    text-decoration: none;
    list-style-type: none;
}

body{
    width: 100%;
    
}


.wrap-container{
    width: 70%;
    margin: 0 auto;
}

a{
	text-decoration:none !important;
}


.btn-primary{
   background-color:#3f78bf !important;
   border-color:#3f78bf !important;
}

.btn-primary a{
text-decoration: none;
color: white;
}


a{
	text-decoration:none !important;
}
.nav-tabs {
--bs-nav-tabs-link-active-border-color
}

.plus{
	width: 20px;
	height:20px;
	color: black;
}
.fong{
 font-size: 11px !important;
}

.fong2 {

  text-align: center;

}

.yellow{
	background-color: rgb(255, 205, 74);
}

.gropu2_left{
    width: 75%;
    border-radius: 5px;
}


</style>

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
	var loginsbox = document.getElementById("login_box");
	var mypagebox = document.getElementById("success_login_box");
	var admin_mypage_box = document.getElementById("success_admin_login_box");
	var member_menu = document.getElementById("member_menu");
	var admin_menu = document.getElementById("admin_menu");
	
	if((isLogin=="true"&&isAdminLogin=="false")||(isLogin=="true"&&isAdminLogin.length==0)){
		loginsbox.style.display="none";
		mypagebox.style.display="block";
		member_menu.style.display="block";
		admin_menu.style.display="none";
		fn_check_family();
	}
	else if((isAdminLogin=="true"&&isLogin=="false")||(isAdminLogin=="true"&&isLogin.length==0)){
		loginsbox.style.display="none";
		admin_mypage_box.style.display="block";
		member_menu.style.display="none";
		admin_menu.style.display="block";
	}
	else{
		loginsbox.style.display="block";
		member_menu.style.display="block";
		admin_menu.style.display="none";
	}

	
    //게시판 최신글
	fn_topBoardList();
	
	//공지사항 최신글
	fn_notice_top_three();
}

//-----------------------------------------------------------------------------------------------------
    function fn_check_family(){
	   var mno="${memVO.mno}";
	   var mid="${memVO.mid}";
	   var mname="${memVO.mname}";
	   var fmvo="";
	   var contents="";
	   
	   $.ajax({
	         type: "post",
	         url: "${contextPath}/checklist/getHomechecklist.do",
	         data:{
	         'mno':mno
	         },
	         success: function(data) {
	            console.log(data);
	               contents+='<button class="nav-link active p-2" id="nav-home-tab" data-bs-toggle="tab" data-bs-target="#';
	               contents+=mid+mname+'" type="button" role="tab" aria-selected="true">';
	               contents+='나';
	               contents+='</button>';
	               
	               for(var i=0; i<data.length; i++){
	               fmvo=data[i];
	               contents+='<button class="nav-link p-2" id="nav-home-tab" data-bs-toggle="tab" data-bs-target="#';
	               contents+=mid+fmvo.fname+'" type="button" role="tab" aria-selected="false">';
	               contents+=fmvo.fname;
	               contents+='</button>';
	               
	               console.log(contents);
	            }
	            $("#nav-tab").html(contents);
	         },
	         error: function(xhr, status, error) {
	            console.log("실패");
	         }
	      });
	}
	//여기까지
	
	//가족이름에 맞는 체크리스트내용 들고오기
	function fn_check_detail(name){
	   
	   var id="${memVO.mid}";
	   var name=name;
	   var contents="";
	   var ckvo="";
	   
	   $.ajax({
	      type: "post",
	      url: "${contextPath}/checklist/getdetailcklist.do",
	      data:{
	      'ckid':id,
	      'ckname':name
	      },
	      success: function(data) {
	         console.log(data);
	         for(var i=0; i<data.length; i++){
	            ckvo=data[i];
	            
	            contents+='<div class="tab-pane fade show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab" tabindex="0">';
	            contents+='<ul>'
	         
	            contents+='</div>';
	            
	            
	         }
	         $("#nav-tabContent").html(contents);
	      },
	      error: function(xhr, status, error) {
	         console.log("실패");
	      }
	   });
	}
    
    //게시판 최신글
    function fn_topBoardList(){
    	$.ajax({
        type: "get",
        url: "${contextPath}/board/topboardlist.do",
        success: function(data, textStatus){
        	var boardList = "";
            for(var i=0; i<data.length; i++){
            	var bInfo = data[i];
            	console.log(bInfo.bwriteDate);
            	var date = new Date(bInfo.bwriteDate);
            	var formattedDate = formatDate(date);
            	console.log(formattedDate);
            	boardList+="<li class='list-group-item'>";
            	boardList+="<a style='width: 70%;' class='fw-semibold' href='${contextPath}/board/findBoard.do?barticleNo="+bInfo.barticleNo+"'>"+bInfo.btitle;
            	boardList+="</a><p style='width: 30%;' class='mb-0'>"+formattedDate+"</li>";
                $("#board_topthree").html(boardList);
            }
        },
        error: function(data,textStatus) {
            console.log("error");
        },
        complete:function(data,textStatus){}
    	});
    }
    
//공지사항 최신글
function fn_notice_top_three(){
   
   var result="";
   var VO="";
   
   
   var notice_topthree=document.getElementById("notice_topthree");
   
   $.ajax({
        type: "GET",
        url: "${contextPath}/notice/noticetopthree.do",
        success: function(data) {
           
           fn_notice_top(data);
           
            for(var i=0; i<data.length; i++){
               
               VO=data[i];
            var date=VO.nwritedate;
            var nwritedate = new Date(date);

            var formattedDate =formatDate(nwritedate);
            console.log(formattedDate);
            
               result+="<li class='list-group-item'>";
               result+="<a style='width: 70%;' class='fw-semibold' href='${contextPath}/notice/getDetailNotice.do?narticleno="+VO.narticleno+"'>"+VO.ntitle;
               result+="</a><p style='width: 30%;' class='mb-0'>"+formattedDate+"</li>";
               $("#notice_topthree").html(result);
               
               
            }
           
        },
        error: function(xhr, status, error) {
            // 요청이 실패했을 때 실행되는 함수
            console.error(error);
            $("#notice_topthree").html("페이지 오류");
        }
    });
   
}

function fn_notice_top(data){
   
   var VO=data[1];
   var topnotice="<a href='${contextPath}/notice/getDetailNotice.do?narticleno="+VO.narticleno+"'>"+VO.ntitle+"</a>";
   
   $("#top").html(topnotice);
}

 // 날짜를 변환할 함수
function formatDate(date) {
	var year = date.getFullYear().toString().substr(-2); // 마지막 2자리만 추출
	var month = (date.getMonth() + 1).toString().padStart(2, '0'); // 0부터 시작하므로 1을 더하고 2자리로 패딩
	var day = date.getDate().toString().padStart(2, '0'); // 2자리로 패딩
	return year + '-' + month + '-' + day;
}

function fn_logout()
{
	var url = "${contextPath}/member/logout.do";
	if(confirm("로그아웃 하시겠습니까?")){
		window.location.href = url;
	}
	else{
		
	}
}
   
function fn_admin_reservation() //관리자 예약관리로 들어가기
{
	      var allreserv = "${contextPath}/reservation/getlistReservations.do";
	      window.location.href=allreserv;  
}
   

function fn_my_reservation() // 회원나의 예약관리 
{
	//내 예약 보기
	var myrsvurl = "${contextPath}/reservation/getlistMyReservations.do?mid=${memVO.mid}";
	window.location.href=myrsvurl;
}

 function fn_mypage(action){
      //console.log("action : "action);
      var mypageurl = "${contextPath}/member/findMember.do?action="+action;
      window.location.href=mypageurl;
}
//------------------------------------------------------의료기관 js
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
//------------------------------------------------------의료기관 js
//-------------------------------------부트스트랩
 const myCarouselElement = document.querySelector('#myCarousel')

 const carousel = new bootstrap.Carousel(myCarouselElement, {
   interval: 1000,
   touch: false
 })

 const triggerTabList = document.querySelectorAll('#myTab button')
 triggerTabList.forEach(triggerEl => {
   const tabTrigger = new bootstrap.Tab(triggerEl)

   triggerEl.addEventListener('click', event => {
     event.preventDefault()
     tabTrigger.show()
   })
 })
 
 //-------------------------------------부트스트랩
</script>
<link rel="stylesheet" href="./resources/CSS/index.css">
</head>
    <body>
    <jsp:include page="nav.jsp"/>
        <div class="container-fluid p-3 pt-4 pb-5 bg-light text-dark">
            <div class="wrap-container">
                <div class="gropu1 mb-4" >
					<div class="card" style="max-width: 100%;" >
					 	<div class="row g-0 ps-0 ms-0" style="max-width: 100%;">
						    <div class="col-md-auto yellow rounded-start-1">
						      <div class="card-body">
						        <b class="card-text">알려드립니다</b>
						      </div>
						    </div>
						    <div class="col-md-8">
						      <div class="card-body">
						        <p class="card-text" id="top"></p>
						      </div>
						    </div>
						</div>
					</div>
               </div>
                <div class="gropu2 d-flex mb-4">
                    <div class="gropu2_left">
                    	<div class="container ps-0 pe-0">
							<div id="carouselExampleAutoplaying" class="carousel slide" data-bs-ride="carousel">
                    			<div class="carousel-indicators">
								    <button type="button" data-bs-target="#carouselExampleAutoplaying" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
								    <button type="button" data-bs-target="#carouselExampleAutoplaying" data-bs-slide-to="1" aria-label="Slide 2"></button>
								    <button type="button" data-bs-target="#carouselExampleAutoplaying" data-bs-slide-to="2" aria-label="Slide 3"></button>
								  </div>
							  <div class="carousel-inner border border-secondary-subtle rounded-2">
							    <div class="carousel-item active">
							      <img src="/proCareZone/resources/img/1.jpg" class="d-block w-100 " >
							    </div>
							    <div class="carousel-item">
							      <img src="/proCareZone/resources/img/2.jpg" class="d-block w-100 ">
							    </div>
							    <div class="carousel-item">
							      <img src="/proCareZone/resources/img/3.jpg" class="d-block w-100 " >
							    </div>
							  </div>
							  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleAutoplaying" data-bs-slide="prev">
							    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
							    <span class="visually-hidden">Previous</span>
							  </button>
							  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleAutoplaying" data-bs-slide="next">
							    <span class="carousel-control-next-icon" aria-hidden="true"></span>
							    <span class="visually-hidden">Next</span>
							  </button>
							</div>
                    	</div>
                    	<form action="${contextPath}/hospital/getlistHospital.do">
	                        <div class="card mt-4">
								<div class="card-body p-3 ps-5">
								    <p class="fw-bold fs-4 mb-0" >지정의료기관 찾기
								</div>
								<hr class="m-auto" style="width: 90%;">
								<div class="card-body d-flex justify-content-evenly p-3 pt-4 pb-4">
									<select	class="form-select form-select-sm" style="width: 20%;" aria-label="Small select example" name="state" id="state" title="시/도를 선택하세요." onchange="stateList()">
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
									<select	class="form-select form-select-sm" style="width: 20%;" aria-label="Small select example" name="city" id="city" >
										<option value=''>시/군/구</option>
									</select>
									<select class="form-select form-select-sm" style="width: 30%;" aria-label="Small select example" name="vccname" id="vccname">
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
								    <a href="${contextPath}/hospital/getlistHospital.do" class="btn btn-primary rounded-1" style="width: 10%;">검색</a>
								  </div>
							</div>
						</form>
                	</div>
                    <div class="right card container me-0 p-0" style="width: 18rem;">
                      	<div class="card-header border-bottom p-4" id="login_box">
						    <p class="card-title p-3 text-center fw-semibold">
						    	로그인해서 더 많은 서비스를 받아보세요.
						    <p>
						    <div class="d-flex justify-content-between">
	                                <div id="login" >
	                                    <a href="${contextPath}/member/loginForm.do" class="btn btn-primary fong" id="memLogin">로그인</a>
	                                </div>
	                                <div id="admin" >
	                                   	<a href="${contextPath}/member/adminLoginForm.do" class="btn btn-primary text-wrap fong" id="adLogin">관리자 로그인</a>
	                                </div>
	                                <div id="join">
	                                    <a href="${contextPath}/member/memberForm.do" class="btn btn-primary fong" id="signup">회원가입</a>
	                                </div>
	                         </div>
					 	</div>
					 	<c:choose>
					 		<c:when test="${isAdminLogin}">
					 			<div class="card-header border-bottom p-4" style="display:none;" id="success_admin_login_box">
								    <p class="card-title p-3 text-center fw-semibold">
								    	<span>${adVO.adname}</span>님 안녕하세요.
								    </p>
		                            <div class="d-flex justify-content-between">
		                                <div id="mypage"> 
		                                    <button id="btn_mypage" onClick="fn_mypage('admin')" class="btn btn-primary fong">마이페이지</button>
		                                </div>
		                                <div id="my_res">
		                                    <button id="btn_my_res" onClick="fn_admin_reservation()" class="btn btn-primary fong">예약관리</button>
		                                </div>
		                                <div id="logout">
		                                    <button id="btn_logout" onClick="fn_logout()" class="btn btn-primary fong">로그아웃</button>
		                                </div>
		                            </div>
					 			</div>
					 		</c:when>
					 		<c:when test="${isLogin}">
					 			<div class="card-header border-bottom p-4" style="display:none;" id="success_login_box">
								    <p class="card-title p-3 text-center fw-semibold">
								    	<span>${memVO.mname}</span>님 안녕하세요.
								    </p>
		                            <div class="d-flex justify-content-between">
		                                <div id="mypage"> 
		                                    <button id="btn_mypage" onClick="fn_mypage('member')" class="btn btn-primary fong" >마이페이지</button>
		                                </div>
		                                <div id="my_res">
		                                    <button id="btn_my_res" onClick="fn_my_reservation()" class="btn btn-primary fong" >예약관리</button>
		                                </div>
		                                <div id="logout">
		                                    <button id="btn_logout" onClick="fn_logout()" class="btn btn-primary fong" >로그아웃</button>
		                                </div>
		                            </div>
					 			</div>
					 		</c:when>
					 	</c:choose>
					 	<c:choose>
					 		<c:when test="${isLogin }">
						 		<nav>
								  <div class="nav nav-tabs" id="nav-tab" role="tablist">
								    <button class="nav-link active p-2" id="nav-home-tab" data-bs-toggle="tab" data-bs-target="#nav-home" type="button" role="tab" aria-controls="nav-home" aria-selected="true">Home</button>
								    <button class="nav-link p-2" id="nav-profile-tab" data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="false">Profile</button>
								    <button class="nav-link p-2" id="nav-contact-tab" data-bs-toggle="tab" data-bs-target="#nav-contact" type="button" role="tab" aria-controls="nav-contact" aria-selected="false">Contact</button>
								  	<button class="nav-link p-2" id="nav-contact-tab" data-bs-toggle="tab" data-bs-target="#nav-contact" type="button" role="tab" aria-controls="nav-contact" aria-selected="false">Contact</button>
								  </div>
								</nav>
								<div class="tab-content" id="nav-tabContent">
								  <div class="tab-pane fade show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab" tabindex="0">...</div>
								  <div class="tab-pane fade" id="nav-profile" role="tabpanel" aria-labelledby="nav-profile-tab" tabindex="0">...</div>
								  <div class="tab-pane fade" id="nav-contact" role="tabpanel" aria-labelledby="nav-contact-tab" tabindex="0">...</div>
								  <div class="tab-pane fade" id="nav-contact2" role="tabpanel" aria-labelledby="nav-contact-tab" tabindex="0">...</div>
								</div>
					 		</c:when>
					 		<c:when test="${isAdminLogin}">
					 			<p>관리자입니다.
					 		</c:when>
					 		<c:otherwise>
						 		<div class="card-body d-flex flex-column align-items-center">
						 			<div class="mt-5 mb-2 pt-5">
						 				<img src="${contextPath}/resources/img/checklist.gif" width="100" >	
						 			</div>
								    <a class="fw-medium fong2" href="${contextPath}/member/loginForm.do">체크리스트로 나의 건강을 관리해보세요!</a>
							    </div>
					 		</c:otherwise>
					 	</c:choose>
					</div>
                </div>
                <div class="gropu3"></div>
                <div class="gropu4"></div>
                <div class="gropu5 d-flex justify-content-between">
                	<div class="card w-100 me-4" >
						<div class="card-header">
						    <b class="float-start">공지사항</b>
						    <a class="border border-secondary-subtle float-end plus text-center lh-1 link-underline link-underline-opacity-0" href="${contextPath}/notice/getlistNotice.do">+</a>
						</div>
					  <ul class="list-group list-group-flush" id="notice_topthree">
					  </ul>
					</div>
					<div class="card w-100 me-4">
					  <div class="card-header">
					    	<b class="float-start">게시판</b>
						    <a class="border border-secondary-subtle float-end plus text-center lh-1 link-underline link-underline-opacity-0" href="${contextPath}/board/listBoards.do">+</a>
					  </div>
					  <ul class="list-group list-group-flush" id="board_topthree">
					  </ul>
					</div>
					<div class="card w-100 m-0">
						<div class="card-header">
					    	<b class="float-start">건강한 Tip!</b>
						</div>
						<!-- 
					  	<div class="d-flex justify-content-between h-100">
						  	<div class="border border-secondary-subtle w-50 h-100 d-flex align-content-between flex-wrap">
					  			<iframe height="130" class="w-100 p-2" src="https://www.youtube.com/embed/sWKJPUibW5Y?si=onmf_QKyFqIBsKxz" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
					  			<h6 style="font-size:12px;" class="p-2">[KONAS-ASP 4편] 항생제 적정 사용관리와 감염관리의 상승효과</h6>
					  		</div>
					  		<div class="border border-secondary-subtle w-50 h-100 d-flex align-content-between flex-wrap">
					  			<iframe height="130" class="w-100 p-2" src="https://www.youtube.com/embed/8kSw3pIrSQI?si=yJaMADbz3buJ3-UE" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>	
					  			<h6 style="font-size:12px;" class="p-2">[손씻기 실험영상] 올바른 손씻기 6단계에는 다 이유가 있습니다</h6>
					  		</div>
					    </div>
					     -->
					</div>
                </div>
            </div>
        </div>
        <jsp:include page="footer.jsp"/>
    </body>
</html>