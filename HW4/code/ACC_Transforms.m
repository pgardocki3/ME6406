
clear;
close all

s=(zeros(100,200,3));
s(:,1:100,1)=225;
s(:,1:100,2)=88;
s(:,1:100,3)=96;
s(:,101:200,1)=149;
s(:,101:200,2)=135;
s(:,101:200,3)=134;

Dh=zeros(1,9); 
[h123,Dh(1)]=ACC(s,1,2,3);
[h12c,Dh(2)]=ACC(s,1,2,'c');
[h1b3,Dh(3)]=ACC(s,1,'b',3);
[h1bc,Dh(4)]=ACC(s,1,'b','c');
[ha23,Dh(5)]=ACC(s,'a',2,3);
[ha2c,Dh(6)]=ACC(s,'a',2,'c');
[hab3,Dh(7)]=ACC(s,'a','b',3);
[habc,Dh(8)]=ACC(s,'a','b','c');


Dh(9)=round(sqrt((s(1,1,1)-s(1,size(s,2),1))^2+(s(1,1,2)-s(1,size(s,2),2))^2+(s(1,1,3)-s(1,size(s,2),3))^2));

A=zeros(8,6); 
A(1,:)=[h123(1,1,1) h123(1,1,2) h123(1,1,3) h123(1,size(h123,2),1) h123(1,size(h123,2),2) h123(1,size(h123,2),3)];
A(2,:)=[h12c(1,1,1) h12c(1,1,2) h12c(1,1,3) h12c(1,size(h12c,2),1) h12c(1,size(h12c,2),2) h12c(1,size(h12c,2),3)];
A(3,:)=[h1b3(1,1,1) h1b3(1,1,2) h1b3(1,1,3) h1b3(1,size(h1b3,2),1) h1b3(1,size(h1b3,2),2) h1b3(1,size(h1b3,2),3)];
A(4,:)=[h1bc(1,1,1) h1bc(1,1,2) h1bc(1,1,3) h1bc(1,size(h1bc,2),1) h1bc(1,size(h1bc,2),2) h1bc(1,size(h1bc,2),3)];
A(5,:)=[ha23(1,1,1) ha23(1,1,2) ha23(1,1,3) ha23(1,size(ha23,2),1) ha23(1,size(ha23,2),2) ha23(1,size(ha23,2),3)];
A(6,:)=[ha2c(1,1,1) ha2c(1,1,2) ha2c(1,1,3) ha2c(1,size(ha2c,2),1) ha2c(1,size(ha2c,2),2) ha2c(1,size(ha2c,2),3)];
A(7,:)=[hab3(1,1,1) hab3(1,1,2) hab3(1,1,3) hab3(1,size(hab3,2),1) hab3(1,size(hab3,2),2) hab3(1,size(hab3,2),3)];
A(8,:)=[habc(1,1,1) habc(1,1,2) habc(1,1,3) habc(1,size(habc,2),1) habc(1,size(habc,2),2) habc(1,size(habc,2),3)];


d=120; 
D=zeros(size(s,1),size(s,2),3);
for i=1:3
    D(:,:,i)=d;
end

subplot(4,2,1)
imshow(uint8(h123+D))
title('1-2-3')
subplot(4,2,2)
imshow(uint8(h12c+D))
title('1-2-c')
subplot(4,2,3)
imshow(uint8(h1b3+D))
title('1-b-3')
subplot(4,2,4)
imshow(uint8(h1bc+D))
title('1-b-c')
subplot(4,2,5)
imshow(uint8(ha23+D))
title('a-2-3')
subplot(4,2,6)
imshow(uint8(ha2c+D))
title('a-2-c')
subplot(4,2,7)
imshow(uint8(hab3+D))
title('a-b-3')
subplot(4,2,8)
imshow(uint8(habc+D))
title('a-b-c')
