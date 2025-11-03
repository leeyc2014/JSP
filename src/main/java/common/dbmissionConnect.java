package common;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

public class dbmissionConnect {
	public Connection con;
	public Statement st;
	public PreparedStatement ps;
	public ResultSet rs;
	
	public dbmissionConnect() {
		try {
			// JDBC 드라이버 로드
			Class.forName("com.mysql.cj.jdbc.Driver");
			
			// DB에 연결
			String url = "jdbc:mysql://localhost:3306/world";
			String id = "musthave";
			String pwd = "tiger";
			con = DriverManager.getConnection(url, id, pwd);
			
			System.out.println("DB 연결 성공");
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public void close() { 
		try { 
			if (rs != null) rs.close(); 
			if (st != null) st.close();
			if (ps != null) ps.close();
			if (con != null) con.close(); 
			System.out.println("JDBC 자원 해제");
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}

}
