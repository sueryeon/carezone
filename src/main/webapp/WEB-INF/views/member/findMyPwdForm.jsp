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
    	var numinput = document.getElementById("inputNum");
		var memail1 = document.getElementById("memail1").value;
		var memail2 = document.getElementById("memail2").value;
		numinput.disabled=false;
		alert('인증번호를 발송했습니다.\n인증번호가 오지 않으면 입력하신 정보가 회원정보와 일치하는지 확인해 주세요.');
		$.ajax({
			url:"<%=contextPath%>/member/emailcheck.do",
			type:"post",
			data:{
				memail1:memail1,
				memail2:memail2
			},
			success: function (data,textStatus) {
				checkNum = data;
				
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
		var nextBtn = document.getElementById("nextBtn");
		//console.log(inputNum);
		if(cnum===inum){
			console.log('일치함');
			trueNum.style.display="block";
			falseNum.style.display="none";
			nextBtn.style.display="block";
		}
		else {
			console.log('일치하지 않음');
			falseNum.style.display="block";
			trueNum.style.display="none";
			nextBtn.style.display="none";
		}
	}
	
	function inputemail(){
	    var memail2 = document.getElementById("memail2");
	    var selectEmail = document.getElementById("memailSelect").value;
	    memail2.value = selectEmail;
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
	         <div class="login-rightwrap-container ms-4" style="width: 80%;">
	         	<div class="d-flex m-auto border-secondary-subtle login-title text-start pb-3 mt-4 pt-5 mb-0">
		         	<h3 class="me-2"><strong>비밀번호 찾기</strong></h3>
		         	<h3>&#124;</h3>
					<h6 class="lh-lg ms-2"><a href="<%=contextPath%>/member/findMyIdForm.do">아이디 찾기</a></h6>
	         	</div>
				<main class="form-sign mt-4" id="sign_form" style="display:block;">
					<form action="<%=contextPath%>/member/findMyPwd.do" method="post">
						<div class="m-auto">
							<!-- 이름 입력 -->
							<div class="container mb-3" style="width:100%; padding:0px;">
								<div class="idcheck-box col-md-3" style="width:100%;">
									<label for="mname" class="subtitle-label form-label" style="width:100%;">가입한 회원 이름</label>
									<input type="text" class="form-control me-2" id="mname" name="mname" style="width:245px;" placeholder="이름 입력">
								</div>
							</div>
							
							<!-- 아이디 입력 -->
							<div class="container mb-3" style="width:100%; padding:0px;">
								<div class="idcheck-box col-md-3" style="width:100%;">
									<label for="mid" class="subtitle-label form-label" style="width:100%;">아이디</label>
									<input type="text" class="form-control me-2" id="mid" name="mid" style="width:245px;">
								</div>
							</div>
							
							<!-- 이메일 입력 -->
							<div class="container mb-3" style="width:100%; padding:0px;">
								<label for="memail1" class="subtitle-label form-label" style="width:100%;">이메일</label>
								<div class="emailinput-div" style="display:flex;">
									<div class="col-auto emailinput1">
										<input type="text" class="form-control me-2" id="memail1" name="memail1" style="width:245px;">
									</div>
									<div class="col-auto emailinput2">
									    <div class="input-group">
									      <div class="input-group-text">@</div>
									      <input type="text" class="form-control ms-2 me-2" id="memail2" name="memail2" placeholder="email" style="width:130px;">
									    </div>
									 </div>
									 <div class="col-auto">
									 	<label class="visually-hidden" for="memailSelect">Preference</label>
									    <select class="form-select" id="memailSelect" onchange="inputemail();">
									    	<option selected value="">직접 입력</option>
									    	<option id="naver.com" value="naver.com">naver.com</option>
									    	<option id="gmail.com" value="gmail.com">gmail.com</option>
									    	<option id="daum.com" value="daum.com">daum.net</option>
									    </select>
									 </div>
									 <button type="button" class="btn btn-primary ms-2" onClick="fn_emailcheck()">이메일 인증</button>
								</div>
							</div>
							
							<div class="container mb-4" style="width:100%; padding:0px;">
								<label for="inputNum" class="subtitle-label form-label" style="width:100%;">인증번호</label>
								<div style="display:flex;">
									<input type="text" class="form-control me-2" id="inputNum" style="width:245px;" placeholder="인증번호 입력" disabled>
									<button type="button" class="btn btn-primary" onClick="fn_checkNum()">인증하기</button>
									<div class="green ms-3 lh-lg" role="alert" id="trueNum" style="display:none; width:250px">
									 	인증번호가 일치합니다.
									 </div>
									 <div class="red ms-3 lh-lg" role="alert" id="falseNum" style="display:none; width:420px">
									 	인증번호가 일치하지 않습니다. 다시 한 번 확인해 주세요.
									 </div>	
								</div>
							</div>
						</div>		
						<div class="d-flex justify-content-center mt-4">
		                    <button type="submit" id="nextBtn" style="display:none;" class="btn btn-primary me-4">다음</button>
	                    </div>
					</form>
				</main>
			</div>
		</div>
	 </div>
	 <jsp:include page="../footer.jsp"/>
</body>
</html>