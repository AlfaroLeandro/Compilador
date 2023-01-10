# Compilador
Construcción de un compilador.

## OBJETIVO: 

1.Realizar un analizador sintáctico utilizando las herramientas FLEX y BISON. El programa
ejecutable deberá mostrar por pantalla las reglas sintácticas que va analizando el parser en base a un archivo
de entrada (prueba.txt). Las impresiones deben ser claras. Las reglas que no realizan ninguna acción no deben
generar salida.

2.Realizar un generador de código intermedio utilizando el archivo BISON generado en la primera
entrega. El programa ejecutable deberá procesar el archivo de entrada (prueba.txt) y devolver el código
intermedio del mismo junto con la tabla de símbolos.

3.Realizar un compilador utilizando el archivo generado en la segunda entrega. El programa
ejecutable deberá procesar el archivo de entrada (prueba.txt), compilarlo y ejecutarlo.


## TEMAS COMUNES

### ITERACIONES
Implementación de ciclo WHILE

### DECISIONES
Implementación de IF

### ASIGNACIONES
Asignaciones simples A:=B

### TIPO DE DATOS
Constantes numéricas
▪ reales (32 bits)
▪ enteras (16 bits)
El separador decimal será el punto “.”
Ejemplo:
a = 99999.99
a = 99.
a = .9999
Constantes string
Constantes de 30 caracteres alfanuméricos como máximo, limitada por comillas (“ “) ,de la forma “XXXX”
Ejemplo:
b = “@sdADaSjfla%dfg”
b = “asldk fh sjf”

### VARIABLES
Variables numéricas
Estas variables reciben valores numéricos tales como constantes numéricas, variables numéricas u
operaciones que arrojen un valor numérico, del lado derecho de una asignación.

Las variables no guardan su valor en tabla de símbolos.

Las asignaciones deben ser permitidas, solo en los casos en los que los tipos son
compatibles, caso contrario deberá desplegarse un error.

### COMENTARIOS
Deberán estar delimitados por “-/” y “/-“ y podrán estar anidados en un solo nivel.
Ejemplo1:
-/ Realizo una selección /-
IF (a <= 30)
  b = ”correcto” -/ asignación string /- 
ENDIF

### ENTRADA Y SALIDA
Las salidas y entradas por teclado se implementarán como se muestra en el siguiente ejemplo:

Ejemplo:
WRITE “ewr” -/ donde “ewr” debe ser una cte string /-
READ base -/ donde base es una variable /-
WRITE var1 -/ donde var1 es una vble numérica definida previamente /-

### CONDICIONES
Las condiciones para un constructor de ciclos o de selección pueden ser simples ( a < b ) o múltiples.
Las condiciones múltiples pueden ser hasta dos condiciones simples ligadas a través del operador lógico
(AND, OR) o una condición simple con el operador lógico NOT

### DECLARACIONES
Todas las variables deberán ser declaradas de la siguiente manera:
DECVAR
  Línea_de_Declaración_de_Tipos (1)
ENDDEC

Ejemplos de formato:

DECVAR
  
  a1, b1 : FLOAT

  variable1 : STRING

  p1, p2, p3 : FLOAT

ENDDEC


## Se incluye:

▪ El archivo flex que se llamará Lexico.l

▪ El archivo bison que se llamará Sintactico.y

▪ El archivo ejecutable del compilador que se llamará Tercera.exe y que generará el código assembler

▪ final que se llamará Final.asm

