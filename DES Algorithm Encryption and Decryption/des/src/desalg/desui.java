/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package desalg;
import java.awt.Color;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;

import javax.swing.JOptionPane;
import javax.swing.JTextArea;
import javax.swing.border.LineBorder;

/**
 *
 * @authors Christian Wakim
 *          Karim Hatem
 *          Elena Ghazi
 *          Rita-Maria Charbel
 * 
 * Data encryption standard (DES) implementation in Java. 
 * 
 */
public class desui extends javax.swing.JDialog {
   
    public static class DES {
        
        JTextArea tmp = new JTextArea();

        public JTextArea getTmp() {
            return tmp;
        }

        public void setTmp(JTextArea tmp) {
            this.tmp = tmp;
        }
   
    // CONSTANTS 
        // Initial Permutation Table 
        int[] IP = { 58, 50, 42, 34, 26, 18, 
                     10, 2, 60, 52, 44, 36, 28, 20, 
                     12, 4, 62, 54, 46, 38, 
                     30, 22, 14, 6, 64, 56, 
                     48, 40, 32, 24, 16, 8, 
                     57, 49, 41, 33, 25, 17, 
                     9, 1, 59, 51, 43, 35, 27, 
                     19, 11, 3, 61, 53, 45, 
                     37, 29, 21, 13, 5, 63, 55, 
                     47, 39, 31, 23, 15, 7 }; 
  
        // Inverse Initial Permutation Table 
        int[] IP1 = { 40, 8, 48, 16, 56, 24, 64, 
                      32, 39, 7, 47, 15, 55, 
                      23, 63, 31, 38, 6, 46, 
                      14, 54, 22, 62, 30, 37, 
                      5, 45, 13, 53, 21, 61, 
                      29, 36, 4, 44, 12, 52, 
                      20, 60, 28, 35, 3, 43, 
                      11, 51, 19, 59, 27, 34, 
                      2, 42, 10, 50, 18, 58, 
                      26, 33, 1, 41, 9, 49, 
                      17, 57, 25 }; 
  
        // first key-hePermutation Table 
        int[] PC1 = { 57, 49, 41, 33, 25, 
                      17, 9, 1, 58, 50, 42, 34, 26, 
                      18, 10, 2, 59, 51, 43, 35, 27, 
                      19, 11, 3, 60, 52, 44, 36, 63, 
                      55, 47, 39, 31, 23, 15, 7, 62, 
                      54, 46, 38, 30, 22, 14, 6, 61, 
                      53, 45, 37, 29, 21, 13, 5, 28, 
                      20, 12, 4 }; 
  
        // second key-Permutation Table 
        int[] PC2 = { 14, 17, 11, 24, 1, 5, 3, 
                      28, 15, 6, 21, 10, 23, 19, 12, 
                      4, 26, 8, 16, 7, 27, 20, 13, 2, 
                      41, 52, 31, 37, 47, 55, 30, 40, 
                      51, 45, 33, 48, 44, 49, 39, 56, 
                      34, 53, 46, 42, 50, 36, 29, 32 }; 
  
        // Expansion D-box Table 
        int[] EP = { 32, 1, 2, 3, 4, 5, 4, 
                     5, 6, 7, 8, 9, 8, 9, 10, 
                     11, 12, 13, 12, 13, 14, 15, 
                     16, 17, 16, 17, 18, 19, 20, 
                     21, 20, 21, 22, 23, 24, 25, 
                     24, 25, 26, 27, 28, 29, 28, 
                     29, 30, 31, 32, 1 }; 
  
        // Straight Permutation Table 
        int[] P = { 16, 7, 20, 21, 29, 12, 28, 
                    17, 1, 15, 23, 26, 5, 18, 
                    31, 10, 2, 8, 24, 14, 32, 
                    27, 3, 9, 19, 13, 30, 6, 
                    22, 11, 4, 25 }; 
  
