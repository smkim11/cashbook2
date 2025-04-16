<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String ID = (String)(session.getAttribute("ID"));
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
		font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
		background-color: #f9fcff;
		padding: 40px;
		text-align: center;
	}
	h1 {
		color: #0A9AE0;
		margin-bottom: 40px;
	}
	.table {
		width: 40%;
		margin: auto;
		box-shadow: 0 4px 8px rgba(0,0,0,0.1);
		border-radius: 10px;
		overflow: hidden;
	}
	a {
		text-decoration: none;
		color: #0A9AE0;
		font-weight: bold;
	}
</style>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<%
	if(ID == null){
%>
		<a href="/cashbook2/login/loginForm.jsp">로그인</a>
<% 
	}else{
%>
		<%=ID %>님 환영합니다.
		&nbsp;
		<a href="/cashbook2/login/logout.jsp">로그아웃</a>
<% 
	}
%><hr>
<h1>메인 페이지</h1>
	<table class="w-50 table table-hover">
		<tr>
			<th>1.</th>
			<td><a href="/cashbook2/category/categoryList.jsp">수입 지출 리스트</a></td>
		</tr>
		<tr>
			<th>2.</th>
			<td><a href="/cashbook2/monthList.jsp">달력형 리스트</a></td>
		</tr>
	</table>
</body>
</html>