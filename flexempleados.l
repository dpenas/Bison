%{
#include "y.tab.h"
%}

nombre [^\t\n ]","
empleo [^\t\n]","
idEmpleado [0-9]+
salario [0-9]{4}|[0-9]+"."[0-9]+
anho [0-9]{4}

%%

{anho] {yylval.string = yytext; return ANHO;}
{nombre} {yylval.string = yytext; return NOMBREEMPLEADO;}
{empleo} {yylval.string = yytext; return EMPLEO;}
{salario} {yylval.intdouble = atof(yytext); return SALARIO;}
{idEmpleado} {yylval.intlong = atol(yytext); return IDEMPLEADO;}
\n ;
, ;

%%
