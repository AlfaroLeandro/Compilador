flex Lexico.l
bison -dyv Sintactico.y
gcc miscelaneo.c lex.yy.c y.tab.c -o Primera.exe
pause