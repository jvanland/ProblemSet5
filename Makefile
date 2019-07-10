# Makefile for ASTR_615 PS#5
#
# 	integrator1,2,3.c are the programs to integrate the 3 different sets of 
#	ODE's for problems 1, 2, and 3 respectively.
#		Output is a file NameT_nsteps_method.dat
#		
# 	First run make all.
# 	Then you can run any of the integrators.
#
# 	The file IDL contains the plotting scripts I used.
# 	The file Figures contains all the figures.
#	The file Data contains all the data files I created.
# 	ps5.pdf is the document containing written answers.

all: integrator1 integrator2 integrator3

integrator1:
	gcc -o integrator1 integrator1.c rk4.c nrutil.c -lm

integrator2:
	gcc -o integrator2 integrator2.c rk4.c nrutil.c -lm

integrator3:
	gcc -o integrator3 integrator3.c rk4.c nrutil.c -lm

clean:
	rm -rf integrator1 integrator2 integrator3