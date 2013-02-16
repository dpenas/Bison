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

typedef struct table{
	long idEmpleado;
	char nombre[100];
	char puesto[100];
	char anho[4];
	double salario;
	int control;
} tablaFinales;

tablaFinales finales[100];

int numemp = 1;
int final = 0;

void obtaininformationsal(char * field, char * valor, char * simbolo){
	float valorreal;
	valorreal = atof(valor);
	int i;
	for(i=0; i < numemp; i++){	
		if(!strcmp(simbolo, ">")){
			if (empleados[i].salario > valorreal){
				printf("EL SALARIO ES MAYOR\n\n\n");
			}
		}else{
			if(!strcmp(simbolo, "<")){
				if (empleados[i].salario < valorreal){
					printf("EL SALARIO ES MENOR\n\n\n");
				}
			}else{
				if (empleados[i].salario == valorreal){
					printf("EL VALOR ES IGUAL\n\n\n");
				}
			}
		}
	}
}

void obtaininformationid(char * field, char * valor, char * simbolo){

	float valorreal;
	valorreal = atof(valor);
	int i;
	for(i=0; i < numemp; i++){	
		if(!strcmp(simbolo, ">")){
			if (empleados[i].idEmpleado > valorreal){
				printf("EL ID ES MAYOR\n\n\n");
			}
		}else{
			if(!strcmp(simbolo, "<")){
				if (empleados[i].idEmpleado < valorreal){
					printf("EL ID ES MENOR\n\n\n");
				}
			}else{
				if (empleados[i].idEmpleado == valorreal){
					printf("EL ID ES IGUAL\n\n\n");
				}
			}
		}
	}
}

void obtaininformationstring(char * valor, int tipo){

	int i;
	for(i=0; i < numemp; i++){

		if (!tipo){
			if (!strncmp(empleados[i].anho, valor, strlen(valor))){
				printf("LOS ANHOS SON IGUALES\n");	
			}
		}
		if (tipo == 1){	
			if (!strncmp(empleados[i].puesto, valor, strlen(valor))){
				printf("LOS EMPLEOS SON IGUALES\n");	
			}
		}
		if (tipo == 2){	
			if (!strncmp(empleados[i].nombre, valor, strlen(valor))){
				printf("LOS NOMBRES SON IGUALES\n");	
			}
		}
	}

}

int stringexists(char * field, char* valor, char* simbolo){
//Esta función es una blasfemia en todos los sentidos. No mirar.
	printf("Me han enviado esto: %s\n", field);
	if(!strncmp(field, "salario", strlen("salario"))){
		printf("ENTRO EN STRINGEXISTS\n");
		obtaininformationsal(field, valor, simbolo);
		return 0;
	} else{
		if (!strncmp(field, "idEmpleado", strlen("idempleado"))){
			obtaininformationid(field, valor, simbolo);
			return 1;
		} else{
			if (!strncmp(field, "anho", strlen("anho"))){
				obtaininformationstring(valor, 0);
				return 2;
			}else{
				if (!strncmp(field, "empleo", strlen("empleo"))){
					obtaininformationstring(valor, 1);
					return 3;
				}else{
					if (!strncmp(field, "nombre", strlen("nombre"))){
					obtaininformationstring(valor,2);
						return 4;
					}
				}
			}
		}
	}
return -1;
}

void insertID(long id){
	empleados[0].idEmpleado = id;
}

void insertNombrePuesto(char nombreopuesto[100], int caso){
	if (caso){
		strcpy(empleados[0].nombre, nombreopuesto);
	}else{
		strcpy(empleados[0].puesto, nombreopuesto);
	}
}

void insertAnho(char anho[4]){
	strcpy(empleados[0].anho, anho);
}

void insertSalario(double salario){
	empleados[0].salario = salario;
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

operandos: operandos AND OPERANDOS MAYOR OPERANDOS {printf("AND MAYOR: %s\n",$3); stringexists($3, $5, ">");}
	 | operandos AND OPERANDOS MENOR OPERANDOS {printf("AND MENOR: %s\n",$3); stringexists($3, $5, "<");}
	 | operandos AND OPERANDOS IGUAL OPERANDOS {printf("AND IGUAL: %s\n",$3); stringexists($3, $5, "=");}
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
	insertSalario(2000);
	insertAnho("1422");
	insertNombrePuesto("Alberto", 0);
	insertNombrePuesto("Genocida", 1);
	yyparse();
}
