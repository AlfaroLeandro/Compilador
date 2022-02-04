%{
#include "lista.h"
#include "y.tab.h"
#define COND_AND 2
#define COND_OR 1
#define COND_NORMAL 0
#define TIPO_FLOAT "FLOAT"
#define TIPO_STRING "STRING"
#define TIPO_INTEGER "INTEGER"

FILE *yyin;

tList symbolTable;
tStack stackDataTypeDecVar;
tStack invertStackDataType;
tStack stackVar;

extern int yylex();
extern void yyerror();
extern char* yytext;
extern int yylineno;

int verifyVariable( char *dato , tList *symb);
%}

%union{
    char* strVal;
}

%token DIM_T
%token WHILE_T
%token IN_T
%token ENDWHILE_T
%token DO_T
%token IF_T
%token ELSE_T
%token ENDIF_T
%token INT_T         
%token REAL_T       
%token STRING_T      
%token GET_T        
%token DISPLAY_T    
%token AS_T       
%token WHITESPACES  
%token BREAK_LINE   
%token CORCHETE_A 
%token CORCHETE_C   
%token COMA_T      
%token DOT_COM_T 
%token PARENT_A    
%token PARENT_C     
%token OP_MEN      
%token OP_MAY       
%token OP_MEN_IGU  
%token OP_MAY_IGU      
%token OP_AND      
%token OP_OR    
%token OP_COMP
%token OP_NOT   
%token LONGITUD_T
%token <strVal> CONST_INT
%token <strVal> CONST_INT_BIN
%token <strVal> CONST_INT_HEXA
%token <strVal> CONST_REAL
%token <strVal> VARIABLE    
%token <strVal> CONST_STRING 
%token <strVal> OP_ASIG_T 
%token <strVal> OP_REST_T 
%token <strVal> OP_SUM_T  
%token <strVal> OP_MULT_T   
%token <strVal> OP_DIV_T  
%token COMENTARIO_A_T
%token COMENTARIO_B_T
%token COMENTARIO_C_T
%token .

%left  OP_REST_T OP_SUM_T
%right OP_MULT_T OP_DIV_T
%right MENOS_UNARIO
%right OP_ASIG_T   

%%

programa:   prog             {printf("\n Regla --> prog \n");}
        ;

prog: sentencia                 {printf("\n Regla --> sentencia \n");}
  ;

sentencia: sentencia grammar DOT_COM_T  {printf("\n Regla --> sentencia grammar DOT_COM_T	\n");}
        | grammar DOT_COM_T             {printf("\n Regla --> grammar DOT_COM_T	\n");}
        ;

grammar:   dec_var                    {printf("\n Regla --> dec_var \n");}
       |   asig                       {printf("\n Regla --> asig \n");}
       |   display                    {printf("\n Regla --> display \n");}
       |   get                        {printf("\n Regla --> get \n");}
       |   while                      {printf("\n Regla --> while \n");}
       |   if                         {printf("\n Regla --> if \n");}
       ;

asig: variable OP_ASIG_T expr {
                                  printf("\n Regla --> variable OP_ASIG_T exp \n");
                              }
    | variable OP_ASIG_T const_string_r   {
                                              printf("\n Regla --> variable OP_ASIG_T const_string_r \n");
                                              }
    ;

variable: VARIABLE {  
                      if( (verifyVariable($1, &symbolTable)) != 0) {
                        printf("\n La variable %s no se declaro \n",$1);
                        exit(1);
                      }
                    }
                    ;

const_string_r: CONST_STRING {
		insertString(&symbolTable, $1);
		printf("\n Regla --> CONST_STRING \n");
	};

NUMERO: CONST_INT{
        insertNumber(&symbolTable,$1,TIPO_INTEGER);
        printf("\n Regla --> CONST_INT \n");
      }    
      | CONST_REAL {
        insertNumber(&symbolTable,$1,TIPO_FLOAT);
        printf("\n Regla --> CONST_REAL \n");
      }
      ;

///////////// ARITMETICA /////////////
        
