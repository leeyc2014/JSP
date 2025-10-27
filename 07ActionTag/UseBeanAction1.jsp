<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>액션 태그 - UseBean</title>
</head>
<body>
	<h3>액션 태그로 폼값 한 번에 받기</h3>
	<jsp:useBean id="member" class="membership.MemberDTO" />
	<jsp:setProperty property="*" name="member" />
	<ul>
		<li>ID : <jsp:getProperty name="member" property="id" /></li>
		<li>Pass : <jsp:getProperty name="member" property="pass" /></li>
		<li>Name : <jsp:getProperty name="member" property="name" /></li>
		<li>Regidate : <jsp:getProperty name="member" property="regidate" /></li>
	</ul>
</body>
</html>