%{
	#include "y.tab.h"
	#include <stdio.h>
	#include <stdlib.h>
%}

select "SELECT "
from "FROM "
where "WHERE "
campofrom [^\n\t"WHERE"]+
camposelect [^\n\t"FROM" ,]+
campowhere [^\n\t]+

%s camposelect
%s campowhere
%s campofrom

%%


<camposelect>{camposelect}"," {printf("He leido2: %s\n", yytext); yylval.campo1 = yytext; BEGIN(camposelect); return(FIELDCOMA);}
<camposelect>{camposelect} {printf("He leido2222: %s\n", yytext); yylval.campo1 = yytext; BEGIN(camposelect); return(FIELD);}
<campofrom>{campofrom} {printf("He leidocampofrom: %s\n", yytext); yylval.campo1 = yytext; return(TABLE);}
<campowhere>{campowhere} {printf("He leidocampowhere: %s\n", yytext); yylval.campo1 = yytext; return(OPERANDOS);}

{select} {printf("Ya pillé el Select\n"); yylval.campo1 = yytext; BEGIN(camposelect); return(SELECT);}
{from} {printf("He leido FROM: \n"); yylval.campo1 = yytext; BEGIN(campofrom); return(FROM);}
{where} {printf("He leido WHERE: %s\n", yytext); yylval.campo1 = yytext; BEGIN(campowhere); return(WHERE);}
%%
