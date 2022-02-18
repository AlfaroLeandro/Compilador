#ifndef ARBOL_H_INCLUDED
#define ARBOL_H_INCLUDED
#include <stdio.h>
#include <stdlib.h>
#include <string.h>



#define SIN_MEMORIA 0
#define EXITO       1
#define DUPLICADO   2 

//typedef char* t_info;

/*
typedef struct
{
    char NyA[50];
    int Dni;
    float Prom;
}t_alumnos;*/

typedef struct s_NodoArbol
{
    struct s_NodoArbol *izq;
    struct s_NodoArbol *der;
    char info[50];
}t_NodoArbol;

typedef t_NodoArbol* t_arbol;

/// Prototipos ///

t_NodoArbol* crearHoja( char* lexema);
t_NodoArbol* crearNodo(char* lexema, t_NodoArbol* hijoIzq, t_NodoArbol* hijoDer);
void InOrden(t_arbol *pa, FILE *pIntermedia);
void PostOrden(t_arbol *pa);
void mostrarArbolDeIzqADer(t_arbol *pa, FILE* pArbol);
void mostrarArbolDeIzqADerAux(t_arbol *pa,int nivel, FILE* pArbol);
void VaciarArbol(t_arbol *pa);
t_arbol* recorrerArbol(t_arbol* pArbol, FILE* pAssembler, tLista* listaAux);
void traduccionAssembler(t_arbol* pArbol, FILE* pAssembler, tLista* listaAux);
int esHoja(t_arbol* pArbol);

int contAux=0;
char str_Aux[20];
char str_Salto[20];
char str_FinIf[20];
int contCuerp=0;
int contWhile=0;
int contSalto = 1;
int contFinIf = 1;


t_NodoArbol* crearHoja( char* lexema)
{
    t_NodoArbol* nue = (t_NodoArbol*) malloc (sizeof(t_NodoArbol));
    if(!nue)
    {
        printf("No se pudo reservar memoria para el nodo.\n");
        return NULL;
    }
    //Ponemos izq y der en NULL, y almacenamos el lexema dentro del nodo
    nue->izq = NULL;
    nue->der = NULL;
    strcpy(nue->info, lexema);
    return nue;
}

t_NodoArbol* crearNodo(char* lexema, t_NodoArbol* hijoIzq, t_NodoArbol* hijoDer)
{
    t_NodoArbol* padre = (t_NodoArbol*) malloc (sizeof(t_NodoArbol));
    
    if(!padre)
    {
        printf("No se pudo reservar memoria para el nodo.\n");
        return NULL;
    }

    padre->izq = hijoIzq;
    padre->der = hijoDer;
    strcpy(padre->info, lexema);

    return padre;
}

// Si queremos printear el programa original, printeamos INORDER

void InOrden(t_arbol *pa, FILE *pIntermedia)
{
    if(!(*pa))
        return;
    InOrden(&(*pa)->izq, pIntermedia);
    fprintf(pIntermedia, " %s  ", (*pa)->info);  
    InOrden(&(*pa)->der, pIntermedia);
}

// Si queremos printear el arbol POSORDER, obtenemos la polaca inversa 

void PostOrden(t_arbol *pa)
{
    if(!(*pa))
        return;
    PostOrden(&(*pa)->izq);
    PostOrden(&(*pa)->der);
    printf("%s  ", (*pa)->info);
}

void mostrarArbolDeIzqADer(t_arbol *pa, FILE* pArbol)
{
    pArbol=fopen("Arbol.txt","wt");
    mostrarArbolDeIzqADerAux(pa,0,pArbol);
    fclose(pArbol);
}
void mostrarArbolDeIzqADerAux(t_arbol *pa,int nivel, FILE* pArbol)
{
    int i;
    if(!*pa)
        return;
    mostrarArbolDeIzqADerAux(&(*pa)->der,nivel+1,pArbol);
    fprintf(pArbol,"\n");
    for(i = 0; i < nivel; i++)
        fprintf(pArbol,"\t");
    fprintf(pArbol,"%s", (*pa)->info);
    mostrarArbolDeIzqADerAux(&(*pa)->izq,nivel+1,pArbol);
}

