package model;
import java.sql.*;

import dto.*;
public class LoginDao {
	
	// 로그인
	public Admin cashbookLogin(String id, String pw) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/cashbook", "root", "java1234");
		String sql = "select admin_id adminId, admin_pw adminPw from admin where admin_id=? and admin_pw=?";
		PreparedStatement stmt= conn.prepareStatement(sql);
		stmt.setString(1, id);
		stmt.setString(2, pw);
		ResultSet rs = stmt.executeQuery();
		
		Admin a = new Admin();
		if(rs.next()) {
			System.out.println("로그인 성공");
			a.setAdminId(rs.getString("adminId"));
			a.setAdminPw(rs.getString("adminPw"));
		}
		else {
			System.out.println("로그인 실패");
		}
		
		conn.close();
		return a;
	}
	
	// 비밀번호 변경 
	public int updatePassword(String id, String pw, String newpw) throws Exception {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/cashbook", "root", "java1234");
		String sql = "update admin set admin_pw=? where admin_id=? and admin_pw=?";
		PreparedStatement stmt= conn.prepareStatement(sql);
		stmt.setString(1, newpw);
		stmt.setString(2, id);
		stmt.setString(3, pw);
		
		int row = stmt.executeUpdate();
		
		if(row==1) {
			System.out.println("변경 성공");
		}
		else {
			System.out.println("변경 실패");
		}
		
		conn.close();
		
		return row;
	}
}
