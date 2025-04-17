package controller;

import java.io.IOException;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.HashMap;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.CashDao;


@WebServlet("/dateList")
public class DateListController extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String ID = (String)(session.getAttribute("ID"));
		if(ID == null){ // 로그아웃 상태 일때
			response.sendRedirect(request.getContextPath()+"/index");
			return;
		}
		
		String cashDate = request.getParameter("cashDate");
		
		NumberFormat numberFormat = NumberFormat.getInstance();
		
		ArrayList<HashMap<String,Object>> list = new ArrayList<>();
		CashDao cd = new CashDao();
		try {
			list = cd.selectCashByDate(cashDate);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		request.setAttribute("cashDate", cashDate); 
		request.setAttribute("numberFormat", numberFormat);
		request.setAttribute("list", list); 
		
		request.getRequestDispatcher("/WEB-INF/view/dateList.jsp").forward(request, response);
	}
}
