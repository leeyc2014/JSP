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
<title>dbmission06</title>
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
<h2 class="text">대한민국의 District를 입력 받아서 해당 지역에 있는 모든 도시를 검색해서 출력하세요.</h2>
	<%
	// DB에 연결
	dbmissionConnect dbms = new dbmissionConnect();
	
	// 쿼리문 생성
	String result = request.getParameter("district");
	if(result == null) {
		response.sendRedirect("./dbmission06.jsp?district=");
       	return;
	}
	if (!result.isEmpty()) {
		String sql = "SELECT district, name FROM city WHERE countrycode='KOR' AND district like ?";
        dbms.ps = dbms.con.prepareStatement(sql);
        dbms.ps.setString(1, result);
    } else {
    	String sql = "SELECT district, name FROM city WHERE countrycode='KOR'";
        dbms.ps = dbms.con.prepareStatement(sql);
    }

	// 쿼리 수행
	dbms.rs = dbms.ps.executeQuery();

	// 결과 확인
	%>
	<h3 class="text">입력한 한국의 District: <%= result != null ? result.toUpperCase() : "" %></h3>
	<table>
		<tr>
			<td class="title">district</td>
			<td class="title">name</td>
		</tr>
		<%
		while (dbms.rs.next()) {
		%>
		<%
		String district = dbms.rs.getString("district");
		String name = dbms.rs.getString("name");
		%>
		<tr>		
			<td><% out.println(String.format("%s", district)); %></td>
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