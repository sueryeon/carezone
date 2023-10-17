<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약하기</title>
<c:set var="memVO" value="${memVO}"/>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.min.js" integrity="sha384-Rx+T1VzGupg4BHQYs2gCW9It+akI2MM/mndMCy36UVfodzcJcF0GGLxZIzObiEfa" crossorigin="anonymous"></script>

<link rel="stylesheet" href="../resources/CSS/reservationForm.css">
<script>


var VO="";
var fid="";
var fno="";
var fname="";
var fbirth1="";
var fphone="";

//--------------------------전역변수모음

function stateList(){
		
		var selectState=document.getElementById("state").value;
		var selectCity=document.getElementById("city");
		
		if(selectState===""){
			selectCity.innerHTML = "<option value=''>시/군/구</option>";
		}
		else{
			
			$.ajax({
				type:"post",
				url:"${contextPath}/hospital/selectstate.do",
				async:"true",
				data:{'state':selectState},
				success:function(data,textStatus){
					
					selectCity.innerHTML = "<option value=''>시/군/구</option>";
					var state=JSON.parse(data);
					var cities=state[selectState];
					
					for(var i=0; i<cities.length; i++){
						
						var key=cities[i];
						var value=cities[i];
						var option = document.createElement("option");
	                    option.value = key;
	                    option.text = value;
	                    selectCity.appendChild(option);
	                    
	                    //console.log(key+" : "+value);
					}
				},
				error:function(data,textStatus){
					
				},
				complete:function(data,textStatus){
					
				}
			});
		}
	}
	
	function cityList(){
		var selectCity=document.getElementById("city").value;
		var selectFullCity=document.getElementById("fullcity");
		
		if(selectCity===""){
			selectFullCity.innerHTML = "<option value=''>읍/면/동</option>";
		}
		else{
			
			$.ajax({
				type:"post",
				url:"${contextPath}/hospital/selectcity.do",
				async:"true",
				data:{'city':selectCity},
				success:function(data,textStatus){
					
					selectFullCity.innerHTML = "<option value=''>읍/면/동</option>";
					//console.log(data);
					var city=JSON.parse(data);
					var fullcities=city[selectCity];
	
					for(var i=0; i<fullcities.length; i++){
						
						var key=fullcities[i];
						var value=fullcities[i];
						var option = document.createElement("option");
	                    option.value = key;
	                    option.text = value;
	                    selectFullCity.appendChild(option);
					}
				},
				error:function(data,textStatus){
					
				},
				complete:function(data,textStatus){
					
				}
			});
		}
	}
	
	function fn_search(_pagenum){
		
		var originalState=document.getElementById("state").value;
		var originalCity=document.getElementById("city").value;
		var originalFullcity=document.getElementById("fullcity").value;
		var originalVccname=document.getElementById("vccname").value;
		var pagenum=_pagenum;
		
		$.ajax({
	        type:"POST",
	        url:"${contextPath}/hospital/searchHospital.do",
	        data: {
	        	
	            state: originalState,
	            city: originalCity,
	            fullcity: originalFullcity,
	            vccname: originalVccname,
	            pagenum:pagenum
	            
	        },
	        success: function (data, textStatus) {
	        	
	        	$('#state').val(originalState);
	        	$('#city').val(originalCity);
	        	$('#fullcity').val(originalFullcity);
	        	$('#vccname').val(originalVccname);
				
	        	fn_afterSearch(data,originalVccname);
	
	        },
	        error: function (data, textStatus) {
	            console.error("오류 발생: " + textStatus);
	        }
	    });
	}
	
	function fn_afterSearch(data,originalVccname) {
		
		var originalVccname=document.getElementById("vccname").value;
		var result="";
		var pageresult="";
		var totalArticles=data.totalArticles;
		var list=data.hospitalList;
		
		console.log(list);
		if(list.length!==0){
			
			for(var i=0; i<data.hospitalList.length; i++){
				var VO=list[i];
				console.log(VO);
				result += '<tr class="findtr"><td class="hosname">'+VO.hosname+'</td>';
				result += '<td>'+VO.hoscall+'</td>';
				result += '<td>'+VO.hosaddr+'</td>';
				
				if(VO.vccquantity===0||VO.vccquantity==="0"){
					
					result += '<td>예약불가능</td>';
					result += "<td><input type='radio' name='radio' disabled>";
					result += '</td></tr>';
				}
				else if(VO.vccquantity>0){
					result += '<td>예약가능</td>';
					result += "<td><input type='hidden' name='hos_no' class='findhidden' value="+VO.hosno+"><input type='radio' name='radio'>";
					result += '</td></tr>';
					
				}	
			}
			
			result+="<tr><td colspan=6 id='pagebody'></td></tr>";
			$("#tbody").html(result);
		}
		else{
			result+="<tr><td colspan=6 >조회된 결과가 없습니다.</td></tr>";
				$("#tbody").html(result);
		}
		
		if(totalArticles>100){
			console.log("totalArticles : "+totalArticles);
			for(var i=1; i<11; i++){
				
				if(data.pagesize>1&&i==1){
					pageresult+= "<a class='no_uline ms-2 me-2' href='#' onClick='fn_search("+(((data.pagesize-1)*10)+1)+")'>&nbsp; pre</a>";
				}
				pageresult+="<a class='no_uline ms-2 me-2' href='#' onClick='fn_search("+i+")'>"+i+"</a>";
				if(i==10){
					pageresult+="<a class='no_uline ms-2 me-2' href='#' onClick='fn_search("+((data.pagesize*10)+1)+")'>&nbsp; next</a>";
				}
			}
			console.log("pageresult : "+pageresult);
			
			$("#pagebody").html(pageresult);
		}
		else if(totalArticles==100){
			for(var i=1; i<11; i++){
				pageresult+="<a class='no_uline ms-2 me-2' href='#'>"+i+"</a>";
			}
			
			$("#pagebody").html(pageresult);
		}
		else if(totalArticles<100){
			for(var i=1; i<((totalArticles/10)+1); i++){
				if(i==data.pagenum){
					pageresult+="<a class='no_uline ms-2 me-2' href='#' onClick='fn_search("+i+")'>"+i+"</a>";
				}
				else{
					pageresult+="<a class='no_uline ms-2 me-2' href='#' onClick='fn_search("+i+")'>"+i+"</a>";
					
				}
			}
			console.log(pageresult);
			$("#pagebody").html(pageresult);
		}
		
		
	}

