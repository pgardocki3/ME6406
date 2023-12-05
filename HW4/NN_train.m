
%Initialize Weights
%Layer Q
pnum=16;
jnum=16;
qnum=2;
Wqp=randn(qnum,pnum);
Wpj=randn(pnum,jnum); 
%%%%%%%%%%%%%%Load Training%%%%%%%%%%%%%%
t1a = [0 0 0 0;
       0 1 1 1;
       0 1 0 0;
       0 1 0 0];
t1b = [0 1 1 1;
       0 1 0 0;
       0 1 0 0;
       0 1 0 0];
t1c = [0 1 1 1;
       1 0 0 0;
       1 0 0 0;
       1 0 0 0];
t2a = [0 0 1 0;
       0 0 1 0;
       0 0 1 0;
       1 1 1 0];
t2b = [0 0 0 1;
       0 0 0 1;
       1 1 1 1;
       0 0 0 0]; 
t2c = [0 0 0 1;
       0 0 0 1;
       0 0 0 1;
       1 1 1 0]; 


t1a=t1a(:);
t1b=t1b(:);
t1c=t1c(:);

t2a=t2a(:);
t2b=t2b(:);
t2c=t2c(:);


Input1=[t1a t1b t1c];
Input2=[t2a t2b t2c];


Input=[Input1 Input2];
h=@(I) 1./(1+exp(-I));
k=0;
alpha=2;Eth=1e-4;kmax=400;
Es=100;
R=[1 0; 1 0;
   0 1; 0 1]; 
Error=zeros(1,400);
while Es > Eth && k <= kmax
    Es=0;
    k=k+1;
    TSN=4;
    for i=1:TSN
        %%%%%%%%%%%%Forward Step%%%%%%%%% 
        Ij=Input(:,i);
        Oj=h(Ij);
        Ip=Wpj*Oj;
        Op=h(Ip);
        Iq=Wqp*Op; %%49*4
        Oq=h(Iq);

        deltaQ=(R(i,:)'-Oq).*(h(Iq).*(1-h(Iq)));
        deltaP=h(Ip)'.*(1-h(Ip))'.*(deltaQ'*Wqp);
        
        Wqp=Wqp+deltaQ*Op';
        Wpj=Wpj+deltaP'*Oj';
        Es=.5*sum((R(i,:)'-Oq).^2);        
    end
    Error(k)=Es; 
end

plot(Error);xlabel('Number of Epochs');ylabel('Error');
save('NN_weights.mat')