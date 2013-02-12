%{
	#include "y.tab.h"
	#include <stdio.h>
	#include <stdlib.h>
%}

select "SELECT "
from "FROM "
where "WHERE "
campo1 [^\n\t"FROM""SELECT""WHERE"]+
coma [","]

%s camposelect
%s campofrom
%s from
%s campowhere
%s where

%%

<campowhere>{campo1} {printf("He leido: %s\n", yytext); return(OPERANDOS);}

<where>{where} {printf("He leido WHERE: %s\n", yytext);}

<campofrom>{campo1} {printf("He leido: %s\n", yytext); yylval.campo1 = yytext; BEGIN(where); return(TABLA);}

<from>{from} {printf("He leido FROM: %s\n", yytext); BEGIN(campofrom);}

<camposelect>{campo1}{coma} {printf("He leido: %s\n", yytext); yylval.campo1 = yytext; return(CAMPO1); BEGIN(camposelect);}

<camposelect>{campo1} {printf("He leido22: %s\n", yytext); yylval.campo1 = yytext; BEGIN(from); return(CAMPO1); }

{select} {BEGIN(camposelect);}

%%
