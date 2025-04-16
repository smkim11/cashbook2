package model;
import java.sql.*;
import java.util.*;
public class DataDao {
	
	// 전체 수입/ 지출 총 금액
	public ArrayList<HashMap<String,Object>> selectTotalData() throws Exception {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/cashbook", "root", "java1234");
		String sql = "SELECT ct.kind, COUNT(*) cnt, SUM(c.amount) total "
					+ "FROM cash c INNER JOIN category ct ON c.category_no = ct.category_no "
					+ "GROUP BY ct.kind";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
		ArrayList<HashMap<String,Object>> list = new ArrayList<>();
		while(rs.next()) {
			HashMap<String,Object> m = new HashMap<>();
			m.put("kind", rs.getString("kind"));
			m.put("cnt",rs.getInt("cnt"));
			m.put("total", rs.getInt("total"));
			
			list.add(m);
		}
		
		conn.close();
		
		return list;
	}
	
	// 연도별 총액
	public ArrayList<HashMap<String,Object>> selectYearData(int year) throws Exception {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/cashbook", "root", "java1234");
		String sql ="SELECT year(cash_date) year, ct.kind,COUNT(*) cnt, SUM(c.amount) total "
				 + "FROM cash c INNER JOIN category ct ON c.category_no = ct.category_no "
				 + "WHERE YEAR(cash_date)=? "
				 + "GROUP BY year(cash_date), ct.kind "
				 + "ORDER BY year(cash_date)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, year);
		ResultSet rs = stmt.executeQuery();
		
		ArrayList<HashMap<String,Object>> list = new ArrayList<>();
		while(rs.next()) {
			HashMap<String,Object> m = new HashMap<>();
			m.put("year", rs.getString("year"));
			m.put("kind", rs.getString("kind"));
			m.put("cnt",rs.getInt("cnt"));
			m.put("total", rs.getInt("total"));
			
			list.add(m);
		}
		
		conn.close();
		
		return list;
	}
	
	// 월별 총액
	public ArrayList<HashMap<String,Object>> selectMonthData(int year, int month) throws Exception {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/cashbook", "root", "java1234");
		String sql ="SELECT month(cash_date) month, ct.kind,COUNT(*) cnt, SUM(c.amount) total "
				 + "FROM cash c INNER JOIN category ct ON c.category_no = ct.category_no "
				 + "WHERE YEAR(cash_date)=? and MONTH(cash_date)=? "
				 + "GROUP BY month(cash_date), ct.kind "
				 + "ORDER BY month(cash_date)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, year);
		stmt.setInt(2, month);
		ResultSet rs = stmt.executeQuery();
		
		ArrayList<HashMap<String,Object>> list = new ArrayList<>();
		while(rs.next()) {
			HashMap<String,Object> m = new HashMap<>();
			m.put("month", rs.getString("month"));
			m.put("kind", rs.getString("kind"));
			m.put("cnt",rs.getInt("cnt"));
			m.put("total", rs.getInt("total"));
			
			list.add(m);
		}
		
		conn.close();
		
		return list;
	}
	
	// 해당년도에 대한 월별 총액
	public ArrayList<HashMap<String,Object>> selectMonthDataByYear(int year) throws Exception {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/cashbook", "root", "java1234");
		String sql ="SELECT month(cash_date) month, ct.kind kind, COUNT(*) cnt, SUM(c.amount) total "
				+ "FROM cash c INNER JOIN category ct ON c.category_no = ct.category_no "
				+ "WHERE YEAR(cash_date)=? "
				+ "GROUP BY month(cash_date), ct.kind "
				+ "ORDER BY month(cash_date)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, year);
		ResultSet rs = stmt.executeQuery();
		
		ArrayList<HashMap<String,Object>> list = new ArrayList<>();
		while(rs.next()) {
			HashMap<String,Object> m = new HashMap<>();
			m.put("month", rs.getString("month"));
			m.put("kind", rs.getString("kind"));
			m.put("cnt",rs.getInt("cnt"));
			m.put("total", rs.getInt("total"));
			
			list.add(m);
		}
		
		conn.close();
		
		return list;		
	}
}
