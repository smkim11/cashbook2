<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*"%>
<%@ page import="model.*"%>
<%@ page import="java.net.URLEncoder" %>
<%
	String PW = (String)(session.getAttribute("PW"));
	String pass = request.getParameter("pass");
	int cashNo = Integer.valueOf(request.getParameter("cashNo"));
	String kind = request.getParameter("kind");
	// sendRedirect할때 한글로된 값도 보내기위해 인코딩
	String encodedKind = URLEncoder.encode(kind, "UTF-8");
	
	ReceitDao rd = new ReceitDao();
	if(PW.equals(pass)){
		rd.deleteReceit(cashNo);
		System.out.println("영수증 삭제 성공");
		response.sendRedirect("/cashbook2/cash/cashOne.jsp?cashNo="+cashNo+"&kind="+encodedKind);
	}else{
		System.out.println("비밀번호를 틀렸습니다");
		response.sendRedirect("/cashbook2/cash/deleteReceitForm.jsp?cashNo="+cashNo+"&kind="+encodedKind);
	}
	
%>