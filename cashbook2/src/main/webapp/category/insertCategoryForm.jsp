<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String ID = (String)(session.getAttribute("ID"));
	if(ID == null){ // 로그아웃 상태 일때
		response.sendRedirect("/cashbook2/index.jsp");
		return;
	}	
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
		margin-top:30px;
		
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
		<h1>수입 지출 리스트 추가</h1>
		<form method="post" action="/cashbook2/category/insertCategoryAction.jsp">
		<table class="w-25 table table-bordered text-center align-middle">
			<tr>
				<th>종류</th>
				<td>
					<input class="form-check-input" type="radio" name="kind" value="수입"> 수입
					<input class="form-check-input" type="radio" name="kind" value="지출"> 지출
				</td>
			</tr>
			<tr>
				<th>제목</th>
				<td><input type="text" name="title" class="form-control"></td>
			</tr>
		</table>
		<div class="form-button">
			<button type="submit" class="btn btn-primary">추가</button>
		</div>
		</form>
	</div>
</body>
</html>