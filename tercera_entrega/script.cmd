flex Lexico.l
bison Sintactico.y
bison -dyv Sintactico.y
pause
gcc lex.yy.c y.tab.c -o Grupo14
pause
Grupo14  prueba.txt