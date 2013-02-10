%{
#include "y.tab.h"
#include <stdio.h>
#include <stdlib.h>
%}

nombre [^\t\n0-9,]+
empleo [^\t\n0-9,]+
idEmpleado [0-9]{1}|[0-9]{2}
salario1 [0-9]{4}"."[0-9]+|[0-9]{3}"."[0-9]+
salario2 [0-9]{4}|[0-9]{3}
anho [0-9]{4}
%s nombreemp
%s empleoemp
%s anhoemp
%s salarioemp
%%
<nombreemp>{nombre} {yylval.string = yytext; BEGIN(empleoemp); return NOMBREEMPLEADO;}
<empleoemp>{empleo} {yylval.string = yytext; BEGIN(anhoemp); return EMPLEO;}
<anhoemp>{anho} {yylval.string = yytext; BEGIN(salarioemp); return ANHO;}
<salarioemp>{salario1} {yylval.intdouble = atof(yytext); return SALARIO1;}
<salarioemp>{salario2} {yylval.intnormal = atoi(yytext); return SALARIO2;}
{idEmpleado} {yylval.intlong = atol(yytext); BEGIN(nombreemp); return IDEMPLEADO;}
%%
