load("coef2023.mat");
A=coef.A;
B=coef.B/2;
C=coef.C;
D=coef.D/2;
E=coef.E/2;
F=coef.F;

f=.825;
rho = 7.5;


C_ = [A B D/f; 
      B C E/f;
      D/f E/f F/f^2];
[P,D]=eig(C_);

b = sqrt(1/-D(1,1));
a = sqrt(1/-D(2,2));
c = sqrt(1/D(3,3));

sigma_ba = b^2/a^2;
sigma_bc = b^2/c^2;


syms alpha
sol = solve((sin(alpha))^2 == (1-sigma_ba)/(sigma_bc+1), alpha);
alpha = eval(sol(1));
R=[1 0 0; 0 cos(alpha) sin(alpha); 0 -sin(alpha) cos(alpha)];

gamma = (b*c/a^2)*rho;
K1 = 1/a^2;
K3 = (1\b^2 + 1\c^2)*(sin(2*alpha))*gamma;
K2 = K1;


O = P*R*[0 -K3/(2*K2) gamma]'

