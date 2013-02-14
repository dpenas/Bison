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

%token <campo1> FIELD
%token <campo1> WHERE
%token <campo1> TABLE 
%token <campo1> FROM
%token <campo1> SELECT
%token <campo1> OPERANDOS
%token <campo1> FIELDCOMA
%type <campo1> parte_select parte_from parte_where
%start S

%%
S: parte_select parte_from parte_where;

parte_select: SELECT fields {printf("El select es: %s\n",$1);};

fields: FIELDCOMA fields {printf("Acabo de leer esto LALALA: %s\n\n\n\n", $1);}
      | FIELD {printf("El field es!\n");}
      ;

parte_from: FROM table {printf("El from que lei fue: %s\n", $1);};

table: TABLE {printf("La tabla que lei fue: %s\n", $1);};

parte_where: WHERE operandos;

operandos: OPERANDOS {printf("Los operandos son: %s\n", $1);}
		
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
