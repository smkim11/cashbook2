<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.*"%>
<%@ page import="dto.*"%>
<%
	int cnum = Integer.valueOf(request.getParameter("cnum"));
	
	CategoryDao cd = new CategoryDao();
	cd.deleteCategory(cnum);
	
	response.sendRedirect("/cashbook2/category/categoryList.jsp");
%>