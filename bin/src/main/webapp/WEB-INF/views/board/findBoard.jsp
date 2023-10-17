<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"
    import="java.util.Date"
    import = "javax.servlet.http.HttpSession"
    import = "carezone.member.vo.MemberVO"
    %>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%	String contextPath = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.min.js" integrity="sha384-Rx+T1VzGupg4BHQYs2gCW9It+akI2MM/mndMCy36UVfodzcJcF0GGLxZIzObiEfa" crossorigin="anonymous"></script>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script> 
<script src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>

<script type="text/javascript">
	
	//페이지 로딩 시 세션 아이디와 게시글 아이디 비교하기
	$(document).ready(function(){
		   // 댓글 가져오기
		   fn_allreply();
		   
		   var mid = "${memVO.mid}";
		   var adid = "${adVO.adid}";
		   //console.log("adid : "+adid);
		   var bid = "${boardVO.bid}";
		   var updateBtn = document.getElementById("updateBtn");
		   var deleteBtn = document.getElementById("deleteBtn");
		   var brbox = document.getElementById("brbox");
		   
		   if(mid == bid){
			   updateBtn.style.display="block";
			   deleteBtn.style.display="block";		   
		   }
		   else{
			   updateBtn.style.display="none";
			   deleteBtn.style.display="none";
		   }
		   
		   if(mid.length!=0 || adid.length!=0){
			   brbox.style.display="block";
		   }
		   else{
			   brbox.style.display="none";
		   }

	});

	
	//댓글 전체 조회
	function fn_allreply(){
		
		var mid = "${memVO.mid}";
		var adid = "${adVO.adid}";
	    var _brparentNo = $('#brparentNo').val();
	    $.ajax({
	        url: "<%=contextPath%>/board/listBReplys.do",
	        data: { brparentNo: _brparentNo },
	        type: "get",
	        success: function(data, textStatus){
	            var replyList = "";
	            var replyInfo = JSON.parse(data);
	            if(replyInfo!=null){
	            	for (var i in replyInfo.replys) {
		                var brwriteDate = replyInfo.replys[i].brwriteDate;
		                var momentDate = moment(brwriteDate, "ddd MMM DD HH:mm:ss Z YYYY");
		                var formattedDate = momentDate.format("YYYY-MM-DD HH:mm");
		                var brarticleNo = replyInfo.replys[i].brarticleNo;
		                var brid = replyInfo.replys[i].brid;
		                var brcontent = replyInfo.replys[i].brcontent;
		                console.log(brarticleNo);
		                if (brid == mid) {
		                    replyList += '<div style="display: flex; width:100%;">';
		                    replyList += '<label for="brid' + brarticleNo + '" class="form-label lh-lg">댓글 작성자 : </label> ';
		                    replyList += '<input class="ms-2" id="brid'+brarticleNo + '" type="text" value="' + brid + '" disabled> &nbsp;';
		                    replyList += '<label class="me-2 lh-lg">'+formattedDate+'</label>';
		                    replyList += '<input type="button" id="replydelete'+ brarticleNo + '" value="삭제" class="btn btn-outline-danger" onClick="fn_replydelete('+brarticleNo+')" style="display:block;">';
		                    replyList += '<input type="button" id="cancle'+ brarticleNo + '" value="취소" class="btn btn-outline-primary" style="display: none;" onClick="fn_cancle('+brarticleNo+')">';
		                    replyList += '</div>';
			                replyList += '<br> <div style="display: flex; width:100%;">';
			                replyList += '<textarea class="form-control" id="brcontent' + brarticleNo + '" name="brcontent" rows="3" disabled>' + brcontent + '</textarea>';
			                replyList += '<input type="button" id="replymod'+brarticleNo+'" class="btn btn-primary" value="수정" onClick="fn_reply_mod(' + brarticleNo + ')" style="display=block;">';
			                replyList += '</div><br>';
		                } 
		                else if(brid == adid){
		                	replyList += '<div style="display: flex; width:100%;">';
		                    replyList += '<label for="brid' + brarticleNo + '" class="form-label lh-lg">댓글 작성자 : </label> ';
		                    replyList += '<input class="ms-2" id="brid'+brarticleNo + '" type="text" value="' + brid + '" disabled> &nbsp;';
		                    replyList += '<label class="me-2 lh-lg">'+formattedDate+'</label>';
		                    replyList += '<input type="button" id="replydelete'+ brarticleNo + '" value="삭제" class="btn btn-outline-danger" onClick="fn_replydelete('+brarticleNo+')" style="display:block;">';
		                    replyList += '<input type="button" id="cancle'+ brarticleNo + '" value="취소" class="btn btn-outline-primary" style="display: none;" onClick="fn_cancle('+brarticleNo+')">';
		                    replyList += '</div>';
			                replyList += '<br> <div style="display: flex; width:100%;">';
			                replyList += '<textarea class="form-control" id="brcontent' + brarticleNo + '" name="brcontent" rows="3" disabled>' + brcontent + '</textarea>';
			                replyList += '<input type="button" id="replymod'+brarticleNo+'" class="btn btn-primary" value="수정" onClick="fn_reply_mod(' + brarticleNo + ')" style="display=block;">';
			                replyList += '</div><br>';
		                }
		                
		                else {
		                    replyList += '<div style="display: flex; width:100%;">';
		                    replyList += '<label for="brid' + brarticleNo + '" class="form-label"></label> ';
		                    replyList += '댓글 작성자 : <input id="brid'+brarticleNo + '" type="text" value="' + brid + '" disabled> &nbsp;';
		                    replyList += formattedDate+' &nbsp;';
		                    replyList += '<input type="button" id="replydelete'+ brarticleNo + '" value="삭제" class="btn btn-outline-danger" onClick="fn_replydelete('+brarticleNo+')" style="display:none;">';
		                    replyList += '</div>';
		                    replyList += '<input type="button" id="cancle'+ brarticleNo + '" value="취소" class="btn btn-outline-primary" style="display: none;" onClick="fn_cancle('+brarticleNo+')">';
			                replyList += '<br> <div style="display: flex; width:100%;">';
			                replyList += '<textarea class="form-control" id="brcontent' + brarticleNo + '" name="brcontent" rows="3" disabled>' + brcontent + '</textarea>';
			                replyList += '<input type="button" id="replymod'+brarticleNo+'" class="btn btn-primary" value="수정" onClick="fn_reply_mod(' + brarticleNo + ')" style="display:none;">';
			                replyList += '</div><br>';
		                }

		                
		            }
		            $("#replyinsert").html(replyList + "<br>");
	            }
	        },
	        error: function(data, textStatus){
	            alert('오류 발생');
	        },
	        complete: function(data, textStatus){
	            $('#brcontent').val('');
	        }
	    });
	}
	
	//댓글 수정
	function fn_reply_mod(brarticleNo){
		var text = document.getElementById("brcontent" + brarticleNo);
		var cancle = document.getElementById("cancle"+brarticleNo);
		var replymod = document.getElementById("replymod"+brarticleNo);
		var replydelete = document.getElementById("replydelete"+brarticleNo);
		
		if(text.disabled){
			text.disabled = false;
			replymod.value="등록";
			cancle.style.display='inline';
			replydelete.style.display='none';
		}
	    
		else {
			var brcontent = text.value;
			$.ajax({
	            url: "<%=contextPath%>/board/updateBReply.do",
	            type: "POST",
	            data: {
	                brarticleNo: brarticleNo,
	                brcontent: brcontent
	            },
	            success: function(data, textStatus) {
	                fn_allreply();
	            },
	            error: function(data, textStatus) {
	                alert('오류 발생');
	            },
	            complete: function(data, textStatus) {
	                // 작업 완료 시 수행할 코드
	            }
	        });
		}
	}
	
	//댓글 수정 취소
	function fn_cancle(brarticleNo){
		var text = document.getElementById("brcontent" + brarticleNo);
	    var cancle = document.getElementById("cancle" + brarticleNo);
	    var replymod = document.getElementById("replymod" + brarticleNo);
	    var replydelete = document.getElementById("replydelete"+brarticleNo);

	    text.disabled = true;
	    replydelete.style.display='inline';
	    replymod.value = "수정";
	    cancle.style.display = 'none'; // 취소 버튼 숨김
	}
	
	//댓글 삭제
	function fn_replydelete(brarticleNo){
		$.ajax({
			url:"<%=contextPath%>/board/deleteBReply.do",
			type:"post",
			data:{brarticleNo:brarticleNo},
			success:function(data,textStatus){
				//fn_allreply();
				location.reload();
			},
			error:function(data,textStatus){
				alert('오류 발생');
			},
			complete:function(data,textStatus){
			}
		});
	}
	
	// 입력한 댓글 등록
	//댓글 등록 클릭
	function fn_insertReply(form){
		var brparentNo = $('#brparentNo').val();
		var brid = $('#brid').val();
		var brcontent = $('#brcontent').val();
	    
		$.ajax({
			url : "<%=contextPath%>/board/insertBReply.do",
			type : "POST",
			data:{
				brparentNo:brparentNo,
				brid:brid,
				brcontent:brcontent
			},
			success : function(data,textStatus){
				fn_allreply();
			},
			error : function(data,textStatus){
				alert('오류 발생');
			},
			complete:function(data,textStatus){
				$('#brcontent').val('');
			}
		});
	}

	
	//클릭시 내용 수정 가능
	function fn_enable(form){
		document.getElementById("btitle").disabled = false;
		document.getElementById("bcontent").disabled = false;
		document.getElementById("i_bimgFile").disabled=false;
		var updateBtn = document.getElementById("updateBtn");
		var deleteBtn = document.getElementById("deleteBtn");
		var boardUpdate = document.getElementById("boardUpdate");
		var bdupdateCancel = document.getElementById("bdupdateCancel");
		
		updateBtn.style.display="none";
		deleteBtn.style.display="none";
		boardUpdate.style.display="block";
		bdupdateCancel.style.display="block";
	}
	

	//클릭시 update controller로 이동
	function fn_modify_article(barticleNo){
		var url = "<%=contextPath%>/board/updateBoard.do?barticleNo="+barticleNo;
	    // 파일 선택 여부 확인
	    var selectedFile = document.getElementById("i_bimgFile").files[0];
	    if (selectedFile=='null') {
	        // 파일 선택하지 않은 경우 기존 파일 이름 사용
	        document.getElementsByName("bimgFile")[0].value = "${boardVO.bimgFile}";
	    }
		document.forms[0].action = url;
		document.forms[0].submit();
	 }
	
	//클릭시 수정 취소
	function fn_backBoard(obj){
		document.getElementById("btitle").disabled = true;
		document.getElementById("bcontent").disabled = true;
		document.getElementById("i_bimgFile").disabled=true;
		var updateBtn = document.getElementById("updateBtn");
		var deleteBtn = document.getElementById("deleteBtn");
		var boardUpdate = document.getElementById("boardUpdate");
		var bdupdateCancel = document.getElementById("bdupdateCancel");
		
		updateBtn.style.display="block";
		deleteBtn.style.display="block";
		boardUpdate.style.display="none";
		bdupdateCancel.style.display="none";
	}
	
	//클릭시 이미지 미리보기
	function fn_readImg(input){
		var reader = new FileReader();
		reader.onload=function(e){
			$('.preview').attr('src',e.target.result);
		}
		reader.readAsDataURL(input.files[0]);
	}
	
	//클릭시 게시판 리스트로 돌아가기
	function backToList(input){
		var url = "<%=contextPath%>/board/listBoards.do";
		document.forms[0].action = url;
		document.forms[0].submit();
	}
	
	//클릭시 삭제
	function fn_delete_board(url, barticleNo){
		var fullUrl = url + "?barticleNo="+barticleNo;
		document.forms[0].action = fullUrl;
		document.forms[0].submit();
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
	                           커뮤니티
	                        </div>
	                        <div class="card board-service-box mt-2">
			                  	<ul class="list-group list-group-flush">
								    <li class="list-group-item a-boardform"><a class="board-alink" href="<%=contextPath%>/board/listBoards.do">게시판</a></li>
								    <li class="list-group-item a-qnaform"><a class="board-alink" href="<%=contextPath%>/qna/getlistQna.do">QnA</a></li>
							   </ul>
		                   </div>
                        </div>
                    </div>
                </div>
			</div>
             <!-- 오른쪽 -->
            <div class="right ms-4" style="width: 80%;" >
				<h3 class="border-bottom border-2 border-secondary-subtle text-start pb-3 mt-4 pt-5 mb-4"><strong>게시판</strong></h3>
				<form action="<%=contextPath%>/board/updateBoard.do" method="post" enctype="multipart/form-data">
					<input type="hidden" value="${boardVO.bid }" id="bid" name="bid">
					<div class="mb-3">
					<label for="btitle" class="form-label">글 제목</label>
					  	<input type="text" class="form-control" id="btitle" name="btitle" value="${boardVO.btitle }" disabled>
					</div>
					<div class="mb-3">
					  <label for="bcontent" class="form-label">글 내용</label>
					  <textarea class="form-control" id="bcontent" name="bcontent" rows="3" disabled>${boardVO.bcontent }</textarea>
					</div>
					<div class="mb-3">
						<c:choose>
							<c:when test="${not empty boardVO.bimgFile && boardVO.bimgFile !='null' }">
								<input type="hidden" name="boriginalFile" value="${boardVO.bimgFile}">
								<img class="preview" src="<%=contextPath%>/download.do?barticleNo=${boardVO.barticleNo}&bimgFile=${boardVO.bimgFile}" height=300>
								<input type="file" class="form-control mt-2" name="bimgFile" id="i_bimgFile" value="${boardVO.bimgFile}" disabled onchange="fn_readImg(this);">
							</c:when>
					  		<c:otherwise>
					  			<div id="tr_file_upload">
					  				<img class="preview" src="" height=300><br><br>
					  				<input type="hidden" name="boriginalFile" value="${boardVO.bimgFile}">
					  				<input type="file" class="form-control mt-2" name="bimgFile" id="i_bimgFile" value="${boardVO.bimgFile}" disabled onchange="fn_readImg(this);">
					  			</div>
					  		</c:otherwise>
						</c:choose>
						<br>
					</div>
					<div style="display:flex;">
						<input type=button value="수정하기" class="btn btn-primary me-2" id="updateBtn" onClick="fn_enable(this.form)" style="display:block;">
						<input type=button value="삭제하기" class="btn btn-primary me-2" id="deleteBtn" onClick="fn_delete_board('<%=contextPath%>/board/deleteBoard.do', ${boardVO.barticleNo})" style="display:block;">
					
						<input type=button value="수정반영하기" class="btn btn-primary me-2" id="boardUpdate" onClick="fn_modify_article(${boardVO.barticleNo})" style="display:none;">
						<input type=button value="취소" class="btn btn-primary me-2" id="bdupdateCancel" onClick="fn_backBoard(this.form)" style="display:none;">
						
						<input type=button class="btn btn-primary" value="리스트로 돌아가기"  onClick="backToList(this.form)">
					</div>		
				</form>
				<div class="mb-3 mt-4" id="brbox">
					<c:choose>
						<c:when test="${!empty memVO}">
							<input type="hidden" id="brparentNo" name="brparentNo" value="${boardVO.barticleNo }">
							<input type="hidden" id="brid" name="brid" value="${memVO.mid }">
						  	<label for="bcontent" class="form-label">댓글 작성자 : </label><input type="text" class="ms-2" value="${memVO.mid }" disabled>
						  	<div style="display: flex;" class="mt-2">
						  		<textarea class="form-control" id="brcontent" name="brcontent" rows="3"></textarea>
						  		<input type="button" class="btn btn-primary" value="등록" onClick="fn_insertReply(this.form)">
						  	</div>
						</c:when>
						<c:when test="${!empty adVO }">
							<input type="hidden" id="brparentNo" name="brparentNo" value="${boardVO.barticleNo }">
							<input type="hidden" id="brid" name="brid" value="${adVO.adid }">
						  	<label for="bcontent" class="form-label">댓글 작성자 : </label><input type="text" class="ms-2" value="${adVO.adid }" disabled>
						  	<div style="display: flex;" class="mt-2">
						  		<textarea class="form-control" id="brcontent" name="brcontent" rows="3"></textarea>
						  		<input type="button" class="btn btn-primary" value="등록" onClick="fn_insertReply(this.form)">
						  	</div>
						</c:when>
					</c:choose>
				</div>
				
				<div id="replyinsert" class="mb-3 mt-4"></div>
		    </div>
		</div>
	</div>
	<jsp:include page="../footer.jsp"/>
</body>
</html>