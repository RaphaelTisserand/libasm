ASM = nasm -f elf64
AR = ar rcs
CC = gcc

SRCS = ${wildcard srcs/*.s}
OBJS = ${patsubst srcs/%.s, objs/%.o, ${SRCS}}
OBJS_DIR = objs
NAME = libasm.a

all: ${NAME}

${OBJS_DIR}:
	mkdir -p objs

objs/%.o: srcs/%.s
	${ASM} -o $@ $^

${NAME}: ${OBJS_DIR} ${OBJS}
	${AR} ${NAME} ${OBJS}

example: ${NAME} main.c
	${CC} -o example main.c -L. -lasm

clean:
	rm -rf ${OBJS_DIR}

fclean: clean
	rm -rf ${NAME} example

re: fclean all

.PHONY: all clean fclean re
	#all my homies hates snaji
