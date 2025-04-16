<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.*"%>
<%@ page import="dto.*"%>
<%
	String cashDate = request.getParameter("cashDate");
	int categoryNo = Integer.valueOf(request.getParameter("categoryNo"));
	int amount = Integer.valueOf(request.getParameter("amount"));
	String memo = request.getParameter("memo");
	String color = request.getParameter("color");
	
	Cash c = new Cash();
	c.setCashDate(cashDate);
	c.setCategoryNo(categoryNo);
	c.setAmount(amount);
	c.setMemo(memo);
	c.setColor(color);
	
	CashDao cd = new CashDao();
	cd.insertCash(c);
	
	response.sendRedirect("/cashbook2/dateList.jsp?cashDate="+cashDate);
%>
