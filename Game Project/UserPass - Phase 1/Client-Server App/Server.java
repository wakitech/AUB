import java.io.IOException; 
import java.io.PrintWriter; 
import java.net.ServerSocket; 
import java.net.Socket;
import java.util.List;
import java.util.Scanner;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.*;
public class Server {
	public static void main(String args[]) throws Exception {
		try(ServerSocket listener= new ServerSocket(6000)){
			System.out.println("The statistics server is running...");
			ExecutorService pool=Executors.newFixedThreadPool(20);
			while(true) {
				pool.execute(new StatThread(listener.accept()));
			}
		}
	}
	
	public static class StatThread implements Runnable {
		private Socket socket;
		
		StatThread(Socket socket){
			this.socket=socket;
		}
		@Override
		public void run() {
			System.out.println("Connected: "+socket);
			try {
				Scanner in = new Scanner(socket.getInputStream());
				PrintWriter out= new PrintWriter(socket.getOutputStream(),true);
				while(in.hasNextLine()) {
					out.println("Hello from the server");
				}
			}
			catch (IOException e) {
				e.printStackTrace();
			}
			finally {
				try {
					socket.close();}catch(IOException e) {}
				System.out.println("Closed: "+socket);
			}
		}
	}
}
					
					
					
					
			