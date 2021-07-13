%{

	/* Integrantes:
	Daniel Stulberg Huf - 1920468
	Eduardo Sardenberg Tavares - 1911328
	*/

	#include <stdlib.h>
	#include <stdio.h>
	#include <string.h>

	int yylex();
	int nParams = 0;   //numero de parametros da funcao gerada

	void yyerror(const char *s) {
		fprintf(stderr, "%s\n", s);
	};

%}

%union
  {
	char *str;
	int number;
};

//inicializacao e definicao dos tipos dos tokens
%type <str> program varlist ret cmds cmd;
%token <str> ID;
%token <number> ENTRADA;
%token <number> SAIDA;
%token <number> END;
%token <number> NEWLINE;
%token <number> ENQUANTO;
%token <number> FACA;
%token <number> INC;
%token <number> ZERA;
%token <number> SE;
%token <number> ENTAO;
%token <number> SENAO;
%token <number> VEZES;
%token <number> FIM;
%token <number> IGUAL;
%token <number> ABREP;
%token <number> FECHAP;

%start program
%%

program : ENTRADA varlist SAIDA ret cmds END NEWLINE  {printf("int provol2c(%s) {\n\n%s\n%s\n", $2, $5, $4);}
	;

varlist : varlist ID   {char *params=malloc(strlen($1) + strlen($2) + 7); sprintf(params, "%s, int %s", $1, $2); $$ = params; nParams++;}
        | ID           {char *param = malloc(strlen($1) + 5); sprintf(param,"int %s",$1); $$ = param; nParams++;}
        ;

ret     : ID           {char *retorno = malloc(strlen($1) + 14); sprintf(retorno,"\treturn %s;\n\n}\n",$1); $$ = retorno;}
        ;

cmds : cmds cmd        {char *comandos=malloc(strlen($1) + strlen($2) + 2); sprintf(comandos, "%s\t%s", $1, $2); $$=comandos;}
     | cmd             {char *comando=malloc(strlen($1) + 2); sprintf(comando, "\t%s", $1); $$=comando;}
     ;

cmd : ENQUANTO ID FACA cmds FIM        {char *indeterminada=malloc(strlen($2) + strlen($4) + 16); sprintf(indeterminada, "while (%s) {\n\t%s\t}\n", $2, $4); $$ = indeterminada;}
    | ID IGUAL ID                      {char *igualdade=malloc(strlen($1) + strlen($3) + 6); sprintf(igualdade, "%s = %s;\n",$1,$3); $$ = igualdade;}
    | INC ABREP ID FECHAP              {char *incremento=malloc(strlen($3) + 5); sprintf(incremento, "%s++;\n",$3); $$ = incremento;}
    | ZERA ABREP ID FECHAP             {char *zerar=malloc(strlen($3) + 7); sprintf(zerar, "%s = 0;\n",$3); $$ = zerar;};
    | SE ID ENTAO cmds FIM             {char *condicional1=malloc(strlen($2) + strlen($4) + 13); sprintf(condicional1, "if (%s) {\n\t%s\t}\n", $2, $4); $$ = condicional1;}
    | SE ID ENTAO cmds SENAO cmds FIM  {char *condicional2=malloc(strlen($2) + strlen($4) + strlen($6) + 24); sprintf(condicional2, "if (%s) {\n\t%s\t}\n\telse{\n\t%s\t}\n", $2, $4, $6); $$ = condicional2;}
    | FACA ID VEZES cmds FIM           {char *determinada=malloc(strlen($2) + strlen($4) + 30); sprintf(determinada, "for (int i=0; i<%s; i++) {\n\t%s\t}\n", $2, $4); $$ = determinada;}                        
    ;

%%

int main() {

	printf("#include <stdio.h>\n#include <stdlib.h>\n");

	yyparse();

	printf("int main(int argc, char *argv[]) {\n\n\tprintf(\"Saida -> %%d\\n\", provol2c(atoi(argv[1])");
	for (int i=2; i<nParams+1; i++)
		printf(", atoi(argv[%d])", i);
	printf("));\n\treturn 0;\n\n}");

	return 0;
}

        