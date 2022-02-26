%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>
#include <math.h>
#include "y.tab.h"

#define MAX_VALUE_STRING 32
#define MAX_CHARACTERS_INT_REAL 30
#define MAX_VALUE_INTEGER 65535
#define MAX_VALUE_FLOAT INT_MAX

#define BASE_BINARIA 2
#define BASE_HEXADECIMAL 16
#define VALOR_MIN_LETRA 10

#define ES_CARACTER_NUMERO(C) 	   ((C>='0' && C<='9')? 1:0)
#define CARACTER_NUM_A_ENTERO(C)   (C-'0')
#define CARACTER_LETRA_A_ENTERO(C) (C<='Z'? (C-'A'):(C-'a'))

int base_a_decimal(char* numero, int longitud, int base);
int detectar_base_devolver_valor(char* numero);

FILE *yyin;
FILE *archSal;

int errorLexico(void);
void yyerror(char* mensaje);
%}

%option noyywrap
%option yylineno


/* Palabras reservadas */

WHILE_T			"while"|"WHILE"|"While"
ENDWHILE		"ENDWHILE"|"Endwhile"|"EndWhile"|"endwhile"
DISPLAY			"DISPLAY"|"Display"|"display"
GET				"GET"|"Get"|"get"
READ_T			"read"|"READ"
FLOAT_T			"Float"|"float"|"FLOAT"
INT_T		    "Int"|"int"|"INT"|"Integer"|"INTEGER"|"integer"
CHAR            "Char"|"char"|"CHAR"
STRING          "STRING"|"String"|"string"
IN_T 			"in"|"In"|"IN"
DO_T 			"do"|"Do"|"DO"
OP_AVG			"avg"|"AVG"
ELSE_T			"else"|"ELSE"|"Else"
IF_T			"if"|"IF"|"If"
ENDIF			"ENDIF"|"endif"|"Endif"
DIM				"DIM"|"Dim"|"dim"


/* Saltos de linea, espacios, definiciones de exp reg */

