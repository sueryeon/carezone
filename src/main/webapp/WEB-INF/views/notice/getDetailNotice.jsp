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
      var Noticeupdate = document.getElementById("Noticeupdate");
      var Noticedelete = document.getElementById("Noticedelete");
      var tr_btn_modify= document.getElementById("tr_btn_modify");
      
      /*관리자가 로그인했을 때*/
      if(isAdminLogin=="true"){
    	  Noticeupdate.style.display="block";
    	  qnadelete.style.display="block";
    	  tr_btn_modify.style.display="block"
      }
      else{
    	  Noticeupdate.style.display="none";
    	  qnadelete.style.display="none";
    	  tr_btn_modify.style.display="none"
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
      obj.action = "${contextPath}/notice/getlistNotice.do";
      obj.submit();
   }
   
   function fn_update_notice(obj){
      
      var Narticleno=${noticeVO.narticleno};
      obj.action = "${contextPath}/notice/updateNoticeForm.do?narticleno="+Narticleno;
      obj.submit();
   
   }
   
   function fn_delete_notice(obj){
      
      alert("삭제되었습니다.");
      
      var Narticleno=${noticeVO.narticleno};
      obj.action = "${contextPath}/notice/deleteNotice.do?narticleno="+Narticleno;
      obj.submit();
   }
 
</script>
</head>
<body>
	<a href="${contextPath}/">홈</a>
	<form name="NoticeArticle" method="post" action="${contextPath}/" enctype="multipart/form-data">
	   <table border="0" align="center">
	      <tr>
	         <td width="150" align="center" bgcolor="#FF9933">
	            글번호
	         </td>
	         <td>
	            <input type="text" value="${noticeVO.narticleno}" disabled/>
	            <input type="hidden" value="${noticeVO.narticleno}" name="narticleno"/>
	         </td>
	      </tr>
	      <tr>
	         <td width="150" align="center" bgcolor="#FF9933">
	            작성자 아이디
	         </td>
	         <td>
	            <input type="text" value="${noticeVO.nid}" name="qid" disabled/>
	         </td>
	      </tr>
	      <tr>
	         <td width="150" align="center" bgcolor="#FF9933">
	            제목
	         </td>
	         <td>
	            <input type="text" value="${noticeVO.ntitle}" name="ntitle" id="i_title" disabled/>
	         </td>
	      </tr>
	      <tr>
	         <td width="150" align="center" bgcolor="#FF9933">
	            내용
	         </td>
	         <td>
	            <textarea rows="20" cols="60" name="ncontent" id="ncontent" disabled style="resize:none">${noticeVO.ncontent}</textarea>
	         </td>
	      </tr>
	      <c:if test="${not empty noticeVO.nimgfile&&noticeVO.nimgfile!='null'}">
	         <tr>
	            <td width="150" align="center" bgcolor="#FF9933" rowspan="2">
	               이미지
	            </td>
	            <td>
	               <input type="hidden" name="originalFileName" value="${noticeVO.nimgfile}"/>
	               <img src="${contextPath}/download.do?nimgfile=${noticeVO.nimgfile}&narticleno=${noticeVO.narticleno}" id="preview"/><br>
	            </td>
	         </tr>
	         <tr>
	            <td width="150" align="center" bgcolor="#FF9933" rowspan="2">
	               <input type="file" name="imageFileName" value="${noticeVO.nimgfile}" id="nimgfile" disabled onchange="readURL(this);"/>
	            </td>
	         </tr>
	      </c:if>
	      <tr>
	         <td width="20%" align="center" bgcolor="#FF9933">
	            등록일자
	         </td>
	         <td>
	            <input type="text" value="<fmt:formatDate value="${noticeVO.nwritedate}" pattern='yyyy-MM-dd' />" disabled/>
	         </td>
	      </tr>
	      <tr id="tr_btn_modify" style="display:none">
	         <td colspan="2" align="center">
	            <input type="button" value="수정반영하기" onClick="fn_modify_article(NoticeArticle)">
	            <input type="button" value="취소" onClick="backToList(NoticeArticle)">
	         </td>
	      </tr>
	   </table>
	   <table border="0" align="center">
	      <tr id="tr_btn">
	         <td colspan=2 align=center>
	            <input type=button id="Noticeupdate" value="수정하기" onClick="fn_update_notice(this.form)" style="display:none;">
	            <input type=button id="Noticedelete" value="삭제하기" onClick="fn_delete_notice(this.form)" style="display:none;">
	            <input type=button value="리스트로 돌아가기" onClick="backToList(this.form)">
	         </td>
	      </tr>
	   </table>
	</form>
</body>
</html>