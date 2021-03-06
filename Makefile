DEBUG=-g -DDEBUG -Wall
OPTIMUS=-O2
BIN=bin
TESTS=tests
CC=g++
PARAMS=-I./src -Wall -std=c++11 -g -DDEBUG

all: payoff payoff2 doubledigital vanillaoption simplemc2 simplemc3 simplemc4

montecarlo: payoff
	$(CC) $(PARAMS) -o bin/montecarlo_price src/options/simplemc.cpp

montecarlo2: payoff simplemc2
	$(CC) $(PARAMS) -o bin/montecarlo2 payoff1.o simplemc2.o src/options/simplemc2main.cpp

montecarlo3: payoff2 simplemc3
	$(CC) $(PARAMS) -o bin/montecarlo3 PayOff2.o simplemc3.o src/options/simplemc3main.cpp

montecarlo4: payoff2 simplemc3
	$(CC) $(PARAMS) -o bin/montecarlo4 PayOff2.o simplemc3.o src/options/simplemc4main.cpp

montecarlo5: payoff2 doubledigital simplemc3
	$(CC) $(PARAMS) -o bin/montecarlo5 doubledigital.o PayOff2.o simplemc3.o src/options/simplemc5main.cpp

montecarlo6: payoff2 simplemc4 vanillaoption
	$(CC) $(PARAMS) -o bin/montecarlo6 PayOff2.o vanilla.o simplemc4.o src/options/simplemc6main.cpp

montecarlo6a: payoff2 simplemc6a vanillaoption2 parameters payoffbridge
	$(CC) $(PARAMS) -o bin/montecarlo6a parameters.o PayOff2.o payoffbridge.o vanilla2.o simplemc6a.o src/options/simplemc6amain.cpp

vanillamain: vanillaoption doubledigital simplemc4 payoff2
	$(CC) $(PARAMS) -o bin/vanillamain vanilla.o doubledigital.o PayOff2.o simplemc4.o src/options/vanillamain.cpp

vanillamain2: vanillaoption2 simplemc5 payoff2 payoffbridge
	$(CC) $(PARAMS) -o bin/vanillamain2 PayOff2.o payoffbridge.o vanilla2.o simplemc5.o src/options/vanillamain2.cpp

statsmain: vanillaoption2 simplemc7 payoff2 payoffbridge meanstatistics
	$(CC) $(PARAMS) -o bin/statsmain PayOff2.o payoffbridge.o vanilla2.o simplemc7.o meanstatistics.o parameters.o src/options/statsmain.cpp

statsmain2: vanillaoption2 simplemc7 payoff2 payoffbridge meanstatistics convergencetable
	$(CC) $(PARAMS) -o bin/statsmain2 PayOff2.o payoffbridge.o vanilla2.o simplemc7.o meanstatistics.o parameters.o convergencetable.o src/options/statsmain2.cpp

statsmain3: vanillaoption2 simplemc8 payoff2 payoffbridge meanstatistics convergencetable antithetic arrays parkmiller random2 normals
	$(CC) $(PARAMS) -o bin/simplemc8main PayOff2.o payoffbridge.o vanilla2.o simplemc8.o meanstatistics.o antithetic.o parkmiller.o normals.o random2.o arrays.o parameters.o convergencetable.o src/options/simplemc8main.cpp

equityfxmain: vanillaoption2 simplemc8 payoff2 payoffbridge meanstatistics convergencetable antithetic arrays parkmiller random2 normals pathdependent pathdependentasian exoticengine exoticbsengine 
	$(CC) $(PARAMS) -o bin/equityfxmain PayOff2.o payoffbridge.o vanilla2.o simplemc8.o \
						meanstatistics.o antithetic.o parkmiller.o normals.o  \
						random2.o arrays.o parameters.o convergencetable.o  \
						pathdependent.o pathdependentasian.o exoticbsengine.o  exoticengine.o \
						src/options/equityfxmain.main

treemain: vanillaoption2 simplemc8 payoff2 payoffbridge meanstatistics \
convergencetable antithetic arrays parkmiller random2 \
normals pathdependent pathdependentasian exoticengine exoticbsengine payoff_forward \
treeamerican treeeuropean treeproduct parameters blackscholesformulas binomialtree
	$(CC) $(PARAMS) -o bin/treemain PayOff2.o payoffbridge.o vanilla2.o simplemc8.o \
						meanstatistics.o antithetic.o parkmiller.o normals.o  \
						random2.o arrays.o parameters.o convergencetable.o  \
						pathdependent.o pathdependentasian.o exoticbsengine.o  exoticengine.o \
						PayOffForward.o binomialtree.o treeeuropean.o treeamerican.o treeproduct.o  \
						BlackScholesFormulas.o \
						src/options/treemain.cpp

solvemain: normals bscall blackscholesformulas
	$(CC) $(PARAMS) -o bin/solvemain normals.o bscall.o BlackScholesFormulas.o \
						src/options/solvemain.cpp

