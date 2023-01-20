<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
    <!--  필요한 라이브러리 Import -->
<%@ page import = "java.sql.*, java.util.*, java.text.*" %>    
	<!-- DB include -->
<%@ include file = "conn_oracle.jsp" %>    
    <!-- form에서 넘어오는 값의 한글 처리 -->
<% request.setCharacterEncoding("UTF-8"); %>

<!-- form에서 넘어오는 데이터는 모두 String으로 넘어온다. 
	Integer.perseInt()
-->

<!--  form에서 넘어오는 변수의 값을 받아서 새로운 변수에 할당 -->
<%
	String na = request.getParameter("name");
	String em = request.getParameter("email");
	String sub = request.getParameter("subject");
	String cont = request.getParameter("content");
	String pw = request.getParameter("password");
	
	int id = 1;	//id에 처음 값을 할당 할때 기본값으로 1을 할당.
				//다음부터는 테이블의 id 컬럼에서 Max값을 가져와서 +1해서 처리

	//날짜 처리
	java.util.Date yymmdd= new java.util.Date();
	out.println(yymmdd);	//Thu Jan 12 11:17:13 KST 2023 23-12-12 11:17 오전
	SimpleDateFormat myformat = new SimpleDateFormat ("yy-dd-d h:m a");
	String ymd = myformat.format(yymmdd);
	out.println(ymd);		//23-12-12 11:13 오전
	
	//DB에 값을 처리할 변수 선언 : Connection <== Include 되어 있음.
	String sql = null;
	Statement stmt = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;	//id 컬럼의 최대값을 select
	
	
	try{
	//DB에서 값을 처리
	
	stmt = conn.createStatement();
	sql = "select max(id) as id from freeboard";	//id : Primary Key
	
	rs = stmt.executeQuery(sql);	//select외에는 executeUpdate를 쓴다.
	
	//rs.next();
	
			
	//out.println(rs.getInt(1) + "<p/>");
	
	//if (true) return;
	
	//테이블의 id 컬럼의 값을 적용 : 최대 값을 가져와서 + 1
	if (!(rs.next())){	//테이블의 값이 존재하지 않는 경우
		id = 1;
	}else {				//테이블의 값이 존재하는 경우 값이
		id = rs.getInt(1) + 1;	//getString은 변수의 이름, getInt는  테이블의 1번방 2번방 3번방 등등으로 가져온다.
	}
	
	
	//Statement 객체는 변수값을 처리하는 것이 복잡하다. PreparedStatement를 사용한다.
	//form에서 넘겨받은 값을 DB에 insert 하는 쿼리(주의 : masterid : id컬럼에 들어오는 값으로 처리해야함)
	sql =	"insert into freeboard (id, name, password, email, ";
	sql +=	"subject, content, inputdate, masterid, readcount, replaynum, step ) ";
	sql +=	"values (?,?,?,?,?,?,?,?, ";
	sql += "0, 0, 0)";
	
	
	//PreparedStatement 객체 생성
		//객체 생성시 sql 구문을 넣는다.
	pstmt = conn.prepareStatement(sql);
	
	//? 변수값을 할당
	pstmt.setInt(1, id);		//int
	pstmt.setString(2, na);
	pstmt.setString(3, pw);
	pstmt.setString(4, em);
	pstmt.setString(5, sub);
	pstmt.setString(6, cont);
	pstmt.setString(7, ymd);
	pstmt.setInt(8, id);		//int
	
	
	pstmt.executeUpdate(); // pstmt를 실행하는 구문
	//out.println(sql);
	//if (true) return;	//프로그램을 중지 시킴. 디버깅할때 사용함.
	
	stmt.executeUpdate(sql);	//저장완료, commit자동으로 처리
	}catch(Exception e) {
		out.println("예상치 못한 오류가 발생했습니다. <p/>");
		out.println("고객 센터 : 02-1111-1111 <p/>");
		//e.printStrackTrace();
	}finally {
		if ( conn != null) conn.close();
		if ( stmt != null) stmt.close();
		if ( rs != null) rs.close();
	}
	//Try catch 블락으로 프로그램이 종료 되지 않도록 처리후 객체 제거
	
%>

<!-- 

	페이지 이동 :
		response.sendRedirect : 클라이언트에서 페이지를 재요청 : URL 주소가 바뀜
		forward : 서버에서 페이지를 이동 : URL 주소가 바뀌지 않는다.
		

 -->
 
<%// response.sendRedirect("freeboard_list.jsp"); %>

  
<jsp:forward page ="freeboard_list03.jsp"/>




<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>