expr: expr OP_SUM_T termino         {
                                    printf("\n Regla --> expr OP_SUM_T termino \n");
                                    }
	|   expr OP_REST_T termino        {
                                    printf("\n Regla --> expr OP_SUM_T termino \n");
                                    } 
	|   termino                       {printf("\n Regla --> termino \n");}
  ;

termino: termino OP_MULT_T factor     {
                                        printf("\n Regla --> termino OP_MULT_T factor \n");
                                      }
	   |   termino OP_DIV_T factor      {
                                       printf("\n Regla --> termino OP_MULT_T factor \n");
                                       }
       |   '-' termino %prec MENOS_UNARIO    {printf("\n '-' termino '%'prec MENOS_UNARIO \n");}
	   |   factor                       {printf("\n Regla --> factor \n");}
     ;

                    
factor: PARENT_A expr PARENT_C    {printf("\n Regla --> PARENT_A expr PARENT_C  \n");}
       | NUMERO                    {printf("\n Regla --> NUMERO  \n");}
	   | VARIABLE                  {
                                  printf("\n Regla --> VARIABLE  \n");
                                  }
      ;

///////// ENTRADA Y SALIDA ///////////////

display: DISPLAY_T const_string_r   {
                                    printf("\n Regla -->  DISPLAY_T const_string_r  \n");
                                    }
       | DISPLAY_T expr             {
                                    printf("\n Regla -->  DISPLAY_T expr   \n");
                                    }
       ;

get: GET_T VARIABLE {
                    printf("\n Regla -->  GET_T VARIABLE \n");
                    }
                    ;

///////// ESTRUCTURAS DE CONTROL ///////////

while: init_while cond_completa sentencia ENDWHILE_T {
                          printf("\n Regla -->  init_while cond_completa sentencia ENDWHILE_T \n");
                        }
						;
						
init_while: WHILE_T {
					printf("\n Regla -->  WHILE_T \n");
                }
                ;

if: condicion_if ELSE_T sentencia ENDIF_T {
      printf("\n Regla --> condicion_if ELSE_T sentencia ENDIF_T  \n");
    }
    | condicion_if ENDIF_T {
      printf("\n Regla --> condicion_if ENDIF_T \n");
    }
    ;

condicion_if: sentencia_if cond_completa sentencia {
		printf("\n Regla --> sentencia_if cond_completa sentencia  \n");
	}
    ;

sentencia_if: IF_T {
            printf("\n Regla --> IF_T \n");
            }
            ;

cond_completa: PARENT_A cond_tipo_1 cond_completa PARENT_C  {printf("\n Regla --> PARENT_A cond_tipo_1 cond_completa PARENT_C \n");}
             | PARENT_A cond_tipo_3 cond_completa PARENT_C  {printf("\n Regla --> PARENT_A cond_tipo_3 cond_completa PARENT_C \n");}
             | PARENT_A cond_tipo_1 cond PARENT_C           {printf("\n Regla --> PARENT_A cond_tipo_1 cond PARENT_C \n");}
             | PARENT_A cond_tipo_2 cond_completa PARENT_C  {printf("\n Regla --> PARENT_A cond_tipo_2 cond_completa PARENT_C \n");}
             | PARENT_A cond_tipo_4 cond_completa PARENT_C  {printf("\n Regla --> PARENT_A cond_tipo_4 cond_completa PARENT_C \n");}
             | PARENT_A cond_tipo_2 cond PARENT_C           {printf("\n Regla --> PARENT_A cond_tipo_2 cond PARENT_C  \n");}
             | PARENT_A cond_tipo_3 cond PARENT_C           {printf("\n Regla --> PARENT_A cond_tipo_3 cond PARENT_C  \n");}
             | PARENT_A cond_tipo_4 cond PARENT_C           {printf("\n Regla --> PARENT_A cond_tipo_4 cond PARENT_C  \n");}
             | PARENT_A cond PARENT_C                       {printf("\n Regla --> PARENT_A cond PARENT_C   \n");}
             | OP_NOT cond_completa                         {printf("\n Regla --> OP_NOT cond_completa   \n");}
             | PARENT_A cond_completa PARENT_C              {printf("\n Regla --> PARENT_A cond_completa PARENT_C    \n");}             
             ;

