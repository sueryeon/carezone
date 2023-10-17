<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
	function fn_insertBoard(){
		var action = "board";
		var isLogin = "${isLogin}";
		var isAdminLogin = "${isAdminLogin}";
		if(isLogin=="false"||isLogin==""){
			if (confirm("로그인 후 진행해 주세요")) {
	            // 사용자가 확인을 선택한 경우 action 값을 URL로 전달하고 이동합니다.
	            var loginurl = "<%=contextPath%>/member/loginForm.do?action=" + action;
	            window.location.href = loginurl;
	        }
		}
		else{
			var addBoardUrl = "<%=contextPath%>/board/insertBoardForm.do";
			window.location.href=addBoardUrl;
		}
	}
</script>

<style>
	.black-link{
		color: black;
		text-decoration: none;
	}
	.black-link:hover{
		color: blue;
		text-decoration: underline;
	}
</style>
<title>커뮤니티</title>
</head>
<body>
	<jsp:include page="../nav.jsp"/>
	<a href="<%=contextPath%>/">메인</a>
	<a href="#" onClick="fn_insertBoard()">글쓰기</a>
	<table class="table table-striped">
	  <thead>
	    <tr>
	    <th scope="col">글번호</th>
	      <th scope="col">제목</th>
	      <th scope="col">작성자</th>
	      <th scope="col">작성일</th>
	    </tr>
	  </thead>
	  <tbody>
	  	<c:choose>
	  		<c:when test="${empty boardsMap.boardList }">
	  			<tr  height="10">
			      <td colspan="4">
			         <p align="center">
			            <b><span style="font-size:9pt;">등록된 글이 없습니다.</span></b>
			        </p>
			      </td>  
			    </tr>
	  		</c:when>
	  		<c:when test="${!empty boardsMap.boardList }">
	  			<c:forEach var="board" items="${boardsMap.boardList}">
					<tr>
						<td>${board.barticleNo }</td>
						<th scope="row"><a href="<%=contextPath%>/board/findBoard.do?barticleNo=${board.barticleNo}" class="black-link">${board.btitle}</a></th>
						<td>${board.bid }</td>
						<td><fmt:formatDate value="${board.bwriteDate}" pattern="yy-MM-dd HH:mm"/></td>
					</tr>
				</c:forEach>
	  		</c:when>
	  	</c:choose>
	  </tbody>
	</table>
	
	<div class="class2">
		<c:if test="${boardsMap.countArticleNo!=null}">
			<c:choose>
				<c:when test="${boardsMap.countArticleNo > 100 }">
					<c:forEach var="page" begin="1" end="10" step="1">
						<c:if test="${boardsMap.pagesize > 1 && page==1 }">
							<a class="no_uline" href="<%=contextPath%>/board/listBoards.do?pagesize=${boardsMap.pagesize-1}&pagenum=${(boardsMap.pagesize-1)*10+1}">&nbsp; pre</a>
						</c:if>
							<a class="no-uline" href="<%=contextPath%>/board/listBoards.do?pagesize=${boardsMap.pagesize}&pagenum=${page}">${(boardsMap.pagesize-1)*10+page}</a>
						<c:if test="${page==10 }">
							<a class="no-uline" href="<%=contextPath%>/board/listBoards.do?pagesize=${boardsMap.pagesize+1}&pagenum=${boardsMap.pagesize*10+1}">&nbsp; next</a>
						</c:if>
					</c:forEach>
				</c:when>
				
				<c:when test="${boardsMap.countArticleNo == 100 }">
					<c:forEach var="page" begin="1" end="10" step="1">
						<a class="no-uline" href="#">${page}</a>
					</c:forEach> 
				</c:when>
				
				<c:when test="${boardsMap.countArticleNo < 100 }">
					<c:forEach var="page" begin="1" end="${boardsMap.countArticleNo/10 +1 }" step="1">
						<c:choose>
							<c:when test="${page==boardsMap.pagenum }">
								<a class="sel-page" href="<%=contextPath%>/board/listBoards.do?pagesize=${boardsMap.pagesize}&pagenum=${page}">${page}</a>
							</c:when>
							<c:otherwise>
								<a class="no-uline" href="<%=contextPath%>/board/listBoards.do?pagesize=${boardsMap.pagesize}&pagenum=${page}">${page}</a>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</c:when>
			</c:choose>
		</c:if>
	</div>
	<jsp:include page="../footer.jsp"/>
</body>
</html>