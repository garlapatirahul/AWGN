
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define PI 3.1415926536
/* unsigned long s0, s1, s2, b;
unsigned long taus()
{
b  = (((s0 << 13) ˆ  s0) >> 19);
s0 = (((s0 & 0xFFFFFFFE) << 12) ˆ b);
b  = (((s1 <<  2) ˆ  s1) >> 25);
s1 = (((s1 & 0xFFFFFFF8) <<  4) ˆ b);
b  = (((s2 <<  3) ˆ  s2) >> 11);
s2 = (((s2 & 0xFFFFFFF0) << 17) ˆ b);
return s0 ˆ s1 ˆ s2;
} */
double AWGN_generator()
{/* Generates additive white Gaussian Noise samples with zero mean and a standard deviation of 1. */
 
  double temp1;
  double temp2;
  double result;
  int p;

  p = 1;

  while( p > 0 )
  {
	temp2 = ( rand() / ( (double)RAND_MAX ) ); 

    if ( temp2 == 0 )
    {// temp2 is >= (RAND_MAX / 2)
      p = 1;
    }// end if
    else
    {// temp2 is < (RAND_MAX / 2)
       p = -1;
    }// end else

  }// end while()

  temp1 = cos( ( 2.0 * (double)PI ) * rand() / ( (double)RAND_MAX ) );
  temp0 = sin( ( 2.0*  (double)PI ) * rand() / ( (double)RAND_MAX ) );
  result1 = sqrt( -2.0 * log( temp2 ) ) * temp1;
  result2 = sqrt( -2.0 * log( temp2 ) ) * temp0;

  return result1;	// return the generated random sample to the caller

}// end AWGN_generator()