void VaciarArbol(t_arbol *pa)
{
    if(!*pa)
        return;
    VaciarArbol(&(*pa)->izq);
    VaciarArbol(&(*pa)->der);
    free(*pa);
    *pa = NULL;
}

void traduccionIf(t_arbol* pArbol,FILE* pAssembler, char* salto){
     if(!*pArbol)
        return;
    if(contCuerp==0){
    fprintf(pAssembler,"%s\n",salto);
    fprintf(pAssembler,"FFREE\n"); 
    
    }
    contCuerp=0;
    free((*pArbol)->izq);
    free((*pArbol)->der);

    (*pArbol)->izq = NULL;
    (*pArbol)->der = NULL;
}

void traduccionCond(t_arbol* pArbol,FILE* pAssembler, char* salto){
     if(!*pArbol)
        return;
    fprintf(pAssembler,"FLD %s\n",((*pArbol)->izq)->info);
    fprintf(pAssembler,"FCOMP %s\n",((*pArbol)->der)->info);
    fprintf(pAssembler,"FSTSW ax\n");
    fprintf(pAssembler,"SAHF\n");
    sprintf(str_Salto, "saltoelse%d", contSalto);
    fprintf(pAssembler,"%s %s\n", salto, str_Salto);

     free((*pArbol)->izq);
     free((*pArbol)->der);

    (*pArbol)->izq = NULL;
    (*pArbol)->der = NULL;
    
    

}
void traduccionCuerpoIf(t_arbol* pArbol,FILE* pAssembler, char* salto){
     if(!*pArbol)
        return;
     if(contCuerp==1){
         char salto2[5]="JMP";
         sprintf(str_FinIf, "fin_if%d", contFinIf);
         fprintf(pAssembler,"%s %s\n",salto2, str_FinIf);
         fprintf(pAssembler,"%s\n",salto);
         return;
     }
     else  if(contCuerp==2){
         sprintf(str_FinIf, "fin_if%d", contFinIf);
         fprintf(pAssembler,"%s\n", str_FinIf);
         contFinIf++;
         free((*pArbol)->izq);
         free((*pArbol)->der);

        (*pArbol)->izq = NULL;
        (*pArbol)->der = NULL;
     }

  
}
void traduccionWhile(t_arbol* pArbol,FILE* pAssembler, char* salto){
     if(!*pArbol)
        return;
     if(contWhile==1){
         fprintf(pAssembler,"%s\n","principiowhile");
         return;
     }
     else  if(contWhile==2){
         fprintf(pAssembler,"JMP principiowhile\n");
         fprintf(pAssembler,"saltoelse\n");
         free((*pArbol)->izq);
         free((*pArbol)->der);

        (*pArbol)->izq = NULL;
        (*pArbol)->der = NULL;
     }

  
}

int esHoja(t_arbol* pNodoArbol){
    if(!*pNodoArbol)
        return 0;
 
    if((!(*pNodoArbol)->izq) && (!(*pNodoArbol)->der))
        return 1;
    else
        return 0;
}

