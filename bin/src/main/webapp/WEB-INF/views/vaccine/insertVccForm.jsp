<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"
    import="java.util.Date" %>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String contextPath = request.getContextPath();
	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.min.js" integrity="sha384-Rx+T1VzGupg4BHQYs2gCW9It+akI2MM/mndMCy36UVfodzcJcF0GGLxZIzObiEfa" crossorigin="anonymous"></script>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script> 
<script src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script src="https://cdn.jsdelivr.net/momentjs/latest/moment-timezone.min.js"></script>

<title>백신 정보 입력</title>
</head>
<body>
	<form action="<%=contextPath%>/board/insertVcc.do" method="post">
		<div class="mb-3">
		  	<input type="text" class="form-control" name="vname" placeholder="백신 이름">
		</div>
		
		<div class="mb-3">
		  <label for="exampleFormControlTextarea1" class="form-label">글 내용</label>
		  <textarea class="form-control" name="vtitle" rows="3"></textarea>
		</div>
		
		<div class="mb-3">
		  <label for="exampleFormControlTextarea1" class="form-label">글 내용</label>
		  <textarea class="form-control" name="vsubtitle" rows="3"></textarea>
		</div>
		
		<div class="mb-3">
		  <label for="exampleFormControlTextarea1" class="form-label">글 내용</label>
		  <textarea class="form-control" name="vspread" rows="3"></textarea>
		</div>
		
		<div class="mb-3">
		  <label for="exampleFormControlTextarea1" class="form-label">글 내용</label>
		  <textarea class="form-control" name="vcare" rows="3"></textarea>
		</div>
		
		<div class="mb-3">
		  <label for="exampleFormControlTextarea1" class="form-label">글 내용</label>
		  <textarea class="form-control" name="vprevent" rows="3"></textarea>
		</div>
		
		<div class="mb-3">
		  <label for="exampleFormControlTextarea1" class="form-label">글 내용</label>
		  <textarea class="form-control" name="vperiod" rows="3"></textarea>
		</div>
		
		<div class="mb-3">
		  <label for="exampleFormControlTextarea1" class="form-label">글 내용</label>
		  <textarea class="form-control" name="vcaution" rows="3"></textarea>
		</div>
		
		<div class="mb-3">
		  <label for="exampleFormControlTextarea1" class="form-label">글 내용</label>
		  <textarea class="form-control" name="vallergy" rows="3"></textarea>
		</div>
		<input type="submit" class="btn btn-primary" value="글작성">
	</form>
</body>
</html>