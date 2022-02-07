#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define SUCCESS 1
#define NO_MEMORY 0

typedef struct sNodeS {
    struct sNodeS* ant;
    char info[200];
    int number;
}tNodeS;

typedef tNodeS* tStack;


void createStack(tStack*p);
int pushStack(tStack*p,char*d);
int popStack(tStack* p,char* d);
int emptyStack(tStack* p);
void seeTop2(const tStack *p, char *d);
int pushStack2(tStack*p, char*d, int number);
int popStack2(tStack* p, char* d, int *number);

void createStack(tStack* p)
{
    *p=NULL;
}

void seeTop2(const tStack *p, char *d)
{
    if(!*p)
        return;

    strcpy(d,(*p)->info);
}

int pushStack(tStack* p,char* d)
{
    tNodeS* newNode=(tNodeS*)malloc(sizeof(tNodeS));
    
    if(!newNode)
        return NO_MEMORY;

    strcpy(newNode->info,d);

    newNode->ant=*p;
    *p=newNode;

    return SUCCESS;
}

int popStack(tStack* p,char* d)
{
    tNodeS* oldNode;
    if(!*p)
        return NO_MEMORY;
    oldNode=(tNodeS*)malloc(sizeof(tNodeS));
    oldNode=*p;
    strcpy(d,oldNode->info);
    *p=oldNode->ant;
    free(oldNode);
    return SUCCESS;
}

int emptyStack(tStack* p)
{
    return !*p;
}

//////


int pushStack2(tStack* p,char* d, int number)
{
    tNodeS* newNode=(tNodeS*)malloc(sizeof(tNodeS));
    
    if(!newNode)
        return NO_MEMORY;

    strcpy(newNode->info,d);
    newNode->number = number;

    newNode->ant=*p;
    *p=newNode;

    return SUCCESS;
}

int popStack2(tStack* p,char* d, int *number)
{
    tNodeS* oldNode;
    if(!*p)
        return NO_MEMORY;
    oldNode=(tNodeS*)malloc(sizeof(tNodeS));
    oldNode=*p;
    strcpy(d,oldNode->info);
    *number = oldNode->number;
    *p=oldNode->ant;
    free(oldNode);
    return SUCCESS;
}