package controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.util.UUID;

import dto.Receit;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import model.ReceitDao;

@WebServlet("/insertReceit")
public class InsertReceitController extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		String ID = (String)(session.getAttribute("ID"));
		if(ID == null){ // 로그아웃 상태 일때
			response.sendRedirect(request.getContextPath()+"/index");
			return;
		}
		
		int cashNo = Integer.valueOf(request.getParameter("cashNo"));
		String kind = request.getParameter("kind");
		
		request.setAttribute("cashNo",cashNo);
		request.setAttribute("kind",kind);
		
		request.getRequestDispatcher("/WEB-INF/view/insertReceit.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
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
		try {
			rd.insertReceit(r);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		response.sendRedirect(request.getContextPath()+"/cashOne?cashNo="+cashNo+"&kind="+encodedKind);
	}

}
