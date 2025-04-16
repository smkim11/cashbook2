package model;
import dto.*;
import java.sql.*;

public class ReceitDao {
	
	// 번호에 해당하는 영수증
	public Receit selectReceit(int cashNo) throws Exception {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/cashbook", "root", "java1234");
		String sql="select filename from receit where cash_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, cashNo);
		ResultSet rs = stmt.executeQuery();
		
		Receit r = new Receit();
		if(rs.next()) {
			r.setFileName(rs.getString("filename"));
		}
		
		conn.close();
		
		return r;
	}
	
	// 영수증 첨부 여부 확인
	public int countReceit(int cashNo) throws Exception {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/cashbook", "root", "java1234");
		String sql = "SELECT COUNT(*) cnt FROM receit where cash_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, cashNo);
		ResultSet rs = stmt.executeQuery();
		rs.next();
		
		int count = rs.getInt("cnt");
		
		conn.close();
		
		return count;
	}
	
	// 영수증 추가
	public void insertReceit(Receit r) throws Exception {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/cashbook", "root", "java1234");
		String sql = "insert into receit(cash_no, filename) values(?,?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, r.getCashNo());
		stmt.setString(2, r.getFileName());
		
		stmt.executeUpdate();
		
		conn.close();
	}
	
	// 영수증 삭제
	public void deleteReceit(int cashNo) throws Exception {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/cashbook", "root", "java1234");
		String sql = "delete from receit where cash_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, cashNo);
		
		stmt.executeUpdate();
		
		conn.close();
	}
}
