package codigo;

import java.io.File;

public class GeneradorLex {
    public static void main(String[] args) {
        String ruta = "C:/Users/angel/Documents/Proyectos Programacion/NetBeansProjects/AnalizadorLexico/src/codigo/Lexer.flex";
        generarLexer(ruta);
    }
    public static void generarLexer(String ruta){
        File archivo = new File(ruta);
        JFlex.Main.generate(archivo);
        
        /*
        ANADIR ESTE CODIGO AL LEXERCLASS GENERADO
package codigo;
import static codigo.Tokens.*;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.io.Reader;
        */
        
    }
}
