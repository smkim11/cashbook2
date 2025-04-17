<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="model.*"%>
<%@ page import="dto.*"%>
<%@ page import="java.text.NumberFormat"%>
<%
	int cashNo = (Integer)(request.getAttribute("cashNo"));
	String kind = (String)(request.getAttribute("kind"));
	NumberFormat numberFormat = (NumberFormat)(request.getAttribute("numberFormat"));
	ArrayList<HashMap<String,Object>> list = (ArrayList<HashMap<String,Object>>)(request.getAttribute("list"));
	Receit r = (Receit)(request.getAttribute("r"));
%>
<!DOCTYPE html>
<html>
<head>
<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<style>
	body {
		font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif !important;
		background-color: #f9fcff !important;
		margin: 0 !important;
		text-align: center;
	}

	h1 {
		text-align: center !important;
		color: #0A9AE0 !important;
		margin-bottom: 30px !important;
	}

	.table {
		background-color: #fff;
		border-radius: 8px;
		overflow: hidden;
		box-shadow: 0 4px 10px rgba(0,0,0,0.05);
		margin:auto;
	}

	a {
		text-decoration: none;
		color: #0A9AE0;
		font-weight: bold;
	}
	
	.atag{
		text-align: center;
	}
	
	.table-wrapper {
		position: relative;
		width: fit-content;
		margin: auto;
		
	}

</style>
<meta charset="UTF-8">
<title></title>
</head>
<body>

<jsp:include page="/nav/nav.jsp"></jsp:include>
<div class="page-content">
	<%
		if(kind.equals("지출")){
	%>
			<h1>지출 상세보기</h1>
	<% 
		}else{
	%>
			<h1>수입 상세보기</h1>
	<% 
		}
	%>
	
	<%
		for(HashMap<String,Object> map : list){
	%>
	<div class="atag">
		<a href="/cashbook2/cash/updateCashForm.jsp?cashNo=<%=cashNo%>">수정</a> |
		<a href="/cashbook2/cash/deleteCashForm.jsp?cashNo=<%=cashNo %>&kind=<%=kind%>">삭제</a> |
		<a href="/cashbook2/cash/insertReceitForm.jsp?cashNo=<%=cashNo %>&kind=<%=kind%>">영수증 등록</a> 
		<%
			if(r.getFileName()!=null){
		%>
			    | <a href="/cashbook2/cash/deleteReceitForm.jsp?cashNo=<%=cashNo %>&kind=<%=kind%>">영수증 삭제</a>
		<% 
			}
		%>
	</div>
			<table class="w-25 table table-bordered text-center align-middle">
				<tr>
					<th>날짜</th>
					<td><%=map.get("cashDate") %></td>
				</tr>
				<tr>
					<th>분류</th>
					<td><%=map.get("title") %></td>
				</tr>
				<tr>
					<th>가격</th>
					<td><%=numberFormat.format(map.get("amount")) %></td>
				</tr>
				<tr>
					<th>메모</th>
					<td><%=map.get("memo") %></td>
				</tr>
			</table>
	<%
		}
	%>
	<table class="w-25 table table-bordered text-center align-middle">
		<tr>
			<th>영수증</th>
		</tr>
		<tr>
			<td><img src="/cashbook2/upload/<%=r.getFileName() %>" style="height:360px" ></td>
		</tr>
	</table>
</div>
</body>
</html>