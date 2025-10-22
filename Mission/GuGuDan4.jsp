<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.dan {
		display: flex;
		margin-bottom: 20px;
	}

	.content {
		margin-right: 30px;
	}

	.title {
		font-size: x-large;
		font-weight: bold;
		text-align: center;
		margin-bottom: 5px;
	}
</style>
</head>
<body>
	<%
	try {
		int val = Integer.parseInt(request.getParameter("val"));
		for (int i = 2; i < 10; i += val) {
	%>
	<div class="dan">
		<%
		for (int k = 0; k < val; k++) {
			if ((i + k) >= 10)
				break;
		%>
		<div class="content">
			<div class="title"><%= i + k %>단</div>
			<%
			for (int j = 1; j < 10; j++) {
			%>
				<%= i + k %> * <%= j %> = <%= (i + k) * j %><br />
		   <!-- out.print((i + k) + " * " + j + " = " + (i + k) * j + "<br />"); -->
			<%
			}
			%>
		</div>
		<%
		}
		%>
	</div>
	<%
		}
	} 
	catch (Exception e) {
		out.print("숫자를 입력하세요");
	}
	%>
</body>
</html>
