<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사용자 관리</title>
<link href="/WorkPlus/css/M-memberlist.css" rel="stylesheet">
<jsp:include page="/header.jsp" />
<script src="js/m_memberlist.js"></script>
</head>
<body>
<div class="main">
	<div class="modal-container"> <!-- 수정하기 모달 -->
		<b>이름</b><input type="text" name="name" id="name" value="" ><br>
		<b>이메일</b><input type="text" name="email" id="email" value="" ><br>		
		<b>부서명</b><input type="text" name="dname" id="dname"value="" ><br>		
		<b>직책</b><input type="text" name="mjob" id="mjob" value="" ><br>		
		<b>사원번호</b><input type="text" name="empnum" id="empnum" value=""><br>	
		
		 <div class="clearfix">
		  	<button type="submit" class="submitbtn">저장</button>
		  	<button type="reset" class="cancelbtn">취소</button>
	 	 </div>
	</div><!-- 수정하기 모달 end -->
	
	
 <h3>사용자 관리</h3><hr>
 <form action="memberList.et" method="get" name="memberlist" class="search_memberlist">
		<input type="hidden" id="searchcheck" name="page" value="${page}">	
		<input type="hidden" id="tab" name="tab" value="${tab}">
			<div class="input-group">
				<select id="viewcount" name="search_field">
					<option value="0" selected>이름</option>
					<option value="1">사원번호</option>
					<option value="2">부서</option>
				</select> 
				   <input name="search_word" type="text" name="search_word" class="form-control"
					         value="${search_word}">
				   <button class="search_btn" type="submit">검색</button>
			</div>
	</form>	
	
 <div class="container"><%-- tab, 검색 container--%>
   <ul class="tabs">
   	 <li class="tab-link current" id="wait" data-tab="tab-1">가입대기[${listcount.wait }]</li>
   	 <li class="tab-link" id="stop" data-tab="tab-2">이용중지[${listcount.stop}]</li>
   	 <li class="tab-link" id="complete" data-tab="tab-3">승인완료[${listcount.complete }]</li>
   </ul>
 </div>
   
  
   
   <%-- 표시 내용 --%>
   <div class="content">
   <select name="orderby" id="order">
	   	<option value="name">이름 순</option>
	   	<option value="empnum">사원번호 순</option>
	   	<option value="dept">부서 순</option>
   </select><br>
   
   <div id="tab-1" class="tab-content current"> <%-- 가입 대기 --%>
    <c:if test="${listcount.wait > 0 }">  
   	<table class="table table-striped" >
		 <thead>
		   <tr>
		   		<th>이름</th>
		   		<th>사원번호</th>
		   		<th>부서</th>
		   		<th>직책</th>
		   		<th>이메일</th>
		   		<th>가입 요청일</th>
		   		<th>설정</th>
		   </tr>
		 </thead>
		 <tbody>
		  <c:forEach var="m" items="${totallist1}">
		  <input type="hidden" value="${m.m_ID}" id="m_id">
		   <tr>
		   	   <td>${m.m_NAME}</td>
		   	   <td>${m.e_NUM}</td>
		   	   <td><%--부서 선택--%>
		   	   		<select name="dnum" id="dept">
					   	<c:forEach var="d" items="${deptlist}">
					   		<option value="${d.d_num}">${d.d_name}</option>
					   	</c:forEach>
		   	   		</select>
		   	   </td> 
		   	   <td>
		   	   		<select name="pnum" id="pnum">
					   	<c:forEach var="p" items="${position}">
					   		<option value="${p.p_NUM}">${p.m_JOB}</option>
					   	</c:forEach>
		   	   		</select>
		   	   
		   	   </td>
		   	   <td>${m.VERIFY_EMAIL}</td>
		   	   <td>${m.m_HIREDATE}</td>
		   	   <td>
			   	   <span id="admit" style="color: blue;">[가입승인]</span></a>&nbsp;
			   	   <a href="memberDelete.et?id=${m.m_ID}&tab=1"><span id="reject" style="color: red;">[가입거절]</span></a>
		   	   </td>
		   </tr>
		  </c:forEach>
		 </tbody>
	 </table>
	 
     <%-- 페이지 이전 다음 --%>
    
 	 <div>
		<ul class="pagination justify-content-center">
			<c:if test="${page1 <= 1}">
				<li class="page-item">
				  <a class="page-link gray">이전&nbsp;</a>
				</li>
			</c:if>
			<c:if test="${page1 > 1}">
				<li class="page-item">
				 <a href="memberList.et?page=${page1-1}&search_field=${search_field}&search_word=${search_word}&tab=1" class="page-link">이전&nbsp;</a>
				</li>
			</c:if>	
			<c:set var="maxpage" value="${(listcount.wait + 10 - 1) / 10 }"/>
			<c:set var="startpage" value="${((page1 - 1) / 10) * 10 + 1 }"/>
			<c:set var="endpage"   value="${startpage + 10 - 1}" />
			<c:if test="${endpage > maxpage }" >
			    <c:set var="endpage" value="${maxpage}"/>
			</c:if>
			<c:forEach var="a" begin="${startpage}" end="${endpage}">
				<c:if test="${ a == page1 }">
					<li class="page-item active">
						<a class="page-link">${a}</a>
					</li>
				</c:if>
				<c:if test="${a != page1}">
					<c:url var="go" value="memberList.et">
						<c:param name="search_field" value="${search_field}" />
						<c:param name="search_word" value="${search_word}" />
						<c:param name="page1" value="${a}"/>
						<c:param name="tab" value="1"/>
					</c:url>
					<li class="page-item">
						<a href="${go}" class="page-link">${a}</a>
					</li>
				</c:if>	
			</c:forEach>
			
			<c:if test="${page1 >= maxpage }">
				<li clss="page-item"'>
					<a class="page-link gray">&nbsp;다음</a>
				</li>
			</c:if>
			<c:if test="${page1 < maxpage }">
				<c:url var="next" value="memberList.net">
					<c:param name="search_field" value="${search_field}" />
					<c:param name="search_word" value="${search_word}" />
					<c:param name="page1" value="${page1+1}" />
					<c:param name="tab" value="1"/>
				</c:url>
			<li class="page-item">
				<a href="${next}" class="page-link">&nbsp;다음</a>
			</li>
			</c:if>
		</ul>
 	 </div>
   </c:if>
 <c:if test="${listcount.wait == 0 }">
     데이터가 존재하지 않습니다.  
 </c:if>

   </div>
   <div id="tab-2" class="tab-content"> 		<%-- 이용 중지 --%>
     <c:if test="${listcount.stop > 0 }">  
     <table class="table table-striped">
		 <thead>
		   <tr>
		   		<th>이름</th>
		   		<th>사원번호</th>
		   		<th>부서</th>
		   		<th>직책</th>
		   		<th>이메일</th>
		   		<th>가입 요청일</th>
		   		<th>설정</th>
		   </tr>
		 </thead>
		 <tbody>
		  <c:forEach var="m" items="${totallist2}">
		   <tr>
		   	   <td>${m.m_NAME}</td>
		   	   <td>${m.e_NUM}</td>
		   	   <td>
		   	    	<select name="dept" id="dept">
					   	<c:forEach var="d" items="${deptlist}">
					   		<option value="${d.d_num}">${d.d_name}</option>
					   	</c:forEach>
		   	   		</select>
		   	   </td>
		   	   <td>${m.p_NUM}</td>
		   	   <td>${m.VERIFY_EMAIL}</td>
		   	   <td>${m.m_HIREDATE}</td>
		   	   <td>
			   	   <a href="memberClearblock.et?id=${m.m_ID}&tab=2"><span id="clear"  style="color: blue;">[중지해제]</span></a>&nbsp; 
			   	   <a href="memberDelete.et?id=${m.m_ID}&tab=2"><span class="delete" style="color: red;">[계정삭제]</span></a>
		   	   </td>
		   </tr>
		  </c:forEach>
		 </tbody>
	 </table>
	<%-- 페이지 이전 다음 --%>
    
 	 <div>
		<ul class="pagination justify-content-center">
			<c:if test="${page2 <= 1}">
				<li class="page-item">
				  <a class="page-link gray">이전&nbsp;</a>
				</li>
			</c:if>
			<c:if test="${page2 > 1}">
				<li class="page-item">
				 <a href="memberList.et?page2=${page2-1}&search_field=${search_field}&search_word=${search_word}&tab=2" class="page-link">이전&nbsp;</a>
				</li>
			</c:if>	
			<c:set var="maxpage" value="${(listcount.stop + 10 - 1) / 10 }"/>
			<c:set var="startpage" value="${((page2 - 1) / 10) * 10 + 1 }"/>
			<c:set var="endpage"   value="${startpage + 10 - 1}" />
			<c:if test="${endpage > maxpage }" >
			    <c:set var="endpage" value="${maxpage}"/>
			</c:if>
			<c:forEach var="a" begin="${startpage}" end="${endpage}">
				<c:if test="${ a == page2 }">
					<li class="page-item active">
						<a class="page-link">${a}</a>
					</li>
				</c:if>
				<c:if test="${a != page2}">
					<c:url var="go" value="memberList.et">
						<c:param name="search_field" value="${search_field}" />
						<c:param name="search_word" value="${search_word}" />
						<c:param name="page2" value="${a}"/>
						<c:param name="tab" value="2"/>
					</c:url>
					<li class="page-item">
						<a href="${go}" class="page-link">${a}</a>
					</li>
				</c:if>	
			</c:forEach>
			
			<c:if test="${page2 >= maxpage }">
				<li class="page-item">
					<a class="page-link gray">&nbsp;다음</a>
				</li>
			</c:if>
			<c:if test="${page2 < maxpage }">
				<c:url var="next" value="memberList.net">
					<c:param name="search_field" value="${search_field}" />
					<c:param name="search_word" value="${search_word}" />
					<c:param name="page2" value="${page2+1}" />
					<c:param name="tab" value="2"/>
				</c:url>
			<li class="page-item">
				<a href="${next}" class="page-link">&nbsp;다음</a>
			</li>
			</c:if>
		</ul>
 	 </div>
   </c:if>
 <c:if test="${listcount.wait == 0 }">
     데이터가 존재하지 않습니다.  
 </c:if>
 </div>
   
   <div id="tab-3" class="tab-content">			<%-- 승인 완료 --%>
    <c:if test="${listcount.complete > 0 }" >
     <c:if test="${ !empty searchlist }">
     <c:set var="totallist3" value="${searchlist }" />
     </c:if>
     <table class="table table-striped">
		 <thead>
		   <tr>
		   		<th>이름</th>
		   		<th>사원번호</th>
		   		<th>부서</th>
		   		<th>직책</th>
		   		<th>이메일</th>
		   		<th>가입 요청일</th>
		   		<th>설정</th>
		   </tr>
		 </thead>
		 <tbody>
		  <c:forEach var="m" items="${totallist3}">
		   <tr>
		   	   <td class="name">${m.m_NAME}</td>
		   	   <td class="empnum">${m.e_NUM}</td>
		   	   <td class="dname">${m.d_NAME}</td>
		   	   <td class="mjob">${m.m_JOB}</td>
		   	   <td class="email">${m.VERIFY_EMAIL}</td>
		   	   <td>${m.m_HIREDATE}</td>
		   	   <td>
			   	   <span class="update"  style="color: blue;">[수정]</span>&nbsp;
			   	   <a href="memberDelete.et?id=${m.m_ID}&tab=3"><span class="delete" style="color: red;">[계정삭제]</span></a>
		   	   </td>
		   </tr>
		   </c:forEach>
		 </tbody>
	 </table>
	 <%-- 페이지 이전 다음 --%>
	 <%-- 페이지 처리 변경하기!!!!!!!!! --%>
    
    <c:if test="${tab == 1}" >
			<c:set var="count" value="${listcount.wait}"/>
    </c:if>
    <c:if test="${tab == 2}" >
			<c:set var="count" value="${listcount.stop}"/>
    </c:if>
    <c:if test="${tab == 3}" >
			<c:set var="count" value="${listcount.complete}"/>
    </c:if>
    
 	 <div>
		<ul class="pagination justify-content-center">
			<c:if test="${page3 <= 1}">
				<li class="page-item">
				  <a class="page-link gray">이전&nbsp;</a>
				</li>
			</c:if>
			<c:if test="${page3 > 1}">
				<li class="page-item">
				 <a href="memberList.et?page3=${page3-1}&search_field=${search_field}&search_word=${search_word}&tab=${tab}" class="page-link">이전&nbsp;</a>
				</li>
			</c:if>	
			<c:set var="maxpage" value="${(listcount.complete + 5 - 1) / 5 }"/>
			<c:set var="startpage" value="${((page3 - 1) / 10) * 10 + 1 }"/>
			<c:set var="endpage"   value="${startpage + 10 - 1}" />
			<c:if test="${endpage > maxpage }" >
			    <c:set var="endpage" value="${maxpage}"/>
			</c:if>
			<c:forEach var="a" begin="${startpage}" end="${endpage}">
				<c:if test="${ a == page3 }">
					<li class="page-item active">
						<a class="page-link">${a}</a>
					</li>
				</c:if>
				<c:if test="${a != page3}">
					<c:url var="go" value="memberList.et">
						<c:param name="search_field" value="${search_field}" />
						<c:param name="search_word" value="${search_word}" />
						<c:param name="page3" value="${a}"/>
						<c:param name="tab" value="3"/>
					</c:url>
					<li class="page-item">
						<a href="${go}" class="page-link">${a}</a>
					</li>
				</c:if>	
			</c:forEach>
			
			<c:if test="${page3 >= maxpage }">
				<li class="page-item"'>
					<a class="page-link gray">&nbsp;다음</a>
				</li>
			</c:if>
			<c:if test="${page3 < maxpage }">
				<c:url var="next" value="memberList.net">
					<c:param name="search_field" value="${search_field}" />
					<c:param name="search_word" value="${search_word}" />
					<c:param name="page3" value="${page3+1}" />
					<c:param name="tab" value="3"/>
				</c:url>
			<li class="page-item">
				<a href="${next}" class="page-link">&nbsp;다음</a>
			</li>
			</c:if>
		</ul>
 	 </div>
   </c:if>
 <c:if test="${listcount.complete == 0 }">
     데이터가 존재하지 않습니다.  
 </c:if>
   </div>
 </div>
 </div><%-- container end --%>
</div><%-- main end --%>
<script>
//검색 클릭 후 응답화면에는 검색시 선택한 필드가 선택되도록
let selectedValue = '${search_field}'
if(selectedValue != '-1')
	$("#viewcount").val(selectedValue);
else
	selectedValue=0;   //선택된 필드가 없는 경우 기본적으로 아이디를 선택하도록 합니다.

</script>
</body>
</html>