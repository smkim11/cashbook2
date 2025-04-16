<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="model.*"%>
<%@ page import="dto.*"%>
<%
	String ID = (String)(session.getAttribute("ID"));
	if(ID == null){ // 로그아웃 상태 일때
		response.sendRedirect("/cashbook2/index.jsp");
		return;
	}
	
	// dateList.jsp -> 수입 지출 입력 버튼(0000-00-00) ->
	String cashDate = request.getParameter("cashDate");
	
	// insertCashForm-> kind 선택(String kind)
	String kind = request.getParameter("kind");
	if(kind == null){
		kind="";
	}
	
	ArrayList<Category> list = new ArrayList<>();
	if(kind!=null){// insertCashForm에서 kind 선택 후 재요청
		// DB에서 선택된 kind에 해당하는 title목록
		CategoryDao cd = new CategoryDao();
		list = cd.selectCategoryListByKind(kind);
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
	h2 {
		text-align: center !important;
		color: #0A9AE0 !important;
		margin-bottom: 30px;
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
	<h2>종류 선택</h2>
	<form method="post" action="/cashbook2/cash/insertCashForm.jsp">
		<table class="w-25 table table-bordered text-center align-middle">
		<input type="hidden" name="cashDate" value="<%=cashDate%>">
			<tr>
				<th>종류</th>
				<td>
					<select name="kind" class="form-control">
						<%
							if(kind.equals("수입")){
						%>
								<option value="" >::선택::</option>
								<option value="수입" selected>수입</option>
								<option value="지출">지출</option>
						<% 
							}else if(kind.equals("지출")){
						%>
								<option value="">::선택::</option>
								<option value="수입">수입</option>
								<option value="지출" selected>지출</option>
						<% 
							}else{
						%>
								<option value="">::선택::</option>
								<option value="수입">수입</option>
								<option value="지출">지출</option>
						<% 
							}
						%>
					</select>
				</td>
			</tr>
		</table>
		<div class="form-button">
			<button type="submit" class="btn btn-primary">선택</button>
		</div>
	</form>
	<hr>
	
	<%
		if(kind.equals("수입")){
	%>
			<h2>수입 추가</h2>
	<%
		}else if(kind.equals("지출")){
	%>
			<h2>지출 추가</h2>
	<% 
		}else{
	%>
			<h2>추가</h2>
	<% 
		}
	%>
	<form method="post" action="/cashbook2/cash/insertCashAction.jsp">
		<table class="w-25 table table-bordered text-center align-middle">
		<tr>
			<th>날짜</th>
			<td><input type="text" name="cashDate" value="<%=cashDate%>" class="form-control mt-3" readonly></td>
		</tr>
		<tr>
			<th>카테고리</th>
			<td>
				<select name="categoryNo" class="form-control">
					<%
						if(list != null){
							for(Category ct : list){
					%>
								<option value="<%=ct.getCategoryNo()%>"><%=ct.getTitle() %></option>
					<%	
							}
						}
					%>
				</select>
			</td>
		</tr>
		<tr>
			<th>금액</th>
			<td><input type="number" name="amount" class="form-control"></td>
		</tr>
		<tr>
			<th>메모</th>
			<td><textarea name="memo" class="form-control" cols="5" rows="6"></textarea></td>
		</tr>
		<tr>
			<th>색</th>
			<td><input type="color" name="color" class="form-control form-control-color"></td>
		</tr>
		</table>
		<div class="form-button">
			<button type="submit" class="btn btn-primary">입력</button>
		</div>
	</form>
</div>
</body>
</html>