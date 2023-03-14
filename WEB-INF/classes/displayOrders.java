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

@WebServlet("/displayOrders")   // Configure the request URL for this servlet (Tomcat 7/Servlet 3.0 upwards)
public class displayOrders extends HttpServlet {

   // The doGet() runs once per HTTP GET request to this servlet.
   @Override
   public void doGet(HttpServletRequest request, HttpServletResponse response)
               throws ServletException, IOException {
      // Set the MIME type for the response message
      response.setContentType("text/html");
      PrintWriter out = response.getWriter();
      ArrayList<Integer> listItemID = new ArrayList<Integer>();
      String username = "";
      Integer user_id = 0 ;
      ArrayList<Integer> updatedQuantity = new ArrayList<Integer>();
      ArrayList<Integer>listID = new ArrayList<Integer>();
      ArrayList<String>listName = new ArrayList<String>();
      ArrayList<Float>listPrice = new ArrayList<Float>();
      ArrayList<String>listOrderedDate = new ArrayList<String>();
      boolean test = false;
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

         //Execute a SQL SELECT query to get all the orders placed from the orders table;
         sqlStr = "select * from orders where user_id = " + user_id;
         rs = stmt.executeQuery(sqlStr);
         //get all the updated quantity
         while(rs.next()){
            updatedQuantity.add(rs.getInt("qty"));
            listOrderedDate.add(rs.getString("ordered_date"));
            listItemID.add(rs.getInt("item_id"));
         }

         //Execute a SQL SELECT query from snacks table to get all the snack that the user order into an array list
         Integer[] listItemIDs = new Integer[listItemID.size()];
         listItemIDs = listItemID.toArray(listItemIDs);

         for(int i = 0; i<listItemIDs.length;++i){
            sqlStr = "select * from snacks where item_id = " + "'" + listItemIDs[i] +"'";
            rs = stmt.executeQuery(sqlStr);
            while(rs.next()){
               listID.add(rs.getInt("item_id"));
               listName.add(rs.getString("item_name"));
               listPrice.add(rs.getFloat("price"));
            }
         }

         request.setAttribute("username",username);
         request.setAttribute("listID",listID);
         request.setAttribute("listName",listName);
         request.setAttribute("listPrice",listPrice);
         request.setAttribute("quantity",updatedQuantity);
         request.setAttribute("listDate",listOrderedDate);
         request.getRequestDispatcher("order.jsp").forward(request,response);
         conn.close();
         
      } catch(Exception ex) {
         ex.printStackTrace();
      }  // Step 5: Close conn and stmt - Done automatically by try-with-resources (JDK 7)
      out.close();
   }
}