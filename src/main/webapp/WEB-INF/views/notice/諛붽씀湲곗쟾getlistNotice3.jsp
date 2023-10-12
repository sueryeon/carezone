<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="memVO" value="${memVO}"/>
<c:set var="adVO" value="${adVO}"/>
<%
	request.setCharacterEncoding("UTF-8");
	String contextPath=request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.min.js" integrity="sha384-Rx+T1VzGupg4BHQYs2gCW9It+akI2MM/mndMCy36UVfodzcJcF0GGLxZIzObiEfa" crossorigin="anonymous"></script>
<style>
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
<jsp:include page="../nav.jsp"/>
	<div class="container-fluid p-3 pt-4 bg-light text-dark">
		<div class="wrap-container d-flex justify-content-between">
			<div class="left me-4" style="width: 20%;">
				<div class="memform-leftwrap-container">
                  <div class="left-box ">
                     <div class="service-box">
                        <div class="mem-service form-control">
                           회원 서비스
                        </div>
                        <div class="memservice-box">
                            <a class="form-control a-loginform" href="<%=contextPath%>/member/loginForm.do">로그인</a>
                           <a class="form-control a-signform active" href="<%=contextPath%>/member/memberForm.do">회원가입</a>
                           <a class="form-control a-findform" href="#">아이디/비밀번호 찾기</a>
                        </div>
                     </div>
                  </div>
               </div>
			</div>
			<div class="right ms-4 text-center" style="width: 80%;" >
				<table class="table">
					<thead>
						<tr>
							<th scope="col" colspan="4" class="text-end" >
								<c:choose>
									<c:when test="${!empty adVO}">
										<a href="<%=contextPath%>/notice/getNoticeForm.do" class="btn btn-primary me-4">글쓰기</a>
									</c:when>
									<c:otherwise>
									</c:otherwise>
								</c:choose>
							</th>
						</tr>
						<tr>
							<th class="col-sm-2" scope="col">글번호</th>
							<th class="col-sm-6" scope="col">글제목</th>
							<th class="col-sm-2" scope="col">작성자</th>
							<th class="col-sm-2" scope="col">작성일</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="list_Notice" items="${listNotice}" >
							<tr>
								<td>${list_Notice.narticleno}</td> 
								<td class="text-start">
									<a href="<%=contextPath%>/notice/getDetailNotice.do?narticleno=${list_Notice.narticleno}">${list_Notice.ntitle}</a>
								</td>
								<td>${list_Notice.nid}</td>
								<td><fmt:formatDate value="${list_Notice.nwritedate }" pattern="yy-MM-dd" /></td>
							</tr>
					</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<jsp:include page="../footer.jsp"/>
</body>
</html>