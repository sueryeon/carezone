<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">

   window.onload = function(){
      fn_allreply();
      var isLogin="${isLogin}";
      var isAdminLogin="${isAdminLogin}";
      console.log(isLogin);
      console.log(isAdminLogin);
      var qnaupdate = document.getElementById("qnaupdate");
      var adqnaReply = document.getElementById("adqnaReply");
      var qnadelete = document.getElementById("qnadelete");
      var listReply = document.getElementById("listReply");
      
      /*관리자가 로그인했을 때*/
      if(isAdminLogin=="true"){
    	  adqnaReply.style.display="block";
    	  qnaupdate.style.display="none";
    	  qnadelete.style.display="block";
    	  listReply.style.display="block";
      }
      
      /*회원이 로그인 했을 때*/
      else if(isLogin=="true"){
    	  adqnaReply.style.display="none";
    	  qnaupdate.style.display="block";
    	  qnadelete.style.display="block";
    	  listReply.style.display="block";
      }
      
      /*비회원일 때*/
      else{
    	  adqnaReply.style.display="none";
    	  qnaupdate.style.display="none";
    	  qnadelete.style.display="none";
    	  listReply.style.display="none";
      }
      
   }
   
   function readURL(input){
      if(input.files&&input.files[0]){
         var reader=new FileReader();
         reader.onload=function(e){
            $('#preview').attr('src',e.target.result);
         }
         reader.readAsDataURL(input.files[0]);
      }
   }
   
   function backToList(obj){
      obj.action = "${contextPath}/qna/getlistQna.do";
      obj.submit();
   }
   
   function fn_update_qna(obj){
      
      var Qarticleno=${qnaVO.qarticleno};
      obj.action = "${contextPath}/qna/updateQnaForm.do?qarticleno="+Qarticleno;
      obj.submit();
   
   }
   
   function fn_delete_qna(obj){
      
      alert("삭제되었습니다.");
      
      var Qarticleno=${qnaVO.qarticleno};
      obj.action = "${contextPath}/qna/deleteQna.do?qarticleno="+Qarticleno;
      obj.submit();
   }
   
   function fn_reply_qna(){      
      var Qarticleno=${qnaVO.qarticleno};
      var Qrecontent=$('#qrecontent').val();
      
      $.ajax({
         type:"post",
         url:"${contextPath}/qna/insertReplyQna.do",
         data:{
            'Qarticleno' : Qarticleno,
            'Qrecontent' : Qrecontent
         },
         success:function(data,textStatus){
        	 fn_allreply();
         },
         error:function(data,textStatus){
            
         },
         complete:function(data,textStatus){
        	 $('#qrecontent').val('');
         }
      });
   }
   
   function fn_allreply(){
      
      var qre_article_no=${qnaVO.qarticleno};
      
      $.ajax({
         type:"post",
         dataType:"text",
         async:true,
         url:"${contextPath}/qna/getlistReplyQna.do",
         data:{qrearticleno:qre_article_no},
         
         success:function(data,textStatus){
            $('#listReply').html(data);
         },
         error:function(data,textStatus){
            
         },
         complete:function(data,textStatus){
        	 $('#qrecontent').val('');
         }
      });      
   }
   
   function fn_modify(_qreplyno){
      
      var qreplyno=_qreplyno;
      var qrecontent=document.getElementById("qrecontent"+qreplyno);
      var modify=document.getElementById("modify"+qreplyno);
      var update=document.getElementById("update"+qreplyno);
      var back=document.getElementById("back"+qreplyno);
      var Delete=document.getElementById("delete"+qreplyno);
      
      qrecontent.disabled=false;
      modify.style.display="none";
      update.style.display="block";
      back.style.display="block";
      Delete.style.display="none";
   
   }
   

   function fn_back(_qreplyno){
      
      var qreplyno=_qreplyno;
      var qrecontent=document.getElementById("qrecontent"+qreplyno);
      var modify=document.getElementById("modify"+qreplyno);
      var update=document.getElementById("update"+qreplyno);
      var back=document.getElementById("back"+qreplyno);
      var Delete=document.getElementById("delete"+qreplyno);
      
      qrecontent.disabled=true;
      modify.style.display="block";
      update.style.display="none";
      back.style.display="none";
      Delete.style.display="block";
      
   }
   
   function fn_delete(_qreplyno){
      
      var qreplyno=_qreplyno
      
      $.ajax({
         type:"post",
         dataType:"text",
         async:true,
         url:"${contextPath}/qna/deleteReplyQna.do",
         data:{qreply_no:qreplyno},
      
         success:function(data,textStatus){
            alert("댓글이 삭제되었습니다.");
            fn_allreply();
         },
         error:function(data,textStatus){
            
         },
         complete:function(data,textStatus){
            
         }
      });      
      
   }

   function fn_update(_qreplyno){
         
      var qreplyno=_qreplyno;
      var qrecontent=document.getElementById("qrecontent"+qreplyno);
      var modify=document.getElementById("modify"+qreplyno);
      var update=document.getElementById("update"+qreplyno);
      var back=document.getElementById("back"+qreplyno);
      var Delete=document.getElementById("delete"+qreplyno);
      var qrecontent=$('#qrecontent'+qreplyno).val();
      
      qrecontent.disabled=true;
      modify.style.display="block";
      update.style.display="none";
      back.style.display="none";
      Delete.style.display="block";
      
      $.ajax({
         type:"post",
         dataType:"text",
         async:true,
         url:"${contextPath}/qna/updateReplyQna.do",
         data:{
            'qreplyno':qreplyno,
            'qrecontent':qrecontent
         },
      
         success:function(data,textStatus){
            fn_allreply();
            
         },
         error:function(data,textStatus){
            
         },
         complete:function(data,textStatus){
            alert("댓글이 수정되었습니다.");
         }
      });
   }
   
