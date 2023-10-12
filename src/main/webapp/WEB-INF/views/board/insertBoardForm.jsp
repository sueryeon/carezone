<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"
    import = "javax.servlet.http.HttpSession"
    import = "carezone.member.vo.MemberVO"
    %>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% 
	String contextPath = request.getContextPath();
	MemberVO memVO = (MemberVO) session.getAttribute("memVO");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.min.js" integrity="sha384-Rx+T1VzGupg4BHQYs2gCW9It+akI2MM/mndMCy36UVfodzcJcF0GGLxZIzObiEfa" crossorigin="anonymous"></script>
<script>
	function fn_boardCancel(){
		var cancelurl = "<%=contextPath%>/board/listBoards.do";
		window.location.href=cancelurl;
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

.btn-outline-primary{
   border-color:#3f78bf !important;
   color:#3f78bf !important;
}

.btn-outline-primary:hover{
	background-color: #3f78bf !important;
	color: white !important;
}

.btn-outline-primary a{
	text-decoration: none;
	color: white;
}
</style>
<title>글쓰기 창</title>
</head>
<body>
	<jsp:include page="../nav.jsp"/>
	<div class="container-fluid p-3 pt-4 bg-light text-dark pb-5">
		<div class="wrap-container justify-center">
			<h3 class="border-bottom border-2 border-secondary-subtle text-start pb-3 mt-4 pt-5 mb-0"><strong>글쓰기</strong></h3>
			<div class="mt-4" style="width:100%;">
				<form action="<%=contextPath%>/board/insertBoard.do" method="post" enctype="multipart/form-data">
					<input type="hidden" value="<%=memVO.getMid() %>" id="bid" name="bid">
					<div class="mb-3">
					  	<input type="text" class="form-control" id="btitle" name="btitle" placeholder="제목을 입력하세요">
					</div>
					<div class="mb-3">
					  <label for="exampleFormControlTextarea1" class="form-label">글 내용</label>
					  <textarea class="form-control" id="bcontent" name="bcontent" rows="3" style="min-height:200px;"></textarea>
					</div>
					<div class="mb-3">
				  		<input class="form-control" type="file" id="bimgFile" name="bimgFile">
					</div>
					<input type="submit" class="btn btn-outline-primary me-2" value="글작성">
					<input type="button" class="btn btn-outline-primary" onClick="fn_boardCancel()" value="취소">
				</form>
			</div>
		</div>
	</div>
	
	<jsp:include page="../footer.jsp"/>
</body>
</html>