<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.*"%>
<%@ page import="dto.*"%>
<%@ page import="java.util.*"%>
<%
	int cnum = (Integer)(request.getAttribute("cnum"));
	Category c = (Category)(request.getAttribute("c"));
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
		text-align: center;
		color: #0A9AE0 !important;
	}

	.table {
		background-color: #fff;
		border-radius: 8px;
		overflow: hidden;
		box-shadow: 0 4px 10px rgba(0,0,0,0.05);
		margin:auto;
		margin-top: 30px;
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
<jsp:include page="/nav/nav.jsp" />
	<div class="page-content">
		<h1>제목 수정</h1>
		<form action="<%=request.getContextPath() %>/updateCategory" method="post">
			<table class="w-25 table table-bordered text-center align-middle">
				<tr>
					<th>번호</th>
					<td><input type="text" name="cnum" value="<%=cnum%>" class="form-control mt-3" readonly></td>
				</tr>
				<tr>
					<th>종류</th>
					<td>
						<%
							if(c.getKind().equals("수입")){
						%>
								<input class="form-check-input" type="radio" name="kind" value="수입" checked> 수입
								<input class="form-check-input" type="radio" name="kind" value="지출"> 지출
						<% 
							}else{
						%>
								<input class="form-check-input" type="radio" name="kind" value="수입"> 수입
								<input class="form-check-input" type="radio" name="kind" value="지출" checked> 지출
						<% 
							}
						%>
						
					</td>
				</tr>
				<tr>
					<th>제목</th>
					<td><input type="text" name="title" value="<%=c.getTitle()%>" class="form-control"></td>
				</tr>
			</table>
			<div class="form-button">
				<button type="submit" class="btn btn-primary">수정</button>
			</div>
		</form>
	</div>
</body>
</html>