<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	int cashNo = (Integer)(request.getAttribute("cashNo"));
	String kind = (String)(request.getAttribute("kind"));
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
	<h1>영수증 등록</h1>
	<form method="post" action="<%=request.getContextPath() %>/insertReceit" enctype="multipart/form-data">
	<input type="hidden" name="cashNo" value="<%=cashNo %>">
	<input type="hidden" name="kind" value="<%=kind %>">
		<table class="w-50 table table-bordered text-center align-middle">
			<tr>
				<th>영수증</th>
				<td><input type="file" name="receit" class="form-control"></td>
			</tr>
		</table>
		<div class="form-button">
			<button type="submit" class="btn btn-primary">등록</button>
		</div>
	</form>
</div>
</body>
</html>