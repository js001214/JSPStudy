<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ page import = "java.sql.*" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MSSQL Connection</title>
</head>
<body>
<%

	// 변수 초기화
	Connection conn = null;
	String driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
	String url = "jdbc:sqlserver://localhost:1433;DatabaseName=myDB;encrypt=false";
	Boolean connect = false;
	try {
		Class.forName(driver);
		conn = DriverManager.getConnection(url,"sa","1234");
		
		connect=true;
		conn.close();
	}catch(Exception e){
		connect = false;
		e.printStackTrace();
	}
	
	
	if(connect==true) {
		out.println("MSSQL DB 연결이 잘 되었습니다.");
	}else {
		out.println("MSSQL DB 연결이 실패 했습니다.");
	}
	
	
	%>

</body>
</html>