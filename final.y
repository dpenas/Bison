%{
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

/**
AVISO: Acabas de entrar en un mundo lleno de ifs anidados, números
     mágicos y brujería por doquier. El código es cuasi-imposible de entender 
     gracias a mi lógica difusa. Yo de ti me abstendría de entender lo que sucede.
     Simplemente ten fe.
**/

typedef struct table{
	long idEmpleado;
	char nombre[100];
	char puesto[100];
	char anho[4];
	double salario;
} tablaEmpleados;

tablaEmpleados empleados[100];

typedef struct tableaux{
	long idEmpleado;
	char nombre[100];
	char puesto[100];
	char anho[4];
	double salario;
	int control;
} tablaFinales;

tablaFinales auxfinales[100];

int line2 = 0;
int line = -1;
int numemp = 0;
int controlaux = 0;
int numauxfinal = 0;
int iter = 0;
int controlOR = 0;
void insertAuxEmpleado (int posEmpleado, int andor){
	auxfinales[numauxfinal].idEmpleado = empleados[posEmpleado].idEmpleado;
	auxfinales[numauxfinal].salario = empleados[posEmpleado].salario;
	strcpy(auxfinales[numauxfinal].nombre, empleados[posEmpleado].nombre);
	strcpy(auxfinales[numauxfinal].puesto, empleados[posEmpleado].puesto);
	strcpy(auxfinales[numauxfinal].anho, empleados[posEmpleado].anho);
	if(!andor && !controlOR){controlaux++;}
	auxfinales[numauxfinal].control = controlaux;
	numauxfinal++;
}

void imprimeresultados(){
	for (iter = 0; iter < numauxfinal; iter++){
		if(auxfinales[iter].idEmpleado != -1){
			printf("IdEmpleado: %lu\n", auxfinales[iter].idEmpleado);
			printf("Nombre: %s\n", auxfinales[iter].nombre);
			printf("Empleo: %s\n", auxfinales[iter].puesto);
			printf("Salario: %f\n", auxfinales[iter].salario);
			printf("Anho: %s\n", auxfinales[iter].anho);
		}
	}
}

void imprimeempleados(){
	for (iter = 0; iter <= line; iter++){
			printf("IdEmpleado: %lu\n", empleados[iter].idEmpleado);
			printf("Nombre: %s\n", empleados[iter].nombre);
			printf("Empleo: %s\n", empleados[iter].puesto);
			printf("Salario: %f\n", empleados[iter].salario);
			printf("Anho: %s\n", empleados[iter].anho);
	}
}

void obtaininformationsal(char * field, char * valor, char * simbolo, int andor){
	float valorreal;
	valorreal = atof(valor);
	int i;
	if (!andor){
		for(i=0; i < numemp; i++){	
			if(!strcmp(simbolo, ">")){
				if (empleados[i].salario > valorreal){
					printf("EL SALARIO ES MAYOR\n\n\n");
					insertAuxEmpleado(i,andor);
					controlOR = 1;
				}
			}else{
				if(!strcmp(simbolo, "<")){
					if (empleados[i].salario < valorreal){
						printf("EL SALARIO ES MENOR\n\n\n");
						insertAuxEmpleado(i,andor);
						controlOR = 1;
					}
				}else{
					if (empleados[i].salario == valorreal){
						printf("EL VALOR ES IGUAL\n\n\n");
						insertAuxEmpleado(i,andor);
						controlOR = 1;
					}
				}
			}
		}
	}
	else{
		for (i = 0; i < numauxfinal; i++){
			if(!strcmp(simbolo,">") && controlaux == auxfinales[i].control){
				if (!(auxfinales[i].salario > valorreal)){
					auxfinales[i].idEmpleado = -1;
				}
			}
			if(!strcmp(simbolo,"<") && controlaux == auxfinales[i].control){
				if (!(auxfinales[i].salario < valorreal)){
					auxfinales[i].idEmpleado = -1;
				}
			}
			if(!strcmp(simbolo,"=") && controlaux == auxfinales[i].control){
				if (!(auxfinales[i].salario == valorreal)){
					auxfinales[i].idEmpleado = -1;
				}
			}
		}	
	}
	controlOR = 0;
}

void obtaininformationid(char * field, char * valor, char * simbolo, int andor){
	float valorreal;
	valorreal = atof(valor);
	int i;
	if(!andor){
		for(i=0; i < numemp; i++){	
			if(!strcmp(simbolo, ">")){
				if (empleados[i].idEmpleado > valorreal){
					printf("EL ID ES MAYOR\n\n\n");
					insertAuxEmpleado(i,andor);
					controlOR = 1;
				}
			}else{
				if(!strcmp(simbolo, "<")){
					if (empleados[i].idEmpleado < valorreal){
						printf("EL ID ES MENOR\n\n\n");
						insertAuxEmpleado(i,andor);
						controlOR = 1;
					}
				}else{
					if (empleados[i].idEmpleado == valorreal){
						printf("EL ID ES IGUAL\n\n\n");
						insertAuxEmpleado(i,andor);
						controlOR = 1;
					}
				}
			}
		}
	}		
	else{
		for (i = 0; i < numauxfinal; i++){
			if(!strcmp(simbolo,">") && controlaux == auxfinales[iter].control){
				if (!(auxfinales[iter].idEmpleado > valorreal)){
					auxfinales[iter].idEmpleado = -1;
				}
			}
			if(!strcmp(simbolo,"<") && controlaux == auxfinales[iter].control){
				if (!(auxfinales[iter].idEmpleado < valorreal)){
					auxfinales[iter].idEmpleado = -1;
				}
			}
			if(!strcmp(simbolo,"=") && controlaux == auxfinales[iter].control){
				if (!(auxfinales[iter].idEmpleado == valorreal)){
					auxfinales[iter].idEmpleado = -1;
				}
			}
		}	
	}
	controlOR = 0;
}

void obtaininformationstring(char * valor, int tipo, int andor){
	int i;
	printf("Numauxfinal: %i\n", numauxfinal);
	if (andor == 0){
		for(i=0; i < numemp; i++){
			if (!tipo){
				if (!strncmp(empleados[i].anho, valor, strlen(valor))){
					insertAuxEmpleado(i,andor);
					printf("LOS ANHOS SON IGUALES\n");
					controlOR = 1;
				}
			}
			if (tipo == 1){	
				if (!strncmp(empleados[i].puesto, valor, strlen(valor))){
					printf("LOS EMPLEOS SON IGUALES\n");
					insertAuxEmpleado(i,andor);
					controlOR = 1;
				}
			}
			if (tipo == 2){	
				if (!strncmp(empleados[i].nombre, valor, strlen(valor))){
					printf("LOS NOMBRES SON IGUALES\n");	
					insertAuxEmpleado(i,andor);
					controlOR = 1;
				}
			}
		}
	}
	else{
		for (i = 0; i < numauxfinal; i++){
			printf("NUMAUXFINAL ES: %i\n\n", numauxfinal);
			if(tipo == 0){
				printf("ENTROOOOOOOOOOO\n\n\n");
				if((strncmp(auxfinales[iter].anho,valor,strlen(valor))!=0) && controlaux == auxfinales[iter].control){
					auxfinales[iter].idEmpleado = -1;
				}
			}
			if(tipo == 1){
				if((strncmp(auxfinales[iter].puesto,valor,strlen(valor))!=0) && controlaux == auxfinales[iter].control){
					auxfinales[iter].idEmpleado = -1;
				}
			}
			if(tipo == 2){
				if((strncmp(auxfinales[iter].nombre,valor,strlen(valor))!= 0) && controlaux == auxfinales[iter].control){
					auxfinales[iter].idEmpleado = -1;
				}
			}
		}
	}	
	
	controlOR = 0;

}

int stringexists(char * field, char* valor, char* simbolo, int andor){
//Esta función es una blasfemia en todos los sentidos. No mirar.
	printf("Me han enviado esto: %s\n", field);
	if(!strncmp(field, "salario", strlen("salario"))){
		obtaininformationsal(field, valor, simbolo, andor);
		return 0;
	} else{
		if (!strncmp(field, "idEmpleado", strlen("idempleado"))){
			obtaininformationid(field, valor, simbolo, andor);
			return 1;
		} else{
			if (!strncmp(field, "anho", strlen("anho"))){
				obtaininformationstring(valor, 0, andor);
				return 2;
			}else{
				if (!strncmp(field, "empleo", strlen("empleo"))){
					obtaininformationstring(valor, 1, andor);
					return 3;
				}else{
					if (!strncmp(field, "nombre", strlen("nombre"))){
					obtaininformationstring(valor, 2, andor);
						return 4;
					}
				}
			}
		}
	}
return -1;
}

void insertID(long id){
	line++;
	empleados[line].idEmpleado = id;
	numemp++;
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
	char * campo1;
	char * string;
	double intdouble;
	long intlong;
	int intnormal;
}


%token <campo1> AND OR WHERE FIELD TABLE FROM SELECT OPERANDOS MAYOR MENOR IGUAL
%type <campo1> parte_select parte_from parte_where
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
S: parte_select parte_from parte_where | leeidempleado leenombre leeempleo leeanho leesal;

parte_select: SELECT fields {};

fields: fields FIELD {printf("FIELD: %s\n", $2);}
      | FIELD {printf("El primer FIELD es: %s\n", $1);}
      ;

parte_from: FROM table {};

table: TABLE {printf("TABLA: %s\n", $1);};

parte_where: WHERE operandos;

operandos: operandos AND OPERANDOS MAYOR OPERANDOS {printf("AND MAYOR: %s\n",$3); stringexists($3, $5, ">", 1);}
	 | operandos AND OPERANDOS MENOR OPERANDOS {printf("AND MENOR: %s\n",$3); stringexists($3, $5, "<", 1);}
	 | operandos AND OPERANDOS IGUAL OPERANDOS {printf("AND IGUAL: %s\n",$3); stringexists($3, $5, "=", 1);}
	 | operandos OR OPERANDOS IGUAL OPERANDOS {printf("OR IGUAL: %s\n", $3); stringexists($3, $5, "=", 0);}
	 | operandos OR OPERANDOS MENOR OPERANDOS {printf("OR MENOR: %s\n", $3); stringexists($3, $5, "<", 0);}
	 | operandos OR OPERANDOS MAYOR OPERANDOS {printf("OR MAYOR: %s\n", $3); stringexists($3, $5, ">", 0);}
	 | OPERANDOS MAYOR OPERANDOS {printf("PRIMER OPERANDO MAYOR: %s \n", $1); stringexists($1, $3, ">", 0);}
	 | OPERANDOS MENOR OPERANDOS {printf("PRIMER OPERANDO MENOR: %s \n", $1); stringexists($1, $3, "<", 0);}
	 | OPERANDOS IGUAL OPERANDOS {printf("PRIMER OPERANDO IGUAL: %s \n", $1); stringexists($1, $3, "=", 0);}
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
	 
		
%%
void main(){
	yyparse();
	printf("LOS RESULTADOS FINALES: \n\n\n");
	imprimeempleados();
}
