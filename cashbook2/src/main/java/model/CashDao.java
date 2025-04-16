package model;
import java.sql.*;
import java.util.*;

import dto.Cash;
public class CashDao {
	
	// 해당하는 년, 월에 대한 정보
	public ArrayList<HashMap<String,Object>> selectCash(int year, int month) throws Exception {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/cashbook", "root", "java1234");
		String sql = "SELECT c.cash_no cashNO, c.category_no categoryNo, c.cash_date cashDate, "
					+"c.amount, c.memo, c.color, c.createdate, c.updatedate, ct.kind, ct.title "
					+"FROM cash c INNER JOIN category ct ON c.category_no = ct.category_no "
					+"where YEAR(c.cash_date)=? and MONTH(c.cash_date)=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1,year);
		stmt.setInt(2,month);
		ResultSet rs = stmt.executeQuery();
		
		ArrayList<HashMap<String,Object>> list = new ArrayList<>();
		while(rs.next()) {
			HashMap<String,Object> m = new HashMap<>();
			m.put("cashNo", rs.getInt("cashNo"));
			m.put("categoryNo", rs.getInt("categoryNo"));
			m.put("cashDate", rs.getString("cashDate"));
			m.put("amount", rs.getInt("amount"));
			m.put("memo", rs.getString("memo"));
			m.put("color", rs.getString("color"));
			m.put("createdate", rs.getString("createdate"));
			m.put("updatedate", rs.getString("updatedate"));
			m.put("kind", rs.getString("kind"));
			m.put("title", rs.getString("title"));
			
			list.add(m);
		}
		
		conn.close();
		
		return list;
	}
	
	// 특정 날짜에 해당하는 cash 상세정보
	public ArrayList<HashMap<String,Object>> selectCashByDate(String cashDate) throws Exception {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/cashbook", "root", "java1234");
		String sql = "SELECT ct.kind, ct.title, c.amount, c.memo, c.color, c.cash_no cashNo "
					+ "FROM cash c INNER JOIN category ct ON c.category_no = ct.category_no "
					+ "WHERE c.cash_date LIKE ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1,cashDate);
		ResultSet rs = stmt.executeQuery();
		
		ArrayList<HashMap<String,Object>> list = new ArrayList<>();
		while(rs.next()) {
			HashMap<String,Object> map = new HashMap<>();
			map.put("kind", rs.getString("kind"));
			map.put("title", rs.getString("title"));
			map.put("amount", rs.getInt("amount"));
			map.put("memo", rs.getString("memo"));
			map.put("color", rs.getString("color"));
			map.put("cashNo", rs.getInt("cashNo"));
			
			list.add(map);
		}
		
		conn.close();
		
		return list;
	}
		
	// cashNo에 해당하는 정보들 가져오는 메소드
	public ArrayList<HashMap<String,Object>> selectCashByNo(int cashNo) throws Exception {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/cashbook", "root", "java1234");
		String sql = "SELECT c.cash_date cashDate, c.amount, c.memo, c.color, ct.kind, ct.title "
					+ "FROM cash c INNER JOIN category ct ON c.category_no = ct.category_no "
					+ "WHERE c.cash_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, cashNo);
		ResultSet rs = stmt.executeQuery();
		
		ArrayList<HashMap<String,Object>> list = new ArrayList<>();
		if(rs.next()) {
			HashMap<String,Object> m = new HashMap<>();
			m.put("cashDate",rs.getString("cashDate"));
			m.put("amount",rs.getInt("amount"));
			m.put("memo", rs.getString("memo"));
			m.put("color", rs.getString("color"));
			m.put("kind", rs.getString("kind"));
			m.put("title", rs.getString("title"));
			
			list.add(m);
		}
		
		conn.close();
		
		return list;
	}
	
	// cashDate 하나만 가져오는 메소드
	public Cash selectCashDate(int cashNo) throws Exception {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/cashbook", "root", "java1234");
		String sql = "select cash_date cashDate from cash where cash_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, cashNo);
		ResultSet rs = stmt.executeQuery();
		
		Cash c = new Cash();
		if(rs.next()) {
			c.setCashDate(rs.getString("cashDate"));
		}
		
		conn.close();
		
		return c;
	}
	
	// 날짜별 수입과 지출 총합을 보여주는 메소드
	public ArrayList<HashMap<String,Object>> totalAmountByDate(int year, int month) throws Exception {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/cashbook", "root", "java1234");
		String sql ="SELECT SUM(c.amount) SUM , ct.kind, c.cash_date cashDate "
				  + "FROM cash c "
				  + "inner join category ct ON c.category_no = ct.category_no "
				  + "where YEAR(c.cash_date)=? and MONTH(c.cash_date)=? "
			      + "GROUP BY ct.kind, c.cash_date";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, year);
		stmt.setInt(2, month);
		
		ResultSet rs = stmt.executeQuery();
		
		ArrayList<HashMap<String,Object>> list = new ArrayList<>();
		while(rs.next()) {
			HashMap<String,Object> m = new HashMap<>();
			m.put("sum", rs.getInt("sum"));
			m.put("kind", rs.getString("kind"));
			m.put("cashDate", rs.getString("cashDate"));
			
			list.add(m);
		}
		
		conn.close();
		
		return list;
		
	}
	// cash 추가
	public void insertCash(Cash c) throws Exception {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/cashbook", "root", "java1234");
		String sql = "insert into cash(category_no, cash_date, amount, memo, color) values(?,?,?,?,?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, c.getCategoryNo());
		stmt.setString(2, c.getCashDate());
		stmt.setInt(3, c.getAmount());
		stmt.setString(4, c.getMemo());
		stmt.setString(5, c.getColor());
		
		stmt.executeUpdate();
		
		conn.close();
	}
	
	// cash 정보 수정
	public void updateCash(Cash c) throws Exception {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/cashbook", "root", "java1234");
		String sql = "update cash set cash_date=?, amount=?, memo=? where cash_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, c.getCashDate());
		stmt.setInt(2, c.getAmount());
		stmt.setString(3, c.getMemo());
		stmt.setInt(4, c.getCashNo());
		
		stmt.executeUpdate();
		
		conn.close();
	}
	
	// cash 삭제
	public void deleteCash(int cashNo) throws Exception {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/cashbook", "root", "java1234");
		String sql = "delete from cash where cash_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, cashNo);
		
		stmt.executeUpdate();
		
		conn.close();
	}
}
