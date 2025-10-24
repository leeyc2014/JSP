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
<title>dbmission03</title>
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
<h2 class="text">국가 명의 일부를 입력 받아서 국가명, 도시명, 도시인구수를 검색해서 출력하세요.</h2>
	<%
	// DB에 연결
	dbmissionConnect dbms = new dbmissionConnect();
	
	// 쿼리문 생성
	String result = request.getParameter("country");
	if(result == null) {
		response.sendRedirect("./dbmission03.jsp?country=");
       	return;
	}
	if (!result.isEmpty()) {
		String sql = "SELECT country.name, city.name, city.population FROM country, city WHERE country.code=city.countrycode and country.name LIKE ?";
        dbms.ps = dbms.con.prepareStatement(sql);
        dbms.ps.setString(1, "%" + result + "%");
    } else {
    	String sql = "SELECT country.name, city.name, city.population FROM country, city WHERE country.code=city.countrycode";
        dbms.ps = dbms.con.prepareStatement(sql);
    }

	// 쿼리 수행
	dbms.rs = dbms.ps.executeQuery();

	// 결과 확인
	%>
	<h3 class="text">입력한 국가명(일부 가능): <%= result != null ? result.toUpperCase() : "" %></h3>
	<table>
		<tr>
			<td class="title">countryname</td>
			<td class="title">cityname</td>
			<td class="title">population</td>
		</tr>
		<%
		while (dbms.rs.next()) {
		%>
		<%
		String countryname = dbms.rs.getString("country.name");
		String cityname = dbms.rs.getString("city.name");
		Integer population = dbms.rs.getInt("city.population");
		%>
		<tr>		
			<td><% out.println(String.format("%s", countryname)); %></td>
			<td><% out.println(String.format("%s", cityname)); %></td>
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