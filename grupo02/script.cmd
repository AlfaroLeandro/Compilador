flex Lexico.l
bison Sintactico.y
bison -dyv Sintactico.y
pause
gcc lex.yy.c y.tab.c -o Tercera
pause
Tercera  prueba.txt