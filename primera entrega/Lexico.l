%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>
#include <math.h>
#include "y.tab.h"

#define MAX_INTEGER 65535
#define BASE_BINARIA 2
#define BASE_HEXADECIMAL 16
#define MAX_CHARACTERS 100
#define VALOR_MIN_LETRA 10
#define MAX_FLOAT INT_MAX

#define ES_CARACTER_NUMERO(C) 	   ((C>='0' && C<='9')? 1:0)
#define CARACTER_NUM_A_ENTERO(C)   (C-'0')
#define CARACTER_LETRA_A_ENTERO(C) (C<='Z'? (C-'A'):(C-'a'))


FILE *yyin;
FILE *ptTxt;

int yyerror(void);
void informeDeError(char* msg);
int base_a_decimal(char* numero, int longitud, int base);
%}

%option noyywrap
%option yylineno
NUMERO          [0-9]
LETRA           [a-zA-Z]
ESPACIO         [" "]
CARACTERCOM		@|\(|\)|\<|\>|\]|\[|\=|\?|\"|\.|\,|\+|\t|\n|\/|\_|\:|\;|¿|\*|{LETRA}|{NUMERO}|{ESPACIO} 
COMENTARIO_C_T  ("*")(\/)({CARACTERCOM})*(("*")(\/)({CARACTERCOM})*(\/)("*"))?({CARACTERCOM})*(\/)("*")
OP_AND          "&&"
OP_OR           "||"
WHITESPACES     [ \t\r\v\f]
BREAK_LINE      [\n]
COMA_T          ","
DOT_COM_T       ";"
CONST_REAL      {NUMERO}+"."{NUMERO}+|{NUMERO}+"."|"."{NUMERO}+
CONST_INT       {NUMERO}+
CONST_INT_BIN	"0b"([0-1])+
CONST_INT_HEXA  "0x"([0-9]|[a-f]|[A-F])+
COMILLA_D       ["]
COMILLA_D_2_A   [“]
COMILLA_D_2_C   [”]
CONST_STRING    ({COMILLA_D}|{COMILLA_D_2_A}|{COMILLA_D_2_C}){1}(.)*({COMILLA_D}|{COMILLA_D_2_A}|{COMILLA_D_2_C}){1}
AS_T            "AS"|"As"|"as"
INT_T           "INT"|"int"|"Int"|"Integer"|"INTEGER"|"integer"
REAL_T          "REAL"|"Real"|"real"
STRING_T        "STRING"|"String"|"string"
DIM_T           "DIM"|"Dim"|"dim"
WHILE_T         "while"|"WHILE"|"While"
ENDWHILE_T      "endwhile"|"ENDWHILE"|"EndWhile"|"Endwhile"
DO_T            "do"|"DO"|"Do"
IN_T            "IN"|"In"|"in"
IF_T            "IF"|"If"|"if"
ELSE_T          "else"|"ELSE"|"Else"
ENDIF_T         "endif"|"ENDIF"|"EndIf"
GET_T           "GET"|"Get"|"get"
DISPLAY_T       "DISPLAY"|"Display"|"display"
CORCHETE_A      "["
CORCHETE_C      "]"
PARENT_A        "("
PARENT_C        ")"
OP_ASIG_T       ":="|"="
OP_SUM_T        "+"
OP_REST_T       "-"
OP_MEN          "<"
OP_MAY          ">"
OP_COMP         "=="
OP_MULT_T       "*"
OP_DIV_T        "/"
OP_NOT          "!"
LONGITUD_T      "LONG"|"long"|"Long"
OP_MEN_IGU      {OP_MEN}{OP_ASIG_T}
OP_MAY_IGU      {OP_MAY}{OP_ASIG_T}
VARIABLE        {LETRA}({LETRA}|{NUMERO}|"_")*

%%

{DIM_T}                     {return DIM_T;}    
{AS_T}                      {return AS_T;}        
{IF_T}                      {return IF_T;}        
{ELSE_T}                    {return ELSE_T;}      
{ENDIF_T}                   {return ENDIF_T;} 
{WHILE_T}                   {return WHILE_T;}     
{DO_T}                      {return DO_T;}        
{IN_T}                      {return IN_T;}        
{ENDWHILE_T}                {return ENDWHILE_T;}  
{REAL_T}                    {return REAL_T;}      
{INT_T}                     {return INT_T;}    
{LONGITUD_T}                {return LONGITUD_T;}    
{GET_T}                     {return GET_T;}       
{DISPLAY_T}                 {return DISPLAY_T;}   
{CORCHETE_A}                {return CORCHETE_A;}  
{CORCHETE_C}                {return CORCHETE_C;}  
{STRING_T}                  {return STRING_T;}    
{COMENTARIO_C_T}            {;}
{CONST_STRING}              {
                                if(strlen(yytext) > MAX_CHARACTERS){
                                    informeDeError("STRING SUPERA EL MAXIMO DE CARACTERES PERMITIDO");
                                } else {
                                   yylval.strVal = strdup(yytext);
                                    return CONST_STRING;
                                }

                            }

{CONST_INT}                 {   
                                int value = atoi(strdup(yytext));
                                if( value > MAX_INTEGER ) {
                                    informeDeError("NUMERO SUPERA EL MAXIMO PERMITIDO");
                                } else {
                                    yylval.strVal = strdup(yytext);
                                    return CONST_INT;
                                }
                            } 


{CONST_INT_BIN}				{   
                                int value = base_a_decimal(yytext+2,strlen(yytext+2),BASE_BINARIA);
                                if( value > MAX_INTEGER ) {
                                    informeDeError("NUMERO SUPERA EL MAXIMO PERMITIDO");
                                } else {
                                    yylval.strVal = strdup(yytext);
                                    return CONST_INT_BIN;
                                }
                            }
					
{CONST_INT_HEXA}				{   
                                int value = base_a_decimal(yytext+2,strlen(yytext+2),BASE_HEXADECIMAL);
                                if( value > MAX_INTEGER ) {
                                    informeDeError("NUMERO SUPERA EL MAXIMO PERMITIDO");
                                } else {
                                    yylval.strVal = strdup(yytext);
                                    return CONST_INT_HEXA;
                                }
                            }
					

{CONST_REAL}                 {  
                                float value = atof(strdup(yytext));
                                if( value > MAX_FLOAT ) {
                                    informeDeError("NUMERO SUPERA EL MAXIMO PERMITIDO");
                                } else {
                                    yylval.strVal = strdup(yytext);
                                    return CONST_REAL;
                                }
                            }   
    
{VARIABLE}                  {yylval.strVal = strdup(yytext); return VARIABLE;}    
{OP_ASIG_T}                 {yylval.strVal = strdup(yytext); return OP_ASIG_T;}   
{OP_SUM_T}                  {yylval.strVal = strdup(yytext); return OP_SUM_T;}    
{OP_REST_T}                 {yylval.strVal = strdup(yytext); return OP_REST_T;}   
{OP_MULT_T}                 {yylval.strVal = strdup(yytext); return OP_MULT_T;}   
{OP_DIV_T}                  {yylval.strVal = strdup(yytext); return OP_DIV_T;}    
{OP_MEN}                    {return OP_MEN;}      
{OP_MAY}                    {return OP_MAY;}      
{OP_MEN_IGU}                {return OP_MEN_IGU;}  
{OP_MAY_IGU}                {return OP_MAY_IGU;}      
{OP_AND}                    {return OP_AND;}      
{OP_OR}                     {return OP_OR;}            
{OP_COMP}                   {return OP_COMP;}
{OP_NOT}                    {return OP_NOT;} 
{COMA_T}                    {return COMA_T;}      
{DOT_COM_T}                 {return DOT_COM_T;}   
{PARENT_A}                  {return PARENT_A;}    
{PARENT_C}                  {return PARENT_C;}    
{WHITESPACES}               {;} 
{BREAK_LINE}                {;}  
.                           {informeDeError("CARACTER NO RECONOCIDO");} 

%%


void informeDeError(char* msg)
{
    printf("%s - EN LA LINEA %d\n", msg, yylineno); 
    system("Pause");
    exit(1);
}

int yyerror(void){

	printf("ERROR SINTACTICO EN LA LINEA: %d\n", yylineno);
	system("Pause");
	exit(1);
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