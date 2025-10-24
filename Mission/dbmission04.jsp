<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="common.dbmissionConnect" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>dbmission04</title>
<style>
table {
	border: 1px solid;
	border-collapse: collapse;
	display: flex;
    justify-content: center;
    border: none;
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
.text {
	text-align: center;
}
</style>
</head>
<body>
<h2 class="text">대륙을 입력 받아서 해당 대륙에 위치한 국가를 검색해서 출력하세요.</h2>
	<%
	// DB에 연결
	dbmissionConnect dbms = new dbmissionConnect();
	
	// 쿼리문 생성
	String result = request.getParameter("continent");
	if(result == null) {
		response.sendRedirect("./dbmission04.jsp?continent=");
       	return;
	}
	if (!result.isEmpty()) {
		String sql = "SELECT continent, name FROM country WHERE continent LIKE ?";
        dbms.ps = dbms.con.prepareStatement(sql);
        dbms.ps.setString(1, result);
    } else {
    	String sql = "SELECT continent, name FROM country";
        dbms.ps = dbms.con.prepareStatement(sql);
    }

	// 쿼리 수행
	dbms.rs = dbms.ps.executeQuery();

	// 결과 확인
	%>
	<h3 class="text">입력한 대륙: <%= result != null ? result.toUpperCase() : "" %></h3>
	<table>
		<tr>
			<td class="title">continent</td>
			<td class="title">name</td>
		</tr>
		<%
		while (dbms.rs.next()) {
		%>
		<%
		String continent = dbms.rs.getString("continent");
		String name = dbms.rs.getString("name");
		%>
		<tr>		
			<td><% out.println(String.format("%s", continent)); %></td>
			<td><% out.println(String.format("%s", name)); %></td>
		</tr>
		<%
		}
		%>	
	</table>
	<%
	// 연결 닫기
	dbms.close();
	%>
</body>
</html>