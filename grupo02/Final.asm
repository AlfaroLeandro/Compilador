include macros2.asm
include number.asm
.MODEL LARGE	; Modelo de Memoria
.386	        ; Tipo de Procesador
.STACK 200h		; Bytes en el Stack

.DATA 

_0b00010                      dd                            2.00                          ;Cte en formato  Int
_0xab7                        dd                            2743.00                       ;Cte en formato  Int
_1                            dd                            1.00                          ;Cte en formato  Int
_3                            dd                            3.00                          ;Cte en formato  Int
_30                           dd                            30.00                         ;Cte en formato  Int
_4                            dd                            4.00                          ;Cte en formato  Int
_5                            dd                            5.00                          ;Cte en formato  Int
_LyC                          dd                             " LyC"                          ;Cte en formato                String
_hola                         dd                             "hola"                          ;Cte en formato                String
_if                           dd                             "  if"                          ;Cte en formato                String
a                             dd                            ?                             ;Variable Int
c                             dd                            ?                             ;Variable Int
cadena                        dd                            ?                             ;Variable String
var1                          dd                            ?                             ;Variable Int
var2                          dd                            ?                             ;Variable Int
x                             dd                            ?                             ;Variable Float
y                             dd                            ?                             ;Variable Int
@Aux1                         dd                            ?                             ;Variable Float
@Aux2                         dd                            ?                             ;Variable Float
@Aux3                         dd                            ?                             ;Variable Float
@Aux4                         dd                            ?                             ;Variable Float


.CODE

mov AX,@DATA    ; Inicializa el segmento de datos
mov DS,AX
mov es,ax ;

FLD _0b00010
FSTP a
FFREE
FLD c
FLD _0xab7
FMUL 
FSTP @Aux1
FFREE
FLD @Aux1
FSTP a
FFREE
FLD _1
FSTP var1
FFREE
FLD _1
FSTP var2
FFREE
FLD _1
FSTP x
FFREE
FLD var2
FLD var1
FMUL 
FSTP @Aux2
FFREE
FLD @Aux2
FLD var2
FADD 
FSTP @Aux3
FFREE
FLD @Aux3
FSTP x
FFREE
getString c
FLD _hola
FSTP cadena
FFREE
principiowhile:
FLD a
FCOMP var1
FSTSW ax
SAHF
JNE saltoelse2
displayString _if
saltoelse2:
FFREE
JMP principiowhile
saltoelse:
FLD a
FCOMP x
FSTSW ax
SAHF
JNA saltoelse4
FLD _4
FCOMP _5
FSTSW ax
SAHF
JNE saltoelse4
FLD _30
FSTP y
FFREE
saltoelse4:
FFREE
saltoelse5:
FFREE
FLD var1
FLD _3
FMUL 
FSTP @Aux4
FFREE
FLD a
FCOMP @Aux4
FSTSW ax
SAHF
JNBE saltoelse6
FLD a
FSTP var1
FFREE
JMP fin_if1
saltoelse6:
FLD x
FSTP var1
FFREE
fin_if1:
displayString _LyC
displayString cadena



mov ax,4c00h	; Indica que debe finalizar la ejecución
int 21h

End