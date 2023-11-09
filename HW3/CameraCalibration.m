data=load('camera_calibration_data.mat');
Xw=data.Xw;
Yw=data.Yw;
u=data.u;
v=data.v;
A=[(v.*Xw)' (v.*Yw)' -1*(u.*Xw)' -1*(u.*Yw)' v'];
B=[u'];
Mu=pinv(A)*B;
Sr=Mu(1)^2+Mu(2)^2+Mu(3)^2+Mu(4)^2;
%%Assume +ve Ty
Ty=((Sr- (Sr.^2- 4*(Mu(1)*Mu(4) - Mu(2)*Mu(3)).^2)^0.5)./(2*(Mu(1)*Mu(4) - Mu(2)*Mu(3)).^2))^0.5;
Tx=Mu(5)*Ty;
R22=Mu(4)*Ty;
R21=Mu(3)*Ty;
R12=Mu(2)*Ty;
R11=Mu(1)*Ty;
%%check
i=5;%%can make this random later on
Ex= R11*Xw(i) + R12*Yw(i) + Tx;
Ex=round(Ex,6);
Ey= R21*Xw(i) + R22*Yw(i) + Ty;
Ey=round(Ey,6);

if (sign(Ex)*sign(Ey)==-1)
    Ty=-1*Ty;
    Tx=-1*Tx;
    R22=-1*R22;
    R21=-1*R21;
    R11=-1*R11;
end
S1=1;S2=1;%%assume +ve S1*S2
R13= S1*(1-R11^2 - R12^2)^0.5;
R23= S2*(1-R21^2 - R22^2)^0.5;
if (sign(R11*R22 + R12*R22)==-1)
    R31= R12*R23 - R13*R22;
    R32= R13*R21 - R11*R23;
    R33=R11*R22 - R12*R21;
else
    R13=-1*R13;
    R23=-1*R23;
    R31= R12*R23 - R13*R22;
    R32= R13*R21 - R11*R23;
    R33=R11*R22 - R12*R21;
end
R=[R11 R12 R13;R21 R22 R23; R31 R32 R33];
x=R11.*Xw+ R12.*Yw + ones(1,length(R11.*Xw))*Tx;
rd=(u.*u + v.*v).^0.5;
Ad=[x' (rd.^2.*x)' (-1.*u)'];
Bd=((R31.*Xw)' + (R32*Yw)').* u';
x= pinv(Ad)*Bd;
x=x';
Tz=x(3);
T=[Tx Ty Tz];
f=abs(x(1));