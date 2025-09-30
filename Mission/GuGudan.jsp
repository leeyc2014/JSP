<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
int val = Integer.parseInt(request.getParameter("val"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%	
	for(int i = 2 ; i < 10 ; i+=val) {
		for(int j = 0 ; j < 10 ; j++) {
			for (int k = 0 ; k < val ; k++) {

				if (10 <= i+k) {
					%><br /><%
					break;
				}
				if (j == 0) {
					out.print((i+k) + "단&nbsp");
				}
				else {
					out.print(String.format("%d * %d = %d", (i+k), j, (i+k)*j));
				}
				if (k < val-1)	out.print("&nbsp");
				else {
					%><br /><%
				}
			}
		}
		out.println();
	}
%>
</body>
</html>