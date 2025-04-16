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
	
	CashDao cd = new CashDao();
	Cash c = cd.selectCashDate(cashNo);
	
	if(PW.equals(pass)){
		cd.deleteCash(cashNo);
		System.out.println("삭제 성공");
		response.sendRedirect("/cashbook2/dateList.jsp?cashDate="+c.getCashDate());
	}
	else{
		System.out.println("비밀번호가 틀렸습니다");
		response.sendRedirect("/cashbook2/cash/deleteCashForm.jsp?cashNo="+cashNo+"&kind="+encodedKind);
	}
	
	
%>