//------------------------------------------------------------------------병원검색 js

	//step1

	function fn_step1_next(obj){
		var urlParams = new URLSearchParams(window.location.search);
		var hosname = urlParams.get('hosname');
		console.log(hosname);
		var step3=document.getElementById("step3");
		var step2=document.getElementById("step2");
		var step1=document.getElementById("step1");
		
		if(hosname.length!=0){
			step2.style.display="none";
			step1.style.display="none";
			step3.style.display="block";
		}
		
		else{
			step2.style.display="block";
			step1.style.display="none";
			step3.style.display="none";
		}		
		
	}

	//step2
	function fn_step2_pre(){
		
		var step2=document.getElementById("step2");
		var step1=document.getElementById("step1");
		
		step2.style.display="none";
		step1.style.display="block";
		
	}
	
	function fn_step2_next(obj){
		
		var step2=document.getElementById("step2");
		var step3=document.getElementById("step3");
		
		var choose_hospital = document.querySelector('input[type="radio"]:checked');
		var hosname="";
		var hosno="";
		var vccname=document.getElementById("vccname").value;
		

	        if (choose_hospital) {
	            // 선택된 라디오 버튼 앞의 텍스트를 가져옵니다.
	            var trElement = choose_hospital.closest('.findtr');
	            var hiddenInput = trElement.querySelector('.findhidden');
	            
	            
	            if (hiddenInput) {
	                hosno = hiddenInput.value;
	                console.log("가져온데이터"+hosno);
	            }
	            
	            if (trElement) {
	                var hosnameElement = trElement.querySelector('.hosname');
	                
	                if (hosnameElement) {
	                    hosname = hosnameElement.textContent.trim();
	                }
	            }
	        }


		step2.style.display="none";
		step3.style.display="block";
		
		var rhospital=document.getElementById("rhospital");
		var rhospital2=document.getElementById("rhospital2");
		var rvcc=document.getElementById("rvcc");
		var rvcc2=document.getElementById("rvcc2");
		var hos__no1=document.getElementById("hos__no1");
		var hos__no2=document.getElementById("hos__no2");

		
		rhospital.value=hosname;
		rhospital2.value=hosname;
		rvcc.value=vccname;
		rvcc2.value=vccname;
		hos__no1.value=hosno;
		hos__no2.value=hosno;
	}

	
	//step3
	function fn_step3_pre(){
		
		var step2=document.getElementById("step2");
		var step3=document.getElementById("step3");
		
		step2.style.display="block";
		step3.style.display="none";
		
	}
	
	document.addEventListener('DOMContentLoaded', function() {
	    const mvcinsertform = document.querySelector('.a-mvcinsertform');
	    const mvclistform = document.querySelector('.a-mvclistform');
	    const hopitalform = document.querySelector('.a-hopitalform');
	    var myModalEl = document.getElementById('modal_btn');
		
		
	    mvcinsertform.classList.add('active'); // 초기 링크를 활성화 상태로 표시
	    
	    hopitalform.addEventListener('click', function() {
	        hopitalform.classList.add('active'); //링크 활성화
	        mvcinsertform.classList.remove('active'); // 다른 링크 비활성화
	        mvclistform.classList.remove('active'); // 다른 링크 비활성화
	    });
	    
	    mvcinsertform.addEventListener('click', function() {
	    	mvcinsertform.classList.add('active'); //링크 활성화
	    	hopitalform.classList.remove('active'); // 다른 링크 비활성화
	        mvclistform.classList.remove('active'); // 다른 링크 비활성화

	    });
	    
	    mvclistform.addEventListener('click', function() {
	    	mvclistform.classList.add('active'); //링크 활성화
	    	hopitalform.classList.remove('active'); // 다른 링크 비활성화
	    	mvcinsertform.classList.remove('active'); // 다른 링크 비활성화

	    });

		
	    myModalEl.addEventListener('click', showmodal);
	    

	});
	
	var modalresult="";
	
	
	function showmodal(){

		modalresult="";
		
		$.ajax({
            url: "${contextPath}/member/listFamilyMembers.do?mno=${memVO.mno}&action=ajax ",
            method: 'post',
            dataType: 'json',
            success: function(data) {
            	
            	console.log(data);
            	if(data.length!=0){
	            	for(var i=0; i<data.length; i++){
	            		
	            		VO=data[i];
	            		fid=VO.fid;
	            		fno=VO.fno;
	            		fname=VO.fname;
	            		fbirth1=VO.fbirth1;
	            		fphone=VO.fphone;
	            		
	            		modalresult+="<button type='button' id='choosing' onClick='closeModal(\"" + fid + "\", \"" + fname + "\", \"" + fbirth1 + "\", \"" + fphone + "\")'><div class='card' style='width: 18rem;''><div class='card-body'><h5 class='card-title' id='fname'>";
	            		modalresult+=fname+"님</h5><p class='card-text' id='fbirth1'>생년월일 : "+fbirth1+"</p>";
	            		modalresult+="<p class='card-text' id='fphone' >연락처 : "+fphone+"</p></div></div></button>";

	            		$("#modalbody").html(modalresult);
	            	}
            	}
            	else{
            		$('#modalbody').html("등록된 가족이 없습니다.");
            	}
                
            },
            error: function(xhr, status, error) {
                // Ajax 요청이 실패한 경우 처리할 코드
                console.error(error);
            }
        });

	}
	
	function closeModal(fid,fname,fbirth1,fphone) {
		
		$('#exampleModal').modal('hide');
		$('.modal-backdrop').remove();
		
		fn_choose(fid,fname,fbirth1,fphone);
	}
	
	
	function fn_choose(fid,fname,fbirth1,fphone){
		var f_info=document.getElementById("f_info");
		f_info.style.display="block";
		$('#rsubname').val(fname);
		$('#rsubbirth1').val(fbirth1);
		$('#rsubphone').val(fphone);

	}  
	
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
		
		var memlist = document.getElementById("memlist");
		var adlist = document.getElementById("adlist");
		var hoslist = document.getElementById("hoslist");
		
		if((isLogin=="true"&&isAdminLogin=="false")||(isLogin=="true"&&isAdminLogin.length==0)){

			member_menu.style.display="block";
			admin_menu.style.display="none";
			memlist.style.display="block";
			adlist.style.display="none";
			hoslist.style.display="none";
		}
		else if((isAdminLogin=="true"&&isLogin=="false")||(isAdminLogin=="true"&&isLogin.length==0)){

			member_menu.style.display="none";
			admin_menu.style.display="block";
			memlist.style.display="none";
			adlist.style.display="block";
			hoslist.style.display="block";
		}
		else{
			member_menu.style.display="block";
			admin_menu.style.display="none";
		}
		
		//관리자가 로그인했을 때
		var step1 = document.getElementById("step1");
		var step2 = document.getElementById("step2");
		var step2_preBtn = document.getElementById("step2_preBtn");
		if(isAdminLogin=="true"){
			step1.style.display="none";
			step2.style.display="block";
			step2_preBtn.style.display="none";
		}

	}
	
	function showDiv(){
		
		var radio1=document.getElementById("radio1");
		var radio2=document.getElementById("radio2");
		var myself=document.getElementById("myself");
		var family=document.getElementById("family");
		if(radio1.checked){
			myself.style.display = "block";
			family.style.display = "none"; 
		}
		else{
			family.style.display = "block"; 
			myself.style.display = "none";
		}		
		
	}
	
