<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.min.js" integrity="sha384-Rx+T1VzGupg4BHQYs2gCW9It+akI2MM/mndMCy36UVfodzcJcF0GGLxZIzObiEfa" crossorigin="anonymous"></script>

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
</script>
</head>
<body>
	<form action="<%=request.getContextPath()%>/reservation/updateReservation.do" method="post">
		<input type="hidden" name="rno" value="${rsvVO.rno}">
  		<div class="col-md-6">
			이름 : <input type="text" class="form-control" name="rname" value="${rsvVO.rname}" disabled>
  		</div>
  		<div class="row">
  			생년월일 : <div class="col">
				<input type="text" class="form-control" name="rbirth1" value="${rsvVO.rbirth1}" disabled>
	  		</div>
	  		-
	  		<div class="col">
				<input type="number" class="form-control" name="rbirth2" value="${rsvVO.rbirth2}" disabled>
	  		</div>
  		</div>
		<div class="col-md-6">
			폰번호 : <input type="text" class="form-control" name="rphone" value="${rsvVO.rphone}" disabled>
  		</div>
  		<div class="col-md-6">
			병원 : <input type="text" class="form-control" name="rhospital" value="${rsvVO.rhospital}">
  		</div>
  		<div class="col-md-6">
			백신 : <input type="text" class="form-control" name="rvcc" value="${rsvVO.rvcc}"> 
  		</div>
  		<div class="col-md-6">
			예약날짜 : <input type="date" class="form-control" name="rdate" value="${rsvVO.rdate}">
  		</div>
		<div class="col-12">
			<button type="submit" class="btn btn-primary">예약수정하기</button>
		</div>
	</form>
</body>
</html>