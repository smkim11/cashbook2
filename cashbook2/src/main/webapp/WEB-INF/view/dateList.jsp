<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="model.*"%>
<%@ page import="dto.*"%>
<%@ page import="java.text.NumberFormat"%>
<%
	String cashDate = (String)(request.getAttribute("cashDate"));
	NumberFormat numberFormat = (NumberFormat)(request.getAttribute("numberFormat"));
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
	span{
	font-size:30px
	}
	body {
		font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif !important;
		background-color: #f9fcff !important;
		margin: 0 !important;
		text-align: center !important;
	}

	.page-content {
		padding-top: 70px;
	}

	h1 {
		text-align: center;
		color: #0A9AE0 !important;
		margin-bottom: 30px;
	}

	.container {
		max-width: 900px;
		margin: auto;
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
	
	.table-wrapper {
		position: relative;
		width: fit-content;
		margin: auto;
		margin-top:30px;
		margin-bottom:10px;
		left: 320px;
	}

</style>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<jsp:include page="/nav/nav.jsp"></jsp:include>
<div class="page-content">
	<h1><%=cashDate %> 수입 지출</h1>
	<div class="table-wrapper">
		<form method="post" action="<%=request.getContextPath() %>/insertCash" >
			<input type="hidden" name="cashDate" value="<%=cashDate%>">
			<button type="submit" class="btn btn-primary">추가</button>
		</form>
	</div>
	<table class="w-50 table table-bordered text-center align-middle">
		<tr>
			<th>종류</th>
			<th>제목</th>
			<th>가격</th>
			<th>메모</th>
			<th>영수증</th>
		</tr>
			<% 
				for(HashMap<String,Object> m : list){
			%>
					<tr>
						<td style='color:<%=m.get("color")%>'><%=m.get("kind") %></td>
						<td style='color:<%=m.get("color")%>'><%=m.get("title") %></td>
						<td style='color:<%=m.get("color")%>'><%=numberFormat.format(m.get("amount"))%></td>
						<td style='color:<%=m.get("color")%>'>
							<a href="<%=request.getContextPath() %>/cashOne?cashNo=<%=m.get("cashNo")%>&kind=<%=m.get("kind") %>"><%=m.get("memo") %></a>
						</td>
						<td>
							<%
								ReceitDao rd = new ReceitDao();
								int receitCount = rd.countReceit((Integer)(m.get("cashNo")));
								if(receitCount==0){
							%>
									<span>&#128581;&#127995;</span>
							<% 
								}else{
							%>
									<span>&#128582;&#127995;</span>
							<% 
								}
							%>
						</td>
					</tr>
			<% 
				}
			%>
	</table>
	
</div>
</body>
</html>