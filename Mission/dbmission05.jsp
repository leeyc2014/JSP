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
<title>dbmission05</title>
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
<h2 class="text">넓이(10,0002 km)를 입력 받아서 입력 값보다 작은 면적을 가진 국가의 이름과 면적을 면적 오름차순으로 검색해서 출력하세요.</h2>
	<%
	// DB에 연결
	dbmissionConnect dbms = new dbmissionConnect();
	double cnt = 0.0;
	
	// 쿼리문 생성
	String area = request.getParameter("surfacearea");
	if(area == null) {
		response.sendRedirect("./dbmission05.jsp?surfacearea=");
       	return;
	}
	if (!area.isEmpty()) {
		double result = Double.parseDouble(area);
		cnt = result;
		String sql = "SELECT name, surfacearea FROM country WHERE surfacearea < ?";
        dbms.ps = dbms.con.prepareStatement(sql);
        dbms.ps.setDouble(1, result);
    } else {
    	String sql = "SELECT name, surfacearea FROM country";
        dbms.ps = dbms.con.prepareStatement(sql);
    }

	// 쿼리 수행
	dbms.rs = dbms.ps.executeQuery();

	// 결과 확인
	%>
	<h3 class="text">입력한 넓이: <%= String.format("%.2f", cnt) %></h3>
	<table>
		<tr>
			<td class="title">name</td>
			<td class="title">surfacearea</td>
		</tr>
		<%
		while (dbms.rs.next()) {
		%>
		<%
		String name = dbms.rs.getString("name");
		double surfacearea = dbms.rs.getDouble("surfacearea");
		%>
		<tr>		
			<td><% out.println(String.format("%s", name)); %></td>
			<td><% out.println(String.format("%.2f", surfacearea)); %></td>
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