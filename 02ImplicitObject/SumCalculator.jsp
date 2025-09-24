<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
	int s1 = 0;
    int s2 = 0;
    String num1 = request.getParameter("num1");
    String num2 = request.getParameter("num2");
    if(num1 != null && num2 != null) {
    	s1 = Integer.parseInt(num1);
    	s2 = Integer.parseInt(num2);
    }
  	int result = s1 + s2;
	%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sum</title>
</head>
<body>
	<h2>더하기 연산</h2>
	<form>
	숫자 1 : <input type="text" name="num1" value="<%= s1 %>"/><br />
	숫자 2 : <input type="text" name="num2" value="<%= s2 %>"/><br />
	결과 : <input type="text" name="result" value="<%= result %>" readonly /><br />
	<input type="submit" value="계산" />
	</form>
</body>
</html>