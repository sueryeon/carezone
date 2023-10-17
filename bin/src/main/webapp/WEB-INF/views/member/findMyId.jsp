<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String contextPath = request.getContextPath(); 
   String action = request.getParameter("action");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.min.js" integrity="sha384-Rx+T1VzGupg4BHQYs2gCW9It+akI2MM/mndMCy36UVfodzcJcF0GGLxZIzObiEfa" crossorigin="anonymous"></script>
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
		
		
	    const signFormLink = document.querySelector('.al-signform');
	    const adminFormLink = document.querySelector('.al-adminform');
	    const loginFormLink = document.querySelector('.al-loginform');
	    const findFormLink = document.querySelector('.al-findform');
	
	    findFormLink.classList.add('active'); // 초기에는 회원가입 링크를 활성화 상태로 표시
	    
	    loginFormLink.addEventListener('click', function() {
	        //로그인 링크 클릭
	        loginFormLink.classList.add('active'); // 아이디/비밀번호 찾기 링크 활성화
	        signFormLink.classList.remove('active'); // 다른 링크 비활성화
	        findFormLink.classList.remove('active'); //비활성화
	    });
	    
	    adminFormLink.addEventListener('click', function() {
	        //관리자 링크 클릭 시
	        adminFormLink.classList.add('active'); // 아이디/비밀번호 찾기 링크 활성화
	        loginFormLink.classList.remove('active'); //비활성화
	        signFormLink.classList.remove('active'); // 다른 링크 비활성화
	        findFormLink.classList.remove('active'); //비활성화
	    });
	
	    signFormLink.addEventListener('click', function() {
	        // 회원가입 링크 클릭 시
	        signFormLink.classList.add('active'); // 회원가입 링크 활성화
	        loginFormLink.classList.remove('active'); // 다른 링크 비활성화
	        findFormLink.classList.remove('active'); //비활성화
	    });
	    
	    findFormLink.addEventListener('click', function() {
	        // 아이디/비번찾기 링크 클릭 시
	        signFormLink.classList.remove('active'); // 회원가입 링크 활성화
	        loginFormLink.classList.remove('active'); // 다른 링크 비활성화
	        findFormLink.classList.add('active'); //비활성화
	    });
	
	}
	
    var checkNum
	//이메일 인증
	function fn_emailcheck(){
		var memail1 = document.getElementById("memail1").value;
		var memail2 = document.getElementById("memail2").value;
		$.ajax({
			url:"<%=contextPath%>/member/emailcheck.do",
			type:"post",
			data:{
				memail1:memail1,
				memail2:memail2
			},
			success: function (data,textStatus) {
				checkNum = data;
				alert('인증번호를 발송했습니다.<br> 인증번호가 오지 않으면 입력하신 정보가 회원정보와 일치하는지 확인해 주세요.');
	        },
			error:function(data,textStatus){},
			complete:function(data,textStatus){

			}
		});
	}
	
	//인증번호 확인
	function fn_checkNum(){
		console.log(checkNum);
		var inputNum = document.getElementById("inputNum").value;

		var cnum = Number(checkNum);
		var inum = Number(inputNum);
		
		var trueNum = document.getElementById("trueNum");
		var falseNum = document.getElementById("falseNum");
		//console.log(inputNum);
		if(cnum===inum){
			console.log('일치함');
			trueNum.style.display="block";
			falseNum.style.display="none";
		}
		else {
			console.log('일치하지 않음');
			falseNum.style.display="block";
			trueNum.style.display="none";
		}
	}
	
	function inputemail(){
	    var memail2 = document.getElementById("memail2");
	    var selectEmail = document.getElementById("memailSelect").value;
	    memail2.value = selectEmail;
	}
	
	function fn_loginBtn(){
		var loginurl = "<%=contextPath%>/member/loginForm.do";
		window.location.href=loginurl;
	}
	function fn_pwdfind(){
		var pfurl = "<%=contextPath%>/member/findMyPwdForm.do";
		window.location.href=pfurl;
	}
	/*
	document.addEventListener('DOMContentLoaded', function() {

	});*/
</script>
<title>로그인창</title>
<c:set var="result" value="${param.result}"/>
<c:set var="inputid" value="${param.inputid }"/>
<c:choose>
   <c:when test="${result == 'loginFailed'}">
      <script>
         window.onload=function(){
            loginfalse = document.getElementById("loginfalse");
            loginfalse.style.display="block";
            loginform.mid.value="${inputid}";
            loginform.mpwd.focus();
         }
      </script>
   </c:when>
</c:choose>
<link rel="stylesheet" href="../resources/CSS/loginForm.css">
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

.red{
	color: #e51e3e !important;
}
.green{
	color: #12d31c !important;
}

</style>
</head>
<body>
	<jsp:include page="../nav.jsp"/>
	<div id="join" class="container-fluid p-3 pt-4 bg-light text-dark pb-5">
		<div class="wrap-container d-flex justify-content-between">
			<!-- 왼쪽 회원 서비스 -->
			<div class="loginform-leftwrap-container me-4" style="width: 20%;">
	            <div class="loginleft-box">
	               <div class="loginservice-box">
	                  <div class="loginmem-service form-control">
	                     회원 서비스
	                  </div>
	                  <div class="card loginmemservice-box mt-2">
	                  	<ul class="list-group list-group-flush">
						    <li class="list-group-item al-loginform"><a class="list-link" href="<%=contextPath%>/member/loginForm.do">로그인</a></li>
						    <li class="list-group-item al-adminform"><a class="list-link" href="<%=contextPath%>/member/adminLoginForm.do">관리자 로그인</a></li>
						    <li class="list-group-item al-signform"><a class="list-link" href="<%=contextPath%>/member/memberForm.do">회원가입</a></li>
						    <li class="list-group-item al-findform active"><a class="list-link" href="<%=contextPath%>/member/findMyIdForm.do">아이디/비밀번호 찾기</a></li>
						  </ul>
	                  </div>
	               </div>
	            </div> 
	         </div>
	         <!-- 오른쪽 페이지 -->
	         <div class="right ms-4" style="width: 80%;" >
				<h3 class="login-title border-secondary-subtle text-start pb-3 mt-4 pt-5 mb-0"><strong>아이디 찾기 &#124;</strong></h3>
				<div class="right-box d-flex justify-content-center mt-4 mb-4">
					<c:choose>
						<c:when test="${!empty mid}">
							<div class="m-auto">
								<label for="mid" class="subtitle-label form-label" style="width:100%; font-size: 15px;">회원의 아이디</label>
								<div class="d-flex">
									<div class="me-2">
										<input type="text" class="form-control mb-2" name="mid" value="${mid }" disabled style="width:150px;">
										<button type="button" class="btn btn-primary me-2" id="findMyPwd" style="width:150px;" onClick="fn_pwdfind()">비밀번호 찾기</button>
									</div>
									<button type="button" class="btn btn-primary me-2" onClick="fn_loginBtn()">로그인하기</button>
								</div>
							</div>
						</c:when>
						
						<c:when test="${empty mid }">
							등록된 회원이 없습니다. <br>
							가입한 이름과 이메일을 다시 한 번 확인해 주시길 바랍니다.
						</c:when>
					</c:choose>
				</div>
			</div>
		</div>
	 </div>
	 <jsp:include page="../footer.jsp"/>
</body>
</html>