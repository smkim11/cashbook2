<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	
	LoginDao ld = new LoginDao();
	Admin a = ld.cashbookLogin(id, pw);
	
	if(a.getAdminPw() != null){ // 로그인 성공 시
		session.setAttribute("ID",a.getAdminId());
		session.setAttribute("PW",a.getAdminPw());
		
		response.sendRedirect("/cashbook2/index.jsp");
	}
	else{ // 로그인 실패 시
		response.sendRedirect("/cashbook2/login/loginForm.jsp");
	}
	
	
	
%>