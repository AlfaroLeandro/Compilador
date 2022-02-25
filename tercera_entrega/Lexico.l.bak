%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>
#include <math.h>
#include "miscelaneo.h"
#include "y.tab.h"

#define MAX_CHARACTERS 32
#define MAX_CHARACTERS_INT_REAL 30
#define MAX_VALUE_STRING 30
#define MAX_VALUE_INTEGER 65535
#define MAX_VALUE_FLOAT INT_MAX

FILE *yyin;
FILE *archSal;

int tokenInvalido(void);
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
FLOAT_T			"Float"|"float"|"FLOAT"|"real"|"REAL"|"Real"
INT_T		    "Int"|"int"|"INT"|"Integer"|"INTEGER"|"integer"
CHAR            "Char"|"char"|"CHAR"
STRING          "STRING"|"String"|"string"
IN_T 			"in"|"In"|"IN"
DO_T 			"do"|"Do"|"DO"
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
{DIM}				 {return DIM;}
{ELSE_T}			 {return ELSE_T;}
{IF_T}				 {return IF_T;}
{ENDIF}				 {return ENDIF;}
{IN_T}				 {return IN_T;}
{DO_T}				 {return DO_T;}
{WHILE_T}			 {return WHILE_T;}
{ENDWHILE}			 {return ENDWHILE;}
{DISPLAY}			 {return DISPLAY;}
{GET}				 {return GET;}
{READ_T}			 {return READ_T;}
{FLOAT_T}			 {return FLOAT_T;}
{INT_T}			     {return INT_T;}
{CHAR} 			     {return CHAR;} 
{AS}                 {return AS;}
{STRING}             {return STRING;}

{COMENTARIO}		{;}
{COMENTARIO_A}		{;}		
{COMENTARIO_C}		{;}





{CONST_STRING}		{
                    if(strlen(yytext) > MAX_VALUE_STRING)
                        {
                         yyerror("STRING TOO LONG (MAX VALUE: 30)"); 
                        }
                    else
                        {
                            yylval.strVal = strdup(yytext);
                            return CONST_STRING;
                        }
                    }

{CONST_INT}			{
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


{OP_DISTINTO}		{return OP_DISTINTO;}
{OP_IGUAL}			{return OP_IGUAL;}
{OP_MAYORIGUAL}		{return OP_MAYORIGUAL;}
{OP_MAYOR}			{return OP_MAYOR;}
{OP_MENOR}			{return OP_MENOR;}
{OP_MENORIGUAL}		{return OP_MENORIGUAL;}
{OP_DIVISION}		{return OP_DIVISION;}
{OP_SUM}			{return OP_SUM;}
{OP_MENOS}			{return OP_MENOS ;}
{OP_MUL}			{return OP_MUL;}
{OP_ASIG}			{return OP_ASIG;}
{AND_T}				{return AND_T;}
{OR_T}				{return OR_T;}
{NOT_T}				{return NOT_T;}


{LLAVE_C}			{return LLAVE_C;}
{LLAVE_A}			{return LLAVE_A;}
{PARENT_C}			{return PARENT_C;}
{PARENT_A}			{return PARENT_A;}
{COMA}				{return COMA;}
{SEP_LINEA}			{return SEP_LINEA;}
{linefeed}			{;} // linefeed = \n
{whitespace}		{;}
" "
.					{tokenInvalido();}

%%


void yyerror(char* mensajeError)
{
    printf("ERROR - %s - ON LINE %d\n", mensajeError, yylineno); //yylineno = va contando las lineas, por lo que informa la linea del error
    system("Pause");
    exit(1);
}

int tokenInvalido(void){
	printf("ERROR - \"%s\" INVALID TOKEN ON LINE %d\n", yytext, yylineno);
	system("Pause");
	exit(1);
}
