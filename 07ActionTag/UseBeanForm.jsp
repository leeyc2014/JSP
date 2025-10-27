<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>액션 태그 - UseBean</title>
</head>
<body>
	<h2>액션 태그로 폼값 한 번에 받기</h2>
	<form method="post" action="UseBeanAction1.jsp">
		ID : <input type="text" name="id" /><br />
		Pass : <input type="password" name="pass" /><br />
		Name : <input type="text" name="name" /><br />
		Regidate : <input type="date" name="regidate" /><br />
		<input type="submit" value="폼값 전송" />
	</form>
</body>
</html>