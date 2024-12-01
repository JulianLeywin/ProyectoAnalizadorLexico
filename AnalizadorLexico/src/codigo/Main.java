package codigo;
import java.io.*;


public class Main {
    public static void main(String[] args) {
        try (Reader reader = new FileReader("entrada.txt");
             BufferedWriter writer = new BufferedWriter(new FileWriter("salida.txt"))) {
            
            Lexerclass lexer = new Lexerclass(reader, writer);

            while (!lexer.isEOF()) {
                lexer.yylex();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
