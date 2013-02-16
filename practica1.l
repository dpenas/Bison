%{
	#include "y.tab.h"
	#include <stdio.h>
	#include <stdlib.h>
%}

select "SELECT "
from "FROM "
where "WHERE "
and "AND "
or "OR "
campofrom [^\n\t"WHERE"]+
camposelect [^\n\t"FROM" ,]+
campowhere [^\n\t"AND""OR"">""<""="]+
mayor "> "
menor "< "
igual "= "

%s camposelect
%s campowhere
%s campofrom

%%

<camposelect>{camposelect} {yylval.campo1 = yytext; BEGIN(camposelect); return(FIELD);}
<camposelect>"," {yylval.campo1 = yytext; BEGIN(camposelect);}
<campofrom>{campofrom} {yylval.campo1 = yytext; return(TABLE);}
<campowhere>{campowhere}";" {yylval.campo1 = yytext; return(OPERANDOS);}
<campowhere>{and} {yylval.campo1 = yytext; BEGIN(campowhere); return(AND);}
<campowhere>{or} {yylval.campo1 = yytext; BEGIN(campowhere); return(OR);}
<campowhere>{mayor} {yylval.campo1 = yytext; BEGIN(campowhere); return(MAYOR);}
<campowhere>{menor} {yylval.campo1 = yytext; BEGIN(campowhere); return(MENOR);}
<campowhere>{igual} {yylval.campo1 = yytext; BEGIN(campowhere); return(IGUAL);}
<campowhere>{campowhere} {yylval.campo1 = yytext; BEGIN(campowhere); return(OPERANDOS);}

{select} {yylval.campo1 = yytext; BEGIN(camposelect); return(SELECT);}
{from} {yylval.campo1 = yytext; BEGIN(campofrom); return(FROM);}
{where} {yylval.campo1 = yytext; BEGIN(campowhere); return(WHERE);}
%%
