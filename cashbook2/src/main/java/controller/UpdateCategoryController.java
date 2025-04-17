package controller;

import java.io.IOException;
import java.sql.SQLException;

import dto.Category;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.CategoryDao;

@WebServlet("/updateCategory")
public class UpdateCategoryController extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String ID = (String)(session.getAttribute("ID"));
		if(ID == null){ // 로그아웃 상태 일때
			response.sendRedirect(request.getContextPath()+"/index");
			return;
		}	
		
		int cnum = Integer.valueOf(request.getParameter("cnum"));
		
		CategoryDao cd = new CategoryDao();
		Category c = null;
		try {
			c = cd.selectCategoryOne(cnum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		request.setAttribute("cnum", cnum);
		request.setAttribute("c", c);
		
		request.getRequestDispatcher("/WEB-INF/view/updateCategory.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int cnum = Integer.valueOf(request.getParameter("cnum"));
		String kind = request.getParameter("kind");
		String title = request.getParameter("title");
		
		Category c = new Category();
		c.setTitle(title);
		c.setCategoryNo(cnum);
		
		CategoryDao cd = new CategoryDao();
		try {
			cd.updateCategoryTitle(c);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		response.sendRedirect(request.getContextPath()+"/categoryList");
	}

}
