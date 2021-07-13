%option yywrap

      /* Integrantes:
      Daniel Stulberg Huf - 1920468
      Eduardo Sardenberg Tavares - 1911328
      */

      #include <stdio.h>
      #include <string.h>
      #include "y.tab.h"
%%

END         return(END);
SAIDA       return(SAIDA);
ENTRADA     return(ENTRADA);
ENQUANTO    return(ENQUANTO);
FACA        return(FACA);
INC         return(INC);
ZERA        return(ZERA);
SE          return(SE);
ENTAO       return(ENTAO);
SENAO       return(SENAO);
VEZES       return(VEZES);
FIM         return(FIM);
\n          return(NEWLINE);
"="         return(IGUAL);
"("         return(ABREP);
")"         return(FECHAP);
[a-zA-Z]+   {yylval.str=strdup(yytext); return (ID);}