        // S-box Table 
        int[][][] sbox = { 
            { { 14, 4, 13, 1, 2, 15, 11, 8, 3, 10, 6, 12, 5, 9, 0, 7 }, 
              { 0, 15, 7, 4, 14, 2, 13, 1, 10, 6, 12, 11, 9, 5, 3, 8 }, 
              { 4, 1, 14, 8, 13, 6, 2, 11, 15, 12, 9, 7, 3, 10, 5, 0 }, 
              { 15, 12, 8, 2, 4, 9, 1, 7, 5, 11, 3, 14, 10, 0, 6, 13 } }, 
  
            { { 15, 1, 8, 14, 6, 11, 3, 4, 9, 7, 2, 13, 12, 0, 5, 10 }, 
              { 3, 13, 4, 7, 15, 2, 8, 14, 12, 0, 1, 10, 6, 9, 11, 5 }, 
              { 0, 14, 7, 11, 10, 4, 13, 1, 5, 8, 12, 6, 9, 3, 2, 15 }, 
              { 13, 8, 10, 1, 3, 15, 4, 2, 11, 6, 7, 12, 0, 5, 14, 9 } }, 
            { { 10, 0, 9, 14, 6, 3, 15, 5, 1, 13, 12, 7, 11, 4, 2, 8 }, 
              { 13, 7, 0, 9, 3, 4, 6, 10, 2, 8, 5, 14, 12, 11, 15, 1 }, 
              { 13, 6, 4, 9, 8, 15, 3, 0, 11, 1, 2, 12, 5, 10, 14, 7 }, 
              { 1, 10, 13, 0, 6, 9, 8, 7, 4, 15, 14, 3, 11, 5, 2, 12 } }, 
            { { 7, 13, 14, 3, 0, 6, 9, 10, 1, 2, 8, 5, 11, 12, 4, 15 }, 
              { 13, 8, 11, 5, 6, 15, 0, 3, 4, 7, 2, 12, 1, 10, 14, 9 }, 
              { 10, 6, 9, 0, 12, 11, 7, 13, 15, 1, 3, 14, 5, 2, 8, 4 }, 
              { 3, 15, 0, 6, 10, 1, 13, 8, 9, 4, 5, 11, 12, 7, 2, 14 } }, 
            { { 2, 12, 4, 1, 7, 10, 11, 6, 8, 5, 3, 15, 13, 0, 14, 9 }, 
              { 14, 11, 2, 12, 4, 7, 13, 1, 5, 0, 15, 10, 3, 9, 8, 6 }, 
              { 4, 2, 1, 11, 10, 13, 7, 8, 15, 9, 12, 5, 6, 3, 0, 14 }, 
              { 11, 8, 12, 7, 1, 14, 2, 13, 6, 15, 0, 9, 10, 4, 5, 3 } }, 
            { { 12, 1, 10, 15, 9, 2, 6, 8, 0, 13, 3, 4, 14, 7, 5, 11 }, 
              { 10, 15, 4, 2, 7, 12, 9, 5, 6, 1, 13, 14, 0, 11, 3, 8 }, 
              { 9, 14, 15, 5, 2, 8, 12, 3, 7, 0, 4, 10, 1, 13, 11, 6 }, 
              { 4, 3, 2, 12, 9, 5, 15, 10, 11, 14, 1, 7, 6, 0, 8, 13 } }, 
            { { 4, 11, 2, 14, 15, 0, 8, 13, 3, 12, 9, 7, 5, 10, 6, 1 }, 
              { 13, 0, 11, 7, 4, 9, 1, 10, 14, 3, 5, 12, 2, 15, 8, 6 }, 
              { 1, 4, 11, 13, 12, 3, 7, 14, 10, 15, 6, 8, 0, 5, 9, 2 }, 
              { 6, 11, 13, 8, 1, 4, 10, 7, 9, 5, 0, 15, 14, 2, 3, 12 } }, 
            { { 13, 2, 8, 4, 6, 15, 11, 1, 10, 9, 3, 14, 5, 0, 12, 7 }, 
              { 1, 15, 13, 8, 10, 3, 7, 4, 12, 5, 6, 11, 0, 14, 9, 2 }, 
              { 7, 11, 4, 1, 9, 12, 14, 2, 0, 6, 10, 13, 15, 3, 5, 8 }, 
              { 2, 1, 14, 7, 4, 10, 8, 13, 15, 12, 9, 0, 3, 5, 6, 11 } } 
        };
        
        int[] shiftBits = { 1, 1, 2, 2, 2, 2, 2, 2, 
                            1, 2, 2, 2, 2, 2, 2, 1 }; 
  
