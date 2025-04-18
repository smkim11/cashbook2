package controller;

import java.io.IOException;
import java.net.URLEncoder;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.ReceitDao;

@WebServlet("/deleteReceit")
public class DeleteReceitController extends HttpServlet {
     
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		String ID = (String)(session.getAttribute("ID"));
		if(ID == null){ // 로그아웃 상태 일때
			response.sendRedirect(request.getContextPath()+"/index");
			return;
		}
		
		int cashNo = Integer.valueOf(request.getParameter("cashNo"));
		String kind = request.getParameter("kind");
		
		request.setAttribute("cashNo", cashNo);
		request.setAttribute("kind", kind);
		
		request.getRequestDispatcher("/WEB-INF/view/deleteReceit.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		String PW = (String)(session.getAttribute("PW"));
		String pass = request.getParameter("pass");
		int cashNo = Integer.valueOf(request.getParameter("cashNo"));
		String kind = request.getParameter("kind");
		// sendRedirect할때 한글로된 값도 보내기위해 인코딩
		String encodedKind = URLEncoder.encode(kind, "UTF-8");
		
		ReceitDao rd = new ReceitDao();
		if(PW.equals(pass)){
			try {
				rd.deleteReceit(cashNo);
			} catch (Exception e) {
				e.printStackTrace();
			}
			System.out.println("영수증 삭제 성공");
			response.sendRedirect(request.getContextPath()+"/cashOne?cashNo="+cashNo+"&kind="+encodedKind);
		}else{
			System.out.println("비밀번호를 틀렸습니다");
			response.sendRedirect(request.getContextPath()+"/deleteReceit?cashNo="+cashNo+"&kind="+encodedKind);
		}
	}

}
