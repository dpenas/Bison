CC = gcc -g -O0

INPUT = practica1
FLEX = lex.yy.c
BISON = y.tab.c

default:
	bison $(INPUT).y -yd
	flex $(INPUT).l
	$(CC) $(FLEX) $(BISON) -o $(INPUT) -lfl -ly
