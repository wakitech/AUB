import java.io.FileWriter;   // Import the FileWriter class
import java.io.IOException;  // Import the IOException class to handle errors
import java.util.Scanner;
import java.io.BufferedWriter;
import java.io.Writer;
import java.io.File;
import java.io.BufferedReader;
import java.util.Vector;

public class UserPass {
    
    private static Scanner x;
  public static void main(String[] args) {
      
      String LogUsername, LogPassword;
      Scanner Log = new Scanner(System.in);
      System.out.print("Enter your username: ");
      LogUsername = Log.nextLine();
      System.out.print("Enter your password: ");
      LogPassword = Log.nextLine();
      String filepath = "UserPass.txt";
      verifyLogin(LogUsername, LogPassword, filepath);
    }
      
    
    
    
  public static void verifyLogin(String LogUsername, String LogPassword, String filepath)
      { 
          boolean found = false;
          String tempUsername = "";
          String tempPassword = "";
       try {
           x = new Scanner(new File(filepath));
           x.useDelimiter("[;\n]");
           
           while(x.hasNext() && !found)
           {
               tempUsername = x.next();
               tempPassword = x.next();
               if (tempUsername.trim().equals(LogUsername.trim()) && tempPassword.trim().equals(LogPassword.trim()))
               {   
                   found = true;
                   break;
               }
            }
                x.close();
                System.out.println(found);
                   
        }
        catch (Exception e)
        {
            System.out.println("Error");
        }
        
    try {
        
      if (found == false) {
          
      String User, Pass;
      Scanner input = new Scanner(System.in);
      FileWriter myWriter = new FileWriter("UserPass.txt", true);
      myWriter.write(LogUsername+";"+LogPassword+"\n");
      System.out.println("Successfully wrote to the file.");
      myWriter.close();
      
    } 
}
    catch (IOException e) {
        
      System.out.println("An error occurred.");
      e.printStackTrace();
      
    }
    
  }
  
}
