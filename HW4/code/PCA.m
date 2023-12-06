clear
clc

img = imread('Chicken.jpg');
img=im2double(img);
C=zeros(3);
N=600*800;

for k=1:3
    for j=1:3
        C(k,j)=1/(N)*sum((reshape(img(:,:,k)',N,1)-mean(mean(img(:,:,k)))).*(reshape(img(:,:,j)',N,1)-mean(mean(img(:,:,j)))));
    end
end

[V,D,W] = eig(C);
[D,I] = sort(diag(D),'descend');
V = V(:, I);
V=V';

R=img(:,:,1);
G=img(:,:,2);
B=img(:,:,3);

Rmean= sum(sum(R))/B(1)*B(2);
Gmean= sum(sum(G))/B(1)*B(2);
Bmean= sum(sum(B))/B(1)*B(2);

R1= R- Rmean;
G1= G- Gmean;
B1= B- Bmean;

R1=R1(:)';
G1=G1(:)';
B1=B1(:)';
X=[R1; G1; B1];

V1=V*X;
a=0;   
b=255;

x1_m=min(V1(1,:));  
x1_M=max(V1(1,:));  

x2_m=min(V1(2,:));  
x2_M=max(V1(2,:));  

x3_m=min(V1(3,:));  
x3_M=max(V1(3,:));  

y1=((b-a)/(x1_M-x1_m))*(V1(1,:)-x1_m) + a;
y2=((b-a)/(x2_M-x2_m))*(V1(2,:)-x2_m) + a;   
y3=((b-a)/(x3_M-x3_m))*(V1(3,:)-x3_m) + a;

r=reshape(y1,[600,800]);  
g=reshape(y2,[600,800]);
b=reshape(y3,[600,800]);


subplot(1,3,1)
imshow(uint8(r))
subplot(1,3,2)
imshow(uint8(g))
subplot(1,3,3)
imshow(uint8(b))