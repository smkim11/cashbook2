package controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;

import dto.Cash;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.CashDao;


@WebServlet("/updateCash")
public class UpdateCashController extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String ID = (String)(session.getAttribute("ID"));
		if(ID == null){ // 로그아웃 상태 일때
			response.sendRedirect(request.getContextPath()+"/index");
			return;
		}
		
		int cashNo = Integer.valueOf(request.getParameter("cashNo"));
		
		CashDao cd = new CashDao();
		ArrayList<HashMap<String,Object>> list = new ArrayList<>();
		try {
			list = cd.selectCashByNo(cashNo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		request.setAttribute("cashNo", cashNo);
		request.setAttribute("list", list);
		
		request.getRequestDispatcher("/WEB-INF/view/updateCash.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String cashDate = request.getParameter("cashDate");
		int cashNo = Integer.valueOf(request.getParameter("cashNo"));
		String kind = request.getParameter("kind");
		String memo = request.getParameter("memo");
		String title = request.getParameter("title");
		int amount = Integer.valueOf(request.getParameter("amount"));
		// sendRedirect할때 한글로된 값도 보내기위해 인코딩
		String encodedKind = URLEncoder.encode(kind, "UTF-8");
		
		Cash c = new Cash();
		c.setCashDate(cashDate);
		c.setMemo(memo);
		c.setAmount(amount);
		c.setCashNo(cashNo);
		
		CashDao cd = new CashDao();
		try {
			cd.updateCash(c);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		response.sendRedirect(request.getContextPath()+"/cashOne?cashNo="+cashNo+"&kind="+encodedKind);
	}

}
