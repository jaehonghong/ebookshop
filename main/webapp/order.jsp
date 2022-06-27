    <%@ page import="java.util.*, java.lang.*" %>
    <%@ page import="java.sql.*" %>
    <%@ page language="java" contentType="text/html;charset=utf-8"
    pageEncoding="utf-8" %>
    <% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<h1>인터넷 프로그래머 문고</h1>
	<h3>제목을 입력하세요</h3>
	<form method="post">
	책제목 : <input type="text" name="title"><br>
	<input type="submit" value="검색">
	</form>
	<%String title = request.getParameter("title");
		if(title!=null){
	%>
	<%
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection(
			"jdbc:mysql://localhost:3306/testdb3","java","java");
	Statement stmt = conn.createStatement();
	
	String sql = "SELECT * FROM book_table WHERE title LIKE ";
			sql += "'%"+title+"%'";
	sql += "ORDER BY title ASC";
	ResultSet rs = stmt.executeQuery(sql);
	%>
	<hr>
	<form method="post" action="order_proc.jsp">
	<table border=1 cellpadding = 5>
	<tr>
	<th>주문</th>
	<th>저자</th>
	<th>제목</th>
	<th>가격</th>
	<th>남아있는 수량</th>
	</tr>
	<%
		while(rs.next()){
			int id = rs.getInt("id");
	%>
	<tr>
	<td><input type="checkbox" name="id" value="<%=id %>"></td>
	<td><%=rs.getString("author") %></td>
	<td><%=rs.getString("title") %></td>
	<td><%=rs.getInt("price") %> 원</td>
	<td><%=rs.getInt("qty") %> 권</td>
	</tr>
	<%
		}
	%>
	</table>
	<br> <input type="submit" value="주문"><input type="reset" value="초기화">
	</form>
	<a href="<%=request.getRequestURI() %>"><h3>다시 주문하기</h3></a>
	<%
	rs.close();
	stmt.close();
	conn.close();
		}
	%>
</body>
</html>