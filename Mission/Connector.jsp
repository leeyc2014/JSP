<%@page import="common.dbmissionConnect"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="common.MyUtil"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.Context"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 국가코드의 일부를 입력 받아서 해당 국가의 국가코드, 도시명, 도시인구수를 검색해서 출력하세요. (City) -->
<!-- http://localhost:8080/JSPMission/dbmission02.jsp?name=kor -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>dbmission02</title>
<link rel="stylesheet" href="../css/style.css">
</head>
<body>
<div id="body-align">
<%
	//요청 URL에서 파라미터 "name"의 값을 읽어온다.
	String name = request.getParameter("name");
	if (name == null) {
		// 파라미터값이 null이면 기본값을 설정해서 redirect한다.
		response.sendRedirect("./Connector.jsp?name=kor");
		return;
	}
	
	// 메시지들을 출력한다.(Optional)
	out.println("<ul>");
	out.println("<li>국가명의 일부를 입력 받아서 해당 국가명, 도시명, 인구수를 출력</li>");
	out.println("<li>입력 국가명 : " + name + "</li>");
	out.println("</ul>");
	
	// 데이터베이스 연결 객체 생성
	dbmissionConnect dbmc = new dbmissionConnect();
	try {
		// 질의 객체 생성
		dbmc.ps = dbmc.con.prepareStatement("select countrycode,name,Population "
				+ " from city where countrycode like ?");
		// 질의 객체 파라미터 설정
		dbmc.ps.setString(1, "%" + name + "%");
		
		// 요청 URL을 실행하기 위한 SQL문을 출력한다.(Optional)
		MyUtil.writeSQL(out, dbmc.ps);
		
		// 질의 실행
		dbmc.rs = dbmc.ps.executeQuery();

		// 질의 결과 출력
		MyUtil.writeTableFromResultSet(out, dbmc.rs);
	}
	catch(Exception e) {
		// 예외 발생 시 메시지 출력
		out.println("Error:" + e.getMessage());
	}
	finally {
		// 리소스 해제 및 연결 종료
		dbmc.close();
	}
%>
</div>
</body>
</html>