        // hexadecimal to binary conversion 
        String hextoBin(String input) 
        { 
            int n = input.length() * 4; 
            input = Long.toBinaryString( 
                Long.parseUnsignedLong(input, 16)); 
            while (input.length() < n) 
                input = "0" + input; 
            return input; 
        } 
  
        // binary to hexadecimal conversion 
        String binToHex(String input) 
        { 
            int n = (int)input.length() / 4; 
            input = Long.toHexString( 
                Long.parseUnsignedLong(input, 2)); 
            while (input.length() < n) 
                input = "0" + input; 
            return input; 
        } 
  
        // per-mutate input hexadecimal 
        // according to specified sequence 
        String permutation(int[] sequence, String input) 
        { 
            String output = ""; 
            input = hextoBin(input); 
            for (int i = 0; i < sequence.length; i++) 
                output += input.charAt(sequence[i] - 1); 
            output = binToHex(output); 
            return output; 
        } 
        
  
        // xor 2 hexadecimal strings 
        String xor(String a, String b) 
        { 
            // hexadecimal to decimal(base 10) 
            long t_a = Long.parseUnsignedLong(a, 16); 
            // hexadecimal to decimal(base 10) 
            long t_b = Long.parseUnsignedLong(b, 16); 
            // xor 
            t_a = t_a ^ t_b; 
            // decimal to hexadecimal 
            a = Long.toHexString(t_a); 
            // prepend 0's to maintain length 
            while (a.length() < b.length()) 
                a = "0" + a; 
            return a; 
        } 
  
        // left Circular Shifting bits 
        String leftCircularShift(String input, int numBits) 
        { 
            int n = input.length() * 4; 
            int perm[] = new int[n]; 
            for (int i = 0; i < n - 1; i++) 
                perm[i] = (i + 2); 
            perm[n - 1] = 1; 
            while (numBits-- > 0) 
                input = permutation(perm, input); 
            return input; 
        } 
        public static String[] aftershift = new String[16];
        public static String[] afterperm = new String[16];
        
        // preparing 16 keys for 16 rounds 
        
        public static String[][] answer = new String[16][3];
        public static String pc1;
        String[] getKeys(String key, String type) 
        { 
            String keys[] = new String[16]; 
            
            // first key permutation 
            key = permutation(PC1, key);
            pc1 = key.toUpperCase();
            if (type=="encrypt") {
            	for (int i = 0; i < 16; i++) { 
                	key = leftCircularShift(key.substring(0, 7), shiftBits[i]) 
                        + leftCircularShift(key.substring(7, 14), 
                                              shiftBits[i]); 
                	
                    aftershift[i] = key.toUpperCase();
                    // key permutation 
                    keys[i] = permutation(PC2, key).toUpperCase(); 
                    afterperm[i] = keys[i].toUpperCase();
                } 
            }
            else {
            	for (int i = 0; i < 16; i++) { 
                	key = leftCircularShift(leftCircularShift(key.substring(0, 7)
                             , shiftBits[i]) 
                          + key.substring(7, 14), 
                                              shiftBits[i]); 
                    aftershift[i] = key.toUpperCase();
                    // second key permutation 
                    keys[i] = permutation(PC2, key); 
                    
                    afterperm[i] = keys[i].toUpperCase();
                } 
                int j = 0;
                String temp;
                while (j<8) {
                	temp = keys[j];
                	keys[j] = keys[16-j-1];
                	keys[16-j-1] = temp;
                	j+=1;
                }

            }
            for (int i = 0;i<16;i++) {
            	answer[i][0] = "Key(" + Integer.toString(i+1)+")";
            	answer[i][1] = aftershift[i];
            	answer[i][2] = keys[i];
            }
            

            return keys; 
        
       } 
        // s-box lookup 
        String sBox(String input) 
        { 
            String output = ""; 
            input = hextoBin(input); 
            for (int i = 0; i < 48; i += 6) { 
                String temp = input.substring(i, i + 6); 
                int num = i / 6; 
                int row = Integer.parseInt( 
                    temp.charAt(0) + "" + temp.charAt(5), 2); 
                int col = Integer.parseInt( 
                    temp.substring(1, 5), 2); 
                output += Integer.toHexString( 
                    sbox[num][row][col]); 
            } 
            return output; 
        } 
        public static String [][] rd = new String[16][9];

