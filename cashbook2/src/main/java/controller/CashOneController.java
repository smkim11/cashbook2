package controller;

import java.io.IOException;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.HashMap;

import dto.Receit;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.CashDao;
import model.ReceitDao;

@WebServlet("/cashOne")
public class CashOneController extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String ID = (String)(session.getAttribute("ID"));
		if(ID == null){ // 로그아웃 상태 일때
			response.sendRedirect(request.getContextPath()+"/index");
			return;
		}	
		int cashNo = Integer.valueOf(request.getParameter("cashNo"));
		String kind = request.getParameter("kind");
		
		NumberFormat numberFormat = NumberFormat.getInstance();
		
		CashDao cd = new CashDao();
		ArrayList<HashMap<String,Object>> list = new ArrayList<>();
		try {
			list = cd.selectCashByNo(cashNo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		ReceitDao rd = new ReceitDao();
		Receit r = new Receit();
		try {
			r = rd.selectReceit(cashNo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		request.setAttribute("cashNo", cashNo);
		request.setAttribute("kind", kind);
		request.setAttribute("numberFormat", numberFormat);
		request.setAttribute("list", list);
		request.setAttribute("r", r);
		
		request.getRequestDispatcher("/WEB-INF/view/cashOne.jsp").forward(request, response);
	}
}
