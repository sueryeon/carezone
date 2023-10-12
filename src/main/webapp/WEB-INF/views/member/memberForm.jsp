<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<% String contextPath = request.getContextPath(); %>
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
	document.addEventListener('DOMContentLoaded', function() {
	    const signFormLink = document.querySelector('.a-signform');
	    const adminFormLink = document.querySelector('.a-adminform');
	    const loginFormLink = document.querySelector('.a-loginform');
	    const findFormLink = document.querySelector('.a-findform');
	
	    signFormLink.classList.add('active'); // 초기에는 회원가입 링크를 활성화 상태로 표시
	    
	    loginFormLink.addEventListener('click', function() {
	        // 아이디/비밀번호 찾기 링크 클릭 시
	        loginFormLink.classList.add('active'); // 아이디/비밀번호 찾기 링크 활성화
	        adminFormLink.classList.remove('active'); //비활성화
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
	        adminFormLink.classList.remove('active'); //비활성화
	        loginFormLink.classList.remove('active'); // 다른 링크 비활성화
	        findFormLink.classList.remove('active'); //비활성화
	    });
	    
	    findFormLink.addEventListener('click', function() {
	        // 회원가입 링크 클릭 시
	        signFormLink.classList.remove('active'); // 회원가입 링크 활성화
	        adminFormLink.classList.remove('active'); //비활성화
	        loginFormLink.classList.remove('active'); // 다른 링크 비활성화
	        findFormLink.classList.add('active'); //비활성화
	    });
	});

    window.onload = function(){
    	
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
    	
        let signup = document.signup;
        signup.onsubmit = function(){
        	var mid = signup.mid.value;
        	var mpwd = signup.mpwd.value;
        	var mname = signup.mname.value;
        	var mbirth1 = signup.mbirth1.value;
        	var mbirth2 = signup.mbirth2.value;
        	var memail1 = signup.memail1.value;
        	var memail2 = signup.memail2.value;
        	var mphone = signup.mphone.value;
        	var maddr = signup.maddr.value;
        	
        	
        	
        	/*아이디 유효성 검사*/
            if(!mid){ // mid 필드의 값이 없다면
                var midalert = document.getElementById("midalert");
                midalert.style.display = "block"; // div를 화면에 표시
                var midalert2 = document.getElementById("midalert2");
       		 	midalert2.style.display="none";
                signup.mid.focus(); // mid 필드에 포커스 맞춤
                return false; // 폼 제출을 중지
            }
            /*아이디: 5~20자의 영문 소문자, 숫자만 사용 가능합니다.*/
            else if(mid) {
            	var midalert = document.getElementById("midalert");
                midalert.style.display = "none"; // div를 화면에 표시
                
            	var regex = /^(?=.*[a-z])(?=.*\d)[a-z\d]+$/;
            	 if (mid.length < 5 || mid.length > 20 || !regex.test(mid)) {
            	        var midalert2 = document.getElementById("midalert2");
            	        midalert2.style.display="block";
            	        signup.mid.focus();
            	        return false;
            	    }
            	 else{
            		 var midalert2 = document.getElementById("midalert2");
            		 midalert2.style.display="none";
            	 }
            	 
            }
           
            /*비밀번호 유효성 검사*/
            if(!mpwd){ // mpwd 필드의 값이 없다면
                var mpwdalert = document.getElementById("mpwdalert");
                mpwdalert.style.display = "block"; // div를 화면에 표시
           	 	var mpwdalert2 = document.getElementById("mpwdalert2");
       	 		mpwdalert2.style.display="none";
                signup.mpwd.focus(); // mpwd 필드에 포커스 맞춤
                return false; // 폼 제출을 중지
            }
            else if(mpwd){
           	 	var mpwdalert = document.getElementById("mpwdalert");
           	 	mpwdalert.style.display = "none"; // div를 화면에 표시
           	 	
           	 	var pattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*.])[a-zA-Z\d!@#$%^&*.]+$/;
           	 	if(mpwd.length < 8 || mpwd.length > 20 || !pattern.test(mpwd)){
           	 		var mpwdalert2 = document.getElementById("mpwdalert2");
           	 		mpwdalert2.style.display="block";
           	 		signup.mpwd.focus();
           	 		return false;
           	 	}
           	 	else{
	           	 	var mpwdalert2 = document.getElementById("mpwdalert2");
	       	 		mpwdalert2.style.display="none";
           	 	}
           	 }
            
            /*이름 유효성 검사*/
            if (!mname) { // mname 필드의 값이 없다면
			    var mnamealert = document.getElementById("mnamealert");
			    mnamealert.style.display = "block"; // div를 화면에 표시
			    var mnamealert2 = document.getElementById("mnamealert2");
			    mnamealert2.style.display = "none";
			    signup.mname.focus(); // mname 필드에 포커스 맞춤
			    return false; // 폼 제출을 중지
			} else if (mname) {
			    var mnamealert = document.getElementById("mnamealert");
			    mnamealert.style.display = "none"; // div를 화면에 표시
			
			    var pattern = /^([A-Z]+|[가-힣]+)$/;
			    var space = /\s/;
			
			    if (space.test(mname)) {
			    	var mnamealert2 = document.getElementById("mnamealert2");
			        mnamealert2.style.display = "block";
			        signup.mname.focus();
			        return false;
			    }
			
			    if (mname.length < 2 || !pattern.test(mname)) {
			        var mnamealert2 = document.getElementById("mnamealert2");
			        mnamealert2.style.display = "block";
			        signup.mname.focus();
			        return false;
			    } else {
			        var mnamealert2 = document.getElementById("mnamealert2");
			        mnamealert2.style.display = "none";
			    }
			}

            /*생년월일 유효성검사*/
            if(!mbirth1){ // mbirth1 필드의 값이 없다면
                var mbirth1alert = document.getElementById("mbirth1alert");
                var mbirth2alert2 = document.getElementById("mbirth2alert2");
     		    mbirth2alert2.style.display = "none";
                mbirth1alert.style.display = "block"; // div를 화면에 표시
                signup.mbirth1.focus();
                return false; 
            }
            else if(mbirth1)
            {
            	var mbirth1alert = document.getElementById("mbirth1alert");
                mbirth1alert.style.display = "none"; // div를 화면에 표시 안함
				
            	var currentDate = new Date();
            	var crrentYear = currentDate.getFullYear();
            	var year = parseInt(mbirth1.substring(0,2),10);
            	var month = parseInt(mbirth1.substring(2,4),10);
            	var day = parseInt(mbirth1.substring(4,6),10);
            	var daysInMonth = new Date(year+1900, month,0).getDate();
            	console.log(daysInMonth);
           	    
           	    if((month<0||month>12)||(day<1||day>daysInMonth)){
           	    	var mbirth2alert2 = document.getElementById("mbirth2alert2");
         		    mbirth2alert2.style.display = "block";
           	    	signup.mbirth1.focus();
           	    	return false;
           	    }
           	    else{
        	    	var mbirth2alert2 = document.getElementById("mbirth2alert2");
	      		    mbirth2alert2.style.display = "none";
	        	}
           }
            
           /*주민 뒷자리 1개*/
           if(!mbirth2){ // mbirth2 필드의 값이 없다면
                var mbirth2alert = document.getElementById("mbirth2alert");
                mbirth2alert.style.display = "block"; // div를 화면에 표시
                signup.mbirth2.focus();
                return false; 
            }
           
           else if(mbirth2){
        	    var mbirth2alert = document.getElementById("mbirth2alert");
				mbirth2alert.style.display = "none"; // div를 화면에 표시 
				
        	   if((mbirth2==1)||(mbirth2==2)||(mbirth2==3)||(mbirth2==4)){
        		   var mbirth2alert2 = document.getElementById("mbirth2alert2");
        		   mbirth2alert2.style.display = "none";
        	   }
				
        	   else{
        		   var mbirth2alert2 = document.getElementById("mbirth2alert2");
        		   mbirth2alert2.style.display = "block"; // div를 화면에 표시
        		   signup.mbirth2.focus();
        		   return false;
        	   }
        	        	 	
           }
           
           /*이메일 유효성 검사*/
			if(!memail1){ // mbirth2 필드의 값이 없다면
				console.log(memail1);
			    var memail1alert = document.getElementById("memail1alert");
			    memail1alert.style.display = "block"; // div를 화면에 표시
			    signup.memail1.focus();
			    return false; 
			}
			else if(memail1){
				var memail1alert = document.getElementById("memail1alert");
			 	memail1alert.style.display = "none"; // div를 화면에 표시
			}
          
          if(!memail2){ // memail2 필드의 값이 없다면
              var memail2alert = document.getElementById("memail2alert");
              memail2alert.style.display = "block"; // div를 화면에 표시
              signup.memail2.focus();
              return false; 
          }
          else{
          	 var memail2alert = document.getElementById("memail2alert");
          	 memail2alert.style.display = "none"; // div를 화면에 표시
          }
          
          /*휴대폰번호 유효성 검사*/
          if(!mphone){ // mphone 필드의 값이 없다면
              var mphonealert = document.getElementById("mphonealert");
              mphonealert.style.display = "block"; // div를 화면에 표시
              signup.mphone.focus();
              return false; 
          }
          else{
          	 var mphonealert = document.getElementById("mphonealert");
          	 mphonealert.style.display = "none";
          }
            
          if(!maddr){ // maddr 필드의 값이 없다면
              var maddralert = document.getElementById("maddralert");
              maddralert.style.display = "block"; // div를 화면에 표시
              signup.maddr.focus();
              return false; 
          }
          else{
          	 var maddralert = document.getElementById("maddralert");
          	 maddralert.style.display = "none";
          }
        }
    }
    

	function inputemail(){
	    var memail2 = document.getElementById("memail2");
	    var selectEmail = document.getElementById("memailSelect").value;
	    memail2.value = selectEmail;
	}
	
	function fn_idcheck(){
	    var check_id = document.getElementById("mid").value;
	    if(!check_id){
	    	var midalert = document.getElementById("midalert");
            midalert.style.display = "block"; // div를 화면에 표시
            var midalert2 = document.getElementById("midalert2");
   		 	midalert2.style.display="none";
            signup.mid.focus(); // mid 필드에 포커스 맞춤
            return false;
	    }
	    else if(check_id){
	    	$.ajax({
		        url:"<%=contextPath%>/member/midcheck.do",
		        data:{checkid:check_id},
		        type:"post",
		        success:function(data,textStatus){
		            if(data=='1'){
		                alert('이미 사용중인 아이디 입니다.');
		                document.getElementById("mid").value="";
		                document.getElementById("mid").focus();
		            }else{
		            	alert('사용 가능한 ID 입니다.');
		            	document.getElementById("mpwd").focus();
		            }
		        },
		        error:function(data,textStatus){
		        },
		        complete:function(data,textStatus){
		        }
		    });
	    }
	}
	
	function fn_phonecheck(){
		var check_phone = document.getElementById("mphone").value;
		if(!check_phone){
			var mphonealert = document.getElementById("mphonealert");
            mphonealert.style.display = "block"; // div를 화면에 표시
            signup.mphone.focus();
            return false;
		}
		else if(check_phone){
			$.ajax({
				url:"<%=contextPath%>/member/mphonecheck.do",
				data:{checkphone:check_phone},
				type:"post",
				success:function(data,textStatus){
					if(data=='1'){
						alert('이미 가입된 번호입니다.');
						document.getElementById("mphone").value="";
						document.getElementById("mphone").focus();
					} else{
						alert('가입 가능한 번호입니다.');
						document.getElementById("maddr").focus();
					}
				},
				error:function(data,textStatus){},
				complete:function(data,textStatus){}
			});
		}
		
	}
