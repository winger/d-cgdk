DC = dmd
DFLAGS = -O -release -inline -noboundscheck

SRC=$(wildcard *.d) $(wildcard */*.d)

all : MyStrategy

MyStrategy : $(SRC)
	$(DC) $(DFLAGS) $(SRC) -of$@

clean :
	$(RM) MyStrategy MyStrategy.exe *.o *.obj compilation.log result.txt
