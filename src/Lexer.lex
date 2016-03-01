//import java_cup.runtime.*;

%%
%class Lexer
%unicode
%cup
%line
%column

/*

%{
  private boolean debug_mode;
  public  boolean debug()            { return debug_mode; }
  public  void debug(boolean mode){ debug_mode = mode; }

  private void print_lexeme(int type, Object value){
    if(!debug()){ return; }

    System.out.print("<");
    switch(type){
      case sym.LET:
        System.out.print("LET"); break;
      case sym.EQUAL:
        System.out.print(":="); break;
      case sym.SEMICOL:
        System.out.print(";"); break;
      case sym.PLUS:
        System.out.print("+"); break;
      case sym.MINUS:
        System.out.print("-"); break;
      case sym.MULT:
        System.out.print("*"); break;
      case sym.DIV:
        System.out.print("/"); break;
      case sym.LPAREN:
        System.out.print("("); break;
      case sym.RPAREN:
        System.out.print(")"); break;
      case sym.INTEGER:
        System.out.printf("INT %d", value); break;
      case sym.IDENTIFIER:
        System.out.printf("IDENT %s", value); break;
    }
    System.out.print(">  ");
  }

  
  private Symbol symbol(int type) {
    print_lexeme(type, null);
    return new Symbol(type, yyline, yycolumn);
  }
  private Symbol symbol(int type, Object value) {
    print_lexeme(type, value);
    return new Symbol(type, yyline, yycolumn, value);
  }
  
  
  String string="";
  
%}

*/
 
%{
StringBuilder stringBuilder = new StringBuilder();
String string="";
%}

Whitespace = \r|\n|\r\n|" "|"\t"

Letter = [a-zA-Z]
Digit = [0-9]
IdChar = {Letter} | {Digit} | "_"
Identifier = {Letter}{IdChar}*    // case sensitive?
Integer = -?(0|[1-9]{Digit}*)
Float = -?[0-9]+.[0-9]+
Rational = -?([0-9]+_)?[0-9]+\/[0-9]+
//Numbers = {Integer} | {Float} | {Rational}
Boolean  = [T|F]
Character = "\'"."\'"
//Primitive = {Boolean}|{Integer}|{Rational}|{Float}|{Character}

/*
Dic = 
Seq = 
Top = 
Main = 
In = 
Tdef = 
Fdef = 
Alias =
Void =  
Read = 
Print = 
If = 
Fi = 
While = 
Then = 
Do = 
Od = 
Else = 
Forall = 
Return = 
*/

//multiLineComment = "/#" ({whiteSpace}|{inputCharacter}|{whiteSpace}|{lineTerminator})* "#/"

%x MULTILINECOMMENT 
%x SINGLELINECOMMENT
%x STRING 

