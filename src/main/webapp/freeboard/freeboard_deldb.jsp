<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import = "java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ include file = "conn_oracle.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 삭제를 처리하는 페이지</title>
</head>
<body>

[<a href="freeboard_list03.jsp?go=<%=request.getParameter("page") %>"> 
	게시판으로 이동 </a>]

<%

//DB 접속 하는 객체 선언
String sql = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

int id = Integer.parseInt(request.getParameter("id"));
int page1 = Integer.parseInt(request.getParameter("page"));
String pw = request.getParameter("password");	//폼에서 넘겨진 password

/*
out.println(id + "<p/>");
out.println(page1 + "<p/>");
out.println(pw + "<p/>");

if (true) return;	//프로그램 종료
*/

	try {	//DB에 쿼리를 보내는 블락 : DB에 오류가 발생시 프포그램이 종료되지 않도록 처리
		sql ="select * from freeboard where id = ?";		
		pstmt= conn.prepareStatement(sql);
		pstmt.setInt(1, id);
		rs = pstmt.executeQuery();
		
		if(!(rs.next())) { //rs의 값이 비어 있을때
			out.println("해당 값이 존재 하지 않습니다");
		}else { //rs의 값이 존재할때
			//rs의 password 컬럼의 값을 가져와서 폼에서 넘겨받은 password
					//pwd : DB에서 가져온 password
					//pw : 사용자가 폼에서 넘긴 password
				String pwd = rs.getString("password");
		
		
			if (pwd.equals(pw)) {	//DB의 password 와 폼의 password가 같을때
				//delete 쿼리를 적용
				sql = "delete freeboard where id =?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, id);
				pstmt.executeUpdate();
				
				//
				out.println("잘 삭제 되었습니다");
			}else {	//다를때 
				out.println("패스워드");
			}
		}
		
	}catch(Exception e) {
		out.println("DB 오류로 인해서 삭제를 실패 했습니다.");
		e.printStackTrace();		//디버깅
	}finally {
		if ( conn != null ) {conn.close();}
		if ( pstmt != null ) {pstmt.close();}
		if ( rs!= null ) {rs.close();}
	}









%>

</body>
</html>