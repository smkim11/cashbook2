<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<style>
	.navbar-custom {
		background-color: #0A9AE0;
		padding: 10px 20px;
		position: fixed;
		top: 0;
		width: 100%;
		z-index: 1000;
		box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
	}
	.navbar-custom a {
		color: white;
		text-decoration: none;
		font-weight: bold;
		margin-right: 20px;
	}
	.navbar-custom a:hover {
		text-decoration: underline;
	}
	.page-content {
		padding-top: 70px; 
	}
</style>
<div class="navbar-custom d-flex align-items-center justify-content-between">
	<div>
		<a href="<%=request.getContextPath() %>/index">홈</a>
		<a href="<%=request.getContextPath() %>/monthList">달력</a>
		<a href="<%=request.getContextPath() %>/categoryList">수입 지출</a>
	</div>
	<div>
		<a href="<%=request.getContextPath() %>/logout">로그아웃</a>
	</div>
</div>