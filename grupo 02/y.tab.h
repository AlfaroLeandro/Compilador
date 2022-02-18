
/* A Bison parser, made by GNU Bison 2.4.1.  */

/* Skeleton interface for Bison's Yacc-like parsers in C
   
      Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.
   
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.
   
   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */


/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     WHILE_T = 258,
     ENDWHILE = 259,
     DISPLAY = 260,
     GET = 261,
     READ_T = 262,
     FLOAT_T = 263,
     INT_T = 264,
     CHAR = 265,
     IN_T = 266,
     DO_T = 267,
     AS = 268,
     STRING = 269,
     whitespace = 270,
     linefeed = 271,
     DIGITO = 272,
     LETRA = 273,
     COMILLA_D = 274,
     COMILLA_A = 275,
     COMILLA_C = 276,
     CONST_INT = 277,
     CONST_FLOAT = 278,
     OP_AVG = 279,
     CONST_STRING = 280,
     ELSE_T = 281,
     IF_T = 282,
     ENDIF = 283,
     DIM = 284,
     ID_T = 285,
     OP_MENOS = 286,
     OP_SUM = 287,
     OP_DIVISION = 288,
     OP_MUL = 289,
     MENOS_UNARIO = 290,
     OP_ASIG = 291,
     OP_DISTINTO = 292,
     OP_IGUAL = 293,
     OP_MAYORIGUAL = 294,
     OP_MAYOR = 295,
     OP_MENOR = 296,
     OP_MENORIGUAL = 297,
     OR_T = 298,
     AND_T = 299,
     NOT_T = 300,
     PARENT_C = 301,
     PARENT_A = 302,
     COMA = 303,
     SEP_LINEA = 304
   };
#endif
/* Tokens.  */
#define WHILE_T 258
#define ENDWHILE 259
#define DISPLAY 260
#define GET 261
#define READ_T 262
#define FLOAT_T 263
#define INT_T 264
#define CHAR 265
#define IN_T 266
#define DO_T 267
#define AS 268
#define STRING 269
#define whitespace 270
#define linefeed 271
#define DIGITO 272
#define LETRA 273
#define COMILLA_D 274
#define COMILLA_A 275
#define COMILLA_C 276
#define CONST_INT 277
#define CONST_FLOAT 278
#define OP_AVG 279
#define CONST_STRING 280
#define ELSE_T 281
#define IF_T 282
#define ENDIF 283
#define DIM 284
#define ID_T 285
#define OP_MENOS 286
#define OP_SUM 287
#define OP_DIVISION 288
#define OP_MUL 289
#define MENOS_UNARIO 290
#define OP_ASIG 291
#define OP_DISTINTO 292
#define OP_IGUAL 293
#define OP_MAYORIGUAL 294
#define OP_MAYOR 295
#define OP_MENOR 296
#define OP_MENORIGUAL 297
#define OR_T 298
#define AND_T 299
#define NOT_T 300
#define PARENT_C 301
#define PARENT_A 302
#define COMA 303
#define SEP_LINEA 304




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{

/* Line 1676 of yacc.c  */
#line 77 "Sintactico.y"

    /* Aca dentro se definen los campos de la variable yylval */
	char* strVal; 



/* Line 1676 of yacc.c  */
#line 157 "y.tab.h"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


