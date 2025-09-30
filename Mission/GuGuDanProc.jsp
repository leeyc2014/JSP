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
		String gugudan = request.getParameter("gugudan");
		String dan = request.getParameter("dan");
		if(gugudan != null) {
			if(Integer.parseInt(dan) >= 2 && Integer.parseInt(dan) <= 9) {
				switch(gugudan){
				case "gugudan1":
					response.sendRedirect("GuGuDan1.jsp");
					break;
				case "gugudan2":
					response.sendRedirect("GuGuDan2.jsp");
					break;
				case "gugudan3":
					response.sendRedirect("GuGuDan3.jsp?val=" + dan);
					break;
				case "gugudan4":
					response.sendRedirect("GuGuDan4.jsp?val=" + dan);
					break;
				}
			}		
			else {
				response.sendRedirect("GuGuDanForm.jsp");
			}
		}
		else {
			response.sendRedirect("GuGuDanForm.jsp");
		}
		
	%>
</body>
</html>