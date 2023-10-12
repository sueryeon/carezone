<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	request.setCharacterEncoding("UTF-8");
	String contextPath = request.getContextPath();
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
		obj.action = "${contextPath}/qna/getlistQna.do";
		obj.submit();
	}
</script>
</head>
<body>
	<h1 style="text-align:center">새 글 쓰기</h1>
	<form name="QnaArticleForm" method="post" action="<%=contextPath %>/qna/insertQna.do" enctype="multipart/form-data">
		<input type="hidden" name="qid" value="${memVO.mid}"/>
		<table border="0" align="center">
			<tr>
				<td align="right">글제목 : </td>
				<td colspan="2"><input type="text" size="67" maxlength="500" name="qtitle"/></td>
			</tr>
			<tr>
				<td align="right">글내용 : </td>
				<td colspan="2"><textarea rows="10" cols="65" maxlength="4000" name="qcontent"></textarea></td>
			</tr>
			<tr>
				<td align="right">이미지파일 첨부 : </td>
				<td><input type="file" onchange="readURL(this);" name="qimgfile"/></td>
				<td><img id="preview" src="" width=200 height=200></td>
			</tr>
			<tr>
				<td align="right"></td>
				<td colspan="2">
					<input type="submit" value="글쓰기"/>
					<input type="button" value="목록보기" onClick="backToList(this.form)"/>
				</td>
			</tr>
		</table>		
	</form>
</body>
</html>