void traduccionAssembler(t_arbol* pArbol, FILE* pAssembler, tLista* listaAux){
       if(!*pArbol)
        return;
        char cadena[50]="";
        if(strcmp((*pArbol)->info, ">")==0 ){
            strcat(cadena,"JNA\0");
             traduccionCond(pArbol,pAssembler,cadena);
            return;
        }else if (strcmp((*pArbol)->info, "<")==0 ){
            strcat(cadena,"JNB\0");
             traduccionCond(pArbol,pAssembler,cadena);
            return;
        }else if (strcmp((*pArbol)->info, ">=")==0 ){
            strcat(cadena,"JNAE\0");
             traduccionCond(pArbol,pAssembler,cadena);
            return;
        }else if (strcmp((*pArbol)->info, "<=")==0 ){
             strcat(cadena,"JNBE\0");
             traduccionCond(pArbol,pAssembler,cadena);
            return;
        }else if (strcmp((*pArbol)->info, "==")==0 ){
             strcat(cadena,"JNE\0");
             traduccionCond(pArbol,pAssembler,cadena); 
            return;
        }else if (strcmp((*pArbol)->info, "!=")==0 ){
             strcat(cadena,"JE\0");
             traduccionCond(pArbol,pAssembler,cadena);
            return;
        }
        
        
        if (strcmp((*pArbol)->info, "IF")==0 ){
             sprintf(str_Salto, "saltoelse%d\0", contSalto);
             contSalto++;
             strcat(cadena, str_Salto);
             traduccionIf(pArbol,pAssembler,cadena);
            return;
        } else if (strcmp((*pArbol)->info, "CUERPO")==0 ){
            contCuerp++;
            sprintf(str_Salto, "saltoelse%d\0", contSalto);
            contSalto++;
            strcat(cadena, str_Salto);
            traduccionCuerpoIf(pArbol,pAssembler,cadena);
            return;
        }

        if (strcmp((*pArbol)->info, "WHILE")==0 ){
            contWhile++;
            sprintf(str_Salto, "saltoelse%d\0", contSalto);
            contSalto++;
            strcat(cadena, str_Salto);
            traduccionWhile(pArbol,pAssembler,cadena);
            return;
        }

        if (strcmp((*pArbol)->info, "DISPLAY")==0 ){
            fprintf(pAssembler,"displayString %s\n",(*pArbol)->izq->info);
            free((*pArbol)->izq);
            (*pArbol)->izq = NULL;
             return;
        }

        
        int tam=strlen("Sentencia");
        strncpy( cadena, (*pArbol)->info, tam);
        cadena[tam]='\0';
       if(strcmp(cadena, "Sentencia")!=0 && strcmp(cadena, "NODOAUX")!=0 && strcmp(cadena, "MAX")!=0 && strcmp(cadena, "MIN")!=0 
         && strcmp(cadena, "EQUMAX")!=0 && strcmp(cadena, "EQUMIN")!=0 && strcmp(cadena, "EQUAUX")!=0 && strcmp(cadena, "LONGITUD")!=0  ){

            
            if(strcmp((*pArbol)->info,":=")!=0)//si no son iguales
                fprintf(pAssembler,"FLD %s\n",((*pArbol)->izq)->info);
            fprintf(pAssembler,"FLD %s\n",((*pArbol)->der)->info);
        
            if(strcmp((*pArbol)->info, "+")==0)
            fprintf(pAssembler,"FADD \n");
            else if(strcmp((*pArbol)->info, "-")==0)
                fprintf(pAssembler,"FSUB \n");
            else if(strcmp((*pArbol)->info, "/")==0)
                fprintf(pAssembler,"FDIV \n");
            else if(strcmp((*pArbol)->info, "*")==0)
            fprintf(pAssembler,"FMUL \n");
            
            if(strcmp((*pArbol)->info,":=")==0){
                fprintf(pAssembler,"FSTP %s\n",((*pArbol)->izq)->info);    
            }
            else{
                sprintf(str_Aux,"@Aux%d",++contAux);
                fprintf(pAssembler,"FSTP %s\n",str_Aux);
                strcpy((*pArbol)->info, str_Aux);

                insertarID(listaAux, str_Aux, "Float");
            }
            fprintf(pAssembler,"FFREE\n"); 
            
        }
            free((*pArbol)->izq);
            free((*pArbol)->der);

            (*pArbol)->izq = NULL;
            (*pArbol)->der = NULL;

}

t_arbol* recorrerArbol(t_arbol* pArbol, FILE* pAssembler, tLista* listaAux){
  // printf("Recorrer arbol assembler: \n");
    
    if(*pArbol==NULL )
        return NULL;
    
       if(strcmp((*pArbol)->info, "WHILE")==0 ){
         traduccionAssembler(pArbol,pAssembler,listaAux);
    }
    recorrerArbol(&(*pArbol)->izq, pAssembler, listaAux);
 
     if(strcmp((*pArbol)->info, "CUERPO")==0 ){
         traduccionAssembler(pArbol,pAssembler,listaAux);
    }
   
    recorrerArbol(&(*pArbol)->der, pAssembler,listaAux);




    if( esHoja(&(*pArbol)->izq) && ((esHoja(&(*pArbol)->der)) || (*pArbol)->der == NULL)){
       
        traduccionAssembler(pArbol,pAssembler,listaAux);
        

        return pArbol;
    }
    
}


#endif // ARBOL_H_INCLUDED