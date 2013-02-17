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

%s nombreemp
%s empleoemp
%s anhoemp
%s salarioemp
%s camposelect
%s campowhere
%s campofrom
%%
<nombreemp>{nombre}  {printf("Leo esto: %s \n", yytext); yylval.string = yytext; BEGIN(empleoemp); return NOMBREEMPLEADO;}
<empleoemp>{empleo} {printf("Leo esto: %s \n", yytext); yylval.string = yytext; BEGIN(anhoemp); return EMPLEO;}
<anhoemp>{anho} {printf("Leo esto: %s \n", yytext);yylval.string = yytext; BEGIN(salarioemp); return ANHO;}
<salarioemp>{salario1} {printf("Leo esto: %s \n", yytext); yylval.intdouble = atof(yytext); return SALARIO1;}
<salarioemp>{salario2} {printf("Leo esto: %s \n", yytext); yylval.intnormal = atoi(yytext); return SALARIO2;}

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
{idEmpleado} {printf("Leo esto: %s \n", yytext); yylval.intlong = atol(yytext); BEGIN(nombreemp); return IDEMPLEADO;}
%%
