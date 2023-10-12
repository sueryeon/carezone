<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<% String contextPath = request.getContextPath(); 
	String mid= request.getParameter("mid");
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
		
		let famadd = document.famadd;
		famadd.onsubmit = function(){
			var fname = famadd.fname.value;
			var fbirth1 = famadd.fbirth1.value;
			var fphone = famadd.fphone.value;
			var faddr = famadd.faddr.value;
			
			/*이름 유효성 검 사*/
			if(!fname){
				//fname의 값이 없을때
				var fnamealert = document.getElementById("fnamealert");
				var fnamealert2 = document.getElementById("fnamealert2");
				fnamealert.style.display="block";
				fnamealert2.style.display="none";
				famadd.fname.focus();
				return false;
			}
			else if (fname){
				//fname 값이 있을 때
				var fnamealert = document.getElementById("fnamealert");
				var fnamealert2 = document.getElementById("fnamealert2");
				
				var pattern = /^([A-Z]+|[가-힣]+)$/;
				var space=/\s/;
				
				if(space.test(fname)){
					//공백이 포함되어 있을 때
					fnamealert.style.display="none";
					fnamealert2.style.display="block";
					famadd.fname.focus();
					return false;
				}
				
				if(fname.length<2 || !pattern.test(fname)){
					//길이가 2보다 작거나 pattern과 일치하지 않을 때
					fnamealert2.style.display="block";
					fnamealert.style.display="none";
					famadd.fname.focus();
					return false;
				}
				else{
					fnamealert.style.display="none";
					fnamealert2.style.display="none";
				}
			}
			
			/*생년월일 유효성 검사*/
			if(!fbirth1){
				//생년월일 비어있을 때
				var fbirth1alert = document.getElementById("fbirth1alert");
				var fbirth2alert2 = document.getElementById("fbirth2alert2");
				fbirth1alert.style.display="block";
				fbirth2alert2.style.display="none";
				famadd.fbirth1.focus();
				return false;
			}
			else if(fbirth1){
				//생년월일 값이 있을 때
				var fbirth1alert = document.getElementById("fbirth1alert");
				var fbirth2alert2 = document.getElementById("fbirth2alert2");
				fbirth1alert.style.display="none";
				
				var currentDate = new Date();
            	var crrentYear = currentDate.getFullYear();
            	var year = parseInt(fbirth1.substring(0,2),10);
            	var month = parseInt(fbirth1.substring(2,4),10);
            	var day = parseInt(fbirth1.substring(4,6),10);
            	var daysInMonth = new Date(year+1900, month,0).getDate();
            	console.log(daysInMonth);
				
				if((month<0||month>12) || (day<1||day>daysInMonth)){
					fbirth2alert2.style.display="block";
					famadd.fbirth1.focus();
					return false;
				}
				else{
					fbirth2alert2.style.display="none";
				}
			}
		}
	}
	
	function fn_fphonecheck(){
		var check_fphone = document.getElementById("fphone").value;
		if(!check_fphone){
			var fphonealert = document.getElementById("fphonealert");
			fphonealert.style.display="block";
			famadd.fphone.focus();
			return false;
		}
		else if(check_fphone){
			$.ajax({
				url:"<%=contextPath%>/member/fphonecheck.do",
				data:{checkfphone:check_fphone},
				type:"post",
				success:function(data,textStatus){
					if(data=='1'){
						alert('이미 등록된 번호입니다.');
						document.getElementById("fphone").value="";
						document.getElementById("fphone").focus();
					}
					else{
						alert('등록 가능한 번호입니다.');
						document.getElementById("faddr").focus();
					}
				},
				error:function(data,textStatus){},
				complete:function(data,textStatus){}
			});
		}
	}
	
	function fn_finsertCancel(){
		var fcancelUrl = "<%=contextPath%>/member/listFamilyMembers.do";
		window.location.href=fcancelUrl;
	}

