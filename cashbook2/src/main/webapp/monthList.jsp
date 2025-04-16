<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="model.*"%>
<%@ page import="dto.*"%>
<%@ page import="java.text.NumberFormat"%>
<%
	String ID = (String)(session.getAttribute("ID"));
	if(ID == null){ // 로그아웃 상태 일때
		response.sendRedirect("/cashbook2/index.jsp");
		return;
	}
	
	Calendar c = Calendar.getInstance();
	
	if(request.getParameter("targetMonth") != null){
		c.set(Calendar.MONTH,Integer.valueOf(request.getParameter("targetMonth")));
	}
	
	c.set(Calendar.DATE,1); // 날짜를 1일로 변경
	
	int lastDate = c.getActualMaximum(Calendar.DATE);
	int dayOfWeek = c.get(Calendar.DAY_OF_WEEK); // 요일별 숫자 변환-> 일=1,월=2...
	
	int startBlank = dayOfWeek-1;
	int endBlank = 0;
	int totalCell = startBlank+lastDate+endBlank;
	
	// 전체 칸 개수가 7로 나누어지지 않으면 나누어지도록 endBlank 추가
	if(totalCell % 7 != 0){
		endBlank = 7 - totalCell % 7;
		totalCell = startBlank+lastDate+endBlank;
	}
	
	CashDao cd = new CashDao();
	
	ArrayList<HashMap<String,Object>> list = cd.totalAmountByDate(Integer.valueOf(c.get(Calendar.YEAR)),Integer.valueOf(c.get(Calendar.MONTH)+1));
	
	int year = c.get(Calendar.YEAR);
	int month = c.get(Calendar.MONTH)+1;
	DataDao dd = new DataDao();
	ArrayList<HashMap<String,Object>> totalList = dd.selectTotalData();
	ArrayList<HashMap<String,Object>> totalYearList = dd.selectYearData(year);
	ArrayList<HashMap<String,Object>> totalMonthList = dd.selectMonthData(year,month);
	
	NumberFormat numberFormat = NumberFormat.getInstance();
%>
<!DOCTYPE html>
<html>
<head>
<style>
	body {
		font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif !important;
		margin: 20px;
		background-color: #f8fbff !important;
	}

	h1 {
		color: #0A9AE0 !important;
	}

	a {
		text-decoration: none !important;
		color: #0A9AE0;
		font-weight: bold !important;
	}

	.container {
		display: flex;
		gap: 40px;
		align-items: flex-start;
	}

	.calendar {
		flex: 2;
	}

	.stats {
		flex: 1;
		margin-top: 111px;
	}

	.table, .table2 {
		border-collapse: collapse;
		width: 100%;
		background-color: #fff;
		box-shadow: 0 4px 8px rgba(0, 0, 0, 0.05);
		border-radius: 8px;
		overflow: hidden;
	}

	.table th, .table td,
	.table2 th, .table2 td {
		border: 1px solid #cce6ff;
		padding: 8px;
		text-align: center;
	}

	.table th {
		background-color: #e6f3ff;
	}

	.table2 th {
		background-color: #d6efff;
		color: #0A9AE0;
	}

	.table2 td {
		background-color: #f7fbff;
	}

	span {
		font-size: 13px;
	}
	.calendar-header {
		display: flex;
		justify-content: space-between;
		align-items: center;
		margin: 20px auto;
		width: 80%;
		background-color: #f5f5f5;
		border-radius: 10px;
		padding: 16px 24px;
		box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	}

	.calendar-header h1 {
		font-size: 24px;
		color: #333;
		margin: 0;
	}

	.nav-button {
		background-color: #0A9AE0;
		color: #fff;
		text-decoration: none;
		padding: 8px 16px;
		border-radius: 6px;
		font-weight: bold;
		transition: background-color 0.3s;
	}

	.nav-button:hover {
		background-color: #0077b6;
	}
</style>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<jsp:include page="/nav/nav.jsp" />
	<div class="page-content">

<div class="container">
	<div class="calendar">
	<div class="calendar-header">
		<a class="nav-button" href="/cashbook2/monthList.jsp?targetMonth=<%=c.get(Calendar.MONTH)-1%>">◀</a>
		<h1><%=c.get(Calendar.YEAR) %>년 <%=c.get(Calendar.MONTH)+1 %>월</h1>
		<a class="nav-button" href="/cashbook2/monthList.jsp?targetMonth=<%=c.get(Calendar.MONTH)+1%>">▶</a>
	</div>
	<table class="table">
		<tr>
			<th style="color:red";>일</th>
			<th>월</th>
			<th>화</th>
			<th>수</th>
			<th>목</th>
			<th>금</th>
			<th style="color:blue";>토</th>
		</tr>
		<tr>
			<%
				for(int i=1;i<=totalCell;i++){
			%>
					<td style="height:80px; vertical-align:top; text-align:right;">
					<%
						if(i-startBlank>0 && i-startBlank<=lastDate){
							
					%>	
					<%
							String mon = String.format("%02d", c.get(Calendar.MONTH) + 1);
							String date = String.format("%02d", i-startBlank);
					%>
							<a href="/cashbook2/dateList.jsp?cashDate=<%=c.get(Calendar.YEAR)%>-<%=mon%>-<%=date %>"><%=i-startBlank %></a><br>
							<%
								String expense = "-";
								String income = "-";
								for(HashMap<String,Object> m : list){
							%>
									<%
										if(Integer.valueOf(String.valueOf(m.get("cashDate")).substring(8))==i-startBlank){
											
									%>
											<%
												if(m.get("kind").equals("지출") && m.get("sum") != null){
											%>	
														<%expense =numberFormat.format(m.get("sum"))+"원";%>
											<% 
												}else if (m.get("kind").equals("수입") && m.get("sum") != null){
											%>
														<%income =numberFormat.format(m.get("sum"))+"원";%>
											<% 
												}
											%>
									<% 
										}
									%>
							<% 
								}
							%>	
							<span style="color:blue"><%=income %></span><br>
							<span style="color:red"><%=expense %></span><br>
					<% 
						}else{
					%>
							<%="" %>
					<% 
						}
					%>
					</td>
				<%
					if(i%7==0){
				%>
						</tr><tr>
				<% 
					}
				%>
			<% 
				}
			%>
		</table>
	</div>
	<div class="stats">
	<table class="table2">
		<tr>
			<th>전체통계</th>
			<th>종류</th>
			<th>총액(원)</th>
		</tr>
			<%
				for(HashMap<String,Object> m : totalList){
			%>
					<tr>
						<td>.</td>
						<td><%=m.get("kind")%></td>
						<td><%=numberFormat.format(m.get("total"))%></td>
					</tr>
			<% 
				}
			%>
		<tr>
			<th>현재년도</th>
			<th>종류</th>
			<th>총액(원)</th>
		</tr>
			<%
				for(HashMap<String,Object> m : totalYearList){
			%>
					<tr>
						<td><%=m.get("year")%>년</td>
						<td><%=m.get("kind")%></td>
						<td><%=numberFormat.format(m.get("total"))%></td>
					</tr>
			<% 
				}
			%>
			<tr>
			<th>현재 월</th>
			<th>종류</th>
			<th>총액(원)</th>
		</tr>
			<%
				for(HashMap<String,Object> m : totalMonthList){
			%>
					<tr>
						<td><%=m.get("month")%>월</td>
						<td><%=m.get("kind")%></td>
						<td><%=numberFormat.format(m.get("total"))%></td>
					</tr>
			<% 
				}
			%>
	</table>
	</div>
</div>
</div>
</body>
</html>