<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.*"%>
<%@ page import="dto.*"%>
<%
	String kind = request.getParameter("kind");
	String title = request.getParameter("title");
	
	Category c = new Category();
	c.setKind(kind);
	c.setTitle(title);
			
	CategoryDao cd = new CategoryDao();
	cd.insertCategory(c);
	
	response.sendRedirect("/cashbook2/category/categoryList.jsp");
%>