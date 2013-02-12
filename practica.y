%{
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

typedef struct table{
	long idEmpleado;
	char nombre[100];
	char puesto[100];
	char anho[4];
	double salario;
} tablaEmpleados;

tablaEmpleados empleados[100];

int line = -1;
int line2 = 0;
void insertID(long id){
	line++;
	empleados[line].idEmpleado = id;
}

void insertNombrePuesto(char nombreopuesto[100], int caso){
	if (caso){
		strcpy(empleados[line].nombre, nombreopuesto);
	}else{
		strcpy(empleados[line].puesto, nombreopuesto);
	}
}

void insertAnho(char anho[4]){
	printf("Voy a imprimir este anho: %s\n", anho);
	strcpy(empleados[line].anho, anho);
}

void insertSalario(double salario){
	printf("EL LINE2 ES: %i\n", line2);
	empleados[line2].salario = salario;
	line2++;
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
%type <string> leeanho 
%type <string> leeempleo 
%type <string> leenombre
%start S

%%
S: leeidempleado leenombre leeempleo leeanho leesal {printf("Hemos llegado al final: \n");}
	;

leeidempleado: IDEMPLEADO {printf("ID: %lu \n", $1); insertID($1);} 
	;

leenombre: NOMBREEMPLEADO {printf("NOMBRE: %s \n", $1); insertNombrePuesto($1,1);}
	;

leeempleo: EMPLEO {printf("EMPLEO %s \n", $1); insertNombrePuesto($1,0);}
	;

leeanho: ANHO {printf("HOLA\n"); printf("ANHO: %s \n", $1); insertAnho($1);}
        ;

leesal: SALARIO1 {printf("SALARIO1: %f \n", $1); insertSalario($1);}
        | SALARIO2 {printf("SALARIO2: %i \n", $1); insertSalario($1);}
	| SALARIO1 S {printf("SALARIO3 %f\n", $1); insertSalario($1);}
	| SALARIO2 S {printf("SALARIO4 %i\n", $1); insertSalario($1);}
        ;

%%
void main(){
	yyparse();
	printf("OLA K ASE\n");
	printf("ID: %lu\n", empleados[0].idEmpleado);
	printf("Nombre: %s\n", empleados[0].nombre);
	printf("Empleo: %s\n", empleados[0].puesto);
	printf("Salario: %f\n", empleados[0].salario);
	printf("Anho: %s\n", empleados[0].anho);
	printf("ID: %lu\n", empleados[11].idEmpleado);
	printf("Nombre: %s\n", empleados[11].nombre);
	printf("Empleo: %s\n", empleados[11].puesto);
	printf("Salario: %f\n", empleados[11].salario);
	printf("Anho: %s\n", empleados[11].anho);

}