whitespace      [ \t\r\v\f]
linefeed        [\n]
DIGITO 			[0-9]
LETRA			[a-zA-Z]
COMILLA_D		["]
COMILLA_A		[“]
COMILLA_C		[”]



CONST_INT 		{DIGITO}+|"0b"([0-1])+|"0x"([0-9]|[a-f]|[A-F])+
CONST_FLOAT 	{DIGITO}+"."{DIGITO}+
CONST_STRING	({COMILLA_A}|{COMILLA_D}|{COMILLA_C}){1}(.)*({COMILLA_A}|{COMILLA_D}|{COMILLA_C}){1}
ID_T			{LETRA}({LETRA}|{DIGITO}|"_")*

/* Operadores */

OP_DISTINTO	 	"!""="
OP_IGUAL		"=""="
OP_MAYORIGUAL	">""="
OP_MAYOR		">"
OP_MENOR		"<"
OP_MENORIGUAL	"<""="
OP_ASIG			":="|"="
OP_DIVISION		"/"
OP_SUM			"+"
OP_MUL			"*"
OP_MENOS		"-"
OR_T			"OR"|"||"
AND_T			"AND"|"&&"
NOT_T 			"!"
AS              "AS"|"As"|"as"



/* Comentarios */

COMENTARIO_A    "*""/"
COMENTARIO_C	"/""*"
COMENTARIO      {COMENTARIO_A}(.)*{COMENTARIO_C}


/* Llaves, parentensis, etc */

LLAVE_C			"}"
LLAVE_A			"{"
PARENT_C		")"
PARENT_A		"("
COMA			","
SEP_LINEA		";"



%%		
{DIM}				 {return DIM;printf("%s", yytext);}
{ELSE_T}			 {return ELSE_T;printf("%s", yytext);}
{IF_T}				 {return IF_T;printf("%s", yytext);}
{ENDIF}				 {return ENDIF;printf("%s", yytext);}
{IN_T}				 {return IN_T;printf("%s", yytext);}
{DO_T}				 {return DO_T;printf("%s", yytext);}
{WHILE_T}			 {return WHILE_T;printf("%s", yytext);}
{ENDWHILE}			 {return ENDWHILE;printf("%s", yytext);}
{DISPLAY}			 {return DISPLAY;printf("%s", yytext);}
{GET}				 {return GET;printf("%s", yytext);}
{READ_T}			 {return READ_T;printf("%s", yytext);}
{FLOAT_T}			 {return FLOAT_T;printf("%s", yytext);}
{INT_T}			     {return INT_T;printf("%s", yytext);}
{CHAR} 			     {return CHAR;printf("%s", yytext);} 
{AS}                 {return AS;printf("%s", yytext);}
{STRING}             {return STRING;printf("%s", yytext);}

{COMENTARIO}		{;printf("%s", yytext);}
{COMENTARIO_A}		{;printf("%s", yytext);}		
{COMENTARIO_C}		{printf("%s", yytext);;}





{CONST_STRING}		{
                    if(strlen(yytext) > MAX_VALUE_STRING)
                        {
							printf("%s", yytext);
                         yyerror("STRING TOO LONG (MAX VALUE: 30)"); 
                        }
                    else
                        {
                            yylval.strVal = strdup(yytext);
                            return CONST_STRING;
                        }
                    }

{CONST_INT}			{
						printf("%s", yytext);
						
						if(strlen(yytext) > MAX_CHARACTERS_INT_REAL){
							yyerror("CONSTANTE ENTERA SUPERA EL MAXIMO DE CARACTERES PERMITIDO");
						}
						int value = detectar_base_devolver_valor(yytext);
						
						if( value > MAX_VALUE_INTEGER ) {
							yyerror("NUMERO SUPERA EL MAXIMO PERMITIDO");
						} else if (value < 0) {
							yyerror("NUMERO POR DEBAJO DEL MINIMO PERMITIDO");
						} else {
							yylval.strVal = strdup(yytext);
							return CONST_INT;
						}
                    }	

{CONST_FLOAT}	    {
	printf("%s", yytext);
                    float num = atof(strdup(yytext));
                        if(num > MAX_VALUE_FLOAT) //MAX_VALUE_FLOAT = 2147483648, máximo valor de un número de 32 bits con signo.
                        {
                            yyerror("FLOAT TOO LONG - (MAX VALUE: 2.147.483.648)");
                        }
                    else
                        {
                            yylval.strVal = strdup(yytext);
                            return CONST_FLOAT;
                        }
                    }
					
{ID_T}				{yylval.strVal = strdup(yytext); return ID_T;}


{OP_DISTINTO}		{return OP_DISTINTO;printf("%s", yytext);}
{OP_IGUAL}			{return OP_IGUAL;printf("%s", yytext);}
{OP_MAYORIGUAL}		{return OP_MAYORIGUAL;printf("%s", yytext);}
{OP_MAYOR}			{return OP_MAYOR;printf("%s", yytext);}
{OP_MENOR}			{return OP_MENOR;printf("%s", yytext);}
{OP_MENORIGUAL}		{return OP_MENORIGUAL;printf("%s", yytext);}
{OP_DIVISION}		{return OP_DIVISION;printf("%s", yytext);}
{OP_SUM}			{return OP_SUM;printf("%s", yytext);}
{OP_MENOS}			{return OP_MENOS ;printf("%s", yytext);}
{OP_AVG}			{return OP_AVG;printf("%s", yytext);}
{OP_MUL}			{return OP_MUL;printf("%s", yytext);}
{OP_ASIG}			{return OP_ASIG;printf("%s", yytext);}
{AND_T}				{return AND_T;printf("%s", yytext);}
{OR_T}				{return OR_T;printf("%s", yytext);}
{NOT_T}				{return NOT_T;printf("%s", yytext);}


{LLAVE_C}			{return LLAVE_C;printf("%s", yytext);}
{LLAVE_A}			{return LLAVE_A;printf("%s", yytext);}
{PARENT_C}			{return PARENT_C;printf("%s", yytext);}
{PARENT_A}			{return PARENT_A;printf("%s", yytext);}
{COMA}				{return COMA;printf("%s", yytext);}
{SEP_LINEA}			{return SEP_LINEA;printf("%s", yytext);}
{linefeed}			{printf("%s", yytext);;} // linefeed = \n
{whitespace}		{printf("%s", yytext);;}
" "
.					{tokenInvalido();}

%%


void yyerror(char* mensajeError)
{
	printf("%s aosugdiasgdliasgdlhv", mensajeError);
    printf("ERROR - %s - ON LINE %d\n", mensajeError, yylineno); //yylineno = va contando las lineas, por lo que informa la linea del error
    system("Pause");
    exit(1);
}

int tokenInvalido(void){
	printf("ERROR - \"%s\" INVALID TOKEN ON LINE %d\n", yytext, yylineno);
	system("Pause");
	exit(1);
}

int detectar_base_devolver_valor(char* numero)
{
	int value;
	
	if(strlen(numero)>1) //PREGUNTO SI ES UN NUMERO DE UN SOLO CARACTER
	{
		if(*(numero + 1) == 'x')
			value = base_a_decimal(numero+2,strlen(numero+2),BASE_HEXADECIMAL);
		else if(*(numero + 1) == 'b')
			value = base_a_decimal(numero+2,strlen(numero+2),BASE_BINARIA);
		else
			value = atoi(strdup(numero));
	}
	else
		value = atoi(strdup(numero));
	
	return value;
}

int base_a_decimal(char* numero, int longitud, int base)
{
	int i,
		numero_decimal = 0;
	for(i = 0; i<=longitud-1; i++)
	{
		if(ES_CARACTER_NUMERO(*numero))
			numero_decimal += CARACTER_NUM_A_ENTERO(*numero)*pow((double)base, (double)(longitud-1-i));
		else
			numero_decimal += (CARACTER_LETRA_A_ENTERO(*numero)+VALOR_MIN_LETRA)*pow((double)base, (double)(longitud-1-i));
		numero++;
	}
	
	return numero_decimal;
}