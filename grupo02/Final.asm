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
_Lenguajes y Compiladores     dd                            Lenguajes y Compiladores      ;Cte en formato  String
_if loco                      dd                            if loco                       ;Cte en formato  String
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

FLD 0b00010
FSTP a
FFREE
FLD c
FLD 0xab7
FMUL 
FSTP @Aux1
FFREE
FLD @Aux1
FSTP a
FFREE
FLD 1
FSTP id2
FFREE
FLD 1
FSTP cte1
FFREE
FLD 1
FSTP cte2
FFREE
FLD id2
FLD cte1
FMUL 
FSTP @Aux2
FFREE
FLD @Aux2
FLD cte2
FADD 
FSTP @Aux3
FFREE
FLD @Aux3
FSTP id1
FFREE
principiowhile
FLD a
FCOMP id1
FSTSW ax
SAHF
JNE saltoelse2
displayString if loco
saltoelse2
FFREE
JMP principiowhile
saltoelse
FLD a
FCOMP b
FSTSW ax
SAHF
JNA saltoelse4
FLD 4
FCOMP 5
FSTSW ax
SAHF
JNE saltoelse4
FLD 30
FSTP var2
FFREE
saltoelse4
FFREE
saltoelse5
FFREE
FLD b
FLD 3
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
saltoelse6
FLD b
FSTP var1
FFREE
fin_if1
displayString Lenguajes y Compiladores
displayString cadena



mov ax,4c00h	; Indica que debe finalizar la ejecución
int 21h

End