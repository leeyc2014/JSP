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
<title>dbmission01</title>
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
<h2 class="text">인구 수를 입력 받아서 그보다 많은 인구를 가진 도시를 검색해서 출력하세요.</h2>
	<%
	int cnt = 0;
	// DB에 연결
	dbmissionConnect dbms = new dbmissionConnect();

	// 쿼리문 생성
	String pop = request.getParameter("population");
	if(pop == null) {
		response.sendRedirect("./dbmission01.jsp?population=");
       	return;
	}
	if (!pop.isEmpty()) {
        int result = Integer.parseInt(pop);
        cnt = result;
        String sql = "SELECT name, countrycode, district, population FROM city WHERE population > ?";
        dbms.ps = dbms.con.prepareStatement(sql);
        dbms.ps.setInt(1, result);      
    } else {
        String sql = "SELECT name, countrycode, district, population FROM city";
        dbms.ps = dbms.con.prepareStatement(sql);
    }
	

	// 쿼리 수행
	dbms.rs = dbms.ps.executeQuery();

	// 결과 확인
	%>
	<h3 class="text">인구 수 <%= String.format("%,d", cnt) %>명 이상</h3>
	<table>
		<tr>
			<td class="title">name</td>
			<td class="title">countrycode</td>
			<td class="title">district</td>
			<td class="title">population</td>
		</tr>
		<%
		while (dbms.rs.next()) {
		%>
		<%
		String name = dbms.rs.getString("name");
		String countrycode = dbms.rs.getString("countrycode");
		String district = dbms.rs.getString("district");
		Integer population = dbms.rs.getInt("population");
		%>
		<tr>
			<td><% out.println(String.format("%s", name)); %></td>
			<td><% out.println(String.format("%s", countrycode)); %></td>
			<td><% out.println(String.format("%s", district)); %></td>
			<td><% out.println(String.format("%,d", population)); %></td>
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