        String round(String input, String key, int num) 
        { 
            String left = input.substring(0, 8); 
            rd[num][1] = left.toUpperCase();
            String temp = input.substring(8, 16); 
            String right = temp; 
            rd[num][2] = right.toUpperCase();
            // Expansion permutation 
            temp = permutation(EP, temp);
            rd[num][3] = temp.toUpperCase();
            // xor temp and round key 
            temp = xor(temp, key); 
            rd[num][4] = temp.toUpperCase();
            // lookup in s-box table 
            temp = sBox(temp); 
            rd[num][5] = temp.toUpperCase();
            // Permutation 
            temp = permutation(P, temp); 
            rd[num][6] = temp.toUpperCase();
            // xor 
            left = xor(left, temp); 
            rd[num][7] = left.toUpperCase();
            rd[num][8] = (right+left).toUpperCase();
            Integer ints = new Integer(num+1);
            rd[num][0] = "Round "+ ints.toString();
  
            // swapper 
            
            return right + left; 
        } 
        
        public static String after_swap;
        public static String definitive_cipher;
        public static String initial_permutation;
        String encrypt(String plainText, String key) 
        { 
            int i; 
            // get round keys 
            String keys[] = getKeys(key,"encrypt"); 

  
            // initial permutation 
            plainText = permutation(IP, plainText); 
            initial_permutation = plainText.toUpperCase();
            // 16 rounds 
            for (i = 0; i < 16; i++) { 
                plainText = round(plainText, keys[i], i); 
            } 
  
            // 32-bit swap 
            plainText = plainText.substring(8, 16) 
                        + plainText.substring(0, 8); 
            after_swap = plainText.toUpperCase();
            // final permutation 
            plainText = permutation(IP1, plainText); 
            definitive_cipher=plainText.toUpperCase();
            return plainText; 
        } 
        
        
        String decrypt(String plainText, String key) 
        { 
            int i; 
            // get round keys 
            String keys[] = getKeys(key,"encrypt"); 
  
            // initial permutation 
            plainText = permutation(IP, plainText); 
            initial_permutation = plainText.toUpperCase();
            // 16-rounds 
            for (i=15;i>-1;i--) { 
                plainText = round(plainText, keys[i],i); 
            } 
            
  
            // 32-bit swap 
            plainText = plainText.substring(8, 16) 
                        + plainText.substring(0, 8); 
            after_swap = plainText.toUpperCase();
            plainText = permutation(IP1, plainText); 
            definitive_cipher=plainText.toUpperCase();
            return plainText;
        }
    }
    
    /**
     * Creates new form desui
     */
    public desui(java.awt.Frame parent, boolean modal) {
        super(parent, modal);
        initComponents();
        setLocationRelativeTo(null);
        setResizable(false);
        
}
    
