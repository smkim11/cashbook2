<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
		margin: 0;
		text-align: center;
	}
	h1 {
		margin-top: 30px;
		text-align: center;
		color: #0A9AE0;
		margin-bottom: 30px;
	}

	.table {
		background-color: #fff;
		border-radius: 8px;
		overflow: hidden;
		box-shadow: 0 4px 10px rgba(0,0,0,0.05);
		margin:auto;
		margin-bottom:10px;
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
	<h1>비밀번호 변경</h1>
	<form action="<%=request.getContextPath() %>/updatePw" method="post">
	<table class="w-25 table table-bordered text-center align-middle">
		<input type="hidden" name="id" value="admin">
		<tr>
			<th>기존 비밀번호</th>
			<td><input class="form-control" type="password" name="pw" class="form-control"></td>
		</tr>
		<tr>
			<th>변경 비밀번호</th>
			<td><input class="form-control" type="password" name="newpw" class="form-control"></td>
		</tr>
		<tr>
			<th>비밀번호 확인</th>
			<td><input class="form-control" type="password" name="newpw2" class="form-control"></td>
		</tr>
	</table>
	<div class="form-button">
		<button type="submit" class="btn btn-primary">변경</button>	
	</div>
	</form>
</body>
</html>