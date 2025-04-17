package controller;

import java.io.IOException;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.CashDao;
import model.DataDao;

@WebServlet("/monthList")
public class MonthListController extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String ID = (String)(session.getAttribute("ID"));
		if(ID == null){ // 로그아웃 상태 일때
			response.sendRedirect(request.getContextPath()+"/index");
			return;
		}	
			
		Calendar c = Calendar.getInstance();
		
		if(request.getParameter("targetMonth") != null){
			c.set(Calendar.MONTH,Integer.valueOf(request.getParameter("targetMonth")));
		}
		
		c.set(Calendar.DATE,1); // 날짜를 1일로 변경
		
		int lastDate = c.getActualMaximum(Calendar.DATE);
		int dayOfWeek = c.get(Calendar.DAY_OF_WEEK); // 요일별 숫자 변환-> 일=1,월=2...
		
		int startBlank = dayOfWeek-1;
		int endBlank = 0;
		int totalCell = startBlank+lastDate+endBlank;
		
		// 전체 칸 개수가 7로 나누어지지 않으면 나누어지도록 endBlank 추가
		if(totalCell % 7 != 0){
			endBlank = 7 - totalCell % 7;
			totalCell = startBlank+lastDate+endBlank;
		}
		
		CashDao cd = new CashDao();
		ArrayList<HashMap<String,Object>> list = new ArrayList<>();
		try {
			list = cd.totalAmountByDate(Integer.valueOf(c.get(Calendar.YEAR)),Integer.valueOf(c.get(Calendar.MONTH)+1));
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		int year = c.get(Calendar.YEAR);
		int month = c.get(Calendar.MONTH)+1;
		DataDao dd = new DataDao();
		ArrayList<HashMap<String,Object>> totalList = new ArrayList<>();
		try {
			totalList = dd.selectTotalData();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		ArrayList<HashMap<String,Object>> totalYearList = new ArrayList<>();
		try {
			totalYearList = dd.selectYearData(year);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		ArrayList<HashMap<String,Object>> totalMonthList = new ArrayList<>();
		try {
			totalMonthList = dd.selectMonthData(year,month);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		NumberFormat numberFormat = NumberFormat.getInstance();
		
		request.setAttribute("c", c); 
		request.setAttribute("startBlank",startBlank);     
		request.setAttribute("lastDate",lastDate);
		request.setAttribute("totalCell",totalCell);
		request.setAttribute("list",list);
		request.setAttribute("totalList",totalList);
		request.setAttribute("totalYearList",totalYearList);
		request.setAttribute("totalMonthList",totalMonthList);
		request.setAttribute("numberFormat", numberFormat);
		
		request.getRequestDispatcher("/WEB-INF/view/monthList.jsp").forward(request, response);
	}
}
