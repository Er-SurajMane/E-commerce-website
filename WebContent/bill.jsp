<%@page import="project.ConnectionProvider"%>
<%@page import="java.sql.*"%>
<%@include file="footer.jsp"%>
<html>
<head>
<link rel="stylesheet" href="css/bill.css">
<title>Bill</title>
</head>
<body>
<%
String email = session.getAttribute("email").toString();

try{
	int total=0;
	int sno=0;
	Connection con = ConnectionProvider.getCon();
	Statement st = con.createStatement();
	ResultSet rs = st.executeQuery("select sum(total) from cart where email='"+email+"' and status='invoice'");
	while(rs.next()){
		total=rs.getInt(1);
	}
	ResultSet rs2 = st.executeQuery("select * from users inner join cart where cart.email='"+email+"' and cart.status='invoice'");
	while(rs2.next())
	{
	
%>

<h3>Genie</h3>
<hr>
<br> <br> 
<div class="left-div"><h3>Name: <%=rs2.getString(1) %> </h3></div>
<div class="right-div-right"><h3>Email: <%out.println(email); %> </h3></div>
<div class="right-div"><h3>Mobile Number: <%=rs2.getString(18) %></h3></div>  

<div class="left-div"><h3>Order Date: <%=rs2.getString(12) %> </h3></div>
<div class="right-div-right"><h3>Payment Method: <%=rs2.getString(14) %> </h3></div>
<div class="right-div"><h3>Expected Delivery: <%=rs2.getString(13) %> </h3></div> 

<div class="left-div"><h3>Transaction Id: <%=rs2.getString(15) %> </h3></div>
<div class="right-div"><h3>Address: <%=rs2.getString(17) %> </h3></div> 
<br> <br> 

<hr>
<%break;} %>

	
	<br>
	
<table id="customers">
<h3>Product Details</h3>
  <tr>
    <th>S.No</th>
    <th>Product Name</th>
    <th>category</th>
    <th>Price</th>
    <th>Quantity</th>
     <th>Sub Total</th>
  </tr>
  <%
  ResultSet rs1 = st.executeQuery("select * from cart inner join products where cart.product_id=products.id and cart.email='"+email+"' and cart.status='invoice'");
  while(rs1.next()){
	  sno=sno+1;
 
  %>
  <tr>
    <td><%out.println(sno); %></td>
    <td><%=rs1.getString(14) %></td>
    <td><%=rs1.getString(15) %></td>
    <td><%=rs1.getString(16) %></td>
    <td><%=rs1.getString(3) %></td>
     <td><%=rs1.getString(5) %></td>
  </tr>
  <tr>
<%} %>
</table>
<h3>Total: <%out.println(total); %> </h3>
<a href="placeOrder.jsp"><button class="button left-button">Place Order</button></a>
<a onclick="window.print();"><button class="button right-button">Print Invoice</button></a>
<br><br><br><br>
<%}
catch(Exception e){
	System.out.println(e);
}
%>
</body>
</html>