/*	
	function fn_clause_agree(){
		var agree01 = document.getElementById("agree-clause01"); //1번 동의
		var agree02 = document.getElementById("agree-clause02"); //1번 비동의
		var agree03 = document.getElementById("agree-clause03"); //2번 동의
		var agree04 = document.getElementById("agree-clause04"); //2번 비동의
		
		var agree_container = document.getElementById("agree_container");
		var agree_title = document.getElementById("agree_title");
		
		var sign_form = document.getElementById("sign_form");
		var mem_info_insert = document.getElementById("mem_info_insert");
		

		if(agree01.checked && agree03.checked){
			agree_container.style.display="none";
			agree_title.style.display="none";
			sign_form.style.display="block";
			mem_info_insert.style.display="block";
		}
		else{
			alert("※ 이용약관에 동의해 주셔야 회원가입이 가능합니다.");
		}
	}
*/	
	/*동의약관에서 취소 누르면 홈으로 이동*/
	function fn_clause_cancle(){
		var homeurl = "<%=contextPath%>";
		window.location.href=homeurl;
	}
	
	/*정보 입력단계에서 취소 누르면 앞전으로 이동*/
	function fn_before(){
		var agree_container = document.getElementById("agree_container");
		var agree_title = document.getElementById("agree_title");
		
		var sign_form = document.getElementById("sign_form");
		var mem_info_insert = document.getElementById("mem_info_insert");
		agree_container.style.display="block";
		agree_title.style.display="block";
		sign_form.style.display="none";
		mem_info_insert.style.display="none";
	}
	
	
	var checkNum
	//이메일 인증
	function fn_emailcheck(){
		var memail1 = document.getElementById("memail1").value;
		var memail2 = document.getElementById("memail2").value;
		alert('인증번호를 발송했습니다.\n 인증번호가 오지 않으면 입력하신 정보가 회원정보와 일치하는지 확인해 주세요.');
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
	
	
</script>
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
<link rel="stylesheet" href="../resources/CSS/memForm.css">
<title>회원 가입</title>
</head>
<body>
	<jsp:include page="../nav.jsp"/>
	<div id="join" class="container-fluid p-3 pt-4 bg-light text-dark pb-5">
		<div class="wrap-container d-flex justify-content-between">
			<!-- 왼쪽 회원 서비스 -->
			<div class="memform-leftwrap-container me-4" style="width: 20%;">
	            <div class="left-box">
	               <div class="service-box">
	                  <div class="mem-service form-control">
	                     회원 서비스
	                  </div>
	                  <div class="card memservice-box mt-2">
	                  	<ul class="list-group list-group-flush">
						    <li class="list-group-item a-loginform"><a class="list-alink" href="<%=contextPath%>/member/loginForm.do">로그인</a></li>
						    <li class="list-group-item a-adminform"><a class="list-alink" href="<%=contextPath%>/member/adminLoginForm.do">관리자 로그인</a></li>
						    <li class="list-group-item a-signform active"><a class="list-alink" href="<%=contextPath%>/member/memberForm.do">회원가입</a></li>
						    <li class="list-group-item a-findform"><a class="list-alink" href="<%=contextPath%>/member/findMyIdForm.do">아이디/비밀번호 찾기</a></li>
						  </ul>
	                  </div>
	               </div>
	            </div>
	         </div>
	         <!-- 오른쪽 페이지 -->
	         <div class="memform-rightwrap-container ms-4" style="width: 80%;">
	         	<h3 class="agree-title border-secondary-subtle text-start pb-3 mt-4 pt-5 mb-0" id="agree_title" style="display:block;"><strong>약관 동의</strong></h3>
	         	<h3 class="agree-title border-secondary-subtle text-start pb-3 mt-4 pt-5 mb-0" id="mem_info_insert" style="display:none;"><strong>회원 정보 입력</strong></h3>
	            	<div class="right-box mt-4 mb-4" id="agree_container" style="display:none;">
	            		<div class="agree-subtitle d-flex">
	            			<div class="subtitle-circle rounded-circle border border-3" style="width:15px; height:15px; border-color:#355ba0">
		            		</div>
		            		<h6>회원약관에 동의하셔야 정상적으로 서비스를 이용하실 수 있습니다.</h6>
	            		</div>
	            		<!-- first 동의 -->
                        <div class="first-agree_box mt-4" style="max-width:100%">
                        	<div class="bg-white p-3 rounded-2 border border-secondary-subtle" style="overflow-y: scroll; max-width:100%; height:200px;">
	                             <h6>이용약관</h6>
				                 <h6>제 1 장 총 칙</h6>
				                 <ul class="list-use line">
				                    <li>
				                       <em>제1조 (목적)</em>
				                       <br>본 약관은 질병관리청 예방접종도우미 홈페이지(이하 "홈페이지" 라고 합니다.)에서 제공하는 모든 서비스의 이용조건 및 절차에 관한 사항과 기타 필요한 사항을 정함을 목적으로 합니다. 
				                    </li>
				                    <li>
				                       <em>제2조 (정의)</em>
				                       <br>이 약관에서 사용하는 용어의 정의는 다음과 같습니다.
				                       <ol>
				                          <li>1. "이용자"라 함은 홈페이지에 접속하여 이 약관에 따라 홈페이지가 제공하는 서비스를 이용하는 회원 및 비회원을 말합니다.</li>
				                          <li>2. "회원"이라 함은 이 약관에 동의하고 홈페이지가 제공하는 서비스를 계속적으로 이용할 수 있는 자를 말합니다.</li>
				                          <li>3. "비회원"이라 함은 회원에 가입하지 않고 홈페이지에서 제공하는 서비스를 이용하는 자를 말합니다.</li>
				                       </ol>
				                    </li>
				                    <li>
				                       <em>제3조 (약관의 효력과 변경)</em>
				                       <ol>
				                          <li>① 이 약관은 홈페이지에 게시하여 공시함으로써 효력이 발생합니다.</li>
				                          <li>② 질병관리청("https://nip.kdca.go.kr"이하 ‘예방접종도우미’)는 합리적인 사유가 발생될 경우에는 이 약관을 변경할 수 있으며, 약관이 변경된 경우에는 지체 없이 이를 공시합니다.</li>
				                          <li>③ 제2항에 의거, 변경된 약관은 제1항과 같은 방법으로 효력이 발생합니다.</li>
				                          <li>④ 회원은 변경된 약관 사항에 동의하지 않으면 서비스 이용을 중단하고 이용계약을 해지할 수 있습니다.</li>
				                          <li>⑤ 약관의 효력 발생일 이후의 계속적인 서비스 이용은 약관의 변경사항에 동의한 것으로 간주됩니다.</li>
				                       </ol>
				                    </li>
				                    <li>
				                       <em>제4조 (약관 외 준칙)</em>
				                       <br>질병관리청(‘예방접종도우미’)는 필요한 경우 서비스 내의 개별항목에 대하여 개별약관 또는 운영원칙을 정할 수 있으며, 본 약관에 명시되지 않은 사항이 관계 법령에 규정되어 있을 경우에는 관련 규정에 의합니다.
				                    </li>
				                 </ul>
				                 <h5>제 2 장 회원 가입 및 서비스 이용</h5>
				                 <ul class="list-use line">
				                    <li>
				                       <em>제5조 (이용 계약의 성립)</em><br>
				                       <ol>
				                          <li>① 홈페이지상 서비스 이용 계약은 이용자가 회원 가입에 따른 서비스 이용 신청에 대한 질병관리청(‘예방접종도우미’)의 이용 승낙과 이용자의 이 약관에 동의한다는 의사표시로 성립됩니다.</li>
				                          <li>② 이용자가 회원에 가입하여 홈페이지상 서비스를 이용하고자 하는 경우, 회원은 질병관리청(‘예방접종도우미’)에서 요청하는 개인 신상정보를 제공해야 합니다.</li>
				                          <li>③ 이용자의 홈페이지상 서비스 이용신청에 대하여 질병관리청(‘예방접종도우미’)가 승낙한 경우, 질병관리청(‘예방접종도우미’)는 회원 ID와 기타 질병관리청(‘예방접종도우미’)가 필요하다고 인정하는 내용을 회원에게 통지합니다.</li>
				                          <li>④ 질병관리청(‘예방접종도우미’)는 다음 각 호에 해당하는 서비스 이용 신청에 대하여는 이를 승낙하지 아니합니다.
				                             <ul>
				                                <li>1. 다른 사람의 명의를 사용하여 신청하였을 때</li>
				                                <li>2. 본인의 실명으로 신청하지 않았을 때</li>
				                                <li>3. 서비스 이용 계약 신청서의 내용을 허위, 기재누락, 오기로 기재하였을 때</li>
				                                <li>4. 사회의 안녕과 질서 혹은 미풍양속을 저해할 목적으로 신청하였을 때</li>
				                                <li>5. 가입신청자가 본 약관 제11조 제4항에 의하여 이전에 회원자격을 상실한 후 3년이 경과하지 않았을 때 또는 3년이 경과하였으나 질병관리청의 회원재가입 승낙을 얻지 않았을 때 </li>
				                             </ul>
				                          </li>
				                          <li>⑤ 회원가입계약의 성립시기는 질병관리청의 승낙이 가입신청자에게 도달한 시점으로 합니다.</li>
				                          <li>⑥ 회원은 제2항의 회원정보 기재 내용에 변경이 발생한 경우, 즉시 변경사항을 정정하여 기재하여야 합니다.</li>
				                       </ol>
				                    </li>
				                    <li>
				                       <em>제6조 (서비스 이용 및 제한)</em>
				                       <ol>
				                          <li>① 홈페이지상 서비스 이용은 질병관리청(‘예방접종도우미’)의 업무상 또는 기술상 특별한 지장이 없는 한 연중무휴, 1일 24시간을 원칙으로 합니다.</li>
				                          <li>② 전항의 서비스 이용시간은 시스템 등 정기점검/교체 등 회사가 필요한 경우, 회원에게 사전 통지한 후, 제한할 수 있습니다.</li>
				                          <li>③ 제2항에 의한 서비스 중단의 경우에는 질병관리청(‘예방접종도우미’)는 회원이 홈페이지에 제출한 전자우편 주소로 개별 통지하거나, 불특정다수 회원에 대하여는 홈페이지 초기화면에 서비스 중단 3일전 게시함으로써 개별 통지에 갈음할 수 있습니다. 다만, 질병관리청(‘예방접종도우미’)가 통제할 수 없는 사유로 인한 서비스의 중단(시스템 관리자의 고의, 과실이 없는 디스크 장애, 시스템다운 등)으로 인하여 사전 통지가 불가능한 경우에는 그러하지 아니합니다.</li>
				                       </ol>
				                    </li>
				                    <li>
				                       <em>제7조 (연결 홈페이지와 피연결 홈페이지간의 관계)</em>
				                       <ol>
				                          <li>① 상위 홈페이지와 하위 홈페이지가 하이퍼 링크방식 등으로 연결된 경우, 전자를 연결 홈페이지라고 하고 후자를 피연결 홈페이지라고 합니다.</li>
				                          <li>② 연결 홈페이지는 피연결 홈페이지가 독자적으로 제공하는 재화·용역에 의하여 이용자와 행하는 거래에 대해서 보증책임을 지지 않습니다.</li>
				                       </ol>
				                    </li>
				                    <li>
				                       <em>제8조 (저작권의 귀속 및 이용제한)</em>
				                       <ol>
				                          <li>① 질병관리청(‘예방접종도우미’)가 작성한 저작물에 대한 저작권 기타 지적재산권은 질병관리청(‘예방접종도우미’)에 귀속됩니다.</li>
				                          <li>② 이용자는 홈페이지를 이용함으로써 얻은 정보를 질병관리청(‘예방접종도우미’)의 사전 승낙 없이 복제, 송신, 출판, 배포 방송 기타 방법에 의하여 영리목적으로 이용하거나 제3자에게 이용하게 하여서는 안 됩니다.</li>
				                       </ol>
				                    </li>
				                 </ul>
				                 <h5>제 3 장 의 무</h5>
				                 <ul class="list-use line">
				                    <li>
				                       <em>제9조 (질병관리청(‘예방접종도우미’)의 의무)</em>
				                       <ol>
				                          <li>① 질병관리청(‘예방접종도우미’)는 특별한 사정이 없는 한 회원이 신청한 서비스 제공 개시일에 서비스를 이용할 수 있도록 합니다.</li>
				                          <li>② 질병관리청(‘예방접종도우미’)는 이 약관에서 정한 바에 따라 계속적, 안정적으로 서비스를 제공할 의무가 있습니다.</li>
				                          <li>③ 질병관리청(‘예방접종도우미’)는 이용자가 안전하게 인터넷 서비스를 이용할 수 있도록 이용자의 개인정보 보호를 위한 보안 시스템을 구축합니다.</li>
				                          <li>④ 질병관리청(‘예방접종도우미’)는 회원의 정보를 철저히 보안 유지하며, 예방접종 관련 서비스를 운영하거나 개선하는 경우 등 국가예방접종사업의 수행에만 사용하고, 이외의 다른 목적으로 타 기관 및 제3자에게 양도하지 않습니다. 이용자의 개인정보보호에 관해서는 관련법령 및 질병관리청(‘예방접종도우미’)가 정하는 "개인정보처리방침"에 정한 바에 의합니다.</li>
				                       </ol>
				                    </li>
				                    <li>
				                       <em>제10조 (회원의 의무)</em>
				                       <ol>
				                          <li>① 질병관리청(‘예방접종도우미’)가 관계법령, "개인정보처리방침"에 의해서 그 책임을 지는 경우를 제외하고, 자신의 ID와 비밀번호에 관한 관리의 책임은 회원에게 있습니다.</li>
				                          <li>② 회원은 ID 및 비밀번호를 제3자에게 이용하게 해서는 안 됩니다.</li>
				                          <li>③ 회원은 ID 및 비밀번호를 도난당하거나 제3자가 사용하고 있음을 인지하는 경우에는 회원은 즉시 질병관리청(‘예방접종도우미’)에 그 사실을 통보하고 질병관리청(‘예방접종도우미’)의 안내가 있는 경우에는 그에 따라야 합니다.</li>
				                          <li>④ 회원은 본 약관 및 관계 법령에서 규정한 사항을 준수하여야 합니다.</li>
				                          <li>⑤ 이용자는 다음 행위를 하여서는 안 됩니다.
				                             <ul>
				                                <li>1. 신청 또는 변경시 허위내용의 등록</li>
				                                <li>2. 예방접종도우미 홈페이지에 게시된 정보의 변경</li>
				                                <li>3. 예방접종도우미 홈페이지가 정한 정보 이 외의 정보(컴퓨터 프로그램 등) 송신 또는 게시</li>
				                                <li>4. 예방접종도우미 홈페이지 기타 제3자의 저작권 등 지적재산권에 대한 침해</li>
				                                <li>5. 기타 제3자의 명예를 손상시키거나 업무를 방해하는 행위</li>
				                                <li>6. 외설 또는 폭력적인 메시지, 화상, 음성 기타 공서양속에 반하는 정보를 공개 또는 게시하는 행위</li>
				                             </ul>
				                          </li>
				                       </ol>
				                    </li>
				                 </ul>
				                 <h5>제 4 장 서비스 이용 계약 해지 및 이용 제한</h5>
				                 <ul class="list-use line">
				                    <li>
				                       <em>제11조 (서비스 이용 계약 해지 및 이용 제한)</em>
				                       <ol>
				                          <li>① 회원이 서비스 이용 계약을 해지하고자 하는 때에는 회원 본인이 직접 회원정보수정 메뉴의 회원탈퇴 서비스를 이용하여 서비스 이용 계약 해지 신청을 요청해야 합니다.</li>
				                          <li>② 전항의 경우, 회원은 ID, 비밀번호, 주민등록번호, 탈퇴사유를 입력하여 입력사항 일치여부 확인한 후, 해지 확인을 선택하면 자동으로 회원 가입 및 서비스 이용 계약이 해지됩니다.</li>
				                          <li>③ 질병관리청(‘예방접종도우미’)는 이용자가 본 계약 제10조 제5항에 위반한 경우 상당한 기간을 정하여 서비스 이용을 중지할 수 있습니다.</li>
				                          <li>④ 질병관리청(‘예방접종도우미’)는 회원이 다음 사항에 해당하는 행위를 하였을 경우 사전 통지 없이 서비스 이용 계약을 해지할 수 있습니다.
				                             <ul>
				                                <li>1. 공공 질서 및 미풍 양속에 반하는 경우</li>
				                                <li>2. 범죄적 행위에 관련되는 경우</li>
				                                <li>3. 국익 또는 사회적 공익을 저해할 목적으로 서비스 이용을 계획 또는 실행할 경우</li>
				                                <li>4. 타인의 ID 및 비밀번호를 도용한 경우</li>
				                                <li>5. 타인의 명예를 손상시키거나 불이익을 주는 경우</li>
				                                <li>6. 같은 사용자가 다른 ID로 이중 등록을 한 경우</li>
				                                <li>7. 서비스에 위해를 가하는 등 건전한 이용을 저해하는 경우</li>
				                                <li>8. 기타 관련 법령이나 질병관리청(‘예방접종도우미’)가 정한 이용조건에 위배되는 경우</li>
				                             </ul>
				                          </li>
				                       </ol>
				                    </li>
				                    <li>
				                       <em>제12조 (서비스 이용 제한의 해제 절차)</em>
				                       <ol>
				                          <li>① 질병관리청(‘예방접종도우미’)가 서비스 이용 제한을 하고자 하는 경우에는 그 사유, 일시 및 기간을 정하여 서면 또는 전화 등의 방법을 이용하여 해당 회원 또는 대리인에게 통지합니다.</li>
				                          <li>② 다만, 질병관리청(‘예방접종도우미’)가 긴급하게 이용을 제한해야 할 필요가 있다고 인정하는 경우에는 전항의 과정 없이 서비스 이용을 제한할 수 있습니다.</li>
				                          <li>③ 전항의 규정에 의하여 서비스 이용 중지를 통지 받은 회원 또는 그 대리인은 서비스 이용 중지에 대하여 이의신청을 할 수 있습니다.</li>
				                          <li>④ 질병관리청(‘예방접종도우미’)는 서비스 이용중지 기간 중에 그 이용중지 사유가 해소된 것이 확인된 경우에 한하여 이용중지 조치를 즉시 해제합니다.</li>
				                       </ol>
				                    </li>
				                    <li>
				                       <em>제13조 (회원의 게시물 관리)</em>
				                       <br>질병관리청(‘예방접종도우미’)는 회원이 게시하거나 등록한 내용물이 다음 사항에 해당된다고 판단되는 경우에 사전 통지 없이 삭제할 수 있습니다.
				                       <ol class="mrgT">
				                          <li>1. 타인 또는 질병관리청(‘예방접종도우미’)를 비방하거나 중상모략으로 개인, 단체 및 질병관리청(‘예방접종도우미’)의 명예를 손상시키는 내용인 경우</li>
				                          <li>2. 외설 또는 폭력적인 메시지·화상·음성, 기타 공공질서 및 미풍양속에 위반되는 내용인 경우</li>
				                          <li>3. 범죄적 행위에 부합된다고 인정되는 내용인 경우</li>
				                          <li>4. 타인의 저작권 등 기타의 권리를 침해하는 내용인 경우</li>
				                          <li>5. 기타 관계 법령이나 질병관리청(‘예방접종도우미’)에서 정한 규정에 위배되는 내용인 경우</li>
				                       </ol>
				                    </li>
				                    <li>
				                       <em>제14조(재판관할)</em>
				                       <br>질병관리청(‘예방접종도우미’)와 이용자간에 발생한 서비스 이용에 관한 분쟁에 대하여는 대한민국 법을 적용하며, 본 분쟁으로 인한 소는 민사소송법상의 관할을 가지는 대한민국의 법원에 제기합니다.
				                    </li>
				                    <li>
				                       <em>부 칙 (시행일)</em>
				                       <br>본 약관은 2002년 10월 1일부터 시행합니다.
				                    </li>
				                 </ul>
	                        </div>
	                        
	                        <div class="fw-bold mt-4" style="display:flex;">
	                        	<div class="ag-title">위 이용약관에</div>
	                            <div class="radio-inline1">
			                      <input type="radio" id="agree-clause01" class="agree-radio" name="agree-clause" value="Y"><label for="agree-clause01">동의합니다.</label>
			                      <input type="radio" id="agree-clause02" class="agree-radio" name="agree-clause" value="N"><label for="agree-clause02">동의하지 않습니다.</label>
			                    </div>
	                        </div>
                        </div>
                        <!-- second 동의 -->
                        <div class="second-agree-box mt-4" style="max-width:100%;">
	                        <div class="bg-white p-3 rounded-2 border border-secondary-subtle" style="overflow-y: scroll; max-width:100%; height:200px;">
	                            <h5>「개인정보 수집 및 이용에 대한 동의」</h5>
								<h6>1. 개인정보의 수집·이용 목적</h6>
								<ul class="list-use line">
									<li>회원 가입 및 관리를 위한 본인확인, 부정이용 방지, 민원처리</li>
								</ul>
								<h6>2. 수집하려는 개인정보의 항목</h6>
								<ul class="list-use line">
									<li>필수항목 : 계정(ID), 비밀번호, 이름, 생년월일, 휴대전화번호</li>
								</ul>
								<h6>3. 개인정보의 보유 및 이용 기간</h6>
								<ul class="list-use line">
									<li class="red">예방접종도우미 회원탈퇴 시 까지(2년 이상 접속이 없을 경우 탈퇴처리)</li>
								</ul>
								<h6>4. 동의를 거부할 권리가 있다는 사실 및 동의 거부에 따른 불이익이 있는 경우 그 불이익의 내용</h6>
								<ul class="list-use line">
									<li>수집하는 개인정보에 대해 동의를 거부할 권리가 있으며 동의 거부 시에는 회원가입, 민원서비스가 제한됩니다.</li>
								</ul>
	                        </div>
	                        <div class="fw-bold mt-4" style="display:flex;">
	                        	<div class="ag-title">위 이용약관에</div>
	                            <div class="radio-inline2">
			                      <input type="radio" id="agree-clause03" class="agree-radio"  name="agree-clause2" value="Y"><label for="agree-clause03">동의합니다.</label>
			                      <input type="radio" id="agree-clause04" class="agree-radio"  name="agree-clause2" value="N"><label for="agree-clause04">동의하지 않습니다.</label>
			                    </div>
	                        </div>
                        </div>	
                        <div class="d-flex justify-content-center mt-4">
		                    <button type="button" class="btn btn-primary me-4" onClick="fn_clause_agree()">동의</button>
		                    <button type="button" class="btn btn-primary" onClick="fn_clause_cancle()">취소</button>
	                    </div>                         
                    </div>
                    
                    <!-- 동의 후 main 페이지 -->
	            	<main class="form-sign mt-4" id="sign_form" style="display:block;">
	            		<form action="<%=contextPath%>/member/insertMember.do" method="post" name="signup" id="signupForm">
							<!-- 아이디 입력 -->
							<div class="m-auto">
								<div class="container mb-3" style="width:100%; padding:0px;">
									<div class="idcheck-box col-md-3" style="width:100%;">
										<label for="mid" class="subtitle-label form-label" style="width:100%;">아이디</label>
										<div class="idinput-box" style="display:flex;">
											<input type="text" class="form-control me-2" name="mid" id="mid" placeholder="아이디" min="5" style="width:245px;"> 
											<button type="button" id="idcheck-btn" class="btn btn-primary" onClick="fn_idcheck()">ID 확인</button>
											<div class="red ms-3 lh-lg text-center" id="midalert" style="display:none;">아이디는 필수입니다</div>
											<div class="red ms-3 lh-lg text-center" role="alert" id="midalert2" style="display:none; width:400px;">
												아이디는 5~20자의 영문 소문자, 숫자만 가능합니다.
											</div>
										</div> 
									</div>
								</div>
								
								<!-- 비밀번호 입력 -->
								<div class="container mb-3" style="width:100%; padding:0px;">
									<div class="idcheck-box col-md-3" style="width:100%;">
										<label for="mpwd" class="subtitle-label form-label" style="width:100%;">비밀번호</label>
										<div class="pwdinput-box" style="display:flex;">
											<input type="password" class="form-control" id="mpwd" name="mpwd" style="width:245px;">
											<div class="red ms-3 lh-lg" role="alert" id="mpwdalert" style="display:none;">
												비밀번호는 필수입니다
											</div>
											<div class="red ms-3 lh-lg" id="mpwdalert2" style="display:none; width:600px">
												비밀번호는 8~20자의 영문 대/소문자, 숫자와 특수문자를 포함해야 합니다.
											</div>
										</div>
									</div>
								</div>
								
								<!-- 이름 입력 -->
								<div class="container mb-3" style="width:100%; padding:0px;">
									<div class="col-md-3" style="width:100%;">
										<label for="mname" class="subtitle-label form-label" style="width:100%;">이름</label>
										<div class="nameinput-box" style="display:flex;">
											<input type="text" class="name-input form-control" placeholder="성/이름" id="mname" name="mname" style="width:245px;">
											<div class="red ms-3 lh-lg" role="alert" id="mnamealert" style="display:none; width:200px">
												이름은 필수입니다
											</div>
											<div class="red ms-3 lh-lg" role="alert" id="mnamealert2" style="display:none; width:600px">
												이름은 한글 혹은 대문자를 사용해 주세요(공백 제외)
											</div>
										</div>
										
									</div>
								</div>
	
								<!-- 주민번호 입력 -->
								<div class="container mb-3" style="width:100%; padding:0px;">
									<label for="mbirth1" class="subtitle-label form-label" style="width:100%;">주민등록번호</label>
									<div class="birthinput-box" style="display:flex;">
										<div class="col-auto birthinput1">
											<input type="text" class="form-control me-2" id="mbirth1" name="mbirth1" placeholder="123456" maxlength="6" style="width:245px;">
										</div>
										-
										<div class="col-auto birthinput2">
											<input type="text" class="form-control ms-2 me-2" id="mbirth2" name="mbirth2" style="width:40px;">
										</div>
										<div class="col-auto lh-lg">●●●●●●</div>
										<div class="red ms-3 lh-lg" role="alert" id="mbirth1alert" style="display:none; width:200px">
											생년월일은 필수입니다
										</div>
										<div class="red ms-3 lh-lg" role="alert" id="mbirth2alert" style="display:none; width:300px">
											주민번호 뒷자리의 한 자리는 필수입니다
										</div>
										<div class="red ms-3 lh-lg" role="alert" id="mbirth2alert2" style="display:none; width:200px">
											정확하게 입력해주세요
										</div>
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
										 <div class="red ms-3 lh-lg" role="alert" id="memail1alert" style="display:none; width:180px">
										 	이메일은 필수입니다
										 </div>
										 <div class="red ms-3 lh-lg" role="alert" id="memail2alert" style="display:none; width:180px">
										 	이메일은 필수입니다
										 </div>
									</div>
								</div>
								
								<!-- 인증번호 확인 -->
								<div class="container mb-3" style="width:100%; padding:0px;">
									<label for="inputNum" class="subtitle-label form-label" style="width:100%;">인증번호</label>
									<div style="width:100%; display:flex;">
										<input type="text" class="form-control me-2" id="inputNum" style="width:245px;" placeholder="인증번호 입력">
										<button type="button" class="btn btn-primary" onClick="fn_checkNum()">인증하기</button>
										<div class="green ms-3 lh-lg" role="alert" id="trueNum" style="display:none; width:250px">
										 	인증번호가 일치합니다.
										 </div>
										 <div class="red ms-3 lh-lg" role="alert" id="falseNum" style="display:none; width:420px">
										 	인증번호가 일치하지 않습니다. 다시 한 번 확인해 주세요.
										 </div>	
									</div>
								</div>
								
								<!-- 휴대폰 입력 -->
								<div class="container mb-3" style="width:100%; padding:0px;">
									<label for="mphone" class="subtitle-label form-label" style="width:100%;">휴대폰번호</label>
									<div id="phonecheck-box col-md-3" style="width:100%;">
										<div class="phoneinput-box" style="display:flex;">
											<input type="text" class="form-control me-2" id="mphone" name="mphone" style="width:245px;" maxlength="11">
											<button type="button" class="btn btn-primary" onClick="fn_phonecheck()" style="width:120px;">휴대폰 확인</button>
										</div>
										<div class="red ms-3 lh-lg" role="alert" id="mphonealert" style="display:none; width:300px">
											휴대폰은 필수입니다
										</div>
									</div>
								</div>
								
								<!-- 주소 -->
								<div class="container mb-4" style="width:100%; padding:0px;">
									<label for="maddr" class="subtitle-label form-label" style="width:100%;">주소</label>
									<div class="col-auto" style="display:flex;">
										<input type="text" class="form-control" id="maddr" name="maddr" placeholder="1234 Main St" style="width:245px;">
										<div class="red ms-3 lh-lg" role="alert" id="mphonealert" style="display:none; width:300px">
											주소는 필수입니다
										</div>
									</div>
								</div>
							</div>
							
							<div class="d-flex justify-content-center mt-4">
			                    <button type="submit" class="btn btn-primary me-4">가입하기</button>
			                    <button type="button" class="btn btn-primary" onClick="fn_before()">취소</button>
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