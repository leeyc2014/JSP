<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<%
for(int i = 2; i < 10; i++) {
%>
	<h2><%= i %> 단</h2>	
<%	
for(int j = 1; j < 10; j++) {
%>
<%-- 	<p><%=i %> * <%=j %> = <%= i * j %></p>		 --%>
	<%=i %> * <%=j %> = <%= i * j %> <br />
	<% } %>	
<% } %>
</body>
</html>