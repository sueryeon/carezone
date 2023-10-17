<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"
    import="java.util.Date"
    import = "javax.servlet.http.HttpSession"
    import = "carezone.member.vo.MemberVO"
    %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<%	String contextPath = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<c:set var="memVO" value="${memVO}"/>
<c:set var="adVO" value="${adVO}"/>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.min.js" integrity="sha384-Rx+T1VzGupg4BHQYs2gCW9It+akI2MM/mndMCy36UVfodzcJcF0GGLxZIzObiEfa" crossorigin="anonymous"></script>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script> 
<script src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>

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

	//페이지 로딩 시 세션 아이디와 게시글 아이디 비교하기
	$(document).ready(function(){

		   
		   var adid = "${adVO.adid}";

		   var updateBtn = document.getElementById("updateBtn");
		   var deleteBtn = document.getElementById("deleteBtn");
		   if(adid){
			   updateBtn.style.display="block";
			   deleteBtn.style.display="block";
		   }
		   else{
			   updateBtn.style.display="none";
			   deleteBtn.style.display="none";
		   }

	});
	
	
	   function readURL(input){
		      if(input.files&&input.files[0]){
		         var reader=new FileReader();
		         reader.onload=function(e){
		            $('#preview').attr('src',e.target.result);
		         }
		         reader.readAsDataURL(input.files[0]);
		      }
		   }
		   
	   //이전
		   function backToList(obj){
		      obj.action = "${contextPath}/notice/getlistNotice.do";
		      obj.submit();
		   }
		 
	   //글수정
		   function fn_update_qna(obj){
		      
			   	document.getElementById("ntitle").disabled = false;
				document.getElementById("ncontent").disabled = false;
				document.getElementById("i_nimgfile").disabled=false;
				var updateBtn = document.getElementById("updateBtn");
				var deleteBtn = document.getElementById("deleteBtn");
				var noUpdate = document.getElementById("noUpdate");
				var noCancel = document.getElementById("noCancel");
				
				updateBtn.style.display="none";
				deleteBtn.style.display="none";
				noUpdate.style.display="block";
				noCancel.style.display="block";
		   
		   }
	   
	   //수정취소
	   
	   function fn_backBoard(obj){
		document.getElementById("ntitle").disabled = true;
		document.getElementById("ncontent").disabled = true;
		document.getElementById("i_nimgfile").disabled=true;
		var updateBtn = document.getElementById("updateBtn");
		var deleteBtn = document.getElementById("deleteBtn");
		var noUpdate = document.getElementById("noUpdate");
		var noCancel = document.getElementById("noCancel");
		
		updateBtn.style.display="block";
		deleteBtn.style.display="block";
		noUpdate.style.display="none";
		noCancel.style.display="none";
	}
	   //글수정
	   function fn_modify_article(narticleno){
		var url = "${contextPath}/notice/updateNotice.do?narticleno="+narticleno;
	    // 파일 선택 여부 확인
	    var selectedFile = document.getElementById("i_nimgfile").files[0];
	    if (selectedFile=='null') {
	        // 파일 선택하지 않은 경우 기존 파일 이름 사용
	        document.getElementsByName("nimgfile")[0].value = "${noticeVO.nimgfile}";
	    }
		document.forms[0].action = url;
		document.forms[0].submit();
	 }
	   
		   //글삭제
		   function fn_delete_qna(obj){
		      
		      alert("삭제되었습니다.");
		      
		      var narticleno=${noticeVO.narticleno};
		      obj.action = "${contextPath}/notice/deleteNotice.do?narticleno="+narticleno;
		      obj.submit();
		   }
		   
</script>
<link rel="stylesheet" href="../resources/CSS/findBoard.css">
<title>게시글 수정</title>
</head>
<body>
	<jsp:include page="../nav.jsp"/>
	<div class="container-fluid p-3 pt-4 bg-light text-dark pb-5">
		<div class="wrap-container d-flex justify-content-between">
			<div class="left me-4" style="width: 20%;">
				<!-- 왼쪽 회원 서비스 -->
				<div class="boardform-leftwrap-container">
					<div class="boardleft-box">
						<div class="boardservice-box">
							<div class="boardservice form-control">
	                           공지사항
	                        </div>
	                        <div class="card board-service-box mt-2">
			                  	<ul class="list-group list-group-flush">
									<li class="list-group-item al-boardform"><a class="qna-alink" href="<%=contextPath%>/notice/getlistNotice.do">공지사항</a></li>
							   </ul>
		                   </div>
                        </div>
                    </div>
                </div>
			</div>
             <!-- 오른쪽 -->
            <div class="right ms-4" style="width: 80%;" >
				<h3 class="border-bottom border-2 border-secondary-subtle text-start pb-3 mt-4 pt-5 mb-4"><strong>공지사항</strong></h3>
				<form name="NoticeArticle" action="${contextPath}/" method="post" enctype="multipart/form-data">
					<input type="hidden" value="${noticeVO.nid }" id="nid" name="nid">
					<div class="mb-3">
					<label for="ntitle" class="form-label">글 제목</label>
					  	<input type="text" class="form-control" id="ntitle" name="ntitle" value="${noticeVO.ntitle}" disabled>
					</div>
					<div class="mb-3">
					  <label for="bcontent" class="form-label">글 내용</label>
					  <textarea class="form-control" id="ncontent" name="ncontent" rows="3" disabled>${noticeVO.ncontent }</textarea>
					</div>
					<div class="mb-3">
						<c:choose>
							<c:when test="${not empty qnaVO.qimgfile && qnaVO.qimgfile !='null' }">
								<input type="hidden" name="originalFileName" value="${noticeVO.nimgfile}">
								<img class="preview" src="<%=contextPath%>/download.do?narticleno=${noticeVO.narticleno}&nimgfile=${noticeVO.nimgfile}" height=300>
								<input type="file" class="form-control" name="nimgfile" id="i_nimgfile" value="${noticeVO.nimgfile}" disabled onchange="fn_readImg(this);">
							</c:when>
					  		<c:otherwise>
					  			<div id="tr_file_upload">
					  				<img class="preview" src="" height=300><br><br>
					  				<input type="hidden" name="originalFileName" value="${noticeVO.nimgfile}">
					  				<input type="file" class="form-control" name="nimgfile" id="i_nimgfile" value="${noticeVO.nimgfile}" disabled onchange="fn_readImg(this);">
					  			</div>
					  		</c:otherwise>
						</c:choose>
						<br>
					</div>
					<div class="d-flex">
						<input type=button value="수정하기" class="btn btn-primary me-2" id="updateBtn" onClick="fn_update_qna(this.form)" style="display:block;">
						<input type=button value="삭제하기" class="btn btn-primary me-2" id="deleteBtn" onClick="fn_delete_qna(this.form)" style="display:block;">
					
						<input type=button value="수정반영하기" class="btn btn-primary me-2" id="noUpdate" onClick="fn_modify_article(${noticeVO.narticleno})" style="display:none;">
						<input type=button value="취소" class="btn btn-primary me-2" id="noCancel" onClick="fn_backBoard(this.form)" style="display:none;">
						
						<input type=button class="btn btn-primary" value="이전"  onClick="backToList(this.form)">
					</div>		
				</form>	
		    </div>
		</div>
	</div>
	<jsp:include page="../footer.jsp"/>
</body>
</html>