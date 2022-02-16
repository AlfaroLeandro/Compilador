flex Lexico.l
bison Sintactico.y
bison -dyv Sintactico.y
gcc miscelaneo.c lex.yy.c y.tab.c -o Segunda
pause
Segunda  prueba.txt
pause