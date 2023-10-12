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
	
	}
	document.addEventListener('DOMContentLoaded', function() {
	    const signFormLink = document.querySelector('.al-signform');
	    const adminFormLink = document.querySelector('.al-adminform');
	    const loginFormLink = document.querySelector('.al-loginform');
	    const findFormLink = document.querySelector('.al-findform');
	
	    loginFormLink.classList.add('active'); // 초기에는 회원가입 링크를 활성화 상태로 표시
	    
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
	});
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
						    <li class="list-group-item al-loginform active"><a class="list-link" href="<%=contextPath%>/member/loginForm.do">로그인</a></li>
						    <li class="list-group-item al-adminform"><a class="list-link" href="<%=contextPath%>/member/adminLoginForm.do">관리자 로그인</a></li>
						    <li class="list-group-item al-signform"><a class="list-link" href="<%=contextPath%>/member/memberForm.do">회원가입</a></li>
						    <li class="list-group-item al-findform"><a class="list-link" href="<%=contextPath%>/member/findMyIdForm.do">아이디/비밀번호 찾기</a></li>
						  </ul>
	                  </div>
	               </div>
	            </div> 
	         </div>
	         <!-- 오른쪽 페이지 -->
	         <div class="login-rightwrap-container ms-4" style="width: 80%;">
				<h3 class="login-title border-secondary-subtle text-start pb-3 mt-4 pt-5 mb-0"><strong>로그인</strong></h3>
	            <div class="right-box d-flex justify-content-center mt-4 mb-4" >
					<main class="form-signin d-flex flex-column">
						<form action="<%=contextPath%>/member/memberLogin.do" method="post" id="loginform">
	                    	<input type="hidden" name="action" value="<%=action%>">
	                    	<div class="login-inputbox d-flex">
								<div class="login-idpwd-box">
									<div class="form-floating">
		                            	<input type="text" class="form-control mb-4" id="mid" name="mid" placeholder="아이디 입력...">
		                            	<label for="mid">아이디</label>
		                            </div>
	                              	<div class="form-floating">
	                                 	<input type="password" class="form-control mb-4" id="mpwd" name="mpwd" placeholder="Password">
	                                 	<label for="mpwd">비밀번호</label>
	                              	</div>
								</div>
	                         	<div class="login-button ms-4 mb-4">
	                             	<button class="w-100 btn btn-lg btn-primary" type="submit">로그인</button>   
	                          	</div>   
							</div>
	                        
	                        <div class="mb-4" id="loginfalse" style="display:none; color:red;">
	                              아이디 또는 비밀번호를 잘못 입력했습니다.<br>
	                              입력하신 내용을 다신 확인해주세요
	                        </div>
	                        <div class="member-link">
	                           <a href="<%=contextPath%>/member/memberForm.do">회원가입</a> &#124;
	                           <a href="#">아이디/비밀번호 찾기</a>
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