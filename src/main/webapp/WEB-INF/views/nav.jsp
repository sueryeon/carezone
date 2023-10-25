<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% String contextPath = request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<c:set var="memVO" value="${memVO}"/>
<c:set var="adVO" value="${adVO}"/>

<script type="text/javascript">

document.addEventListener("DOMContentLoaded", function() {
    // 여기에서 span 요소의 내용을 변경하거나 원하는 작업을 수행합니다.
    var HcCount = document.getElementById("HcCount");
    var hc_count = document.getElementById("hc_count");
    var HCCountbox = document.getElementById("HCCountbox");
    var isLogin = "${isLogin}";
    var isAdminLogin = "${isAdminLogin}";
    //var value = 2;
    //HcCount.innerText = value;
    if(isAdminLogin == "true" && isLogin == "false"){
       HCCountbox.style.display="none";
    }
    else if((isAdminLogin=="false" && isLogin=="true")||(isLogin=="true" || isAdminLogin.length==0)){
    	
       HCCountbox.style.display="block";
       
       if(isLogin=="true"){
          HcCount.style.display="block";
           $.ajax({
             url:"<%=contextPath%>/hoscart/countMyHosCart.do",
             type:"get",
             success:function(data,textStatus){
                var count = data;
                if(count != null||count!=0){
                   HcCount.style.display="block";
                   hc_count.style.display="block";
                   HcCount.innerText = count;
                }
                else{
                   HcCount.style.display="none";
                   hc_count.style.display="none";
                }
             },
             error:function(data,textStatus){},
             complete:function(data,textStatus){}
          });
       }
       
       
       else{
          HcCount.style.display="none";
       }
       
    }
    else if((isAdminLogin.length==0 && isLogin.length==0) || (isAdminLogin=="false"&&isLogin=="false")){
       HCCountbox.style.display="block";
       HcCount.style.display="none";
    }
    
});


	function fn_reserv(){
		
		var action = "reserv";
		var isLogin = "${isLogin}";
		var isAdminLogin = "${isAdminLogin}";
		
		if(isLogin=="true"||isLogin.length!=0){
			var resvurl = "<%=contextPath%>/reservation/getreservationForm.do?action="+action;
			window.location.href=resvurl;
		}
		
 		if((isLogin=="false"||isLogin=="")||(isAdminLogin=="false"||isAdminLogin=="")){
			if (confirm("로그인 후 진행해 주세요")) {
	            
	            var loginurl = "<%=contextPath%>/member/loginForm.do?action=" + action;
	            window.location.href = loginurl;
	        }
		}
		else {
			var resvurl = "<%=contextPath%>/reservation/getreservationForm.do";
			window.location.href=resvurl;
		}
	}
	
	
	function fn_myreserv(){

		var action = "myreserv";
		var isLogin = "${isLogin}";
		var isAdminLogin = "${isAdminLogin}";
		
		if(isLogin=="true"||isLogin.length!=0){
			var resvurl = "<%=contextPath%>/reservation/getreservationForm.do?";
			window.location.href=resvurl;
		}
		
 		if((isLogin=="false"||isLogin=="")||(isAdminLogin=="false"||isAdminLogin=="")){
			if (confirm("로그인 후 진행해 주세요")) {
	            
	            var loginurl = "<%=contextPath%>/member/loginForm.do?action=" + action;
	            window.location.href = loginurl;
	        }
		}
		else {
			var resvurl = "<%=contextPath%>/reservation/getreservationForm.do";
			window.location.href=resvurl;
		}
 		
	}
	
	function fn_allreserv(){
		var allreserv = "<%=contextPath%>/reservation/getlistReservations.do";
		window.location.href=allreserv;
		
	}

</script>
<style type="text/css">

nav{
width: 100%;
}
.garo{
	width: 70%;
    margin: 0 auto;
}

.row {
    display: -webkit-box;
    display: -ms-flexbox;
    display: flex;
    -ms-flex-wrap: wrap;
    flex-wrap: wrap;
    margin-right: -15px;
    margin-left: -15px
}

a{
 color: black;
}
</style>

</head>
<body>
<nav class="navbar navbar-expand-lg bs-body-bg-rgb shadow-sm p-3">
  <div class="container-fluid garo">
    <a class="navbar-brand" href="<%=contextPath%>/">
		<img src="/proCareZone/resources/img/carezone.png" alt="CareZone" width="220" height="64">
    </a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse justify-content-between" id="navbarSupportedContent">
      <ul class="navbar-nav ms-5 mb-2 mb-lg-0">
         <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle fw-bold fs-5" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            예방접종 관리
          </a>
         <ul class="dropdown-menu p-4">
          	<div id="member_menu">
	          	<li><a class="dropdown-item" href="#" onClick="fn_reserv()">예방접종 예약</a></li>
	            <li><a class="dropdown-item" href="#" onClick="fn_myreserv()">예방접종 관리</a></li>
	            <li><hr class="dropdown-divider"></li>
	            <li><a class="dropdown-item" href="<%=request.getContextPath()%>/hospital/getlistHospital.do">지정의료기관 찾기</a></li>
	        </div>
            <div id="admin_menu">
	            <li id="admin_li1"><a class="dropdown-item" href="#" onClick="fn_reserv()">회원 예방접종 예약</a></li>
            	<li id="admin_li2"><a class="dropdown-item" href="#" onClick="fn_allreserv()">회원 예방접종 관리</a></li>
	        	<li><hr class="dropdown-divider"></li>
	        	<li><a class="dropdown-item" href="<%=request.getContextPath()%>/hospital/getlistHospital.do">지정의료기관 찾기</a></li>
	            <li><a class="dropdown-item" href="<%=request.getContextPath()%>/hospital/gethospitalForm.do">지정의료기관 관리</a></li>
	        </div>
          </ul>
        </li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle fw-bold fs-5" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            예방접종 정보
          </a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="<%=request.getContextPath()%>/vaccine/listVcc.do">예방접종 대상 감염병</a></li>
          </ul>
        </li>
        <li class="nav-item dropdown">
        	<a class="nav-link dropdown-toggle fw-bold fs-5" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
        		커뮤니티
          	</a>
        	<ul class="dropdown-menu p-4">
    			<li><a class="dropdown-item" href="<%=request.getContextPath()%>/board/listBoards.do">게시판</a></li>
    			<li><hr class="dropdown-divider"></li>
    			<li><a class="dropdown-item" href="<%=request.getContextPath()%>/qna/getlistQna.do">QnA</a></li>
    		</ul>
        </li>
        <li class="nav-item ">
          <a class="nav-link active fw-bold fs-5" aria-current="page" href="<%=request.getContextPath()%>/notice/getlistNotice.do">공지사항</a>
        </li>
    </ul>
	<a class="lh-1 link-underline link-underline-opacity-0 position-relative" id="HCCountbox" href="<%=contextPath%>/hoscart/getlistHosCart.do" style="display:none;">
          <img src="/proCareZone/resources/img/관심백신.png" width=35px>
          관심백신
          <span id="HcCount" class="position-absolute top-0 start-20 translate-middle badge rounded-pill bg-danger" style="display:none;">
              <span id="hc_count" class="visually-hidden" style="display:none;">
              	unread messages
              </span>
          </span>
      </a>
    </div>
  </div>
</nav>
</body>
</html>