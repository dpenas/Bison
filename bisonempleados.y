%{
#include <stdlib.h>
#include <stdio.h>

typedef struct table{
	long idEmpleado;
	char nombre[100];
	char puesto[100];
	char anho[4];
	double salario;
} tablaEmpleados;

tablaEmpleados empleados[100];

void insert(){
}

%}

%union {
	char * string;
	double intdouble;
	long intlong;
}

  
%token <intdouble> SALARIO
%token <intlong> IDEMPLEADO
%token <string> NOMBREEMPLEADO EMPLEO ANHO 
%type <> campo
%start S

S: 



%%
main(){
	yyparse();
}
