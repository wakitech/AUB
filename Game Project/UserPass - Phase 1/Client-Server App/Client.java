import java.io.IOException;
import java.util.*;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;
import java.util.Scanner;

public class Client{
	@SuppressWarnings("resource")
	public static void main(String args[]) throws Exception{
		try(Socket socket= new Socket("localHost",6000)){
			System.out.println("Enter lines of text");
			try(Scanner scanner = new Scanner(System.in)){
			Scanner in = new Scanner(socket.getInputStream());
			PrintWriter out = new PrintWriter(socket.getOutputStream(),true);
			while(scanner.hasNextLine()) {
				String s=scanner.nextLine();
				if(s.equals("DONE")) {
					break;
				}
				out.println(s);
				System.out.println(in.nextLine());
				System.out.println("type DONE if you're Done. If not, continue normally");
			}
			socket.close();
			System.out.println("Thank you, have a good day");
			}
		}
	}
}