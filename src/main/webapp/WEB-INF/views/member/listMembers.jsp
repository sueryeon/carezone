<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String contextPath = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
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
<title>회원 목록 창</title>
</head>
<body>
	<jsp:include page="../nav.jsp"/>
	<table class="table table-striped">
	  <thead>
	    <tr>
	      <th scope="col">아이디</th>
	      <th scope="col">비밀번호</th>
	      <th scope="col">이름</th>
	      <th scope="col">생년월일</th>
	      <th scope="col">성별</th>
	      <th scope="col">이메일</th>
	      <th scope="col">휴대폰번호</th>
	      <th scope="col">주소</th>
	      <th scope="col">수정하기</th>
	      <th scope="col">삭제하기</th>
	    </tr>
	  </thead>
	  <tbody>
		  <c:forEach var="member" items="${membersList}">
				<tr>
					<th scope="row">${member.mid }</th>
					<td>${member.mpwd }</td>
					<td>${member.mname }</td>
					<td>${member.mbirth1 }</td>
					<td>${member.mbirth2 }</td>
					<td>${member.memail1 } @ ${member.memail2 }</td>
					<td>${member.mphone }</td>
					<td>${member.maddr }</td>
					<td><a href="<%=contextPath%>/member/findMember.do?mid=${member.mid}">수정하기</a></td>
					<td><a href="<%=contextPath%>/member/deleteMember.do?mid=${member.mid}">삭제하기</a></td>
				</tr>
			</c:forEach>
	  </tbody>
	</table>
	<jsp:include page="../footer.jsp"/>
</body>
</html>