package controller;

import java.io.IOException;
import java.sql.SQLException;

import dto.Admin;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.LoginDao;


@WebServlet("/login")
public class LoginController extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String ID = (String)(session.getAttribute("ID"));
		if(ID != null){ // 로그인 상태 일때
			response.sendRedirect(request.getContextPath()+"/index");
			return;
		}
		
		request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		
		LoginDao ld = new LoginDao();
		Admin a = null;
		try {
			a = ld.cashbookLogin(id, pw);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		
		if(a.getAdminPw() != null){ // 로그인 성공 시
			
			session.setAttribute("ID",a.getAdminId());
			session.setAttribute("PW",a.getAdminPw());
			
			response.sendRedirect(request.getContextPath()+"/index");
		}
		else{ // 로그인 실패 시
			response.sendRedirect(request.getContextPath()+"/login");
		}
		
	}

}
