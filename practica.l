%{
#include "y.tab.h"
#include <stdio.h>
#include <stdlib.h>
%}

nombre [^\t\n0-9,]+
empleo [^\t\n0-9,]+
idEmpleado [0-9]{1}|[0-9]{2}
salario [0-9]{4}|[0-9]+"."[0-9]+
anho [0-9]{4}
%s nombreemp
%s empleoemp
%s anhoemp
%s salarioemp
%%
<nombreemp>{nombre} {printf("nombre: %s\n", yytext); BEGIN(empleoemp);return NOMBREEMPLEADO;}
<empleoemp>{empleo} {printf("empleo: %s\n", yytext); BEGIN(anhoemp);return EMPLEO;}
<anhoemp>{anho} {printf("anho: %s\n", yytext); BEGIN(salarioemp);return ANHO;}
<salarioemp>{salario} {printf("salario: %s\n", yytext);return SALARIO;}

{idEmpleado} {printf("idEmpleado: %s\n", yytext); BEGIN(nombreemp);return IDEMPLEADO;}
%%
