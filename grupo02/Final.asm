include macros2.asm
include number.asm
.MODEL LARGE	; Modelo de Memoria
.386	        ; Tipo de Procesador
.STACK 200h		; Bytes en el Stack

.DATA 

_0xf00                        dd                            3840.00                       ;Cte en formato  Int
a                             dd                            ?                             ;Variable Int
c                             dd                            ?                             ;Variable Int
cadena                        dd                            ?                             ;Variable String
var1                          dd                            ?                             ;Variable Int
var2                          dd                            ?                             ;Variable Int
x                             dd                            ?                             ;Variable Float
y                             dd                            ?                             ;Variable Int


.CODE

mov AX,@DATA    ; Inicializa el segmento de datos
mov DS,AX
mov es,ax ;

FLD _0xf00
FSTP c
FFREE
getString c



mov ax,4c00h	; Indica que debe finalizar la ejecución
int 21h

End