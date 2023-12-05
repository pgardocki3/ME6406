clear;
load('NN_weights.mat');
test1 = [1 1 1 1;
         1 0 0 0;
         1 0 0 0;
         1 0 0 0];
test2 = [0 0 0 1;
         0 0 0 1;
         0 0 0 1;
         1 1 1 1];
test3 = [1 1 1 1;
         1 0 0 1;
         1 0 0 1;
         1 1 1 1];
test1=test1(:);
test2=test2(:);
test3=test3(:);

Ij=test1;
Oj=h(Ij);
Ip=Wpj*Oj;
Op=h(Ip);
Iq=Wqp*Op;
Oq1=h(Iq)

Ij=test2;
Oj=h(Ij);
Ip=Wpj*Oj;
Op=h(Ip);
Iq=Wqp*Op;
Oq2=h(Iq)

Ij=test3;
Oj=h(Ij);
Ip=Wpj*Oj;
Op=h(Ip);
Iq=Wqp*Op;
Oq3=h(Iq)
