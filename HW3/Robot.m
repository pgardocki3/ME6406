data=load('robot_hand_eye_data.mat');
Hc1=data.Hc1;
Hc2=data.Hc2;
Hc3=data.Hc3;
Hg12=data.Hg12;
Hg23=data.Hg23;
format compact
format short


Hc12=Hc2*inv(Hc1); 
Hc23=Hc3*inv(Hc2);


Rc12=Hc12(1:3,1:3);
Tc12=Hc12(1:3,4);
Rc23=Hc23(1:3,1:3);
Tc23=Hc23(1:3,4);

disp(Rc12)
disp(Rc23)
disp(Tc12)
disp(Tc23)


r11=Rc12(1,1);
r12=Rc12(1,2);
r13=Rc12(1,3);
r21=Rc12(2,1);
r22=Rc12(2,2);
r23=Rc12(2,3);
r31=Rc12(3,1);
r32=Rc12(3,2);
r33=Rc12(3,3);
thetaRc12=acosd((r11+r22+r33-1)/2);
a = 1/(2*sind(thetaRc12));
if sign(r32-r23)~=sign(a*(r32-r23))
    thetaRc12=-thetaRc12;
end
thetaRc12 
n_Rc12=[r32-r23;r13-r31;r21-r12]*a


r11=Rc23(1,1);
r12=Rc23(1,2);
r13=Rc23(1,3);
r21=Rc23(2,1);
r22=Rc23(2,2);
r23=Rc23(2,3);
r31=Rc23(3,1);
r32=Rc23(3,2);
r33=Rc23(3,3);
thetaRc23=acosd((r11+r22+r33-1)/ 2);
a = 1/(2*sind(thetaRc23));
if sign(r32-r23)~=sign(a*(r32-r23))
    thetaRc23=-thetaRc23;
end
thetaRc23 
n_Rc23=[r32-r23;r13-r31;r21-r12]*a
 
Pc12=2*sind(thetaRc12/2)*n_Rc12
Pc23=2*sind(thetaRc23/2)*n_Rc23

Rg12=Hg12(1:3,1:3);
Tg12=Hg12(1:3,4);
r11=Rg12(1,1);
r12=Rg12(1,2);
r13=Rg12(1,3);
r21=Rg12(2,1);
r22=Rg12(2,2);
r23=Rg12(2,3);
r31=Rg12(3,1);
r32=Rg12(3,2);
r33=Rg12(3,3);
thetaRg12=acosd((r11+r22+r33-1)/2)
n_Rg12=[r32-r23;r13-r31;r21-r12]*1/(2*sind(thetaRg12))
Pg12=2*sind(thetaRg12/2)*n_Rg12

Rg23=Hg23(1:3,1:3);
Tg23=Hg23(1:3,4);
r11=Rg23(1,1);
r12=Rg23(1,2);
r13=Rg23(1,3);
r21=Rg23(2,1);
r22=Rg23(2,2);
r23=Rg23(2,3);
r31=Rg23(3,1);
r32=Rg23(3,2);
r33=Rg23(3,3);
thetaRg23=acosd((r11+r22+r33-1)/2)
n_Rg23=[r32-r23;r13-r31;r21-r12]*1/(2*sind(thetaRg23))
Pg23=2*sind(thetaRg23/2)*n_Rg23



P=Pg12;
P_skew=[0 -P(3) P(2);P(3) 0 -P(1);-P(2) P(1) 0];
alpha=sqrt(4-norm(P)^2);
Rcheck_Rg12=(1-norm(P)^2/2)*eye(3)+1/2*(P*P'+alpha*P_skew);
round(Rcheck_Rg12,4) == round(Rg12,4)

P=Pg23;
P_skew=[0 -P(3) P(2);P(3) 0 -P(1);-P(2) P(1) 0];
alpha=sqrt(4-norm(P)^2);
Rcheck_Rg23=(1-norm(P)^2/2)*eye(3)+1/2*(P*P'+alpha*P_skew);
round(Rcheck_Rg23,4) == round(Rg23,4)


A12=Pg12+Pc12;
A23=Pg23+Pc23;
skewA12=[0 -A12(3) A12(2);A12(3) 0 -A12(1);-A12(2) A12(1) 0];
skewA23=[0 -A23(3) A23(2);A23(3) 0 -A23(1);-A23(2) A23(1) 0];
A=[skewA12;skewA23];
B=[(Pg12-Pc12);(Pg23-Pc23)];
PcgP=pinv(A)*B;
Pcg=(2*PcgP)/sqrt(1+norm(PcgP)^2)
alpha=sqrt(4-norm(Pcg)^2);
Pcg_skew=[0 -Pcg(3) Pcg(2);Pcg(3) 0 -Pcg(1);-Pcg(2) Pcg(1) 0];
Rcg=(1-norm(Pcg)^2/2)*eye(3)+1/2*(Pcg*Pcg'+alpha*Pcg_skew)
Tcg=pinv(Rg12-eye(3))*(Rcg*Tc12-Tg12)


