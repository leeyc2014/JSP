<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>구구단</h2>
	<form action="./GuGuDanProc.jsp" method="get">
	<input type="radio" name="gugudan" value="gugudan1" checked="checked" /> Type1 : 세로 <br />
	<input type="radio" name="gugudan" value="gugudan2" /> Type2 : 가로 <br />
	<input type="radio" name="gugudan" value="gugudan3" /> Type3 : 하나만 출력 <br />
	<input type="radio" name="gugudan" value="gugudan4" /> Type4 : 여러개씩 묶어서 출력 <br />
	<input type="number" name ="dan" value="2"/> 단수/열수 <br />
	<input type="submit" value="선택" />
	</form>
</body>
</html>