</script>
</head>
<body>
	<a href="${contextPath}/">홈</a>
	<form name="QnaArticle" method="post" action="${contextPath}/" enctype="multipart/form-data">
	   <table border="0" align="center">
	      <tr>
	         <td width="150" align="center" bgcolor="#FF9933">
	            글번호
	         </td>
	         <td>
	            <input type="text" value="${qnaVO.qarticleno}" disabled/>
	            <input type="hidden" value="${qnaVO.qarticleno}" name="qarticleno"/>
	         </td>
	      </tr>
	      <tr>
	         <td width="150" align="center" bgcolor="#FF9933">
	            작성자 아이디
	         </td>
	         <td>
	            <input type="text" value="${qnaVO.qid}" name="qid" disabled/>
	         </td>
	      </tr>
	      <tr>
	         <td width="150" align="center" bgcolor="#FF9933">
	            제목
	         </td>
	         <td>
	            <input type="text" value="${qnaVO.qtitle}" name="qtitle" id="i_title" disabled/>
	         </td>
	      </tr>
	      <tr>
	         <td width="150" align="center" bgcolor="#FF9933">
	            내용
	         </td>
	         <td>
	            <textarea rows="20" cols="60" name="qcontent" id="qcontent" disabled style="resize:none">${qnaVO.qcontent}</textarea>
	         </td>
	      </tr>
	      <c:if test="${not empty qnaVO.qimgfile&&qnaVO.qimgfile!='null'}">
	         <tr>
	            <td width="150" align="center" bgcolor="#FF9933" rowspan="2">
	               이미지
	            </td>
	            <td>
	               <input type="hidden" name="originalFileName" value="${qnaVO.qimgfile}"/>
	               <img src="${contextPath}/download.do?qimgfile=${qnaVO.qimgfile}&qarticleno=${qnaVO.qarticleno}" id="preview"/><br>
	            </td>
	         </tr>
	         <tr>
	            <td width="150" align="center" bgcolor="#FF9933" rowspan="2">
	               <input type="file" name="imageFileName" value="${qnaVO.qimgfile}" id="qimgfile" disabled onchange="readURL(this);"/>
	            </td>
	         </tr>
	      </c:if>
	      <tr>
	         <td width="20%" align="center" bgcolor="#FF9933">
	            등록일자
	         </td>
	         <td>
	            <input type="text" value="<fmt:formatDate value="${qnaVO.qwritedate}" pattern='yyyy-MM-dd' />" disabled/>
	         </td>
	      </tr>
	      <tr id="tr_btn_modify" style="display:none">
	         <td colspan="2" align="center">
	            <input type="button" value="수정반영하기" onClick="fn_modify_article(QnaArticle)">
	            <input type="button" value="취소" onClick="backToList(QnaArticle)">
	         </td>
	      </tr>
	   </table>
	   <table border="0" align="center">
	      <tr id="tr_btn">
	         <td colspan=2 align=center>
	            <input type=button id="qnaupdate" value="수정하기" onClick="fn_update_qna(this.form)" style="display:none;">
	            <input type=button id="qnadelete" value="삭제하기" onClick="fn_delete_qna(this.form)" style="display:none;">
	            <input type=button value="리스트로 돌아가기" onClick="backToList(this.form)">
	         </td>
	      </tr>
	   </table>
	   <div id="listReply" style="display:none;">
	   </div>
	   <div id="adqnaReply" style="display:none;">
	   		<table>
	   			<tr>
			         <td width="150" align="center" bgcolor="#FF9933">
			            <input type="hidden" name="qrearticleno" id="qrearticleno" value="${qnaVO.qarticleno}"/> 관리자
			         </td>
			         <td>
			            <textarea rows="5" cols="80" name="qrecontent" id="qrecontent" style="resize:none"></textarea>
			         </td>
			         <td>
			            <input type=button value="댓글달기" onClick="fn_reply_qna();">
			         </td>
	      	 	</tr>
	   		</table>
		</div>
	</form>
</body>
</html>