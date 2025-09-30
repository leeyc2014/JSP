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
	<style>
 		table {
 			border-collapse: collapse;
 		}
 		td, tr {
 			padding: 4px 10px;
 		}
 		.title {
 			text-align: center;
 			font-weight: bold;
 			font-size: x-large;
 		}
 	</style>
</head>
<body>
	<table>
        <tr>
            <% 
            for(int i = 2; i <= val + 1; i++) { 
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
                for(int i = 2; i <= val + 1; i++) { 
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