package controller;

import java.io.IOException;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.LoginDao;


@WebServlet("/updatePw")
public class UpdatePwController extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/view/updatePw.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		String newpw = request.getParameter("newpw");
		String newpw2 = request.getParameter("newpw2");
		
		LoginDao ld = new LoginDao();
		int row = 0;
		try {
			row = ld.updatePassword(id, pw, newpw);
		} catch (Exception e) {
			e.printStackTrace();
		}
		// 기존 아이디와 비밀번호가 맞고 변경비밀번호 두개가 같아야 변경 성공
		if(newpw.equals(newpw2)){
			
			if(row==1){
				response.sendRedirect(request.getContextPath()+"/login");
			}
			else{
				System.out.println("기존 비밀번호 확인");
				response.sendRedirect(request.getContextPath()+"/updatePw");
			}
		}
		else{
			System.out.println("변경 비밀번호 확인");
			response.sendRedirect(request.getContextPath()+"/updatePw");
		}
	}

}
