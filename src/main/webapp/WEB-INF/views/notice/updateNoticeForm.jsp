<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<%
	request.setCharacterEncoding("UTF-8");
	String contextPath=request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">

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
		var narticleno=${noticeVO.narticleno}
		obj.action = "${contextPath}/notice/getDetailNotice.do?narticleno="+narticleno;
		obj.submit();
	}
</script>
</head>
<body>
	<h1 style="text-align:center">글 수정하기</h1>
	<form name="NoticeArticleForm" method="post" action="${contextPath}/notice/updateNotice.do" enctype="multipart/form-data">
		<input type="hidden" name="narticleno" value="${noticeVO.narticleno}"/>
		<table border="0" align="center">
			<tr>
				<td align="right">글제목 : </td>
				<td colspan="2"><input type="text" size="67" maxlength="500" name="ntitle" value="${qnaVO.qtitle}"/></td>
			</tr>
			<tr>
				<td align="right">글내용 : </td>
				<td colspan="2"><textarea rows="10" cols="65" maxlength="4000" name="ncontent">${qnaVO.qcontent}</textarea></td>
			</tr>
			<c:if test="${not empty noticeVO.nimgfile&&noticeVO.nimgfile!='null'}">
				<tr>
					<td align="right">이미지파일 첨부 : </td>
					<td colspan="2">
						<input type="hidden" name="originalFileName" value="${noticeVO.noticeVO}"/>
						<img src="${contextPath}/download.do?nimgfile=${noticeVO.noticeVO}&narticleno=${noticeVO.narticleno}" id="preview"/><br>
					</td>
				</tr>
				<tr>
					<td align="right"></td>
					<td colspan="2">
						<input type="file" name="nimgfile" id="nimgfile" onchange="readURL(this);"/>
					</td>
				</tr>
			</c:if>
		
			<tr>
				<td align="right"></td>
				<td colspan="2">
					<input type="submit" value="수정하기"/>
					<input type="button" value="취소하기" onClick="backToList(this.form)"/>
				</td>
			</tr>
		</table>		
	</form>
</body>
</html>