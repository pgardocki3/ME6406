%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%% Pierre Oucif - HW4 - Problem 2 %%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear;
close all
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Part I %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sample=(zeros(100,200,3));
sample(:,1:100,1)=225;
sample(:,1:100,2)=88;
sample(:,1:100,3)=96;
sample(:,101:200,1)=149;
sample(:,101:200,2)=135;
sample(:,101:200,3)=134;
D_h=zeros(1,9); % Vector to stock the distance between Target/Noise
[h123,D_h(1)]=ACC(sample,1,2,3);% We perform the ACC transformation
[h12c,D_h(2)]=ACC(sample,1,2,'c');
[h1b3,D_h(3)]=ACC(sample,1,'b',3);
[h1bc,D_h(4)]=ACC(sample,1,'b','c');
[ha23,D_h(5)]=ACC(sample,'a',2,3);
[ha2c,D_h(6)]=ACC(sample,'a',2,'c');
[hab3,D_h(7)]=ACC(sample,'a','b',3);
[habc,D_h(8)]=ACC(sample,'a','b','c');
% Computation of the distance Target/noise of the initial sample
D_h(9)=round(sqrt((sample(1,1,1)-sample(1,size(sample,2),1))^2+(sample(1,1,2)-sample(1,size(sample,2),2))^2+(sample(1,1,3)-sample(1,size(sample,2),3))^2));

Target_Noise=zeros(8,6); % Matrix to stock the values of the taret and noise after the ACC transformation
Target_Noise(1,:)=Color(h123); % The function Color gives us the RGB values of the Target and Noise
Target_Noise(2,:)=Color(h12c);
Target_Noise(3,:)=Color(h1b3);
Target_Noise(4,:)=Color(h1bc);
Target_Noise(5,:)=Color(ha23);
Target_Noise(6,:)=Color(ha2c);
Target_Noise(7,:)=Color(hab3);
Target_Noise(8,:)=Color(habc);

delta=130; % We add an offset delta to each RGB component to make each transformations visible 
Delta=zeros(size(sample,1),size(sample,2),3);
for i=1:3
    Delta(:,:,i)=delta;
end

% We plot the initial sample and each resulting images
figure(1)
subplot(3,3,1)
imshow(uint8(sample))
title('Sample')
subplot(3,3,2)
imshow(uint8(h123+Delta))
title('1-2-3')
subplot(3,3,3)
imshow(uint8(h12c+Delta))
title('1-2-c')
subplot(3,3,4)
imshow(uint8(h1b3+Delta))
title('1-b-3')
subplot(3,3,5)
imshow(uint8(h1bc+Delta))
title('1-b-c')
subplot(3,3,6)
imshow(uint8(ha23+Delta))
title('a-2-3')
subplot(3,3,7)
imshow(uint8(ha2c+Delta))
title('a-2-c')
subplot(3,3,8)
imshow(uint8(hab3+Delta))
title('a-b-3')
subplot(3,3,9)
imshow(uint8(habc+Delta))
title('a-b-c')
