<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<h1>���ͳ� ���α׷��� ����</h1>
<h3>�ֹ����ּż� �����մϴ�</h3>

<%
	String[] ids = request.getParameterValues("id");
	if(ids != null){
%>
<%@ page import="java.sql.*" %>
		
<%
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/testdb3","java","java");
	Statement stmt = conn.createStatement();
	String sql;
	int recordUpdated;
	ResultSet rs;
%>
<table border=2>
	<tr>
	<th>����</th>
	<th>����</th>
	<th>����</th>
	<th>����</th>
	</tr>
	<%
	for(int i=0;i<ids.length;i++){
		sql = "UPDATE book_table SET qty = qty-1 where id ="+ids[i];
		recordUpdated = stmt.executeUpdate(sql);
		sql = "SELECT * FROM book_table WHERE id="+ids[i];
		rs = stmt.executeQuery(sql);
		while(rs.next()){
	%>
	<tr>
	<td><%=rs.getString("author") %></td>
	<td><%=rs.getString("title") %></td>
	<td><%=rs.getInt("price") %></td>
	<td><%=rs.getInt("qty") %></td>
	</tr>	
	<%  }
		rs.close();
	}
		conn.close();
		stmt.close();
	}
	%>
	
</table>
<a href="order.jsp"><h3>�ֹ� ȭ������ ���ư���</h3></a>


</body>
</html>