/*================본인 인증 및 이메일 인증 함수================*/    
var checkNum
function fn_memcheck(){
	var mname = document.getElementById("mname").value;
	var memail1 = document.getElementById("memail1").value;
	var memail2 = document.getElementById("memail2").value;
	var mcBtn = document.getElementById("mcBtn");
	var emBtn = document.getElementById("emBtn");
	
	$.ajax({
		url:"${contextPath}/member/memcheck.do",
		type:"post",
		data:{
			mname:mname,
			memail1:memail1,
			memail2:memail2
		},
		success: function (data,textStatus) {
			var data = data;
			var result = Number(data);
			if(result == 1){
				mcBtn.style.display="none";
				emBtn.style.display="block";
				alert('본인 인증이 완료되었습니다.\n이메일 인증을 진행해 주세요.');
			}
			else{
				mcBtn.style.display="block";
				emBtn.style.display="none";
				alert('동일한 회원이 없습니다.\n이름과 이메일을 다시 확인해 주세요.');
			}
        },
		error:function(data,textStatus){},
		complete:function(data,textStatus){

		}
	});
}

//이메일 인증
function fn_emailcheck(){
	var numinput = document.getElementById("inputNum");
	var memail1 = document.getElementById("memail1").value;
	var memail2 = document.getElementById("memail2").value;
	numinput.disabled=false;
	alert('인증번호를 발송했습니다.\n인증번호가 오지 않으면 입력하신 정보가 회원정보와 일치하는지 확인해 주세요.');
	$.ajax({
		url:"${contextPath}/member/emailcheck.do",
		type:"post",
		data:{
			memail1:memail1,
			memail2:memail2
		},
		success: function (data,textStatus) {
			checkNum = data;
			
        },
		error:function(data,textStatus){},
		complete:function(data,textStatus){

		}
	});
}

