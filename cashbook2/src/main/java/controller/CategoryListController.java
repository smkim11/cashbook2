package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import dto.Category;
import dto.Paging;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.CategoryDao;

@WebServlet("/categoryList")
public class CategoryListController extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String ID = (String)(session.getAttribute("ID"));
		if(ID == null){ // 로그아웃 상태 일때
			response.sendRedirect(request.getContextPath()+"/index");
			return;
		}
		
		int currentPage = 1;
		if(request.getParameter("currentPage") != null){
			currentPage = Integer.valueOf(request.getParameter("currentPage"));
		}
		int rowPerPage = 5;
		Paging p = new Paging();
		p.setCurrentPage(currentPage);
		p.setRowPerPage(rowPerPage);
		
		CategoryDao cd = new CategoryDao();
		
		ArrayList<Category> list = null;
		try {
			list = cd.selectCategory(p);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		int lastPage = 0;
		try {
			lastPage = p.getLastPage(cd.totalCategory());
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("lastPage", lastPage);
		request.setAttribute("list", list);
		
		request.getRequestDispatcher("/WEB-INF/view/categoryList.jsp").forward(request, response);
	}
}
