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
<style>
a{
text-decoration: none;
}
</style>
</head>
<body>
	<jsp:include page="../nav.jsp"/>
	<a href="<%=contextPath%>/">홈</a>
	<a href="<%=contextPath%>/qna/getqnaForm.do">글쓰기</a>
	<table class="table table-striped">
		<thead>

			<tr>
				<th scope="col">문의현황</th>
				<th scope="col">글제목</th>
				<th scope="col">글작성자</th>
				<th scope="col">작성일</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="list_Qna" items="${listQna}" >
				<tr>
					<td>공백</td> 
					<td>
						<a href="<%=contextPath%>/qna/getDetailQna.do?qarticleno=${list_Qna.qarticleno}">${list_Qna.qtitle}</a>
					</td>
					<td>${list_Qna.qid}</td>
					<td><fmt:formatDate value="${list_Qna.qwritedate }" pattern="yy-MM-dd HH:mm" /> </td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<jsp:include page="../footer.jsp"/>
</body>
</html>