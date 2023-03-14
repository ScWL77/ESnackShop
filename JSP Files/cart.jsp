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
<body onload = "initialTotal()">
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
				ArrayList<Integer> list5 = new ArrayList<Integer>();
				list1 = (ArrayList<Integer>)request.getAttribute("listID");
				list2 = (ArrayList<String>)request.getAttribute("listName");
				list3 = (ArrayList<Float>)request.getAttribute("listPrice");
				list4 = (ArrayList<Integer>)request.getAttribute("listStock");
				list5 = (ArrayList<Integer>)request.getAttribute("quantity");%>
			<h2 style="margin-left:195px;margin-top:50px"><b>My Cart</b> </h2>
			<table id ="cartTable" class = "table table-hover" style = "table-layout:fixed;width:75%;margin-left:auto;margin-right:auto;margin-top:20px;">
				<thead>
					<tr>
						<th scope ="col"> ID </th>
						<th scope ="col"> Name </th>
						<th scope ="col"> Unit Price </th>
						<th scope ="col"> Stock </th>
						<th scope ="col"> Updated Quantity</th>
						<th scope ="col"> Total Price </th>
						<th scope ="col"> Action </th>
					</tr>
				</thead>
				<tbody>
				<%for(int i = 0 ; i<list1.size();i++){%>
				<form method="GET" action="http://localhost:9999/esnackshop/removeFromCart">
				<tr>
					<td name = "id"><%=list1.get(i)%></td>
					<td><%=list2.get(i)%></td>
					<td><%=list3.get(i)%></td>
					<td><%=list4.get(i)%></td>
					<td style = "width:15%" onclick="changeTotal(this,<%=list3.get(i)%>,<%=list1.get(i)%>)">
						<input id = "quantity" style = "width:75%" type="number" min="1" step="1" class="form-control"value = "<%=list5.get(i)%>" name = "quantity">
					</td>
					<td><%=list5.get(i)*list3.get(i)%></td>
					<script>
						function changeTotal(obj,price,quantityRow){
							var table = document.getElementById("cartTable");
							var rowIndex = obj.parentNode.rowIndex;
							var total = 0;
							var cartTotal = 0;
							var quantity = table.rows[rowIndex].cells[4].children[0].value;
							total = quantity * price;
							table.rows[rowIndex].cells[5].innerHTML = total.toFixed(2);

							for(var i = 1;i<=table.rows.length-1;i++){
								cartTotal += parseFloat(table.rows[i].cells[5].innerHTML);
							}

							let rowNo = quantityRow.toString();
							var x = document.getElementById(rowNo);
							x.value = quantity;
							document.getElementById("cartTotal").innerHTML = cartTotal.toFixed(2);
						}
					</script>
					<td>
							<button type="submit" class="btn btn-default btn-sm" style = "background-color:#f40000;color:white;">
							<b> Remove </b>
							<span class="glyphicon glyphicon-trash"></span>
							</button>
							<input id = "id" type="hidden" name="itemid" value = "<%=list1.get(i)%>" required>
							<input id = "name" type="hidden" name="itemname" value = "<%=list2.get(i)%>" required>
          		<input type="hidden" name="username" value = "${username}" required>
          </td>
				</tr>
				</form>
				<%}%>
				</tbody>
			</table>
			<div style="margin:auto;margin-right:0;margin-left:1180px;color:red">
				<span>Total Price: </span>
				<span id = "cartTotal"></span>
			</div>
			<form method="GET" action="http://localhost:9999/esnackshop/orders">
				<button type="submit" style="margin-left:195px;background-color:#1575e7;color:white" class="btn btn-default btn-sm"><b>Place Order</b></button>
				<%for(int i = 0 ; i<list1.size();i++){%>
					<input id = "id" type="hidden" name="orderid" value = "<%=list1.get(i)%>" required>
					<input id = "<%=list1.get(i)%>" type="hidden" name="<%=list1.get(i)%>" value = "<%=list5.get(i)%>"required>
				<%}%>
			</form>
			<script>
				function initialTotal(){
					var table = document.getElementById("cartTable");
					var cartTotal = 0;
					for(var i = 1;i<=table.rows.length-1;i++){
						cartTotal += parseFloat(table.rows[i].cells[5].innerHTML);
					}
					document.getElementById("cartTotal").innerHTML = cartTotal;
				}
			</script>
</body>
</html>
