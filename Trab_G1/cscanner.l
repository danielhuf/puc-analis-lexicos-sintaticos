%{

/* Alunos:
DANIEL STULBERG HUF - 1920468
EDUARDO SARDENBERG TAVARES - 1911328
*/

#include<stdio.h>
#include<math.h>
#include <stdlib.h>
#include<string.h>
#include <unistd.h>

#define CAPACIDADE 1000000

struct par 
{ 
  char* elemento; 
  char* classificacao;
}; 
typedef struct par Par; 

Par* hash[CAPACIDADE];

void insere(char* string1, char* string2)
{   
    long long res = 0;
    int pos, i=0;
    while (string1[i] != '\0') {
        res += (int) string1[i] * pow(63, i);
        i++;
    }
    pos = res%CAPACIDADE;
    if (hash[pos]!= NULL) {
        printf("Colisão: hash[%d] já tem o elemento %s\n", pos, hash[pos]->elemento);
    }
    else {
        hash[pos] = (Par *)malloc(sizeof(Par));
        hash[pos]->elemento = (char *)malloc(strlen(string1)*sizeof(char));
        strcpy(hash[pos]->elemento, string1);
        hash[pos]->classificacao = (char *)malloc(strlen(string2)*sizeof(char));
        strcpy(hash[pos]->classificacao, string2);
        printf("%s inserido em hash[%d]\n", string1,pos);
    }
}

void exibe()
{
    int i;
    printf("\n.--------------------------------------.\n");
    printf("|             TABELA HASH              |");
    printf("\n|--------------------------------------|\n");
    printf("|  POSIÇÃO    ELEMENTO    CLASSIFICAÇÃO|\n");
    printf("|                                      |\n");
    for(i = 0; i < CAPACIDADE; i++)
        if (hash[i]!=NULL)
            printf("|%7d%10s%20.20s |\n",i,hash[i]->elemento,hash[i]->classificacao);
    printf("|--------------------------------------|\n");
}

char* preparaConsulta (char *stringMaior) {
    char *copiaMaior = malloc(strlen(stringMaior) * sizeof(char));
    strcpy(copiaMaior, stringMaior);
    char * token = strtok(copiaMaior, ":");
    token = strtok(NULL, ":");
    return token;
}

void consulta (char* string)
{
    long long res = 0;
    int pos, i=0;
    while (string[i] != '\0') {
        res += (int) string[i] * pow(63, i);
        i++;
    }
    pos = res%CAPACIDADE;
    if(hash[pos]!=NULL && strcmp(hash[pos]->elemento,string)==0)
        printf("Elemento %s encontrado na posição %d!\n", string, pos);
    else
        printf("Elemento %s não foi encontrado na tabela hash.\n", string);
}

void libera() 
{
    int i;
    for (i=0; i<CAPACIDADE; i++)
        if (hash[i]!=NULL) {
            free(hash[i]->elemento);
            free(hash[i]->classificacao);
            free(hash[i]);
        }
    printf("\nMemória liberada!\n");
}

%}

DIGITO                 [0-9]
LETRA                  [a-zA-Z]
ALFANUM                [a-zA-Z0-9]
%x                     c_comment

%%
fim|Fim|FIM   			              return(0);
consulta:.+                                   consulta(preparaConsulta(yytext));
-{DIGITO}+"."{DIGITO}*|{DIGITO}+"."{DIGITO}*  {printf("Leu o ponto flutuante %g\n ", atof(yytext)); insere(yytext,"float");}                        
-{DIGITO}+|{DIGITO}+                          {printf("Leu o inteiro %d\n ", atoi(yytext)); insere(yytext,"int");}
true|false                                    {printf("Leu o booleano %s\n", yytext); insere(yytext,"bool");}
'.'                                           {printf("Leu o caracter %s\n", yytext); insere(yytext,"char");}
\"[^\n"]+\"                                   {printf("Leu a cadeia de caracteres %s\n", yytext); insere(yytext,"string");}
\*{LETRA}+                                    {printf("Leu o ponteiro %s\n", yytext); insere(yytext,"pointer");}
if|else|while|do|break|continue|return|case|switch|struct|typedef|sizeof|double|short|void|int|float|char|long|unsigned|static|goto|include      {printf("Leu a palavra reservada %s\n ", yytext); insere(yytext,"palavra reservada");}
{LETRA}{ALFANUM}*                             {printf("Leu o identificador %s\n ", yytext); insere(yytext, "identificador");}
[]({ })[]                                     {printf("Leu o delimitador %s\n ", yytext); insere(yytext,"delimitador");}
"+"|"-"|"*"|"/"|"%"                           {printf("Leu o operador %s\n ", yytext); insere(yytext,"operador");}
\t                                            {printf("Tabulação. \n"); insere(yytext, "tabulação");}
"//".*                                        printf("Leu o comentário linha unica %s\n ",yytext);
"/*"                                          BEGIN(c_comment);
<c_comment>[^*]*                              { }
<c_comment>"*"+[^*/]*                         { }
<c_comment>"*/"                               {printf("Leu comentário multilinha\n"); BEGIN(INITIAL);}
%%

int main()
{
	yylex();
	exibe();	
        libera();
}