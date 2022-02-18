#include <math.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>

#define BASE_BINARIA 2
#define BASE_HEXADECIMAL 16
#define VALOR_MIN_LETRA 10

#define ES_CARACTER_NUMERO(C) 	   ((C>='0' && C<='9')? 1:0)
#define CARACTER_NUM_A_ENTERO(C)   (C-'0')
#define CARACTER_LETRA_A_ENTERO(C) (C<='Z'? (C-'A'):(C-'a'))

int base_a_decimal(char* numero, int longitud, int base);
int detectar_base_devolver_valor(char* numero);