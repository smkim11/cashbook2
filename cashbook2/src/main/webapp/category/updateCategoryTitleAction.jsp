<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.*"%>
<%@ page import="dto.*"%>
<%
	int cnum = Integer.valueOf(request.getParameter("cnum"));
	String kind = request.getParameter("kind");
	String title = request.getParameter("title");
	
	Category c = new Category();
	c.setTitle(title);
	c.setCategoryNo(cnum);
	
	CategoryDao cd = new CategoryDao();
	cd.updateCategoryTitle(c);
	
	response.sendRedirect("/cashbook2/category/categoryList.jsp");
%>