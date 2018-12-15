CFLAGS= -std=c99 -Wall -Wextra# -g3
CC=gcc
RAPPORTDIR=report

all: homework2

homework2: homework2.c
	$(CC) $(CFLAGS) -o homework2 $^

run: homework2
	./homework2 radar 0 5

adhoc: palindrome.wp palindrome2.wp
	./adhoc/adhoc palindrome.wp
	./adhoc/adhoc palindrome2.wp

clean:
	rm -f homework2