</script>
<link rel="stylesheet" href="../resources/CSS/findMember.css">
<style type="text/css">
.checkalert{
	color: #e51e3e !important;
	text-align: left;
}
</style>
<title>가족 추가하기</title>
</head>
<body>
	<jsp:include page="../nav.jsp"/>
	<div class="container-fluid p-3 pt-4 bg-light text-dark pb-5">
		<div class="wrap-container d-flex justify-content-between">
			<div class="left me-4" style="width: 20%;">
				<!-- 왼쪽 회원 서비스 -->
				<div class="leftwrap-container">
                  <div class="mypgleft-box">
                     <div class="mypgservice-box">
                        <div class="mypgservice form-control">
                           마이페이지
                        </div>
                        <div class="card mypg-service-box mt-2">
                        	<ul class="list-group list-group-flush">
							    <li class="list-group-item al-mypgform"><a class="qna-alink" href="<%=contextPath%>/member/findMember.do?action=member">회원정보 수정</a></li>
							    <li class="list-group-item al-myrsvlistform"><a class="qna-alink" href="<%=contextPath%>/reservation/getlistMyReservations.do?action=mypage">나의 예약 내역</a></li>
							    <li class="list-group-item al-mflistform"><a class="qna-alink" href="<%=contextPath%>/member/listFamilyMembers.do">가족 조회</a></li>
							    <li class="list-group-item al-mfinsertform active"><a class="qna-alink" href="<%=contextPath%>/member/FamFormMember.do">가족 추가</a></li>
						   		<li class="list-group-item al-mfrsvlistform"><a class="qna-alink" href="<%=contextPath%>/reservation/getlistFamReservations.do">가족 예약 내역</a></li>
						   </ul>    
                        </div>
                     </div>
                  </div>
               </div>
			</div>
			<!-- 오른쪽 -->
			<div class="right ms-4" style="width: 80%;" >
				<h3 class="border-bottom border-2 border-secondary-subtle text-start pb-3 mt-4 pt-5 mb-0"><strong>가족 추가</strong></h3>
				<div class="right-box mt-4 mb-4">
					<form action="<%=contextPath%>/member/insertFamilyMember.do" method="post" name="famadd" id="famaddForm">
						<!-- 가족의 이름 -->
						<div class="mb-3">
							<label for="fname" class="form-label">이름</label>
							<div class="col-md-3" style="display:flex; width:100%;">
								<input type="text" class="form-control" placeholder="이름" id="fname" name="fname" maxlength="6" style="width:245px;">
								<div class="checkalert ms-3 lh-lg" role="alert" id="fnamealert" style="display:none; width:200px">
									이름은 필수입니다
								</div>
								<div class="checkalert ms-3 lh-lg" role="alert" id="fnamealert2" style="display:none; width:600px">
									이름은 한글 혹은 대문자를 사용해 주세요(공백 제외)
								</div>
							</div>
						</div>
						<!-- 가족의 생년월일 -->
						<div class="mb-3">
							<label for="fbirth1" class="form-label">생년월일</label>
							<div class="col-md-3" style="display:flex; width:100%;">
								<input type="text" class="form-control" id="fbirth1" name="fbirth1" placeholder="123456" style="width:245px;">
								<div class="checkalert ms-3 lh-lg" role="alert" id="fbirth1alert" style="display:none; width:200px">
									생년월일은 필수입니다
								</div>
								<div class="checkalert ms-3 lh-lg" role="alert" id="fbirth2alert2" style="display:none; width:200px">
									정확하게 입력해주세요
								</div>
							</div>
						</div>
						<!-- 가족의 휴대폰 번호 -->
						<div class="mb-3" style="width:100%; padding:0px;">
							<label for="fphone" class="form-label" style="width:100%;">휴대폰번호</label>
							<div class="col-md-3" style="display:flex; width:100%;">
								<input type="text" class="form-control me-3" id="fphone" name="fphone" style="width:245px;" maxlength="11">
								<button type="button" class="btn btn-outline-primary" onClick="fn_fphonecheck()" style="width:120px;">휴대폰 확인</button>
							</div>
						</div>
						
						<!-- 가족의 주소 -->
						<div class="mb-3">
							<div class="col-4">
								<label for="faddr" class="form-label">주소</label>
								<input type="text" class="form-control" id="faddr" name="faddr" style="width:245px;">
							</div>
						</div>
						<div class="famBtn">
							<button type="submit" class="btn btn-primary">추가하기</button>
							<button type="button" class="btn btn-primary" onClick="fn_finsertCancel()">취소</button>
						</div>
						
					</form>		
				
				</div>
			</div>
		</div>
	</div>
<jsp:include page="../footer.jsp"/>
</body>
</html>