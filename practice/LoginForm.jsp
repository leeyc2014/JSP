<%@page import="utils.JSFunction"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<span style="color: red; font-size: 1.2em;">
		<%= request.getAttribute("LoginErrMsg") == null ? "" : request.getAttribute("LoginErrMsg") %>
	</span>
	<%
	if(session.getAttribute("UserId") == null) {	// 로그인 상태 확인
		// 로그아웃 상태
	%>
	<script>
	function validateForm(form) {
		if(!form.user_id.value) {
			alert("아이디를 입력하세요.");
			return false;
		}
		if(form.user_pw.value == "") {
			alert("패스워드를 입력하세요.");
			return false;	
		}
	}
	</script>
	<form style="text-align: right; margin-right:50px;" action="LoginProcess.jsp" method="post" name="loginFrm" onsubmit="return validateForm(this);">
		&nbsp;&nbsp;&nbsp;아이디 : <input type="text" name="user_id" /><br />
		패스워드 : <input type="password" name="user_pw" /><br /><br />
		<input type="submit" value="로그인하기" />
	</form>
	<br />
	<%
	} 
	else {	// 로그인된 상태	
		String userName = (String)session.getAttribute("UserName");
		%>
			<p style="text-align:right; margin-right:50px; font-weight:bold;">
				<span style="color:blue; font-size:20px;"><%= userName %></span> 
				회원님 <br /> 로그인하셨습니다.<br /><br />
				<a href="Logout.jsp">[로그아웃]</a>
			</p>
		<%
		if(session.getAttribute("loginSuccess") != null) {
			JSFunction.alertLocation(session.getAttribute("UserName") + " 회원님, 로그인하셨습니다.", "List.jsp", out);
			session.removeAttribute("loginSuccess");			
		}
	}
	%>
</body>
</html>