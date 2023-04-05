<%@page import="service.HistoryPage"%>
<%@page import="java.util.ArrayList"%>
<%@page import="service.SearchPage"%>
<%@page import="dao.SqliteDb"%>
<%@page import="dto.PublicWifiInfo"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>와이파이 정보 구하기</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/search.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/getcurrentlocation.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/validationrule.js"></script>
</head>
<body>
	<%
			Double lat =0.0;
			Double lnt =0.0;
			
	    	try{
			    lat = Double.parseDouble(request.getParameter("lat"));
			    lnt = Double.parseDouble(request.getParameter("lnt"));
	    	} catch (Exception e) {
	            e.printStackTrace();
	        }
			
			
			SqliteDb sqliteDb = new SqliteDb();
	
			SearchPage sd = new SearchPage(); 
			
			HistoryPage hp = new HistoryPage(); 
			
			
			
			List<PublicWifiInfo> pwiList = new ArrayList<>();
			pwiList = sd.calDistance(lat, lnt);
			hp.saveUserHistory(lat, lnt);
	%>
	<h1>와이파이 정보 구하기</h1>
	
	<nav id="navbar">
		<ul class="navbar__menu">
	 		<li class="navbar__menu__item"><a href="index.jsp">홈</a></li>
	 		<li class="navbar__menu__item">| <a href="history.jsp?id=-1">위치 히스토리 목록</a></li>
	 		<li class="navbar__menu__item">| <a href="load-wifi.jsp">Open API 와이파이 정보 가져오기</a></li>
		</ul>
	</nav>
	
	<section id="to-insert">
		<form action="search.jsp" method="get">
			<span id="lat">
				LAT: <input id="input-lat" type="text" name="lat" value="<%=lat%>" onkeypress="return numberOfKey(event)" onkeyup="return deleteHangle(event)" required/>
			</span>
			<span id="lnt">
				, LNT: <input id="input-lnt" type="text" name="lnt" value="<%=lnt%>" onkeypress="return numberOfKey(event)" onkeyup="return deleteHangle(event)" required/>
			</span>
			<span>
				<input type="button"  onClick="askForCoords()" value="내 위치 가져오기"/>
			</span>
			<span>
				<input type="submit" value="근처 WIPI 정보 보기"/>
			</span>
		</form>
	</section>
	
	<section id="show-table">
		<table>
    		<thead>
    			<tr>
    				<th>거리(Km)</th>
    				<th>관리번호</th>
    				<th>자치구</th>
    				<th>와이파이명</th>
    				<th>도로명주소</th>
    				<th>상세주소</th>
    				<th>설치위치(층)</th>
    				<th>설치유형</th>
    				<th>설치기관</th>
    				<th>서비스구분</th>
    				<th>망종류</th>
    				<th>설치년도</th>
    				<th>실내외구분</th> 
    				<th>WIFI접속환경</th>
    				<th>X좌표</th>
    				<th>Y좌표</th>
    				<th>작업일자</th>
    			</tr>
    		</thead>
    		<tbody>
 			<%
			for (PublicWifiInfo wifi :pwiList){
			%>
					<tr id ="tr-search-style">
						<td> <%=wifi.getDistance()%> </td>
						<td> <%=wifi.getMgr_no()%> </td>
						<td> <%=wifi.getWrdofc()%> </td>
						<td> <%=wifi.getMain_nm()%> </td>
						<td> <%=wifi.getAdres1()%> </td>
						<td> <%=wifi.getAdres2()%> </td>
						<td> <%=wifi.getInstl_floor()%> </td>
						<td> <%=wifi.getInstl_ty()%> </td>
						<td> <%=wifi.getInstl_mby()%> </td>
						<td> <%=wifi.getSvc_se()%> </td>
						<td> <%=wifi.getCmcwr()%> </td>
						<td> <%=wifi.getCnstc_year()%> </td>
						<td> <%=wifi.getInout_door()%> </td>
						<td> <%=wifi.getRemars3()%> </td>
						<td> <%=wifi.getLat()%> </td>
						<td> <%=wifi.getLnt()%> </td>
						<td> <%=wifi.getWork_dttm()%> </td>
					</tr>		
			<%		
			}
			%>
    		</tbody>
    	</table>
	</section>
</body>
</html>