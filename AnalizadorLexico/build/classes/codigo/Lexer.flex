import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.io.Reader;

%%
%public
%class Lexerclass
%unicode
%standalone

%{
private BufferedWriter writer;
private int lineNumber = 1; 
private int columnNumber = 1; 
private int tokenLength = 0; 
int cont=0;
public boolean isEOF(){
    return zzAtEOF;
}

public Lexerclass(Reader in, BufferedWriter writer) {
    this.zzReader = in;
    this.writer = writer;
}

private void escribeToken(String lexema, String token) {

    try {
        writer.write(cont+": ("+lexema + ") - " + token + "\n");
        cont++;
    } catch (IOException e) {
        e.printStackTrace();
    }
}

private void reportError(String lexema, String message) {
    try {
        writer.write(String.format(cont+": ERROR: Line %d, Column %d: %s '%s' detected.\n",
            lineNumber, columnNumber, message, lexema));
cont++;
    } catch (IOException e) {
        e.printStackTrace();
    }
}

%}

DIGITO=[0-9]
LETRA=[a-zA-Z]
ALFANUMERICO=({LETRA}|{DIGITO})+
IDENTIFICADOR={LETRA}{ALFANUMERICO}*
NUMERO={DIGITO}+(\.{DIGITO}+)?  
ESPACIO=[ \t\r]+
LINEA="\n"
ERROR=[^a-zA-Z0-9 ' =.,<>/*-+:() \t\r\n]
PALABRAS_RESERVADAS="select"|"from"|"where"|"insert"|"update"|"delete"|"join"|"create"|"drop"|"alter"|"table"|"int"|"varchar"|"float"|"boolean"

%%

<YYINITIAL>{
    {PALABRAS_RESERVADAS}    { escribeToken(yytext(), "PALABRA_RESERVADA"); columnNumber += yylength(); }
    
    {IDENTIFICADOR}          { escribeToken(yytext(), "IDENTIFICADOR"); columnNumber += yylength(); }
    
    {NUMERO}                 { escribeToken(yytext(), "NUMERO"); columnNumber += yylength(); }
    
    "="                      { escribeToken(yytext(), "OPERADOR_ASIGNACION"); columnNumber += yylength(); }
    "'"                      { escribeToken(yytext(), "DELIMITADOR"); columnNumber += yylength(); }
    "."                      { escribeToken(yytext(), "DELIMITADOR"); columnNumber += yylength(); }
    "("                      { escribeToken(yytext(), "PAR_IZQUIERDO"); columnNumber += yylength(); }
    ")"                      { escribeToken(yytext(), "PAR_DERECHO"); columnNumber += yylength(); }
    ";"                      { escribeToken(yytext(), "FIN_SENTENCIA"); columnNumber += yylength(); }
    "+"                      { escribeToken(yytext(), "OPERADOR_ARITMETICO"); columnNumber += yylength(); }
    "-"                      { escribeToken(yytext(), "OPERADOR_ARITMETICO"); columnNumber += yylength(); }
    "*"                      { escribeToken(yytext(), "OPERADOR_ARITMETICO"); columnNumber += yylength(); }
    "/"                      { escribeToken(yytext(), "OPERADOR_ARITMETICO"); columnNumber += yylength(); }
    "<"                      { escribeToken(yytext(), "OPERADOR_RELACIONAL"); columnNumber += yylength(); }
    ">"                      { escribeToken(yytext(), "OPERADOR_RELACIONAL"); columnNumber += yylength(); }
    
    {ESPACIO}                { columnNumber += yylength(); /* Ignorar espacios */ }
    {LINEA}                  { lineNumber++; columnNumber = 1; }
    
    {ERROR}                  { reportError(yytext(), "Unknown symbol"); columnNumber += yylength(); }
    
    {NUMERO}{LETRA}*         { reportError(yytext(), "Invalid identifier"); columnNumber += yylength(); }
    {ERROR}{LETRA}*           { reportError(yytext(), "Invalid identifier"); columnNumber += yylength(); }
    {ERROR}{NUMERO}*         { reportError(yytext(), "Invalid identifier"); columnNumber += yylength(); }

}
