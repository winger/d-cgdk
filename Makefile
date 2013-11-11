DC = dmd
DFLAGS = -O

SRC=$(wildcard *.d) $(wildcard */*.d)

all : MyStrategy

MyStrategy : $(SRC)
	$(DC) $(DFLAGS) $(SRC) -of$@
	
run : MyStrategy
	java -jar local-runner.jar true false 3 result.txt true false&
	sleep 2
	./MyStrategy

clean :
	rm MyStrategy *.o compilation.log result.txt