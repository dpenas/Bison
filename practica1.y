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


%token <campo1> AND OR WHERE FIELD TABLE FROM SELECT OPERANDOS MAYOR MENOR IGUAL
%type <campo1> parte_select parte_from parte_where
%start S

%%
S: parte_select parte_from parte_where;

parte_select: SELECT fields {};

fields: fields FIELD {printf("FIELD: %s\n", $2);}
      | FIELD {printf("El primer FIELD es: %s\n", $1);}
      ;

parte_from: FROM table {};

table: TABLE {printf("TABLA: %s\n", $1);};

parte_where: WHERE operandos;

operandos: operandos AND OPERANDOS MAYOR OPERANDOS {printf("AND MAYOR: %s\n",$3);}
	 | operandos AND OPERANDOS MENOR OPERANDOS {printf("AND MENOR: %s\n",$3);}
	 | operandos AND OPERANDOS IGUAL OPERANDOS {printf("AND IGUAL: %s\n",$3);}
	 | operandos OR OPERANDOS IGUAL OPERANDOS {printf("OR IGUAL: %s\n", $3);}
	 | operandos OR OPERANDOS MENOR OPERANDOS {printf("OR MENOR: %s\n", $3);}
	 | operandos OR OPERANDOS MAYOR OPERANDOS {printf("OR MAYOR: %s\n", $3);}
	 | OPERANDOS MAYOR OPERANDOS {printf("PRIMER OPERANDO MAYOR: %s \n", $1);}
	 | OPERANDOS MENOR OPERANDOS {printf("PRIMER OPERANDO MENOR: %s \n", $1);}
	 | OPERANDOS IGUAL OPERANDOS {printf("PRIMER OPERANDO IGUAL: %s \n", $1);}
	 ;
		
%%
void main(){
	insertID(1);
	insertSalario(1420);
	insertAnho("1422");
	insertNombrePuesto("Alberto", 0);
	insertNombrePuesto("Genocida", 1);
	yyparse();
}