//인증번호 확인
function fn_checkNum(){
	console.log(checkNum);
	var inputNum = document.getElementById("inputNum").value;

	var cnum = Number(checkNum);
	var inum = Number(inputNum);
	
	var trueNum = document.getElementById("trueNum");
	var falseNum = document.getElementById("falseNum");
	var nextBtn = document.getElementById("nextBtn");
	//console.log(inputNum);
	if(cnum===inum){
		console.log('일치함');
		trueNum.style.display="block";
		falseNum.style.display="none";
		nextBtn.style.display="block";
	}
	else {
		console.log('일치하지 않음');
		falseNum.style.display="block";
		trueNum.style.display="none";
		nextBtn.style.display="none";
	}
}

function inputemail(){
    var memail2 = document.getElementById("memail2");
    var selectEmail = document.getElementById("memailSelect").value;
    memail2.value = selectEmail;
}


	
</script>
<style type="text/css">
.red{
	color: #e51e3e !important;
}
.green{
	color: #12d31c !important;
}
</style>
</head>
<body>
	<jsp:include page="../nav.jsp"/>
	<div class="container-fluid p-3 pt-4 bg-light text-dark pb-5">
		<div class="wrap-container d-flex justify-content-between">
			<!-- 왼쪽 -->
			<div class="left me-4" style="width: 20%;">
				<!-- 왼쪽 회원 서비스 -->
				<div class="hosform-leftwrap-container">
					<div class="hosleft-box">
						<div class="hosservice-box">
							<div class="hosservice form-control">
	                           예방접종 관리
	                        </div>
	                        <div class="card hos-service-box mt-2">
			                  	<ul class="list-group list-group-flush">
								    <li class="list-group-item a-mvcinsertform active"><a class="vcc-alink" href="${contextPath}/reservation/getreservationForm.do">예방접종 예약</a></li>
								    <li class="list-group-item a-mvclistform" id="memlist"><a class="vcc-alink" href="${contextPath}/reservation/getlistMyReservations.do">예방접종 예약 관리</a></li>
								    <li class="list-group-item a-mvclistform" id="adlist"><a class="vcc-alink" href="${contextPath}/reservation/getlistReservations.do">예방접종 예약 관리</a></li>
								    <li class="list-group-item a-hopitalform"><a class="vcc-alink" href="${contextPath}/hospital/getlistHospital.do">지정 의료기관 찾기</a></li>
							   		<li class="list-group-item a-hopitalform" id="hoslist"><a class="vcc-alink" href="${contextPath}/hospital/gethospitalForm.do">지정 의료기관 관리</a></li>
							   </ul>
		                   </div>
                        </div>
                    </div>
                </div>
			</div>
			<!-- 오른쪽 -->
			<div class="right ms-4" style="width: 80%;" >
				<div id="step1">
					<h3 class="border-bottom border-2 border-secondary-subtle pb-3 mt-4 pt-5 mb-0"><strong>본인 인증</strong></h3>
					<div class="right-box mt-4 mb-4" >
						<div class="m-auto mt-3 m-0">
							<div class="mb-3" style="width:100%; padding:0px;">
								<div class="idcheck-box col-md-3" style="width:100%;">
									<label for="mname" class="subtitle-label form-label" style="width:100%;">가입한 회원 이름</label>
									<input type="text" class="form-control me-2" id="mname" name="mname" style="width:245px;" placeholder="이름 입력">
								</div>
							</div>
							
							<!-- 이메일 입력 -->
							<div class="mb-3" style="width:100%; padding:0px;">
								<label for="memail1" class="subtitle-label form-label" style="width:100%;">이메일</label>
								<div class="emailinput-div" style="display:flex;">
									<div class="col-auto emailinput1">
										<input type="text" class="form-control me-2" id="memail1" name="memail1" style="width:245px;">
									</div>
									<div class="col-auto emailinput2">
									    <div class="input-group">
									      <div class="input-group-text">@</div>
									      <input type="text" class="form-control ms-2 me-2" id="memail2" name="memail2" placeholder="email" style="width:130px;">
									    </div>
									 </div>
									 <div class="col-auto">
									 	<label class="visually-hidden" for="memailSelect">Preference</label>
									    <select class="form-select" id="memailSelect" onchange="inputemail();">
									    	<option selected value="">직접 입력</option>
									    	<option id="naver.com" value="naver.com">naver.com</option>
									    	<option id="gmail.com" value="gmail.com">gmail.com</option>
									    	<option id="daum.com" value="daum.com">daum.net</option>
									    </select>
									 </div>
									 <button type="button" class="btn btn-primary ms-2" onClick="fn_memcheck()" id="mcBtn" style="display:block;">본인 확인</button>
									 <button type="button" class="btn btn-primary ms-2" onClick="fn_emailcheck()" id="emBtn" style="display:none;">이메일 인증</button>
								</div>
							</div>
							
							<div class="mb-4" style="width:100%; padding:0px;">
								<label for="inputNum" class="subtitle-label form-label" style="width:100%;">인증번호</label>
								<div style="display:flex;">
									<input type="text" class="form-control me-2" id="inputNum" style="width:245px;" placeholder="인증번호 입력" disabled>
									<button type="button" class="btn btn-primary" onClick="fn_checkNum()">인증하기</button>
									<div class="green ms-3 lh-lg" role="alert" id="trueNum" style="display:none; width:250px">
									 	인증번호가 일치합니다.
									 </div>
									 <div class="red ms-3 lh-lg" role="alert" id="falseNum" style="display:none; width:420px">
									 	인증번호가 일치하지 않습니다. 다시 한 번 확인해 주세요.
									 </div>	
								</div>
							</div>
							<div id="nextBtn" style="display:none;">
								<button type="button" class="btn btn-primary" onClick="fn_step1_next(this.form)">다음</button>
							</div>
						</div>
					</div>
				</div>
				<div id="step2" style="display: none;">
					<h3 class="border-bottom border-2 border-secondary-subtle pb-3 mt-4 pt-5 mb-0"><strong>지정 의료기관 찾기</strong></h3>
					<form action="${contextPath}/hospital/searchHospital.do">
						<table class="table">
						  <tbody>
						    <tr>
						      <th colspan=1 scope="row">지역</th>
						      <td conlspan=5 class="d-flex">
							      <select class="form-select form-select-sm me-4" style="width: 25%;" aria-label="Small select example" name="state" id="state" title="시/도를 선택하세요." onchange="stateList()">
										<option value="" selected disabled>시/도</option>
										<option value="서울특별시">서울특별시</option>
										<option value="부산광역시">부산광역시</option>
										<option value="대구광역시">대구광역시</option>
										<option value="인천광역시">인천광역시</option>
										<option value="광주광역시">광주광역시</option>
										<option value="대전광역시">대전광역시</option>
										<option value="울산광역시">울산광역시</option>
										<option value="세종특별자치시">세종특별자치시</option>
										<option value="경기도">경기도</option>
										<option value="충청북도">충청북도</option>
										<option value="충청남도">충청남도</option>
										<option value="전라북도">전라북도</option>
										<option value="전라남도">전라남도</option>
										<option value="경상북도">경상북도</option>
										<option value="경상남도">경상남도</option>
										<option value="제주특별자치도">제주특별자치도</option>
										<option value="강원특별자치도">강원특별자치도</option>
									</select>
									<select	class="form-select form-select-sm me-4" style="width: 25%;" aria-label="Small select example" name="city" id="city" title="시/군/구를 선택하세요." onchange="cityList()">
										<option value=''>시/군/구</option>
									</select>
									<select	class="form-select form-select-sm" style="width: 25%;" aria-label="Small select example" name="fullcity" id="fullcity" title="시/군/구를 선택하세요.">
										<option value=''>읍/면/동</option>
									</select>
						      </td>
						    </tr>
						    <tr>
						      <th colspan=1 scope="row">백신</th>
						      <td colspan=5 class="d-flex">
							      <select class="form-select form-select-sm me-4" style="width: 70%;" aria-label="Small select example" name="vccname" id="vccname">
										<option value="">접종가능 백신을 선택하세요.</option>
										<option value="결핵(BCG,피내용)"/>결핵(BCG,피내용)</option>
										<option value="B형간염(HepB)">B형간염(HepB)</option>
										<option value="디프테리아/파상풍/백일해(DTaP)">디프테리아/파상풍/백일해(DTaP)</option>
										<option value="디프테리아/파상풍/백일해/폴리오(DTaP-IPV)">디프테리아/파상풍/백일해/폴리오(DTaP-IPV)</option>
										<option value="디프테리아/파상풍/백일해/폴리오/Hib(DTaP-IPV/Hib)">디프테리아/파상풍/백일해/폴리오/Hib(DTaP-IPV/Hib)</option>
										<option value="파상풍/디프테리아/백일해(Tdap)">파상풍/디프테리아/백일해(Tdap)</option>
										<option value="파상풍/디프테리아(Td)">파상풍/디프테리아(Td)</option>
										<option value="폴리오(IPV)">폴리오(IPV)</option>
										<option value="b형헤모필루스인플루엔자">b형헤모필루스인플루엔자</option>
										<option value="페렴구균(PCV 10가)">페렴구균(PCV 10가)</option>
										<option value="페렴구균(PCV 13가)">페렴구균(PCV 13가)</option>
										<option value="페렴구균(PPSV 23가)">페렴구균(PPSV 23가)</option>
										<option value="로타바이러스(로타릭스)">로타바이러스(로타릭스)</option>
										<option value="로타바이러스(로타텍)">로타바이러스(로타텍)</option>
										<option value="홍역/유행성이하선염/풍진(MMR)">홍역/유행성이하선염/풍진(MMR)</option>
										<option value="수두(VAR)">수두(VAR)</option>
										<option value="A형간염(HepA)">A형간염(HepA)</option>
										<option value="일본뇌염(불활성화 백신,베로세포 유래)">일본뇌염(불활성화 백신,베로세포 유래)</option>
										<option value="일본뇌염(약독화 생백신,씨디제박스)">일본뇌염(약독화 생백신,씨디제박스)</option>
									</select>
									<input type="button" class="btn btn-primary"  id="btn_search" onClick="fn_search(1)" value="검색">
						      </td>
						    </tr>
						  </tbody>
						</table>
						<div class="text-center">
							<table class="table">
								<thead>
									<tr>
										<th class="col-sm-2.5" scope="col">병/의원명</th>
										<th class="col-sm-1.5" scope="col">전화번호</th>
										<th class="col-sm-5" scope="col">주소</th>
										<th class="col-sm-1.5" scope="col">예약가능여부</th>
										<th class="col-sm-1" scope="col">선택</th>
									</tr>
								</thead>
								<tbody id="tbody">
									<tr>
										<td colspan=6 >원하시는 지역을 선택 후 검색하시면 결과를 확인하실 수 있습니다.</td>
									</tr>
									<tr>
										<td colspan="6" id="pagebody">
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						<button type="button" class="btn btn-primary me-4" id="step2_preBtn" onClick="fn_step2_pre()">이전</button>
		                <button type="button" class="btn btn-primary" onClick="fn_step2_next(this.form)">다음</button>
					</form>
				</div>
				<div id="step3" style="display: none;">
					<div class="d-flex">
						<div class="form-check">
						  <input class="form-check-input" type="radio" name="radio" id="radio1" onchange="showDiv()" checked>
						  <label class="form-check-label" for="radio1">
						     본인 예방접종 예약
						  </label>
						</div>
						<div class="form-check">
						  <input class="form-check-input" type="radio" name="radio" id="radio2" onchange="showDiv()">
						  <label class="form-check-label" for="radio2">
						    가족 예방접종 예약
						  </label>
						</div>
					</div>
					<div id="myself">
						<h3 class="border-bottom border-2 border-secondary-subtle pb-3 mt-4 pt-5 mb-0"><strong>본인 예방접종 예약</strong></h3>
						<div class="right-box mt-4 mb-4" >
							<main class="form-sign mt-4">
								<form action="<%=request.getContextPath()%>/reservation/insertReservation.do?action=self" method="post">
									<input type="hidden" name="hcno" value="${hcno }">
									<input type="hidden" name="hosno" value="${hosVO.hosno}">
									<input type="hidden" name="rname" value="${memVO.mname }">
									<input type="hidden" name="rbirth1" value="${memVO.mbirth1 }">
									<input type="hidden" name="rbirth2" value="${memVO.mbirth2 }">
									<input type="hidden" name="rphone" value="${memVO.mphone }">
									
									<div class="m-auto">
										<!-- 이름 -->
										<div class="mb-3" style="width:100%;">
											<label for="rname" class="subtitle-label form-label" style="width:100%;">이름</label>
											<input type="text" class="name-input form-control" id="rname" name="rname" value="${memVO.mname}" disabled style="width:150px;">	
										</div>
										<!-- 생년월일 -->
										<div class="mb-3" style="width:100%;">
											<label for="rbirth1" class="subtitle-label form-label" style="width:100%;">생년월일</label>
											<div class="birthinput-box" style="display:flex;">
												<input type="text" class="form-control me-2" id="rbirth1" name="rbirth1" value="${memVO.mbirth1}" disabled style="width:150px;">
												-
												<input type="text" class="form-control ms-2 me-2" name="rbirth2" value="${memVO.mbirth2}" disabled style="width:35px;">
												<div class="col-auto lh-lg">●●●●●●</div>
											</div>
										</div>
										<!-- 휴대폰 번호 -->
										<div class="mb-3" style="width:100%;">
											<label for="rphone" class="subtitle-label form-label" style="width:100%;">전화번호</label>
											<input type="text" class="name-input form-control" id="rphone" name="rphone" value="${memVO.mphone}" disabled style="width:150px;">	
										</div>
										<!-- 병원 이름 -->
										<div class="mb-3" style="width:100%;">
											<label for="rhospital" class="subtitle-label form-label" style="width:100%;">병원</label>
											<input type="hidden" name="hos__no" id="hos__no1" value=""/> 
											<input type="text" class="name-input form-control" id="rhospital" name="rhospital" value="${hosVO.hosname}" style="width:208px;" readonly>	
										</div>
										<!-- 백신 이름 -->
										<div class="mb-3" style="width:100%;">
											<label for="rvcc" class="subtitle-label form-label" style="width:100%;">백신</label>
											<input type="text" class="name-input form-control" id="rvcc" name="rvcc" value="${hosVO.vccname}" style="width:208px;" readonly>	
										</div>
										
										<!-- 예약 날짜 -->
										<div class="mb-3" style="width:100%;">
											<label for="rdate" class="subtitle-label form-label" style="width:100%;">예약날짜</label>
											<input type="date" class="name-input form-control" id="rdate" name="rdate" style="width:208px;">	
										</div>
									</div>
									<div class="d-flex justify-content-center mt-4">
										<button type="button" class="btn btn-primary me-4" onClick="fn_step3_pre()">이전</button>
										<button type="submit" class="btn btn-primary">예약하기</button>
									</div>
								</form>
							</main>
						</div>
					</div>
					<div id="family" style="display: none;">
						<h3 class="border-bottom border-2 border-secondary-subtle pb-3 mt-4 pt-5 mb-0"><strong>가족 예방접종 예약</strong></h3>
						<div class="right-box mt-4 mb-4" >
							<main class="form-sign mt-4">
								<form action="<%=request.getContextPath()%>/reservation/insertReservation.do?action=family" method="post">
									<input type="hidden" name="hcno" value="${hcno }">
									<input type="hidden" name="hosno" value="${hosVO.hosno}">
									<input type="hidden" name="rname" value="${memVO.mname }">
									<input type="hidden" name="rbirth1" value="${memVO.mbirth1 }">
									<input type="hidden" name="rbirth2" value="${memVO.mbirth2 }">
									<input type="hidden" name="rphone" value="${memVO.mphone }">
									
									<div class="m-auto">
										<div id="f_info_btn">			
											<!-- Button trigger modal -->
											<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal" id="modal_btn">
											  가족정보 불러오기
											</button>
											
											<!-- Modal -->
											<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
											  <div class="modal-dialog modal-dialog-centered">
											    <div class="modal-content">
											      <div class="modal-header">
											        <h1 class="modal-title fs-5" id="exampleModalLabel">예약할 가족 정보를 선택해주세요.</h1>
											        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
											      </div>
											      <div class="modal-body" id="modalbody">
											      </div>
											      <div class="modal-footer">
											        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
											      </div>
											    </div>
											  </div>
											</div>
										</div>
										
										<div id="f_info" style="display: none;">
											<!-- 이름 -->
											<div class="mb-3" style="width:100%;">
												<label for="rname" class="subtitle-label form-label" style="width:100%;">이름</label>
												<input type="text" class="name-input form-control" id="rsubname" name="rsubname" value="${memVO.mname}" style="width:150px;" readonly>	
											</div>
											<!-- 생년월일 -->
											<div class="mb-3" style="width:100%;">
												<label for="rbirth1" class="subtitle-label form-label" style="width:100%;">생년월일</label>
												<div class="birthinput-box" style="display:flex;">
													<input type="text" class="form-control me-2" id="rsubbirth1" name="rsubbirth1" value="${memVO.mbirth1}" style="width:150px;" readonly>
												</div>
											</div>
											<!-- 휴대폰 번호 -->
											<div class="mb-3" style="width:100%;">
												<label for="rphone" class="subtitle-label form-label" style="width:100%;">전화번호</label>
												<input type="text" class="name-input form-control" id="rsubphone" name="rphone" value="${memVO.mphone}" style="width:150px;" readonly>	
											</div>
										</div>
										
										<!-- 병원 이름 -->
										<div class="mb-3" style="width:100%;">
											<label for="rhospital" class="subtitle-label form-label" style="width:100%;">병원</label>
											<input type="hidden" name="hos__no" id="hos__no2" value=""/>
											<input type="text" class="name-input form-control" id="rhospital2" name="rhospital" value="${hosVO.hosname}" style="width:208px;" readonly>	
										</div>
										<!-- 백신 이름 -->
										<div class="mb-3" style="width:100%;">
											<label for="rvcc" class="subtitle-label form-label" style="width:100%;">백신</label>
											<input type="text" class="name-input form-control" id="rvcc2" name="rvcc" value="${hosVO.vccname}" style="width:208px;" readonly>	
										</div>
										
										<!-- 예약 날짜 -->
										<div class="mb-3" style="width:100%;">
											<label for="rdate" class="subtitle-label form-label" style="width:100%;">예약날짜</label>
											<input type="date" class="name-input form-control" id="rdate" name="rdate" style="width:208px;">	
										</div>
									</div>
									<div class="m-auto d-flex">
										<!-- 이름 -->
										<div class="mb-3" style="width:100%;">
											<label for="rname" class="subtitle-label form-label" style="width:100%;">대리인명</label>
											<input type="text" class="name-input form-control" id="rname" name="rname" value="${memVO.mname}" disabled style="width:150px;">	
										</div>
										<!-- 휴대폰 번호 -->
										<div class="mb-3" style="width:100%;">
											<label for="rphone" class="subtitle-label form-label" style="width:100%;">전화번호</label>
											<input type="text" class="name-input form-control" id="rphone" name="rphone" value="${memVO.mphone}" disabled style="width:150px;">	
										</div>
									</div>
									<p>가족 본인의 동의를 받고 대리 예약하였음을 확인합니다. 아닐 시 법적 효력이 유효합니다.(?)
									<div class="d-flex justify-content-center mt-4">
										<button type="button" class="btn btn-primary me-4" onClick="fn_step3_pre()">이전</button>
										<button type="submit" class="btn btn-primary">예약하기</button>
									</div>
								</form>
							</main>
						</div>
					</div>	
				</div>

			</div>
		</div>
	</div>
	<jsp:include page="../footer.jsp"/>
</body>
</html>