solvemain2: normals bscall blackscholesformulas bscalltwo
	$(CC) $(PARAMS) -o bin/solvemain2 normals.o bscalltwo.o BlackScholesFormulas.o \
						src/options/solvemain2.cpp

payfactorymain: payoffbridge payoff2 PayOffRegistration PayOffFactory payoff_forward
	$(CC) $(PARAMS) -o bin/payfactorymain PayOff2.o payoffbridge.o PayOffRegistration.o \
						PayOffFactory.o vanilla2.o PayOffForward.o \
						src/options/payfactorymain.cpp


tests: payoff simplemc2 simplemc3 simplemc4 payoff2 vanillaoption
	$(CC) $(PARAMS) -o bin/test_uniqueptr vanilla.o doubledigital.o PayOff2.o simplemc4.o tests/test_uniqueptr.cpp
	$(CC) $(PARAMS) -o bin/test_vanillaoption vanilla.o doubledigital.o PayOff2.o simplemc4.o tests/test_vanillaoption.cpp

test_parkmiller: parkmiller random2 normals arrays
	$(CC) $(PARAMS) -o bin/test_parkmiller parkmiller.o random2.o normals.o arrays.o tests/test_parkmiller.cpp
test_antithetic: parkmiller random2 normals arrays antithetic
	$(CC) $(PARAMS) -o bin/test_antithetic parkmiller.o antithetic.o random2.o normals.o arrays.o tests/test_antithetic.cpp

payoff:
	$(CC) $(PARAMS) -c src/options/payoff1.cpp
payoff2:
	$(CC) $(PARAMS) -c src/options/PayOff2.cpp
payoff_forward:
	$(CC) $(PARAMS) -c src/options/PayOffForward.cpp
blackscholesformulas:
	$(CC) $(PARAMS) -c src/options/BlackScholesFormulas.cpp
payoffbridge:
	$(CC) $(PARAMS) -c src/options/payoffbridge.cpp
doubledigital:
	$(CC) $(PARAMS) -c src/options/doubledigital.cpp
vanillaoption:
	$(CC) $(PARAMS) -c src/options/vanilla.cpp
vanillaoption2:
	$(CC) $(PARAMS) -c src/options/vanilla2.cpp
simplemc2:
	$(CC) $(PARAMS) -c src/options/simplemc2.cpp
simplemc3:
	$(CC) $(PARAMS) -c src/options/simplemc3.cpp
simplemc4:
	$(CC) $(PARAMS) -c src/options/simplemc4.cpp
simplemc5:
	$(CC) $(PARAMS) -c src/options/simplemc5.cpp
simplemc6a:
	$(CC) $(PARAMS) -c src/options/simplemc6a.cpp
simplemc7:
	$(CC) $(PARAMS) -c src/options/simplemc7.cpp
simplemc8:
	$(CC) $(PARAMS) -c src/options/simplemc8.cpp
parameters:
	$(CC) $(PARAMS) -c src/options/parameters.cpp
meanstatistics:
	$(CC) $(PARAMS) -c src/options/meanstatistics.cpp
convergencetable:
	$(CC) $(PARAMS) -c src/options/convergencetable.cpp
random2:
	$(CC) $(PARAMS) -c src/options/random2.cpp
arrays:
	$(CC) $(PARAMS) -c src/options/arrays.cpp
normals:
	$(CC) $(PARAMS) -c src/options/normals.cpp
parkmiller:
	$(CC) $(PARAMS) -c src/options/parkmiller.cpp
antithetic:
	$(CC) $(PARAMS) -c src/options/antithetic.cpp
exoticengine:
	$(CC) $(PARAMS) -c src/options/exoticengine.cpp
exoticbsengine:
	$(CC) $(PARAMS) -c src/options/exoticbsengine.cpp
pathdependent:
	$(CC) $(PARAMS) -c src/options/pathdependent.cpp
pathdependentasian:
	$(CC) $(PARAMS) -c src/options/pathdependentasian.cpp
treeproduct:
	$(CC) $(PARAMS) -c src/options/treeproduct.cpp
treeamerican:
	$(CC) $(PARAMS) -c src/options/treeamerican.cpp
treeeuropean:
	$(CC) $(PARAMS) -c src/options/treeeuropean.cpp
binomialtree:
	$(CC) $(PARAMS) -c src/options/binomialtree.cpp
bscall:
	$(CC) $(PARAMS) -c src/options/bscall.cpp
bscalltwo:
	$(CC) $(PARAMS) -c src/options/bscalltwo.cpp
PayOffFactory:
	$(CC) $(PARAMS) -c src/options/PayOffFactory.cpp
PayOffRegistration:
	$(CC) $(PARAMS) -c src/options/PayOffRegistration.cpp

clean:
	rm bin/*
	rm *.o
