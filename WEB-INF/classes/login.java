import java.io.*;
import java.sql.*;
import jakarta.servlet.*;             // Tomcat 10
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.util.ArrayList;
import java.util.List;
//import javax.servlet.*;             // Tomcat 9
//import javax.servlet.http.*;
//import javax.servlet.annotation.*;

 
/**
 * Servlet implementation class Register
 */
@WebServlet("/login")
public class login extends HttpServlet {
 	@Override
   public void doPost(HttpServletRequest request, HttpServletResponse response)
               throws ServletException, IOException {
      // Set the MIME type for the response message
      response.setContentType("text/html");
      // Get a output writer to write the response message into the network socket
      PrintWriter out = response.getWriter();

      ArrayList<Integer>listID = new ArrayList<Integer>();
      ArrayList<String>listName = new ArrayList<String>();
      ArrayList<Float>listPrice = new ArrayList<Float>();
      ArrayList<Integer>listStock = new ArrayList<Integer>();
      // Print an HTML page as the output of the query

      try (
         // Step 1: Allocate a database 'Connection' object
         Connection conn = DriverManager.getConnection(
               "jdbc:mysql://localhost:3306/esnackshop?allowPublicKeyRetrieval=true&useSSL=false&serverTimezone=UTC",
               "myuser", "xxxx");   // For MySQL
               // The format is: "jdbc:mysql://hostname:port/databaseName", "username", "password"

         // Step 2: Allocate a 'Statement' object in the Connection
         Statement stmt = conn.createStatement();
      ) {
         // Step 3: Execute a SQL SELECT query
         // Retrieve the books' id. Can order more than one books.
      	String username = request.getParameter("username");
      	String password = request.getParameter("password");
      	String sqlStr = "SELECT * FROM user WHERE username = '" + username + "' and password = '" + password + "';";
         boolean status = false;
         String lastlogin;


      	PreparedStatement ps = conn.prepareStatement(sqlStr);
         //ps.setString(1,username);
         //ps.setString(2,password);

         ResultSet rs = ps.executeQuery(sqlStr);
         status = rs.next();

         sqlStr = "select * from snacks";
         rs = stmt.executeQuery(sqlStr);  // Send the query to the server

         // Step 4: Process the query result set
         while(rs.next()){
            listID.add(rs.getInt("item_id"));
            listName.add(rs.getString("item_name"));
            listPrice.add(rs.getFloat("price"));
            listStock.add(rs.getInt("stock"));
         }

         sqlStr = "insert into log (userid,status) values (?,?)";
         ps = conn.prepareStatement(sqlStr);
         ps.setString(1,username);
         ps.setString(2,"login");
         ps.executeUpdate();
         ps.close();

         if (status){
            request.removeAttribute("error");
            request.setAttribute("username",username);
            request.setAttribute("listID",listID);
            request.setAttribute("listName",listName);
            request.setAttribute("listPrice",listPrice);
            request.setAttribute("listStock",listStock);
            request.getRequestDispatcher("homepage.jsp").forward(request,response);
            //request.getRequestDispatcher("").forward(request,response);
            response.sendRedirect("homepage.jsp");
         }else{
            request.setAttribute("error","have error");
            request.getRequestDispatcher("login.jsp").forward(request,response);
            out.println("Not Valid");
         }
         //ps.close();
         conn.close();

      } catch(Exception ex) {
         out.println("<p>Error: " + ex.getMessage() + "</p>");
         out.println("<p>Check Tomcat console for details.</p>");
         ex.printStackTrace();
      }  // Step 5: Close conn and stmt - Done automatically by try-with-resources (JDK 7)
      out.close();
   }
 
}