package controller;

import java.io.IOException;
import java.util.ArrayList;

import dto.Cash;
import dto.Category;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.CashDao;
import model.CategoryDao;

@WebServlet("/insertCash")
public class InsertCashController extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String ID = (String)(session.getAttribute("ID"));
		if(ID == null){ // 로그아웃 상태 일때
			response.sendRedirect(request.getContextPath()+"/index");
			return;
		}
		
		// dateList.jsp -> 수입 지출 입력 버튼(0000-00-00) ->
		String cashDate = request.getParameter("cashDate");
		
		// insertCashForm-> kind 선택(String kind)
		String kind = request.getParameter("kind");
		if(kind == null){
			kind="";
		}
		
		ArrayList<Category> list = new ArrayList<>();
		if(kind!=null){// insertCashForm에서 kind 선택 후 재요청
			// DB에서 선택된 kind에 해당하는 title목록
			CategoryDao cd = new CategoryDao();
			try {
				list = cd.selectCategoryListByKind(kind);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		request.setAttribute("cashDate", cashDate);
		request.setAttribute("kind", kind);
		request.setAttribute("list", list);
		
		request.getRequestDispatcher("/WEB-INF/view/insertCash.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String cashDate = request.getParameter("cashDate");
		int categoryNo = Integer.valueOf(request.getParameter("categoryNo"));
		int amount = Integer.valueOf(request.getParameter("amount"));
		String memo = request.getParameter("memo");
		String color = request.getParameter("color");
		
		Cash c = new Cash();
		c.setCashDate(cashDate);
		c.setCategoryNo(categoryNo);
		c.setAmount(amount);
		c.setMemo(memo);
		c.setColor(color);
		
		CashDao cd = new CashDao();
		try {
			cd.insertCash(c);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		response.sendRedirect(request.getContextPath()+"/dateList?cashDate="+cashDate);
	}

}
