<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="common.JDBConnect"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JDBC</title>
<style>
table {
	border: 1px solid;
	border-collapse: collapse;
}

td, tr {
	border: 1px solid;
	padding: 4px 10px;
}

.title {
	text-align: center;
	background-color: lightgray;
	font-weight: bold;
}
</style>
</head>
<body>
	<h2>회원 목록 조회 테스트(executeQuery() 사용) - 테이블</h2>
	<%
	// DB에 연결
	JDBConnect jdbc = new JDBConnect();

	// 쿼리문 생성
	String sql = "SELECT id, pass, name, regidate FROM member";
	jdbc.stmt = jdbc.con.createStatement();

	// 쿼리 수행
	jdbc.rs = jdbc.stmt.executeQuery(sql);

	// 결과 확인
	%>
	<table>
		<tr>
			<td class="title">id</td>
			<td class="title">pass</td>
			<td class="title">name</td>
			<td class="title">regidate</td>
		</tr>
		<%
		while (jdbc.rs.next()) {
		%>
		<%
		String id = jdbc.rs.getString(1);
		String pw = jdbc.rs.getString(2);
		String name = jdbc.rs.getString("name");
		java.sql.Date regidate = jdbc.rs.getDate("regidate");
		%>
		<tr>
			<td><% out.println(String.format("%s", id)); %></td>
			<td><% out.println(String.format("%s", pw)); %></td>
			<td><% out.println(String.format("%s", name)); %></td>
			<td><% out.println(String.format("%s", regidate)); %></td>
		</tr>
		<%
		}
		%>	
	</table>
	<%
	// 연결 닫기
	jdbc.close();
	%>

</body>
</html>