#include "miscelaneo.h"

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