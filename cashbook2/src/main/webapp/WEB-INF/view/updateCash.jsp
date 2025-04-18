<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="model.*"%>
<%@ page import="dto.*"%>
<%
	int cashNo = (Integer)(request.getAttribute("cashNo"));

	ArrayList<HashMap<String,Object>> list = (ArrayList<HashMap<String,Object>>)(request.getAttribute("list"));
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
	.form-button {
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
		for(HashMap<String,Object> m : list){
	%>
		<%
			if(m.get("kind").equals("지출")){
		%>
				<h1>지출 수정</h1>
		<% 
			}else{
		%>
				<h1>수입 수정</h1>
		<% 
			}
		%>
		<form method="post" action="<%=request.getContextPath() %>/updateCash">
		<table class="w-25 table table-bordered text-center align-middle">
		<input type="hidden" name=cashNo value="<%=cashNo %>" >
		<input type="hidden" name=kind value="<%=m.get("kind") %>" >
			<tr>
				<th>날짜</th>
				<td><input type="date" name="cashDate" value="<%=m.get("cashDate") %>" class="form-control"></td>
			</tr>
			<tr>
				<th>분류</th>
				<td><input type="text" name="title" value="<%=m.get("title") %>" class="form-control mt-3" readonly></td>
			</tr>
			<tr>
				<th>가격</th>
				<td><input type="number" name="amount" value="<%=m.get("amount") %>" class="form-control"></td>
			</tr>
			<tr>
				<th>메모</th>
				<td><textarea name="memo" class="form-control" cols="5" rows="8"><%=m.get("memo") %></textarea></td>
			</tr>
		</table>
		<div class="form-button">
			<button type="submit" class="btn btn-primary">수정</button>
		</div>
		</form>
	<%
		}
	%>
</div>
</body>
</html>