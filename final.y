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
	int anho;
	double salario;
} tablaEmpleados;

tablaEmpleados empleados[100];

typedef struct tableaux{
	long idEmpleado;
	char nombre[100];
	char puesto[100];
	int anho;
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
int idempleadoy = 0;
int anhoy = 0;
int empleoy = 0;
int salarioy = 0;
int nombrey = 0;

void insertAuxEmpleado (int posEmpleado, int andor){
	auxfinales[numauxfinal].idEmpleado = empleados[posEmpleado].idEmpleado;
	auxfinales[numauxfinal].salario = empleados[posEmpleado].salario;
	strcpy(auxfinales[numauxfinal].nombre, empleados[posEmpleado].nombre);
	strcpy(auxfinales[numauxfinal].puesto, empleados[posEmpleado].puesto);
	auxfinales[numauxfinal].anho = empleados[posEmpleado].anho;
	if(!andor && !controlOR){controlaux++;}
	auxfinales[numauxfinal].control = controlaux;
	numauxfinal++;
}

void imprimeresultados(){
	for (iter = 0; iter < numauxfinal; iter++){
		if(auxfinales[iter].idEmpleado != -1){
			if(idempleadoy)
				printf("IdEmpleado: %lu\n", auxfinales[iter].idEmpleado);
			if(nombrey)
				printf("Nombre: %s\n", auxfinales[iter].nombre);
			if(empleoy)
				printf("Empleo: %s\n", auxfinales[iter].puesto);
			if(salarioy)
				printf("Salario: %f\n", auxfinales[iter].salario);
			if(anhoy)
				printf("Anho: %i\n", auxfinales[iter].anho);
		}
	}
}

void comprobacionfields(char * field){
	if (!strncmp(field, "*", 1)){
		idempleadoy = 1;
		anhoy = 1;
		empleoy = 1;
		salarioy = 1;
		nombrey = 1;
	}
	else{
		if (!strncmp(field, "idEmpleado", strlen("idEmpleado"))) idempleadoy = 1;
		if (!strncmp(field, "anho", strlen("anho"))) anhoy = 1;
		if (!strncmp(field, "puesto", strlen("puesto")))  empleoy = 1;
		if (!strncmp(field, "nombre", strlen("nombre"))) nombrey = 1;
		if (!strncmp(field, "salario", strlen("salario"))) salarioy = 1;
	}
}

void imprimeempleados(){
	int iter;
	for (iter = 0; iter <= line; iter++){
		printf("IdEmpleado: %lu\n", empleados[iter].idEmpleado);
		printf("Nombre: %s\n", empleados[iter].nombre);
		printf("Empleo: %s\n", empleados[iter].puesto);
		printf("Salario: %f\n", empleados[iter].salario);
		printf("Anho: %i\n", empleados[iter].anho);
	}
}

void obtaininformationanho(char * field, char * valor, char * simbolo, int andor){
	int valorreal;
	valorreal = atoi(valor);
	int i;
	if (!andor){
		for(i=0; i < numemp; i++){	
			if(!strcmp(simbolo, ">")){
				if (empleados[i].anho > valorreal){
					insertAuxEmpleado(i,andor);
					controlOR = 1;
				}
			}else{
				if(!strcmp(simbolo, "<")){
					if (empleados[i].anho < valorreal){
						insertAuxEmpleado(i,andor);
						controlOR = 1;
					}
				}else{
					if (empleados[i].anho == valorreal){
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
				if (!(auxfinales[i].anho > valorreal)){
					auxfinales[i].idEmpleado = -1;
				}
			}
			if(!strcmp(simbolo,"<") && controlaux == auxfinales[i].control){
				if (!(auxfinales[i].anho < valorreal)){
					auxfinales[i].idEmpleado = -1;
				}
			}
			if(!strcmp(simbolo,"=") && controlaux == auxfinales[i].control){
				if (!(auxfinales[i].anho == valorreal)){
					auxfinales[i].idEmpleado = -1;
				}
			}
		}	
	}
	controlOR = 0;
}

void obtaininformationsal(char * field, char * valor, char * simbolo, int andor){
	float valorreal;
	valorreal = atof(valor);
	int i;
	if (!andor){
		for(i=0; i < numemp; i++){	
			if(!strcmp(simbolo, ">")){
				if (empleados[i].salario > valorreal){
					insertAuxEmpleado(i,andor);
					controlOR = 1;
				}
			}else{
				if(!strcmp(simbolo, "<")){
					if (empleados[i].salario < valorreal){
						insertAuxEmpleado(i,andor);
						controlOR = 1;
					}
				}else{
					if (empleados[i].salario == valorreal){
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
					insertAuxEmpleado(i,andor);
					controlOR = 1;
				}
			}else{
				if(!strcmp(simbolo, "<")){
					if (empleados[i].idEmpleado < valorreal){
						insertAuxEmpleado(i,andor);
						controlOR = 1;
					}
				}else{
					if (empleados[i].idEmpleado == valorreal){
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
				if (!(auxfinales[i].idEmpleado > valorreal)){
					auxfinales[i].idEmpleado = -1;
				}
			}
			if(!strcmp(simbolo,"<") && controlaux == auxfinales[i].control){
				if (!(auxfinales[i].idEmpleado < valorreal)){
					auxfinales[i].idEmpleado = -1;
				}
			}
			if(!strcmp(simbolo,"=") && controlaux == auxfinales[i].control){
				if (!(auxfinales[i].idEmpleado == valorreal)){
					auxfinales[i].idEmpleado = -1;
				}
			}
		}	
	}
	controlOR = 0;
}

void obtaininformationstring(char * valor, int tipo, int andor){
	int i;
	if (andor == 0){
		for(i=0; i < numemp; i++){
			if (tipo == 1){	
				if (!strncmp(empleados[i].puesto, valor, strlen(empleados[i].nombre))){
					insertAuxEmpleado(i,andor);
					controlOR = 1;
				}
			}
			if (tipo == 2){	
				if (!strncmp(empleados[i].nombre, valor, strlen(empleados[i].nombre))){
					insertAuxEmpleado(i,andor);
					controlOR = 1;
				}
			}
		}
	}
	else{
		for (i = 0; i < numauxfinal; i++){
			if(tipo == 1){
				if((strncmp(auxfinales[i].puesto,valor,strlen(valor))!=0) && controlaux == auxfinales[i].control){
					auxfinales[i].idEmpleado = -1;
				}
			}
			if(tipo == 2){
				if((strncmp(auxfinales[i].nombre,valor,strlen(valor))!= 0) && controlaux == auxfinales[i].control){
					auxfinales[i].idEmpleado = -1;
				}
			}
		}
	}	
	
	controlOR = 0;

}

int stringexists(char * field, char* valor, char* simbolo, int andor){
//Esta función es una blasfemia en todos los sentidos. No mirar.
	if(!strncmp(field, "salario", strlen("salario"))){
		obtaininformationsal(field, valor, simbolo, andor);
		return 0;
	} else{
		if (!strncmp(field, "idEmpleado", strlen("idempleado"))){
			obtaininformationid(field, valor, simbolo, andor);
			return 1;
		} else{
			if (!strncmp(field, "anho", strlen("anho"))){
				obtaininformationanho(field, valor, simbolo, andor);
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

void insertAnho(int anho){
	empleados[line].anho = anho;
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
	char * string;
	double intdouble;
	long intlong;
	int intnormal;
}


%token <campo1> AND OR WHERE FIELD TABLE FROM SELECT OPERANDOS MAYOR MENOR IGUAL
%type <campo1> parte_select parte_from parte_where
%token <intdouble> SALARIO1
%token <intlong> IDEMPLEADO
%token <intnormal> SALARIO2 ANHO
%token <string> NOMBREEMPLEADO EMPLEO
%type <intdouble> leesal
%type <intlong> leeidempleado
%type <string> leeanho 
%type <string> leeempleo 
%type <string> leenombre
%start S

%%
S: parte_select parte_from parte_where | leeidempleado leenombre leeempleo leeanho leesal | leeidempleado leenombre leeempleo leeanho leesal S;

parte_select: SELECT fields {};

fields: fields FIELD {comprobacionfields($2);}
      | FIELD {comprobacionfields($1);}
      ;

parte_from: FROM table {};

table: TABLE {};

parte_where: WHERE operandos;

operandos: operandos AND OPERANDOS MAYOR OPERANDOS {stringexists($3, $5, ">", 1);}
	 | operandos AND OPERANDOS MENOR OPERANDOS {stringexists($3, $5, "<", 1);}
	 | operandos AND OPERANDOS IGUAL OPERANDOS {stringexists($3, $5, "=", 1);}
	 | operandos OR OPERANDOS IGUAL OPERANDOS {stringexists($3, $5, "=", 0);}
	 | operandos OR OPERANDOS MENOR OPERANDOS {stringexists($3, $5, "<", 0);}
	 | operandos OR OPERANDOS MAYOR OPERANDOS {stringexists($3, $5, ">", 0);}
	 | OPERANDOS MAYOR OPERANDOS {stringexists($1, $3, ">", 0);}
	 | OPERANDOS MENOR OPERANDOS {stringexists($1, $3, "<", 0);}
	 | OPERANDOS IGUAL OPERANDOS {stringexists($1, $3, "=", 0);}
	 ;

leeidempleado: IDEMPLEADO {insertID($1);} 
	;

leenombre: NOMBREEMPLEADO {insertNombrePuesto($1,1);}
	;

leeempleo: EMPLEO {insertNombrePuesto($1,0);}
	;

leeanho: ANHO {insertAnho($1);}
     ;

leesal: SALARIO1 {insertSalario($1);}
     | SALARIO2 {insertSalario($1);}
		
%%
void main(int argc, char * argv[]){
	FILE * archivo;
	FILE * archivo2;
	if (argc < 3){
		printf("Tienes que introducir dos ficheros (empleado y select)\n");
		exit(0);
	}
	printf("Cargando...\n");
	archivo = fopen(argv[1],"r");
	lecturaFichero(archivo);
	yyparse();
	printf("Bases de datos cargada\n");
	archivo2 = fopen(argv[2],"r");
	lecturaFichero(archivo2);
	yyparse();
	printf("RESULTADOS:\n\n");
	imprimeresultados();
}
