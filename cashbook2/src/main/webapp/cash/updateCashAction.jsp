<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="model.*"%>
<%@ page import="dto.*"%>
<%@ page import="java.net.URLEncoder" %>
<%
	String cashDate = request.getParameter("cashDate");
	int cashNo = Integer.valueOf(request.getParameter("cashNo"));
	String kind = request.getParameter("kind");
	String memo = request.getParameter("memo");
	String title = request.getParameter("title");
	int amount = Integer.valueOf(request.getParameter("amount"));
	// sendRedirect할때 한글로된 값도 보내기위해 인코딩
	String encodedKind = URLEncoder.encode(kind, "UTF-8");
	
	Cash c = new Cash();
	c.setCashDate(cashDate);
	c.setMemo(memo);
	c.setAmount(amount);
	c.setCashNo(cashNo);
	
	CashDao cd = new CashDao();
	cd.updateCash(c);
	
	response.sendRedirect("/cashbook2/cash/cashOne.jsp?cashNo="+cashNo+"&kind="+encodedKind);
%>