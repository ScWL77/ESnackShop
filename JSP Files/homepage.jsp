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
	<link href="dist/jquery.nok.min.css" rel="stylesheet">
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <link rel="stylesheet" type = "text/css" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
</head>

<body>
<nav class = "navbar navbar-inverse navbar-static-top">
	<div class = "container-fluid">
		<div class = "navbar-header">
			<a style="color:white;font-family:'Rochester',cursive; font-size: 25px" class = "navbar-brand" >ESnackShop</a>
		</div>
	<ul class = "nav navbar-nav navbar-right" method="GET" action="http://localhost:9999/esnackshop/search">
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

	<form class="navbar-form navbar-left" method="GET" action="http://localhost:9999/esnackshop/">
      <div class="form-group">
        <input type="text" class="form-control" name = "snack_name" placeholder="Search">
      </div>
      <button type="submit" class="btn btn-default">Search</button>
  </form>
	</div>
</nav>
			<%ArrayList<Integer> list1 = new ArrayList<Integer>();
				ArrayList<String> list2 = new ArrayList<String>();
				ArrayList<Float> list3 = new ArrayList<Float>();
				ArrayList<Integer> list4 = new ArrayList<Integer>();
				list1 = (ArrayList<Integer>)request.getAttribute("listID");
				list2 = (ArrayList<String>)request.getAttribute("listName");
				list3 = (ArrayList<Float>)request.getAttribute("listPrice");
				list4 = (ArrayList<Integer>)request.getAttribute("listStock");%>
			<h2 style="margin-left:195px;margin-top:50px"><b>List of Snacks</b> </h2>
			<table class = "table table-hover" style = "width:75%;margin-left:auto;margin-right:auto;margin-top:20px">
				<thead>
					<tr>
						<th scope ="col"> ID </th>
						<th scope ="col"> Name </th>
						<th scope ="col"> Unit Price </th>
						<th scope ="col"> Stock </th>
						<th scope ="col"> Quantity </th>
						<th scope ="col"> Action </th>
					</tr>
				</thead>
				<tbody>
				<%for(int i = 0 ; i<list1.size();i++){%>
				<form method="GET" action="http://localhost:9999/esnackshop/cart">			
				<tr>
					<td name = "id"><%=list1.get(i)%></td>
					<td><%=list2.get(i)%></td>
					<td id="unitPrice"><%=list3.get(i)%></td>				
					<td><%=list4.get(i)%></td>			
					<td style = "width:15%">
							<input style = "width:75%" type="number" min="1" step="1" class="form-control" id="amountInput" value = "1" name = "quantity">
					</td>
					<td>
							<button id="add" type = "submit" class="btn btn-default btn-sm" style="background-color:#ff8e06;width:50%;color:white" onclick="test(this)">
								<b> Add to Cart </b>
								<span class="glyphicon glyphicon-shopping-cart"></span>
          		</button>
          		<input id = "name" type="hidden" name="itemname" value = "<%=list2.get(i)%>" required>
          		<input type="hidden" name="username" value = "${username}" required>
          		<script>
          			function test(object){
          				var x = "Item Added";
          				x = x.bold()
          				object.innerHTML = x.fontcolor("black");
          			}
          		</script>
          </td>
				</tr>
				</form>
				<%}%>
				</tbody>
			</table>
</body>
</html>
