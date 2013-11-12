DC = dmd
DFLAGS = -O -release -inline -noboundscheck

LOCAL_RUNNER = java -jar local-runner.jar true false 3 result.txt true false
ifeq ($(OS), Windows_NT)
    LOCAL_RUNNER_BG = START $(LOCAL_RUNNER)
    SLEEP = timeout
else
    LOCAL_RUNNER_BG = $(LOCAL_RUNNER)&
    SLEEP = sleep
endif

SRC=$(wildcard *.d) $(wildcard */*.d)

all : MyStrategy

MyStrategy : $(SRC)
    $(DC) $(DFLAGS) $(SRC) -of$@
    
run : MyStrategy
    $(LOCAL_RUNNER_BG)
    $(SLEEP) 2
    ./MyStrategy

clean :
    $(RM) MyStrategy MyStrategy.exe *.o *.obj compilation.log result.txt
