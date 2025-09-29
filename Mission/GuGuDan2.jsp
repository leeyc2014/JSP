<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<style>
 		table {
 			border:1px solid;
 			border-collapse: collapse;
 		}
 		td, tr {
 			border:1px solid;
 			padding: 4px 10px;
 		}
 		.title {
 			text-align: center;
 			background-color: lightgray;
 		}
 	</style>
</head>
<body>
	<table>
        <tr>
            <% 
            for(int i = 2; i <= 9; i++) { 
            %>
                <td class="title"><%= i %>단</td>
            <% 
            } 
            %>
        </tr>
        	<% 
            for(int j = 1; j <= 9; j++) { 
        	%>
            <tr>
                <% 
                for(int i = 2; i <= 9; i++) { 
                %>
                	<td><%= i %> * <%= j %> = <%= i * j %></td>
                <% 
                } 
                %>
            </tr>
        <% 
        } 
        %>
    </table>
</body>
</html>