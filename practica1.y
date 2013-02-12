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

int line = 0;

void insertID(long id){
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
	empleados[line].salario = salario;
}

void yyerror (char *s) {
	printf("error\n");
	printf("%s\n", s);
}

%}

%union {
	char * campo1;
}

%token <campo1> OPERANDOS
%token <campo1> TABLA
%token <campo1> CAMPO1
%type <campo1> leecampo leetabla
%start S

%%
S: leecampo leetabla {printf("He llegado hasta el final\n");}

leecampo: CAMPO1 {printf("El campo que lei fue: %s \n", $1);}
	| CAMPO1 leecampo {printf("El campo que lei fue 2: %s\n", $1);}
	;
leetabla: TABLA {printf("La tabla se llama: %s\n", $1);}
%%
void main(){
	printf("OLA KKKK ASE\n");
	insertID(1);
	insertSalario(1420);
	insertAnho("1422");
	insertNombrePuesto("Alberto", 0);
	insertNombrePuesto("Genocida", 1);
	yyparse();
}
