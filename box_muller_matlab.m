% Box Muller algorithm verification 
nsamples = 1000000; 

% generate two independent uniform 
distributed random variables 

u0 = rand(nsamples,1); 
u1 = rand(nsamples,1);

% transform the distributions 
f = sqrt(-log(u0)); 
g0 = sqrt(2.0)*cos(2*pi*u1);
g1 = sqrt(2.0)*sin(2*pi*u1);

%gaussian distribution 
x0 = f.*g0;
x1 = f.*g1;

% plot histogram 
hist(x0,500)
hist(x1,500)

% standard deviation is 1.0 
std(x0) 
std(x1)

% mean is zero 
mean(x0)
mean(x1)
