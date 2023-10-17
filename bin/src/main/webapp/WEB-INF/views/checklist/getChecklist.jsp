<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
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
	
	var check=document.querySelectorAll('input[type="checkbox"]:checked');
	
	for (var i = 0; i < check.length; i++) {
	    var checkbox = check[i];
	    var tr=checkbox.closest('tr');
		
	    tr.style.backgroundColor = 'green';
	    
	}
    
 }
 

 
function backToList(obj){
    obj.action = "${contextPath}/";
    obj.submit();
 }

function fn_colorChange(obj) {
	
	var checkbox=document.getElementById(obj);
	var ckno=obj.substr(5);
	console.log(obj+"/"+ckno);
	var tr=checkbox.closest('tr');
	var type=false;
	
	
	if (checkbox.checked) {
		
		type=true;
		tr.style.backgroundColor = 'green'; // 체크되면 녹색 배경

		
    } else {
    	
    	type=false;
    	tr.style.backgroundColor = ''; // 체크가 해제되면 배경색 초기화
    }
	
	$.ajax({
        type:"post",
        url:"${contextPath}/checklist/changeCheckType.do",
        data:{
           type : type,
           ckno : ckno
        },
        success:function(data,textStatus){
        	
        	
        	
        },
        error:function(data,textStatus){
           
        },
        complete:function(data,textStatus){
        }
     });	
}
</script>
<style type="text/css">

</style>
</head>
<body>
<form action="${contextPath}/" method="post">
	<table style="border-collapse: collapse; width: 100%;">
		<tr style="border: 1px solid black;" >
			<td>백신이름</td>
			<td>병원이름</td>
			<td>예약날짜</td>
			<td>대상자</td>
			<td>체크여부</td>
		</tr>
		<c:choose>
			<c:when test="${!empty checklist}">
				<c:forEach var="check_list" items="${checklist}">
					<tr style="border: 1px solid black;">
						<td>${check_list.ckvccname}</td>
						<td>${check_list.ckhosname}</td>
						<td>${check_list.ckrdate}</td>
						<td>${check_list.ckname}</td>
						<c:choose>
							<c:when test="${check_list.ckboolean == true}">
				                <td><input type="checkbox" name="check" id="check${check_list.ckno}" onClick="fn_colorChange(this.id)" checked></td>
				            </c:when>
				            <c:otherwise>
				                <td><input type="checkbox" name="check" id="check${check_list.ckno}" onClick="fn_colorChange(this.id)"></td>
				            </c:otherwise>
						</c:choose>
					</tr>
				</c:forEach>
			</c:when>
			<c:when test="${empty checklist}">
					<tr style="border: 1px solid black;">
						<td colspan=5 >체크리스트가 비어있습니다.</td>
					</tr>
			</c:when>
		</c:choose>
		<input type=button value="리스트로 돌아가기" onClick="backToList(this.form)">
	</table>
</form>
</body>
</html>