<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.dan {
		display:inline-flex;
		flex-direction:row;
	}
	.content {
		margin-right:30px;
	}
</style>
</head>
<body>
	<div class="dan">
	<%	
	for(int i = 2; i < 10; i++) {
	%>
		<div class="content">	
			<h2><%= i %> 단</h2>
			<%
			for(int j = 1; j < 10; j++) {
				out.print(i + " * " + j + " = " + i * j + "<br/>");
			}
			%>
		</div>
	<% 
	}
	%>
	</div>
</body>
</html>