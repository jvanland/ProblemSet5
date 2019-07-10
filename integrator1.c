                                      /*INTEGRATOR*/

//This program integrates any number (NUM) of coupled 1st order differential equations supplied in function 'deriv'.
//Supply initial values (XINIT) at t = 0.
//Give your set of equations a name, output will be a file with this name.
//Command line input is ./integrator Integration_time Step_size Integration_method
//Integration methods (1 = Euler, 2 = Runge-Kutta 4, 3 = Leapfrog)
//Requires nr.h, nrutil.h, nrutil.c, rk4.c [rk4.c and nr.h modified for double precision]

#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include "nrutil.h"
#include "nr.h"
#define NAME (char *)("Sinusoid")  //Give your set of ODE's a name
#define NUM 2  //Number of ODE's
#define XINIT {0, 1}  //Initial conditions

//Function that returns the ODE's
void deriv(double t, double x[], double dxdt[]){

  //Input ODE's here
  //Velocities first (dxdt[1], dxdt[2]...)
  dxdt[1] = x[2];
  //Accelerations last (...dxdt[NUM-1], dxdt[NUM])
  dxdt[2] = -x[1];
 
}

int main(int argc,char *argv[ ])
{
  //take input values
  if (argc != 4)  {
    printf("Usage: %s Integration_time\tStep_size\tIntegration_method (1=Euler,2=RK4,3=LF)\n",argv[0]);
    return 1;
  }
  printf("Reading input...\n");
  double Time = atof(argv[1]); //Integration time
  int T = Time;
  double step = atof(argv[2]);  //timestep
  int method = atoi(argv[3]);  //Integration method

  //initialize variables
  int i,j,n;
  double *dxdt = dvector(1,NUM);
  double *xold = dvector(1,NUM);
  double *x = dvector(1,NUM);
  double *xprint = dvector(1,NUM);
  int nsteps = (Time/step)+0.5;

  //Set initial conditions
  double xinit[NUM] = XINIT;
  for (i=0;i<NUM;i++){
    x[i+1] = xinit[i];
  }
  double t = 0;

  //create file with name NameT_nsteps_method.dat
  printf("Creating file %s%i_%i_%i.dat...\n", NAME, T, nsteps, method);
  char format[] = "%s%i_%i_%i.dat";
  char filename[sizeof format+100];
  sprintf(filename,format,NAME,T,nsteps,method);
  FILE *fp;

if (fp = fopen(filename, "w"))
{
  //print initial values
  printf("Writing initial values to file...\n");
  for (i=1;i<=NUM;i++){
    fprintf(fp, "x%i\t", i);
  }
  fprintf(fp, "t\n");
  for (i=1;i<=NUM;i++){
    fprintf(fp, "%f\t", x[i]);
  }
  fprintf(fp, "%f\n", t);

  //Euler Method
if (method == 1) {
  printf("Integrating using Euler method...\n");

  //loop over number of steps
    for (n=0;n<nsteps;n++){

      //set the values and derivatives at the nth step
      for (j=1;j<=NUM;j++){
	xold[j] = x[j];
      }
      deriv(t, xold, dxdt);

    //calculate values for the n+1 step
      for (i=1;i<=NUM;i++){
	x[i] = xold[i] + step*dxdt[i];
	fprintf(fp, "%1.10f\t", x[i]);
      }
      t = (n+1)*step;
      fprintf(fp, "%f\n", t);

    }
   
 }

//Runge-Kutta 4 method
 else if (method == 2){
   printf("Integrating using Runge-Kutta 4 method...\n");

   //loop over number of steps
   for (n=0;n<nsteps;n++){
     t = n*step;
     //set derivatives at t
     deriv(t, x, dxdt);
     //calculate values of x for the n+1 step
     rk4(x, dxdt, NUM, t, step, x, deriv);
     double ntime = t+step;
     for (i=1;i<=NUM;i++){
       fprintf(fp, "%1.12f\t", x[i]);
      }
     fprintf(fp, "%f\n", ntime);
   }


 }

//Leapfrog method
 else if (method == 3){
   printf("Integrating using Leapfrog method...\n");
   //kick velocities
   deriv(t, x, dxdt);
   for (i=(NUM/2)+1;i<=NUM;i++){
     x[i] = x[i] + (step/2)*dxdt[i];
   }
  //loop over number of steps
    for (n=1;n<=nsteps;n++){
      //set the positions at the nth step and velocities at n+1/2 and take derivatives
      for (j=1;j<=NUM;j++){
	xold[j] = x[j];
      }
      deriv(t, xold, dxdt);
      //calculate values of position for the n+1 step
      for (i=1;i<=NUM/2;i++){
	x[i] = xold[i] + step*dxdt[i];
	fprintf(fp, "%1.10f\t", x[i]);
      }
      //take new derivatives with positions at n+1
      deriv(t, x, dxdt);

      if (n<nsteps){
      //calculate value of velocities for the n+3/2 step
	for (i=(NUM/2)+1;i<=NUM;i++){
	  x[i] = xold[i] + step*dxdt[i];
	  //calculate value of velocities for the n+1 step for file
	  xprint[i] = xold[i] + (step/2)*dxdt[i];
	    fprintf(fp, "%f\t", xprint[i]);
	}
      }
      else if (n==nsteps){
	//kick
	for (i=(NUM/2)+1;i<=NUM;i++){
	  x[i] = xold[i] + (step/2)*dxdt[i];
	  fprintf(fp, "%1.10f\t", x[i]);
	}
      }
      t = n*step;
      fprintf(fp, "%f\n", t);
    }
 }

 printf("Integration complete, values written to file.\n");

fclose(fp);
}
else
printf("Error opening %s%i_%i_%i.dat...\n", NAME, T, nsteps, method);

    return 0;

}

