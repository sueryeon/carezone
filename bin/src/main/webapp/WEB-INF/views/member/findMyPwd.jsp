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
	    
	    
	    newMyPwdform.onsubmit = function(event) {
	        var mpwd = newMyPwdform.mpwd.value;
	        var mpwd = newMyPwdform.mpwdcheck.value;
	        if (!mpwd) {
	            newMyPwdform.mpwd.focus();
	            event.preventDefault(); // 폼 제출 중지
	        }
	        else if(!mpwd){
	        	newMyPwdform.mpwdcheck.focus();
	            event.preventDefault(); // 폼 제출 중지
	        }
	        
	        else if(mpwd!=mpwd){
	        	newMyPwdform.mpwdcheck.focus();
	            event.preventDefault(); // 폼 제출 중지
	        }
	        else{
	        	alert('비밀번호가 변경되었습니다.\n변경된 비밀번호로 로그인 해주세요.');
	        }
	    };

	    document.getElementById("mpwd").addEventListener("input", function(event) {
            var mpwd = this.value;
            console.log("mpwd : "+mpwd);
            var mpwdalert = document.getElementById("mpwdalert");
            var mpwdalert2 = document.getElementById("mpwdalert2");

            // 여기에 비밀번호 유효성 검사 로직을 추가
            // 예: 비밀번호가 조건을 충족하지 않으면 mpwdalert 또는 mpwdalert2 요소를 표시
            if(!mpwd){ // mpwd 필드의 값이 없다면
	            mpwdalert.style.display = "block"; // div를 화면에 표시
	   	 		mpwdalert2.style.display="none";
	        }
	        else{
	       	 	mpwdalert.style.display = "none"; // div를 화면에 표시
	       	 	
	       	 	var pattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*.])[a-zA-Z\d!@#$%^&*.]+$/;
	       	 	if(mpwd.length < 8 || mpwd.length > 20 || !pattern.test(mpwd)){
	       	 		//mpwd.blur();
	       	 		mpwdalert2.style.display="block";
	       	 		newMyPwdform.mpwd.focus();
	       	 		return false;
	       	 	}
	       	 	else{
	       	 		mpwdalert2.style.display="none";
	       	 	}
	       	}
        });
	    
	    document.getElementById("mpwdcheck").addEventListener("input", function() {
	    	if (event.key === "Enter") {
	            event.preventDefault(); // Enter 키의 기본 동작(폼 제출) 막기
	        }
            var mpwdcheck = this.value;
            var mpwd = document.getElementById("mpwd").value;
            var mpwdalert3 = document.getElementById("mpwdalert3");
            var mpwdalert4 = document.getElementById("mpwdalert4");
            var mpwdalert5 = document.getElementById("mpwdalert5");

            // 여기에 비밀번호 유효성 검사 로직을 추가
            // 예: 비밀번호가 조건을 충족하지 않으면 mpwdalert 또는 mpwdalert2 요소를 표시
            if(!mpwdcheck){ // mpwd 필드의 값이 없다면
            	mpwdalert3.style.display = "block"; // div를 화면에 표시
	            mpwdalert4.style.display="none";
	            mpwdalert5.style.display="none";
	   	 		newMyPwdform.mpwdcheck.focus(); // mpwd 필드에 포커스 맞춤
	            return false; // 폼 제출을 중지
	        }
	        else{
	        	
	        	if(mpwdcheck == mpwd){
		            mpwdalert3.style.display ="none"; // div를 화면에 표시
		            mpwdalert4.style.display="none";
		            mpwdalert5.style.display="block";
		            nextBtn.style.display="block";
		            //alert('비밀번호가 변경되었습니다.\n변경된 비밀번호로 로그인 해주세요.');
	        	}
	        	else{
	        		mpwdalert3.style.display ="none"; // div를 화면에 표시
		            mpwdalert4.style.display="block";
		            mpwdalert5.style.display="none";
		            newMyPwdform.mpwdcheck.focus(); // mpwd 필드에 포커스 맞춤
		            return false; // 폼 제출을 중지
	        	}
	       	}
        });

	}
	

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
				<div class="d-flex m-auto border-secondary-subtle login-title text-start pb-3 mt-4 pt-5 mb-0">
		         	<h3 class="me-2"><strong>비밀번호 재설정</strong></h3>
	         	</div>
				<main class="form-sign mt-4" id="sign_form">
					<c:choose>
						<c:when test="${count == 'tru'}">
							<form action="<%=contextPath%>/member/NewMyPwd.do" method="post" name="newMyPwdform" id="newMyPwdform">
								<div class="m-auto">
									<input type="hidden" name="memail1" value="${memail1}">
									<input type="hidden" name="memail2" value="${memail2}">
									<!-- 비밀번호 입력 -->
									<div class="container mb-3" style="width:100%; padding:0px;">
										<div class="idcheck-box col-md-3" style="width:100%;">
											<label for="mpwd" class="subtitle-label form-label" style="width:100%;">새로운 비밀번호 입력</label>
											<div class="pwdinput-box" style="display:flex;">
												<input type="text" class="form-control" id="mpwd" name="mpwd" style="width:245px;" maxlength="20">
												<div class="red ms-3 lh-lg" role="alert" id="mpwdalert" style="display:none;">
													비밀번호는 필수입니다
												</div>
												<div class="red ms-3 lh-lg" id="mpwdalert2" style="display:none; width:600px">
													비밀번호는 8~20자의 영문 대/소문자, 숫자와 특수문자를 포함해야 합니다.
												</div>
											</div>
										</div>
									</div>
									<!-- 비밀번호 확인 -->
									<div class="container mb-3" style="width:100%; padding:0px;">
										<label for="mpwdcheck" class="subtitle-label form-label" style="width:100%;">입력한 비밀번호 확인</label>
										<div class="col-md-3" style="width:100%; display:flex;">
											<input type="text" class="form-control me-2" id="mpwdcheck" name="mpwdcheck" style="width:245px;">
											<div class="red ms-3 lh-lg" role="alert" id="mpwdalert3" style="display:none;">
												비밀번호는 필수입니다
											</div>
											<div class="red ms-3 lh-lg" role="alert" id="mpwdalert4" style="display:none;">
												입력하신 비밀번호와 일치하지 않습니다. 다시 입력해주세요
											</div>
											<div class="green ms-3 lh-lg" role="alert" id="mpwdalert5" style="display:none;">
												입력하신 비밀번호와 일치합니다.
											</div>
										</div>
									</div>
								</div>
								<div class="d-flex justify-content-center mt-4">
				                    <button type="submit" class="btn btn-primary me-4" id="nextBtn" style="display:none;">비밀번호 재설정</button>
			                    </div>
							</form>
						</c:when>
						
						<c:when test="${count == 'fals'}">
							등록된 회원이 없습니다. <br>
							가입한 이름과 이메일을 다시 한 번 확인해 주시길 바랍니다.
						</c:when>
					</c:choose>
				</main>
			</div>
		</div>
	 </div>
	 <jsp:include page="../footer.jsp"/>
</body>
</html>