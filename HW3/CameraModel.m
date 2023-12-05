Pw=[-2 -1 0 1 2 3 -2 -1 0 1 2 3 -1 -2 -1 -2 -1 -2 -1 -2;
    0 0 0 0 0 0 1 1 1 1 1 1 2 2 3 3 4 4 5 5;
    0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
theta=135*pi/180;
f=1.3;
T=[3 3.5 7.5];
k1= 0.01;
Pw = [Pw; ones(1,length(Pw))];
Rx=[1 0 0;0 cos(theta) -sin(theta);0 sin(theta) cos(theta)];
Pc=[Rx T';0 0 0 1];
Cc=Pc*Pw;
u=f.* (Cc(1,:)./Cc(3,:));

v=f.* (Cc(2,:)./Cc(3,:));

r = sqrt(u.^2 + v.^2);
ud = u .* (1 + k1 * r.^2);
vd = v .* (1 + k1 * r.^2);
Xw=Pw(1,:);
Yw=Pw(2,:);

figure;
scatter(ud, vd);
xlabel('ud');
ylabel('vd');
title('2D Image Coordinates');

save('camera_calibration_data.mat','Xw','Yw','u','v','ud','vd');

