import java.io.*;
import java.sql.*;
import jakarta.servlet.*;            // Tomcat 10
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.util.ArrayList;
import java.util.List;
//import classes.item;
//import javax.servlet.*;            // Tomcat 9
//import javax.servlet.http.*;
//import javax.servlet.annotation.*;

@WebServlet("/logout")   // Configure the request URL for this servlet (Tomcat 7/Servlet 3.0 upwards)
public class logout extends HttpServlet {

   // The doGet() runs once per HTTP GET request to this servlet.
   @Override
   public void doGet(HttpServletRequest request, HttpServletResponse response)
   throws ServletException, IOException {
      // Set the MIME type for the response message
      response.setContentType("text/html");
      // Get a output writer to write the response message into the network socket
      PrintWriter out = response.getWriter();
      // Print an HTML page as the output of the query
      ArrayList<Integer>listID = new ArrayList<Integer>();
      ArrayList<String>listName = new ArrayList<String>();
      ArrayList<Float>listPrice = new ArrayList<Float>();
      ArrayList<Integer>listStock = new ArrayList<Integer>();
      String username = "";
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
         String sqlStr = "select * from snacks";

         ResultSet rs = stmt.executeQuery(sqlStr);  // Send the query to the server

         // Step 4: Process the query result set
         while(rs.next()){
            listID.add(rs.getInt("item_id"));
            listName.add(rs.getString("item_name"));
            listPrice.add(rs.getFloat("price"));
            listStock.add(rs.getInt("stock"));
         }

         sqlStr = "select * from log ORDER BY value DESC LIMIT 1;";
         rs = stmt.executeQuery(sqlStr);
         while(rs.next()){
            username = rs.getString("userid");
            sqlStr = "insert into log (userid,status) values (?,?)";
            PreparedStatement ps = conn.prepareStatement(sqlStr);
            ps.setString(1,username);
            ps.setString(2,"logout");
            ps.executeUpdate();
            ps.close();
         }

         request.setAttribute("cartpage","true");
         request.setAttribute("listID",listID);
         request.setAttribute("listName",listName);
         request.setAttribute("listPrice",listPrice);
         request.setAttribute("listStock",listStock);
         request.getRequestDispatcher("homepage.jsp").forward(request,response); //check if file is jsp or html
         conn.close();
         
      } catch(Exception ex) {
         out.println("<p>Error: " + ex.getMessage() + "</p>");
         out.println("<p>Check Tomcat console for details.</p>");
         ex.printStackTrace();
      }  // Step 5: Close conn and stmt - Done automatically by try-with-resources (JDK 7)
      
      //return Item;
      out.close();
   }
}