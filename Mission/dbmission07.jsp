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
<title>dbmission07</title>
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
<h2 class="text">언어를 입력 받아서 해당 언어가 국가 공식 언어인 국가를 출력하세요.</h2>
	<%
	// DB에 연결
	dbmissionConnect dbms = new dbmissionConnect();
	
	// 쿼리문 생성
	String result = request.getParameter("language");
	if(result == null) {
		response.sendRedirect("./dbmission07.jsp?language=");
       	return;
	}
	if (!result.isEmpty()) {
		String sql = "SELECT countrycode, language FROM countrylanguage WHERE isofficial='T' AND language like ?";
        dbms.ps = dbms.con.prepareStatement(sql);
        dbms.ps.setString(1, result);
    } else {
    	String sql = "SELECT countrycode, language FROM countrylanguage WHERE isofficial='T'";
        dbms.ps = dbms.con.prepareStatement(sql);
    }

	// 쿼리 수행
	dbms.rs = dbms.ps.executeQuery();

	// 결과 확인
	%>
	<h3 class="text">입력한 언어: <%= result != null ? result.toUpperCase() : "" %></h3>
	<table>
		<tr>
			<td class="title">countrycode</td>
			<td class="title">language</td>
		</tr>
		<%
		while (dbms.rs.next()) {
		%>
		<%
		String countrycode = dbms.rs.getString("countrycode");
		String language = dbms.rs.getString("language");
		%>
		<tr>		
			<td><% out.println(String.format("%s", countrycode)); %></td>
			<td><% out.println(String.format("%s", language)); %></td>
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