%%
<YYINITIAL> {

  "dict"		{ System.out.print(" dictionary ");  /*return symbol(sym.DIC);*/}
  "seq"			{ System.out.print(" sequence ");  /*return symbol(sym.SEQ);*/}
  "top"			{ System.out.print(" top ");  /*return symbol(sym.TOP);*/}
  "main"		{ System.out.print(" main ");  /*return symbol(sym.MAIN);*/}
  "in"			{ System.out.print(" in ");  /*return symbol(sym.IN);*/}
  "tdef"		{ System.out.print(" type_definition ");  /*return symbol(sym.TDEF);*/}
  "fdef"		{ System.out.print(" function_definition ");  /*return symbol(sym.FDEF);*/}
  "alias"		{ System.out.print(" alias ");  /*return symbol(sym.ALIAS);*/}
  "void"		{ System.out.print(" void ");  /*return symbol(sym.VOID);*/}
  "read"		{ System.out.print(" read ");  /*return symbol(sym.READ);*/}
  "print"		{ System.out.print(" print ");  /*return symbol(sym.PRINT);*/}
  "if"		    { System.out.print(" if ");  /*return symbol(sym.IF);*/}
  "fi"		    { System.out.print(" fi ");  /*return symbol(sym.FI);*/}
  "while"		{ System.out.print(" while ");  /*return symbol(sym.WHILE);*/}
  "then"		{ System.out.print(" then ");  /*return symbol(sym.THEN);*/}
  "do"			{ System.out.print(" do ");  /*return symbol(sym.DO);*/}
  "od"		    { System.out.print(" od ");  /*return symbol(sym.OD);*/}
  "else"		{ System.out.print(" else ");  /*return symbol(sym.ELSE);*/}
  "else if"		{ System.out.print(" else if ");  /*return symbol(sym.ELIF);*/}
  "forall"		{ System.out.print(" for_all ");  /*return symbol(sym.FORALL);*/}
  "return"		{ System.out.print(" return ");  /*return symbol(sym.RETURN);*/}
  "int"		    { System.out.print(" int ");  /*return symbol(sym.INT);*/}
  "float"		{ System.out.print(" float ");  /*return symbol(sym.FLOAT);*/}
  "rat" 		{ System.out.print(" rat ");  /*return symbol(sym.RAT);*/}
  "bool"		{ System.out.print(" bool ");  /*return symbol(sym.BOOL);*/}
  "char"		{ System.out.print(" char ");  /*return symbol(sym.CHAR);*/}
  "len"		{ System.out.print(" len ");  /*return symbol(sym.LEN);*/}
  {Integer}     { System.out.print(" Integer "); /*return symbol(sym.Integer, Integer.parseInt(yytext())); */ }
  {Boolean}     { System.out.print(" Boolean "); /*return symbol(sym.Boolean, yytext()); */}
  {Float}       { System.out.print(" Float ");   /*return symbol(sym.Float, Double.parseDouble(yytext()));*/ }
  {Rational}    { System.out.print(" Rational "); /*return symbol(sym.Rational, yytext());*/ }
  {Identifier}  { System.out.print(" Identifier ");   /*return symbol(sym.IDENTIFIER, yytext());*/ }
  {Whitespace}  {         /* do nothing */               										}
  {Character}   { System.out.print(" Character ");    /*return symbol(sym.Character, yytext()); */ } 
  "="           { System.out.print(" = "); /*return symbol(sym.ASSIGN);*/ }
  ";"           { System.out.print(" ; ");  /*return symbol(sym.SEMICOL);*/  }
  "+"           { System.out.print(" + ");  /*return symbol(sym.PLUS); */    }
  "-"           { System.out.print(" - ");  /*return symbol(sym.MINUS);  */   }
  "*"           { System.out.print(" * ");  /*return symbol(sym.MULT); */    }
  "/"           { System.out.print(" / ");  /*return symbol(sym.DIV);    */   }
  "("           { System.out.print(" ( ");  /*return symbol(sym.LPAREN); */  }
  ")"           { System.out.print(" ) ");  /*return symbol(sym.RPAREN);  */  }
  "{"           { System.out.print(" { ");  /*return symbol(sym.LBRACE);  */  }
  "}"           { System.out.print(" } ");  /*return symbol(sym.RBRACE);   */ }
  "^" 			{ System.out.print(" ^ ");  /*return symbol(sym.POW);	*/}
  "&&" 			{ System.out.print(" && "); /*return symbol(sym.LOGAND);*/}
  "||" 			{ System.out.print(" || "); /*return symbol(sym.LOGOR);*/}
  "!" 			{ System.out.print(" ! ");  /*return symbol(sym.NOT);*/}
  "==" 			{ System.out.print(" == "); /*return symbol(sym.EQUAL);*/}
  "!=" 			{ System.out.print(" != "); /*return symbol(sym.NOTEQUAL);*/}
  "<" 			{ System.out.print(" < ");  /*return symbol(sym.LESS);*/}
  "<=" 			{ System.out.print(" <= "); /*return symbol(sym.LESSEQ);*/}
  ">=" 			{ System.out.print(" >= "); /*return symbol(sym.GREATEREQ);*/}
  ">"			{ System.out.print(" > ");  /*return symbol(sym.GREATER);*/}
  ","			{ System.out.print(" , ");  /*return symbol(sym.COMMA);*/}
  "::"			{ System.out.print(" :: ");  /*return symbol(sym.CONCAT);*/}
  "\."			{ System.out.print(" . ");  /*return symbol(sym.DOT);*/}
  "["			{ System.out.print(" [ ");  /*return symbol(sym.LBRCKT);*/}
  "]"			{ System.out.print(" ] ");  /*return symbol(sym.RBRCKT);*/}
  ":"			{ System.out.print(" : ");  /*return symbol(sym.COLON);*/}
  "\""			{ yybegin(STRING);}
  "/#" 			{yybegin(MULTILINECOMMENT);}
  "\#"          {yybegin(SINGLELINECOMMENT);}
  }
  
  <MULTILINECOMMENT> {
  "#/" 			{yybegin(YYINITIAL);}
  .             { /*do nothing*/    }
  }
  
  <SINGLELINECOMMENT> {
  \n 			{yybegin(YYINITIAL);}
  .             { /*do nothing*/    }
  }
  
  <STRING> {
  "\"" 			{ System.out.print( stringBuilder.toString() ); yybegin(YYINITIAL);}
  .             { stringBuilder.append(yytext()); /*return symbol(sym.STRING, yytext()); */    }
  }
  
[^]  {
  System.out.println("file:" + (yyline+1) +
    ":0: Error: Invalid input '" + yytext()+"'");
  System.out.println("I saw a badchar sign!"); 
}

