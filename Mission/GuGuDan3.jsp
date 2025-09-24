<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
try {	
	int val = Integer.parseInt(request.getParameter("val"));
%>
	<h2><%= val %> 단</h2>
<% 
	if(val > 10 || val < 2) {	
		val = 2;
	} 	
	for(int j = 1; j < 10; j++) {
		out.print(val + " * " + j + " = " + val * j + "<br />");
 	}
} 
catch (Exception e) {
	out.print("숫자를 입력하세요");
}
%>
</body>
</html>