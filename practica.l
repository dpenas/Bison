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
<nombreemp>{nombre}  {printf("Leo esto: %s \n", yytext); yylval.string = yytext; BEGIN(empleoemp); return NOMBREEMPLEADO;}
<empleoemp>{empleo} {printf("Leo esto: %s \n", yytext); yylval.string = yytext; BEGIN(anhoemp); return EMPLEO;}
<anhoemp>{anho} {printf("Leo esto: %s \n", yytext);yylval.string = yytext; BEGIN(salarioemp); return ANHO;}
<salarioemp>{salario1} {printf("Leo esto: %s \n", yytext); yylval.intdouble = atof(yytext); return SALARIO1;}
<salarioemp>{salario2} {printf("Leo esto: %s \n", yytext); yylval.intnormal = atoi(yytext); return SALARIO2;}

{idEmpleado} {printf("Leo esto: %s \n", yytext); yylval.intlong = atol(yytext); BEGIN(nombreemp); return IDEMPLEADO;}
%%
