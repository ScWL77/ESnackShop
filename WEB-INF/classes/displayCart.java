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

@WebServlet("/displayCart")   // Configure the request URL for this servlet (Tomcat 7/Servlet 3.0 upwards)
public class displayCart extends HttpServlet {

   // The doGet() runs once per HTTP GET request to this servlet.
   @Override
   public void doGet(HttpServletRequest request, HttpServletResponse response)
               throws ServletException, IOException {
      // Set the MIME type for the response message
      response.setContentType("text/html");
      PrintWriter out = response.getWriter();
      String username = "";
      Integer user_id = 0;
      ArrayList<Integer> item_ids = new ArrayList<Integer>();
      ArrayList<Integer> quantity = new ArrayList<Integer>();
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
            // Get username who was last login from table log
            String sqlStr = "select * from log where value = (select max(value) from log) and status = 'login'";
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

            //Get the item ids in the cart that correspond to the user_id
            sqlStr = "select * from cart where user_id = " + user_id ;
            rs = stmt.executeQuery(sqlStr);
            while(rs.next()){
               item_ids.add(rs.getInt("snack_id"));
               quantity.add(rs.getInt("quantity"));
            }

            Integer[] item_id = new Integer[item_ids.size()];
            item_id = item_ids.toArray(item_id);

            //get the records corresponding to the item ids
            for(int i = 0; i<item_id.length;i++){
               sqlStr = "select * from snacks where item_id = " + item_id[i];
               rs = stmt.executeQuery(sqlStr);
               while(rs.next()){
                  listID.add(rs.getInt("item_id"));
                  listName.add(rs.getString("item_name"));
                  listPrice.add(rs.getFloat("price"));
                  listStock.add(rs.getInt("stock"));
               }
            }
            request.setAttribute("quantity",quantity);
            request.setAttribute("listID",listID);
            request.setAttribute("listName",listName);
            request.setAttribute("listPrice",listPrice);
            request.setAttribute("listStock",listStock);
            request.setAttribute("username",username);
            request.getRequestDispatcher("cart.jsp").forward(request,response);
            conn.close();
      } catch(Exception ex) {
         ex.printStackTrace();
      }  // Step 5: Close conn and stmt - Done automatically by try-with-resources (JDK 7)*/
      
      out.close();
   }
}