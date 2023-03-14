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

@WebServlet("/cart")   // Configure the request URL for this servlet (Tomcat 7/Servlet 3.0 upwards)
public class cart extends HttpServlet {

   // The doGet() runs once per HTTP GET request to this servlet.
   @Override
   public void doGet(HttpServletRequest request, HttpServletResponse response)
               throws ServletException, IOException {
      // Set the MIME type for the response message
      response.setContentType("text/html");
      PrintWriter out = response.getWriter();

      // Print an HTML page as the output of the query
      Integer user_id = 0;
      Integer item_id = 0;
      String item_name = request.getParameter("itemname");
      String username = request.getParameter("username");
      String quantity = request.getParameter("quantity");
      boolean exist = false;

      try (
         // Step 1: Allocate a database 'Connection' object
         Connection conn = DriverManager.getConnection(
               "jdbc:mysql://localhost:3306/esnackshop?allowPublicKeyRetrieval=true&useSSL=false&serverTimezone=UTC",
               "myuser", "xxxx");   // For MySQL
               // The format is: "jdbc:mysql://hostname:port/databaseName", "username", "password"

         // Step 2: Allocate a 'Statement' object in the Connection
         Statement stmt = conn.createStatement();
      ) {
            // Step 3: Execute a SQL INSERT query into cart table if the parameters are not null
            if(item_name!=null && quantity!=null){
               String sqlStr;
               sqlStr = "select * from user where username = '" + username +"'";

               ResultSet rs = stmt.executeQuery(sqlStr);
               if(rs.next()){
                  user_id = rs.getInt("id");
               }

               sqlStr = "select * from snacks where item_name = '" + item_name +"'";
               rs = stmt.executeQuery(sqlStr);
               if(rs.next()){
                  item_id = rs.getInt("item_id");
               }

               sqlStr = "select * from cart where user_id = " + user_id + " and snack_id=" + item_id;
               rs = stmt.executeQuery(sqlStr);
               if(!rs.next()){
                  //insert item selected that were added into the cart database
                  sqlStr = "insert into cart (user_id,snack_id,quantity) values (?,?,?)";
                  PreparedStatement ps = conn.prepareStatement(sqlStr);
                  ps = conn.prepareStatement(sqlStr);
                  ps.setInt(1,user_id);
                  ps.setInt(2,item_id);
                  ps.setInt(3,Integer.parseInt(quantity));
                  ps.executeUpdate();
                  ps.close();
               }
               conn.close();
            }
            response.sendRedirect("http://localhost:9999/esnackshop/");
      } catch(Exception ex) {
         ex.printStackTrace();
      }  // Step 5: Close conn and stmt - Done automatically by try-with-resources (JDK 7)*/
      
      //return Item;
      out.close();
   }
}
