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
<title>dbmission09</title>
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
<h2 class="text">CountryLanguage에서 사용자가 입력 비율 이상인 언어의 국가 코드와 비율을 검색해서 출력하세요.</h2>
	<%
	// DB에 연결
	dbmissionConnect dbms = new dbmissionConnect();
	
	// 쿼리문 생성
	double cnt = 0.0;
	String per = request.getParameter("percentage");
	if(per == null) {
		response.sendRedirect("./dbmission09.jsp?percentage=");
       	return;
	}
	if (!per.isEmpty()) {
		double result = Double.parseDouble(per);
		cnt = result;
		String sql = "SELECT countrycode, language, percentage FROM countrylanguage WHERE percentage > ?";
        dbms.ps = dbms.con.prepareStatement(sql);
        dbms.ps.setDouble(1, result);
    } else {
    	String sql = "SELECT countrycode, language, percentage FROM countrylanguage";
        dbms.ps = dbms.con.prepareStatement(sql);
    }

	// 쿼리 수행
	dbms.rs = dbms.ps.executeQuery();

	// 결과 확인
	%>
	<h3 class="text">입력한 비율: <%= String.format("%.1f", cnt) %></h3>
	<table>
		<tr>
			<td class="title">countrycode</td>
			<td class="title">language</td>
			<td class="title">percentage</td>
		</tr>
		<%
		while (dbms.rs.next()) {
		%>
		<%
		String countrycode = dbms.rs.getString("countrycode");
		String language = dbms.rs.getString("language");
		double percentage = dbms.rs.getDouble("percentage");
		%>
		<tr>		
			<td><% out.println(String.format("%s", countrycode)); %></td>
			<td><% out.println(String.format("%s", language)); %></td>
			<td><% out.println(String.format("%.1f", percentage)); %></td>
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