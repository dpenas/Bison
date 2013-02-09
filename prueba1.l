%{
#include <stdio.h>
#include <stdlib.h>

FILE* out;
FILE* in;

/*struct tabla{
    long idEmpleado;
    char* nombre;
    char* puesto;
    char* anho;
    double salario;
}*/
%}

empleado [^0-9 \t\n]+
puesto [A-Z a-z]+
idEmpleado [0-9]+
anho [0-9]{4}
salario1 [0-9]+\.[0-9]+
salario2 [0-9]+
salto [\n]
coma ","

%%

{idEmpleado}{coma}{empleado}{coma}{puesto}{coma}{anho}{coma}{salario1}{salto} {printf("Pillo esto\n");}
{idEmpleado}{coma}{empleado}{coma}{puesto}{coma}{anho}{coma}{salario2}{salto} {printf("Pillo esto2\n");}

%%
void main (){
    yylex();
}
