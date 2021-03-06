import java.util.Arrays;
import java.util.Random;
import java.util.Scanner;

public class Game {

    public static void main(String[] args) {      
        System.out.println("The computer has generate a unique 4 digit number.\n"
                + "You can try to guess the 4 digits number in 5 attempts.\n");
        System.out.println("_______________________________________________________\n");
        int[] random=numberGenerator();
        //int maxTry=5;
        int indexMatch=0;
        int match=0;
        int PriceOfGuess=5; //new variable created
        int TotalGold=50; //new variable created
        int TotalSilver=0; //new variable created
        while(indexMatch!=4 && TotalGold > 5){
            
            System.out.print("\nYou have: "+TotalGold+"\n");
            
            int[] guess=getGuess();
            TotalGold = TotalGold-PriceOfGuess; //Price of each guess is 5 GC deducted from total number of GC
            indexMatch=0;
            match=0;
            for(int i=0;i<guess.length;i++){
                if(guess[i]==random[i]){
                    indexMatch++; //One of the numbers in Guess is in correct position
                }
                else if(guess[i]==random[0] || guess[i]==random[1] || guess[i]==random[2] || guess[i]==random[3]){
                    match++; //A number appears in both Random number and Guess
                }
            }
            if(indexMatch==4){ //If all 4 digits were correctly guessed
                System.out.print("Well done! Your guess is CORRECT! The number is: ");
                for(int i=0;i<guess.length;i++){
                    System.out.print(guess[i]); //Printing the correct number
                }
                TotalGold = TotalGold+50;
                System.out.print("You have been awarded 50 Gold coins. Total of Gold = "+TotalGold);
            }
             else{
                // maxTry--; //Number of attempts decreases by 1
                //if(maxTry!=1){
                    System.out.println("You have guessed "+indexMatch+" correct number in correct position,"+
                    " and "+match+" correct number in incorrect position."+"\nYou received "+"Gold = "+indexMatch+" and Silver = "+match); //prints correct and incorrect positions
                    TotalGold = TotalGold+indexMatch;
                    TotalSilver = TotalSilver+match;
                    System.out.print("Gold = "+TotalGold+"\n");
                    System.out.print("Silver = "+TotalSilver+"\n");
                //}
                // else if(maxTry==1){
                    // System.out.println("You have guessed "+indexMatch+" correct number in correct position,"+
                    // " and "+match+" correct number in incorrect position. \nLast attempt!. Good luck");
                //}
                // else{
                    // System.out.println("Sorry, you failed to guess the number in 5 attempts.");
                    // System.out.print("The number is: ");
                    // for(int i=0;i<random.length;i++){
                        // System.out.print(random[i]); //prints the random number after failing to guess it
                // }
            //}
        }
    }   
}

public static int[] getGuess(){
    Scanner keyboard = new Scanner(System.in);
    System.out.println("Please enter your guess: ");
    
    String input = keyboard.nextLine();
        if(input.length()!=4 || input.replaceAll("\\D","").length()!=4){
            System.out.println("Invalid number. You must enter 4 digits between 0-9 only.");
            return getGuess();
    }
    int[] guess = new int[4];
    for (int i = 0; i < 4; i++) {
        guess[i] = Integer.parseInt(String.valueOf(input.charAt(i)));
    }
    return guess;
}

public static int[] numberGenerator() {
    Random randy = new Random();
    int[] randArray = {10,10,10,10};

    for(int i=0;i<randArray.length;i++){
        int temp = randy.nextInt(9);
        while(temp == randArray[0] || temp == randArray[1] || temp == randArray[2] || temp == randArray[3]){
            temp=randy.nextInt(9);
        }
        randArray[i]=temp;      
    }
    return randArray;
}
}