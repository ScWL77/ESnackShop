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

@WebServlet("/orders")   // Configure the request URL for this servlet (Tomcat 7/Servlet 3.0 upwards)
public class orders extends HttpServlet {

   // The doGet() runs once per HTTP GET request to this servlet.
   @Override
   public void doGet(HttpServletRequest request, HttpServletResponse response)
               throws ServletException, IOException {
      // Set the MIME type for the response message
      response.setContentType("text/html");
      PrintWriter out = response.getWriter();
      String[] order_ids = request.getParameterValues("orderid");
      String[] item_id = request.getParameterValues("itemid");
      String[] item_name = request.getParameterValues("itemname");
      ArrayList<Integer> listItemID = new ArrayList<Integer>();
      String username = "";
      Integer user_id = 0 ;
      Integer[] order_quantity = new Integer[order_ids.length];
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

         for(int i = 0;i<order_ids.length;i++){
            order_quantity[i] = Integer.parseInt(request.getParameter(order_ids[i]));
         }

         String sqlStr;
         //Get user_id of the user 
         sqlStr = "select * from log where value = (select max(value) from log) and status = 'login'";

         ResultSet rs = stmt.executeQuery(sqlStr);
         if(rs.next()){
            username = rs.getString("userid");
         }
         //Get the id of the user from table user
         sqlStr = "select * from user where username = '" + username +"'";
         rs = stmt.executeQuery(sqlStr);
         if(rs.next()){
            user_id = rs.getInt("id");
         }

         if(order_ids.length!=0 && order_quantity.length!=0){

            //Execute a SQL INSERT query into orders table
            for (int i = 0; i<order_quantity.length;++i){
               sqlStr = "insert into orders (user_id,item_id,qty,ordered_date) values(?,?,?,now())";
               PreparedStatement ps;
               ps = conn.prepareStatement(sqlStr);
               ps.setInt(1,user_id);
               ps.setInt(2,Integer.parseInt(order_ids[i]));
               ps.setInt(3,order_quantity[i]);
               ps.executeUpdate();
               ps.close();
            }

            //Execute a SQL DELETE query into cart table
            for(int i = 0; i<order_quantity.length;++i){
               sqlStr = "delete from cart where user_id = " + user_id + " and snack_id = " + Integer.parseInt(order_ids[i]);
               PreparedStatement ps;
               ps = conn.prepareStatement(sqlStr);
               ps.executeUpdate();
               ps.close();
            }
         }
         response.sendRedirect("http://localhost:9999/esnackshop/displayCart");
         conn.close();
         
      } catch(Exception ex) {
         ex.printStackTrace();
      }  // Step 5: Close conn and stmt - Done automatically by try-with-resources (JDK 7)
      out.close();
   }
}