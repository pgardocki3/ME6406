function []=  CameraModel(Wc,theta,f,T)
% Wc=[-2 -2 0 1 2 3 -2 -1 0 1 2 3 -1 -2 -1 -2 -1 -2 -1 -2;0 0 0 0 0 0 1 1 1 1 1 1 2 2 3 3 4 4 5 5;0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
% theta=135*pi/180;
% f=1.3;
% T=[3 3.5 7.5];
Wc = [Wc; ones(1,length(Wc))];
Rx=[1 0 0;0 cos(theta) -sin(theta);0 sin(theta) cos(theta)];
Hwc=[Rx T';0 0 0 1];
Cc=Hwc*Wc;
u=f.* (Cc(1,:)./Cc(3,:));
u=round(u,6);
v=f.* (Cc(2,:)./Cc(3,:));
v=round(v,6);
Xw=Wc(1,:);
Yw=Wc(2,:);
save('camera_calibration_data.mat','Xw','Yw','u','v');
end