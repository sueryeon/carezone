<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String contextPath = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.min.js" integrity="sha384-Rx+T1VzGupg4BHQYs2gCW9It+akI2MM/mndMCy36UVfodzcJcF0GGLxZIzObiEfa" crossorigin="anonymous"></script>

</head>
<body>
	<jsp:include page="../nav.jsp"/>
	<h2>백신 장바구니</h2>
	<table class="table table-striped">
		<thead>
			<tr>
				<th scope="col">병원 이름</th>
				<th scope="col">백신 이름</th>
				<th scope="col">예약하기</th>
				<th scope="col">삭제하기</th>
			</tr>
		</thead>
		
		<tbody>
			<c:choose>
				<c:when test="${!empty memVO }">
					<c:choose>
						<c:when test="${!empty hoscartList}">
							<c:forEach var="hoscart" items="${hoscartList }">
								<tr>
									<td>${hoscart.hchosname }</td>
									<td>${hoscart.hcvccname }</td>
									<td><a href="<%=contextPath%>/reservation/getreservationForm.do?hcno=${hoscart.hcno}&hosname=${hoscart.hchosname }&vccname=${hoscart.hcvccname }&hos_no=${hoscart.hchosno}">예약</a></td>
									<td><a href="<%=contextPath%>/hoscart/deleteMyHosCart.do?hcno=${hoscart.hcno}">삭제</a></td>
								</tr>
							</c:forEach>
						</c:when>
						<c:when test="${empty hoscartList }">
							
						</c:when>
					</c:choose>
				</c:when>
				<c:when test="${empty memVO }">
					<tr>
						<td colspan="4">장바구니가 비었습니다.</td>
					</tr>
				</c:when>
			</c:choose>
		
			
		</tbody>
	</table>
	<jsp:include page="../footer.jsp"/>

</body>
</html>