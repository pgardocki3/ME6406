clear
clc
% img(:,:,1)=[3 3 5 6; 3 4 4 5; 4 5 5 6; 4 5 5 6];
% img(:,:,2)=[3 2 3 4; 1 5 3 6; 4 5 3 6; 2 4 4 5];
% img(:,:,3)=[4 2 3 4; 1 4 2 4; 4 3 3 5; 2 3 5 5];

img = imread('Chicken.jpg'); % Read image
img=im2double(img);
C=zeros(3);
B=size(img);
N=(B(1)*B(2));

for k=1:3
    for j=1:3
        C(k,j)=1/(N)*sum((reshape(img(:,:,k)',N,1)-mean(mean(img(:,:,k)))).*(reshape(img(:,:,j)',N,1)-mean(mean(img(:,:,j)))));
    end
end

[V,D,W] = eig(C);
[D,I] = sort(diag(D),'descend');
V = V(:, I);
V=V';
% 
% for k=1:3
%     for m=1:B(1)
%         for n=1:B(2)
%             P(m,n,k)=V(k,:)*reshape(img(m,n,:),3,1);
%         end
%     end
%     %
%     minimum(k)=min(min(P(:,:,k)));
%     maximum(k)=max(max(P(:,:,k)));
% end

C,V,D

R=img(:,:,1);
G=img(:,:,2);
B=img(:,:,3);

R_mean= sum(sum(R))/B(1)*B(2);
G_mean= sum(sum(G))/B(1)*B(2);
B_mean= sum(sum(B))/B(1)*B(2);

R_hat= R- R_mean;
G_hat= G- G_mean;
B_hat= B- B_mean;

R_hat=R_hat(:)';
G_hat=G_hat(:)';
B_hat=B_hat(:)';
X=[R_hat; G_hat; B_hat];

Y=V*X;
b=255;
a=0;
x1_m=min(Y(1,:));
x1_M=max(Y(1,:));
x2_m=min(Y(2,:));
x2_M=max(Y(2,:));
x3_m=min(Y(3,:));
x3_M=max(Y(3,:));

y1=((b-a)/(x1_M-x1_m))*(Y(1,:)-x1_m) + a;
y2=((b-a)/(x2_M-x2_m))*(Y(2,:)-x2_m) + a;
y3=((b-a)/(x3_M-x3_m))*(Y(3,:)-x3_m) + a;

yr=reshape(y1,[600,800]);
yg=reshape(y2,[600,800]);
yb=reshape(y3,[600,800]);

Image_new(:,:,1)=yr;
Image_new(:,:,2)=yg;
Image_new(:,:,3)=yb;

subplot(1,3,1)
imshow(uint8(yr))

subplot(1,3,2)
imshow(uint8(yg))

subplot(1,3,3)
imshow(uint8(yb))