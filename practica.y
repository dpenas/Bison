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

void yyerror (char *s) {
	printf("error\n");
	printf("%s\n", s);
}

%}

%union {
	char * string;
	double intdouble;
	long intlong;
	int intnormal;
}

  
%token <intdouble> SALARIO1
%token <intlong> IDEMPLEADO
%token <intnormal> SALARIO2
%token <string> NOMBREEMPLEADO EMPLEO ANHO 
%type <intdouble> leesal
%type <intlong> leeidempleado
%type <string> leeanho leeempleo leenombre
%start S

%%
S: leeidempleado {printf("Hemos llegado al final: \n");}
	;

leeidempleado:	IDEMPLEADO leenombre {printf("ID: %lu \n", $1);} 
	;

leenombre: NOMBREEMPLEADO leeempleo {printf("NOMBRE: %s \n", $1);}
	;

leeempleo: EMPLEO leeanho {printf("EMPLEO %s \n", $1);}
	;

leeanho: ANHO leesal {printf("ANHO: %s \n", $1);}
        ;

leesal: SALARIO1 {printf("SALARIO: %f \n", $1);}
        | SALARIO2 {printf("SALARIO: %i \n", $1);}
        ;

%%
void main(){
	yyparse();
}
