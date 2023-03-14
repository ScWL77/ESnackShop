<!DOCTYPE html>
<html>
	<head>
		<link rel = "stylesheet" href="style.css">
	</head>

<body>
	<div class = "hero">
		<div class = "form-box">
			<div class = "button-box">
				<div id="btn"></div>
				<button type = "button" class = "toggle-btn" onclick="login()">Login</button>
				<button type = "button" class = "toggle-btn" onclick="register()">Register</button>
			</div>
			<form id = "login" class = "input-group1" action ="/esnackshop/login" method ="POST">
				<h2 class = "header">Log into your account</h2>
				<input id = "username" type ="text" class = "input-field" placeholder="User Id" name = "username" required>
				<input id = "password" type ="password" class = "input-field" placeholder="Enter Password" name = "password" required>
				<button type = "submit" class = "submit-btn">Log in </button>
				<%if(request.getAttribute("error")!= null){%>
					<a id = "error-msg" style = "visibility: visible">The username and password you entered did not match our records. Please try again. </a>
				<%}else{ %>
					<a id= "error-msg" style="visibility: hidden"></a>
				<%}%>
			</form>
			<form id = "register" class = "input-group2" action = "/esnackshop/signup" method = "POST">
				<h2 class ="header">Create an account </h2>
				<input id = "username" type ="text" class = "input-field" placeholder="User Id" name = "username" pattern = "^[a-z0-9_-]{8,}$" title = "Must be at least 8 characters" required>
				<input id = "email" type ="email" class = "input-field" placeholder="Email Id" name = "email" pattern = "^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$" title = "Please enter the email in this format: yourname@example.com " required>
				<input id = "number" type ="text" class = "input-field" placeholder="Phone Number" name = "number" pattern = "^[0-9]*$" title = "Please enter digits only"required>
				<input id = "password" type ="password" class = "input-field" placeholder="Enter Password" name = "password" pattern = "^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$&_%^\/*]).{8,}$" title = "Must be at least 8 characters, one upper case letter,one lower case letter, one number and one special character" required>
				<button type = "submit" class = "submit-btn">Register </button>
			</form>
		</div>
	</div>

	<script type="text/javascript">
		var x = document.getElementById("login");
		var y = document.getElementById("register");
		var z = document.getElementById("btn");

		function register(){
			x.style.left = "-400px";
			y.style.left = "50px";
			z.style.left = "110px";
		}

		function login(){
			x.style.left = "50px";
			y.style.left = "450px";
			z.style.left = "0px";
		}

	</script>

</body>
</html>