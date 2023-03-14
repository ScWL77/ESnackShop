<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <link rel = "stylesheet" href="style.css">
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Rochester&display=swap" rel="stylesheet">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<body>
	<nav class = "navbar navbar-inverse navbar-static-top">
	<div class = "container-fluid">
		<div class = "navbar-header">
			<a style="color:white;font-family:'Rochester',cursive; font-size: 25px" class = "navbar-brand" >ESnackShop</a>
		</div>
	<ul class = "nav navbar-nav navbar-right">
		<%String username = (String)request.getAttribute("username");%>
		<%if(username!=null){%>
			<a style="color:#ffecd1" class = "navbar-brand" id= "profile-name" style="visibility: visible" name = "profile-name"><i class="glyphicon glyphicon-user"></i> ${username}</a>
		<%}else{ %>
			<a style="color:white" class = "navbar-brand" id= "profile-name" style="visibility: hidden"></a>
		<%}%>
		<%if(username!=null){%>
			<li>
				<a style="color:white" href = "http://localhost:9999/esnackshop/"> Home </a>
			</li>
			<li><a style="color:white" href = "http://localhost:9999/esnackshop/displayCart"> Cart </a></li>
			<li><a style="color:white" href = "http://localhost:9999/esnackshop/displayOrders"> Orders </a></li>
			<li><a style="color:white" href = "http://localhost:9999/esnackshop/logout">Logout</a></li>
		<%}else{ %>
			<li><a style="color:white" href = "http://localhost:9999/esnackshop/"> Home </a></li>
			<li><a style="color:white" href = "login.jsp">Login/Register</a></li>
		<%}%>
	</ul>
	</div>
</nav>
			<%ArrayList<Integer> list1 = new ArrayList<Integer>();
				ArrayList<String> list2 = new ArrayList<String>();
				ArrayList<Float> list3 = new ArrayList<Float>();
				ArrayList<Integer> list4 = new ArrayList<Integer>();
				ArrayList<String> list5 = new ArrayList<String>();
				list1 = (ArrayList<Integer>)request.getAttribute("listID");
				list2 = (ArrayList<String>)request.getAttribute("listName");
				list3 = (ArrayList<Float>)request.getAttribute("listPrice");
				list4 = (ArrayList<Integer>)request.getAttribute("quantity");
				list5 = (ArrayList<String>)request.getAttribute("listDate");%>
			<h2 style="margin-left:195px;margin-top:50px"><b>My Orders</b> </h2>
			<table id ="cartTable" class = "table table-hover" style ="table-layout:fixed;width:75%;margin-left:auto;margin-right:auto;margin-top:20px;">
				<thead>
					<tr>
						<th style="width:50px" scope ="col"> ID </th>
						<th style = "width: 350px"scope ="col"> Name </th>
						<th scope ="col"> Unit Price </th>
						<th scope ="col"> Updated Quantity </th>
						<th scope = "col"> Total Price </th>
						<th scope ="col"> Ordered Date</th>
					</tr>
				</thead>
				<tbody>
					<%for(int i = 0 ; i<list1.size();i++){%>
				<tr>
					<td><%=list1.get(i)%></td>
					<td><%=list2.get(i)%></td>
					<td><%=list3.get(i)%></td>
					<td><%=list4.get(i)%></td>
					<td><%=list4.get(i)* list3.get(i)%></td>
					<td><%=list5.get(i)%></td>
				</tr>
				<%}%>
				</tbody>
			</table>
</body>
</html>