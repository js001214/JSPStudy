<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1> Main 페이지 입니다. </h1>
<p> JSP는 HTML 페이지 내에서 <%= "블락의 내용이 JSP 블락이 JSP 입니다" %> </p>

<%
	int a = 2;
	int b = 3; 
	int sum = a + b;
	
	out .println("2+3 = " + sum);
	
%>

</body>
</html>