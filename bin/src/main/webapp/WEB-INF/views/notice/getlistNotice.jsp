<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	request.setCharacterEncoding("UTF-8");
	String contextPath=request.getContextPath();
%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.min.js" integrity="sha384-Rx+T1VzGupg4BHQYs2gCW9It+akI2MM/mndMCy36UVfodzcJcF0GGLxZIzObiEfa" crossorigin="anonymous"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script> 
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
	
	
	document.addEventListener('DOMContentLoaded', function() {
	    const boardFormLink = document.querySelector('.a-boardform');
	    const qnaFormLink = document.querySelector('.a-qnaform');
	
	    qnaFormLink.classList.add('active'); // 초기에는 회원가입 링크를 활성화 상태로 표시
	    
	    boardFormLink.addEventListener('click', function() {
	        // 아이디/비밀번호 찾기 링크 클릭 시
	        boardFormLink.classList.add('active'); // 아이디/비밀번호 찾기 링크 활성화
	        qnaFormLink.classList.remove('active'); // 다른 링크 비활성화
	    });
	
	    qnaFormLink.addEventListener('click', function() {
	        // 회원가입 링크 클릭 시
	        qnaFormLink.classList.add('active'); // 회원가입 링크 활성화
	        boardFormLink.classList.remove('active'); // 다른 링크 비활성화
	    });
	});
</script>
<link rel="stylesheet" href="../resources/CSS/listQna.css">
</head>
<body>
	<jsp:include page="../nav.jsp"/>
	<div class="container-fluid p-3 pt-4 bg-light text-dark pb-5">
		<div class="wrap-container d-flex justify-content-between">
			<div class="left me-4" style="width: 20%;">
				<!-- 왼쪽 회원 서비스 -->
				<div class="qnaform-leftwrap-container">
                  <div class="qnaleft-box ">
                     <div class="qnaservice-box">
                        <div class="qnaservice form-control">
                           공지사항
                        </div>
                        <div class="card qna-service-box mt-2">
                        	<ul class="list-group list-group-flush">
							    <li class="list-group-item al-boardform"><a class="qna-alink" href="<%=contextPath%>/notice/getlistNotice.do">공지사항</a></li>
							</ul>    
                        </div>
                     </div>
                  </div>
               </div>
			</div>
			<!-- 오른쪽 -->
			<div class="right ms-4 text-center" style="width: 80%;" >
				<h3 class="border-bottom border-2 border-secondary-subtle text-start pb-3 mt-4 pt-5 mb-0"><strong>공지사항</strong></h3>
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
						<c:choose>
							<c:when test="${empty articlesMap.listNotice}">
								<tr>
									<td class="text-center" colspan="4">
										<p style="font-size:9pt;">등록된 글이 없습니다.
									</td>
								</tr>
							</c:when>
							<c:when test="${!empty articlesMap.listNotice}">
								<c:forEach var="list_Notice" items="${articlesMap.listNotice}" >
									<tr>
										<td>${list_Notice.narticleno}</td> 
										<th class="text-start">
											<a href="<%=contextPath%>/notice/getDetailNotice.do?narticleno=${list_Notice.narticleno}">${list_Notice.ntitle}</a>
										</th>
										<td>${list_Notice.nid}</td>
										<td><fmt:formatDate value="${list_Notice.nwritedate}" pattern="yy-MM-dd" /></td>
									</tr>
								</c:forEach>
							</c:when>
						</c:choose>
						<tr>
							<td colspan="4">
								<c:if test="${articlesMap.totalArticles !=null}">
									<c:choose>
										<c:when test="${articlesMap.totalArticles > 100}">
											<c:forEach var="page" begin="1" end="10" step="1">
												<c:if test="${articlesMap.pagesize>1&&page==1}">
													<a class="no_uline ms-2 me-2" href="<%=contextPath%>/notice/getlistNotice.do?pagenum=${(articlesMap.pagesize-1)*10+1}">
														&nbsp; pre
													</a>
												</c:if>
													<a class="no_uline ms-2 me-2" href="<%=contextPath%>/notice/getlistNotice.do?pagenum=${page}">
														${page}
													</a>
												<c:if test="${page==10}">
													<a class="no-uline ms-2 me-2" href="<%=contextPath%>/notice/getlistNotice.do?pagenum=${articlesMap.pagesize*10+1}">
														&nbsp; next
													</a>
												</c:if>
											</c:forEach>
										</c:when>
										<c:when test="${articlesMap.totalArticles == 100}">
											<c:forEach var="page" begin="1" end="10" step="1">
												<a class="no_uline ms-2 me-2" href="#">
													${page}
												</a>
											</c:forEach>
										</c:when>
										<c:when test="${articlesMap.totalArticles < 100}">
											<c:forEach var="page" begin="1" end="${articlesMap.totalArticles/10+1}" step="1">
												<c:choose>
													<c:when test="${page==articlesMap.pagenum}">
														<a class="sel-page ms-2 me-2 active" href="<%=contextPath%>/notice/getlistNotice.do?pagenum=${page}">
															<span style="font-weight: bold;">${page}</span> 
														</a>
													</c:when>
													<c:otherwise>
														<a class="sel-page ms-2 me-2" href="<%=contextPath%>/notice/getlistNotice.do?pagenum=${page}">
															${page}
														</a>
													</c:otherwise>
												</c:choose>
											</c:forEach>
										</c:when>
									</c:choose>
								</c:if>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<jsp:include page="../footer.jsp"/>
</body>
</html>