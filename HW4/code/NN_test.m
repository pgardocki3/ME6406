clear;
load('NN_weights.mat');
t1 = [1 1 1 1;
         1 0 0 0;
         1 0 0 0;
         1 0 0 0];
t2 = [0 0 0 1;
         0 0 0 1;
         0 0 0 1;
         1 1 1 1];
t3 = [1 1 1 1;
         1 0 0 1;
         1 0 0 1;
         1 1 1 1];


t1=t1(:);
t2=t2(:);
t3=t3(:);

Ij=t1;
Oj=h(Ij);
Ip=Wpj*Oj;
Op=h(Ip);
Iq=Wqp*Op;
O1=h(Iq)


Ij=t3;
Oj=h(Ij);
Ip=Wpj*Oj;
Op=h(Ip);
Iq=Wqp*Op;
O2=h(Iq)


Ij=t2;
Oj=h(Ij);
Ip=Wpj*Oj;
Op=h(Ip);
Iq=Wqp*Op;
O3=h(Iq)
