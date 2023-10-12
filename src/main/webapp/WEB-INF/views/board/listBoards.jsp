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
	
	}
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
	
	document.addEventListener('DOMContentLoaded', function() {
	    const boardFormLink = document.querySelector('.a-boardform');
	    const qnaFormLink = document.querySelector('.a-qnaform');
	
	    boardFormLink.classList.add('active'); // 초기에는 회원가입 링크를 활성화 상태로 표시
	    
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

<link rel="stylesheet" href="../resources/CSS/listBoards.css">
<title>커뮤니티</title>
</head>
<body>
	<jsp:include page="../nav.jsp"/>
	<div class="container-fluid p-3 pt-4 bg-light text-dark pb-5">
		<div class="wrap-container d-flex justify-content-between">
			<!-- 왼쪽 -->
			<div class="left me-4" style="width: 20%;">
				<!-- 왼쪽 회원 서비스 -->
				<div class="boardform-leftwrap-container">
					<div class="boardleft-box">
						<div class="boardservice-box">
							<div class="boardservice form-control">
	                           커뮤니티
	                        </div>
	                        <div class="card board-service-box mt-2">
			                  	<ul class="list-group list-group-flush">
								    <li class="list-group-item a-boardform active"><a class="board-alink" href="<%=contextPath%>/board/listBoards.do">게시판</a></li>
								    <li class="list-group-item a-qnaform"><a class="board-alink" href="<%=contextPath%>/qna/getlistQna.do">QnA</a></li>
							   </ul>
		                   </div>
                        </div>
                    </div>
                </div>
			</div>
			<div class="right ms-4 text-center" style="width: 80%;" >
				<h3 class="border-bottom border-2 border-secondary-subtle text-start pb-3 mt-4 pt-5 mb-0"><strong>게시판</strong></h3>
				<table class="table">
					<thead>
						<tr>
							<th scope="col" colspan="4" class="text-end" >
								<a href="#" onClick="fn_insertBoard()" class="btn btn-primary me-4">글쓰기</a>
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
					  		<c:when test="${empty boardsMap.boardList }">
					  			<tr  height="10">
							      <td colspan="4">
							         <p align="center" style="font-size:9pt;">
							           등록된 글이 없습니다.
							        </p>
							      </td>  
							    </tr>
					  		</c:when>
					  		<c:when test="${!empty boardsMap.boardList }">
					  			<c:forEach var="board" items="${boardsMap.boardList}">
									<tr>
										<td>${board.barticleNo }</td>
										<th class="text-start" scope="row"><a href="<%=contextPath%>/board/findBoard.do?barticleNo=${board.barticleNo}" class="write-link">${board.btitle}</a></th>
										<td>${board.bid }</td>
										<td><fmt:formatDate value="${board.bwriteDate}" pattern="yy-MM-dd"/></td>
									</tr>
								</c:forEach>
					  		</c:when>
					  	</c:choose>
					  	<tr>
					  		<td colspan="4">
					  			<c:if test="${boardsMap.countArticleNo!=null}">
									<c:choose>
										<c:when test="${boardsMap.countArticleNo > 100 }">
											<c:forEach var="page" begin="1" end="10" step="1">
												<c:if test="${boardsMap.pagesize > 1 && page==1 }">
													<a class="no_uline ms-2 me-2" href="<%=contextPath%>/board/listBoards.do?pagesize=${boardsMap.pagesize-1}&pagenum=${(boardsMap.pagesize-1)*10+1}">&nbsp; pre</a>
												</c:if>
													<a class="no-uline ms-2 me-2" href="<%=contextPath%>/board/listBoards.do?pagesize=${boardsMap.pagesize}&pagenum=${page}">${(boardsMap.pagesize-1)*10+page}</a>
												<c:if test="${page==10 }">
													<a class="no-uline ms-2 me-2" href="<%=contextPath%>/board/listBoards.do?pagesize=${boardsMap.pagesize+1}&pagenum=${boardsMap.pagesize*10+1}">&nbsp; next</a>
												</c:if>
											</c:forEach>
										</c:when>
										<c:when test="${boardsMap.countArticleNo == 100 }">
											<c:forEach var="page" begin="1" end="10" step="1">
												<a class="no-uline ms-2 me-2" href="#">${page}</a>
											</c:forEach> 
										</c:when>
										
										<c:when test="${boardsMap.countArticleNo < 100 }">
											<c:forEach var="page" begin="1" end="${boardsMap.countArticleNo/10 +1 }" step="1">
												<c:choose>
													<c:when test="${page==boardsMap.pagenum }">
														<a class="sel-page ms-2 me-2 active" href="<%=contextPath%>/board/listBoards.do?pagesize=${boardsMap.pagesize}&pagenum=${page}"><span style="font-weight: bold;">${page}</span></a>
													</c:when>
													<c:otherwise>
														<a class="no-uline ms-2 me-2" href="<%=contextPath%>/board/listBoards.do?pagesize=${boardsMap.pagesize}&pagenum=${page}">${page}</a>
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