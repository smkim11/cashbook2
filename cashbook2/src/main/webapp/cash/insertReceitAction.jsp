<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.nio.file.*" %>
<%@ page import="model.*"%>
<%@ page import="dto.*"%>
<%@ page import="java.net.URLEncoder" %>
<%
	int cashNo = Integer.valueOf(request.getParameter("cashNo"));
	String kind = request.getParameter("kind");
	Part part = request.getPart("receit");
	// sendRedirect할때 한글로된 값도 보내기위해 인코딩
	String encodedKind = URLEncoder.encode(kind, "UTF-8");
	
	String originalName = part.getSubmittedFileName();

	// 1) 중복되지 않는 새로운 파일이름 생성
	UUID uuid = UUID.randomUUID();
	String filename = uuid.toString().replace("-","");
	
	// 2) 1의 결과에 확장자 추가
	int dotLastPos = originalName.lastIndexOf(".");
	String ext = originalName.substring(dotLastPos);
	filename = filename + ext;
	
	Receit r = new Receit();
	r.setCashNo(cashNo);
	r.setFileName(filename);
	
	// 3) 파일저장
	String path = request.getServletContext().getRealPath("upload"); 
	System.out.println("path: "+path);
	File emptyFile = new File(path,filename);
	// 파일보낼 inputstream 설정
	InputStream is = part.getInputStream(); 
	// 파일을 받을 outputstream 설정
	OutputStream os = Files.newOutputStream(emptyFile.toPath());
	is.transferTo(os); 
	
	// 4) db에 저장
	ReceitDao rd = new ReceitDao();
	rd.insertReceit(r);
	
	response.sendRedirect("/cashbook2/cash/cashOne.jsp?cashNo="+cashNo+"&kind="+encodedKind);
%>
