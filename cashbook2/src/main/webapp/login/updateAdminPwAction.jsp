<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	String newpw = request.getParameter("newpw");
	String newpw2 = request.getParameter("newpw2");
	
	LoginDao ld = new LoginDao();
	int row = 0;
	
	// 기존 아이디와 비밀번호가 맞고 변경비밀번호 두개가 같아야 변경 성공
	if(newpw.equals(newpw2)){
		row = ld.updatePassword(id, pw, newpw);
		if(row==1){
			response.sendRedirect("/cashbook2/login/loginForm.jsp");
		}
		else{
			System.out.println("기존 비밀번호 확인");
			response.sendRedirect("/cashbook2/login/updateAdminPwForm.jsp");
		}
	}
	else{
		System.out.println("변경 비밀번호 확인");
		response.sendRedirect("/cashbook2/login/updateAdminPwForm.jsp");
	}
%>