    public desui() {
        initComponents();
        this.toFront();
        setLocationRelativeTo(null);
    }
    
    
    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {
    	
        jPanel1 = new javax.swing.JPanel();
        jLabel1 = new javax.swing.JLabel();
        jLabel2 = new javax.swing.JLabel();
        jLabel3 = new javax.swing.JLabel();
        message1 = new javax.swing.JTextField();
        key1 = new javax.swing.JTextField();
        PerfDES = new javax.swing.JButton();
        PerfDec = new javax.swing.JButton();
        reset = new javax.swing.JButton();

        setTitle("DES Algorithm");

        jPanel1.setBackground(new java.awt.Color(51, 51, 51));
        jPanel1.setMaximumSize(new java.awt.Dimension(0, 0));

        jLabel1.setFont(new java.awt.Font("Monospaced", 1, 18)); // NOI18N
        jLabel1.setForeground(new java.awt.Color(51, 255, 0));
        jLabel1.setText("DES ALGORITHM");

        jLabel2.setFont(new java.awt.Font("Monospaced", 1, 15)); // NOI18N
        jLabel2.setForeground(new java.awt.Color(52, 255, 0));
        jLabel2.setText("Enter your 16-digit hexadecimal data block:");
        
        
        message1.setBackground(new java.awt.Color(102, 102, 102));
        message1.setFont(new java.awt.Font("Dialog", 0, 14)); // NOI18N
        message1.setForeground(new java.awt.Color(255, 255, 255));
        message1.setBorder(javax.swing.BorderFactory.createBevelBorder(javax.swing.border.BevelBorder.RAISED));
        message1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                message1ActionPerformed(evt);
            }
        });
        
        
        message1.addKeyListener(new KeyListener() {
        	
            @Override
            public void keyTyped(KeyEvent arg0) {            	
            }

            @Override
            public void keyReleased(KeyEvent arg0) {
            	if (message1.getText().length() == 16) {
            		message1.setBorder(new LineBorder(Color.GREEN, 3));
            	} else {
            		message1.setBorder(new LineBorder(Color.RED, 2));
            	}
            }

            @Override
            public void keyPressed(KeyEvent arg0) {
            }
        });

        jLabel3.setFont(new java.awt.Font("Monospaced", 1, 15)); // NOI18N
        jLabel3.setForeground(new java.awt.Color(52, 255, 0));
        jLabel3.setText("Enter your 16-digit hexadecimal key:");
        

        key1.setBackground(new java.awt.Color(102, 102, 102));
        key1.setFont(new java.awt.Font("Dialog", 0, 14)); // NOI18N
        key1.setForeground(new java.awt.Color(255, 255, 255));
        key1.setBorder(javax.swing.BorderFactory.createBevelBorder(javax.swing.border.BevelBorder.RAISED));
        
        key1.addKeyListener(new KeyListener() {

            @Override
            public void keyTyped(KeyEvent arg0) {            	
            }

            @Override
            public void keyReleased(KeyEvent arg0) {
            	if (key1.getText().length() == 16) {
            		key1.setBorder(new LineBorder(Color.GREEN, 3));
            	} else {
            		key1.setBorder(new LineBorder(Color.RED, 2));
            	}
            }

            @Override
            public void keyPressed(KeyEvent arg0) {
            }
        });
        
        
        PerfDES.setBackground(new java.awt.Color(51, 51, 51));
        PerfDES.setFont(new java.awt.Font("Monospaced", 1, 16)); // NOI18N
        PerfDES.setForeground(new java.awt.Color(52, 255, 0));
        PerfDES.setText("ENCRYPT");
        PerfDES.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
            //	choice = "Encryption";
                PerfDESActionPerformed(evt);
            }
        });
        
        PerfDec.setBackground(new java.awt.Color(51, 51, 51));
        PerfDec.setFont(new java.awt.Font("Monospaced", 1, 16)); // NOI18N
        PerfDec.setForeground(new java.awt.Color(52, 255, 0));
        PerfDec.setText("DECRYPT");
        PerfDec.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
            	//choice = "Decryption";
                PerfDecryption(evt);
            }
        });

        reset.setBackground(new java.awt.Color(51, 51, 51));
        reset.setFont(new java.awt.Font("Monospaced", 1, 16)); // NOI18N
        reset.setForeground(new java.awt.Color(52, 255, 0));
        reset.setText("RESET");
        reset.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                resetActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout jPanel1Layout = new javax.swing.GroupLayout(jPanel1);
        jPanel1.setLayout(jPanel1Layout);
        jPanel1Layout.setHorizontalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(jPanel1Layout.createSequentialGroup()
                        .addGap(45, 45, 45)
                        .addComponent(PerfDES)
                        .addGap(18, 18, 18)
                        .addComponent(PerfDec)
                        .addGap(18, 18, 18)
                        .addComponent(reset, javax.swing.GroupLayout.PREFERRED_SIZE, 103, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addGroup(jPanel1Layout.createSequentialGroup()
                        .addGap(132, 132, 132)
                        .addComponent(jLabel1))
                    .addGroup(jPanel1Layout.createSequentialGroup()
                        .addGap(44, 44, 44)
                        .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                            //.addComponent(key1, javax.swing.GroupLayout.PREFERRED_SIZE, 320, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            	.addComponent(key1, javax.swing.GroupLayout.PREFERRED_SIZE, 350, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addComponent(message1, javax.swing.GroupLayout.PREFERRED_SIZE, 350, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addComponent(jLabel2)
                                .addComponent(jLabel3, javax.swing.GroupLayout.PREFERRED_SIZE, 350, javax.swing.GroupLayout.PREFERRED_SIZE)))))
                .addContainerGap(45, Short.MAX_VALUE))
        );
        jPanel1Layout.setVerticalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addGap(22, 22, 22)
                .addComponent(jLabel1)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addComponent(jLabel2)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addComponent(message1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addComponent(jLabel3)
                .addGap(12, 12, 12)
                .addComponent(key1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(reset, javax.swing.GroupLayout.PREFERRED_SIZE, 44, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(PerfDES, javax.swing.GroupLayout.PREFERRED_SIZE, 44, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(PerfDec, javax.swing.GroupLayout.PREFERRED_SIZE, 44, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addContainerGap(11, Short.MAX_VALUE))
        );

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addComponent(jPanel1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addComponent(jPanel1, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
        );
        pack();
    }// </editor-fold>//GEN-END:initComponents
    public static String ciph;
   // public static String keyy;
   // public static String mess;
    public static String chosen = "";
    private void PerfDESActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_PerfDESActionPerformed
        // TODO add your handling code here:
    	chosen = "encrypt";
        String message = message1.getText();
        String key = key1.getText();
        
        if ((message.length() != 16) | (key.length() != 16)) {
        JOptionPane.showMessageDialog(null, "Invalid input!");
        return;
        }
        
        DES cipher = new DES();
        message = cipher.encrypt(message, key); 
        ciph = message.toUpperCase();

        this.setVisible(false);
        String txt = cipher.getTmp().getText();
        new Output(txt,message1.getText(),key1.getText()).setVisible(true);
        
    }//GEN-LAST:event_PerfDESActionPerformed
    
    
    private void PerfDecryption(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_PerfDESActionPerformed

    	// TODO add your handling code here:
    	chosen = "decrypt";
        String message = message1.getText();
        String key = key1.getText();
        
        if ((message.length() != 16) | (key.length() != 16)) {
        JOptionPane.showMessageDialog(null, "Invalid input!");
        return;
        }
        DES cipher = new DES();
        message = cipher.decrypt(message, key); 
        ciph = message.toUpperCase();

        this.setVisible(false);
        String txt = cipher.getTmp().getText();
        new Output(txt,message1.getText(),key1.getText()).setVisible(true);
        
    }//GEN-LAST:event_PerfDESActionPerformed
    
    
    

    private void message1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_message1ActionPerformed
        // TODO add your handling code here:
        
    }//GEN-LAST:event_message1ActionPerformed

    private void resetActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_resetActionPerformed

        message1.setText("");
        key1.setText("");
        message1.setBorder(javax.swing.BorderFactory.createBevelBorder(javax.swing.border.BevelBorder.RAISED));
        key1.setBorder(javax.swing.BorderFactory.createBevelBorder(javax.swing.border.BevelBorder.RAISED));
        
    }//GEN-LAST:event_resetActionPerformed

    /**
     * @param args the command line arguments
     */
    public static void main(String args[]) {
        /* Set the Nimbus look and feel */
        //<editor-fold defaultstate="collapsed" desc=" Look and feel setting code (optional) ">
        /* If Nimbus (introduced in Java SE 6) is not available, stay with the default look and feel.
         * For details see http://download.oracle.com/javase/tutorial/uiswing/lookandfeel/plaf.html 
         */
        try {
            for (javax.swing.UIManager.LookAndFeelInfo info : javax.swing.UIManager.getInstalledLookAndFeels()) {
                if ("Nimbus".equals(info.getName())) {
                    javax.swing.UIManager.setLookAndFeel(info.getClassName());
                    break;
                }
            }
        } catch (ClassNotFoundException ex) {
            java.util.logging.Logger.getLogger(desui.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(desui.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(desui.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(desui.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>

        /* Create and display the dialog */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                desui dialog = new desui(new javax.swing.JFrame(), true);
                dialog.addWindowListener(new java.awt.event.WindowAdapter() {
                    @Override
                    public void windowClosing(java.awt.event.WindowEvent e) {
                        System.exit(0);
                    }
                });
                dialog.setVisible(true);
            }
        });
    }


	// Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton PerfDES;
    private javax.swing.JButton PerfDec;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JLabel jLabel2;
    private javax.swing.JLabel jLabel3;
    private javax.swing.JPanel jPanel1;
    private javax.swing.JTextField key1;
    private javax.swing.JTextField message1;
    private javax.swing.JButton reset;
    // End of variables declaration//GEN-END:variables
}