cond_tipo_1: cond_completa OP_AND {
      printf("\n Regla -->  cond_completa OP_AND  \n");
      }
      ;

cond_tipo_2: cond_completa OP_OR {
      printf("\n Regla -->   cond_completa OP_OR  \n");
     }
     ;

cond_tipo_3: cond OP_AND {
      printf("\n Regla -->  cond OP_AND  \n");
      }
      ;

cond_tipo_4: cond OP_OR {
      printf("\n Regla -->  cond OP_OR   \n");
      }
      ;


cond: expr OP_COMP expr    {
      printf("\n Regla --> expr OP_COMP expr   \n");
    }
    | expr OP_MAY_IGU expr {
      printf("\n Regla --> expr OP_MAY_IGU expr   \n");
    }
    | expr OP_MEN_IGU expr {
      printf("\n Regla --> expr OP_MEN_IGU expr   \n");
    }
    | expr OP_MEN expr     {
      printf("\n Regla --> expr OP_MEN expr   \n");
    }
    | expr OP_MAY expr     {
      printf("\n Regla --> expr OP_MAY expr   \n");
    }
    ;

////////// DECLARACION DE VARIABLES //////////

dec_var: DIM_T OP_MEN dupla_asig OP_MAY {
	                                    char dataType[100];
                                        char variable[100];
                                        while(!emptyStack(&stackDataTypeDecVar)){
                                          popStack(&stackDataTypeDecVar,dataType);
                                          pushStack(&invertStackDataType,dataType);
                                        }
                                        while(!emptyStack(&invertStackDataType) && !emptyStack(&stackVar)){
                                            popStack(&invertStackDataType,dataType);
                                            popStack(&stackVar,variable);
                                            insertVariable(&symbolTable,variable,dataType);
                                        }
                                         printf("\n Regla --> DIM_T OP_MEN dupla_asig OP_MAY  \n");
};


dupla_asig:  vasAsig COMA_T dupla_asig COMA_T tipo             {
                                                                printf("\n Regla --> VARIABLE COMA_T dupla_asig COMA_T tipo   \n");
                                                                }
          |  vasAsig OP_MAY AS_T OP_MEN tipo                   {
                                                                printf("\n Regla -->  VARIABLE OP_MAY AS_T OP_MEN tipo   \n");
                                                                }
          ;

vasAsig: VARIABLE { 
                    if( (verifyVariable($1, &symbolTable)) == 1) {
                      pushStack(&stackVar,$1);
                    } else {
                      printf("\n La variable %s ya fue declarada anteriormente \n", $1);
                      exit(1);
                    }
        }
        ;
 
tipo: 	INT_T 	    {pushStack(&stackDataTypeDecVar,"INTEGER");
                    printf("\n Regla -->  INT_T   \n");
                    }
      | REAL_T      {pushStack(&stackDataTypeDecVar,"FLOAT");
                    printf("\n Regla -->  REAL_T   \n");
                    }	
      | STRING_T  	{pushStack(&stackDataTypeDecVar,"STRING");
                    printf("\n Regla -->  STRING_T   \n");
                    }
      ;

%%


int main(int argc, char* argv[])
{
    if((yyin = fopen(argv[1],"rt")) == NULL)
    {
        printf("\n No se puede abrir el archivo %s \n", argv[1]);
    }

    printf("\n Comienzo de la compilacion \n\n");

    createList(&symbolTable);
    createStack(&stackVar);
    createStack(&stackDataTypeDecVar);
    createStack(&invertStackDataType);
	

    yyparse();

    deleteTable(&symbolTable);
    
    printf("\n Compilacion exitosa \n");
    fclose(yyin);
    return 0;
}

int verifyVariable( char *dato , tList *symb){

    while(*symb) {
      if(strcmp((*symb)->name, dato)==0)
        return 0;
      symb = &(*symb)->next;
    }

    return 1;
}