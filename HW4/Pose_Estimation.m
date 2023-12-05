image = imread('block.png');
BW = edge(image, 'canny');
[H, T, R] = hough(BW);
P = houghpeaks(H, 9);
lines = houghlines(BW, T, R, P);
Nc = zeros(9, 3);
P = zeros(9, 3);
cx=376;
cy=240;
dx=.0006;

for i = 1:9
    x1 = (lines(i).point1(1)-cx)*dx;
    y1 = -(lines(i).point1(2)-cy)*dx;
    x2 = (lines(i).point2(1)-cx)*dx;
    y2 = -(lines(i).point2(2)-cy)*dx;

    a = (y1 - y2)*.79;
    b = (x2 - x1)*.79;
    c = (x1*y2-x2*y1);

    magnitude = sqrt(a^2 + b^2 + c^2);
    Nc(i, :) = [a, b, c] / magnitude;
    P(i, :) = [a, b, c] / magnitude;
end
Px=[10 0 10 10 0 0 0 0 10];
Py=[0 0 0 10 0 10 10 10 10];
Pz=[0 10 10 10 10 10 10 0 10];

V = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 -.4226 -.6943 -.5826]';

W = [Nc(1,1) 0 0 Nc(1,2) 0 0 Nc(1,3) 0 0 0 0 0;%1
     Nc(1,1)*Px(1) 0 0 Nc(1,2)*Px(1) 0 0 Nc(1,3)*Px(1) 0 0 Nc(1,1) Nc(1,2) Nc(1,3);
     Nc(2,1) 0 0 Nc(2,2) 0 0 Nc(2,3) 0 0 0 0 0;%2
     Nc(2,1)*Px(2) 0 Nc(2,1)*Pz(2) Nc(2,2)*Px(2) 0 Nc(2,2)*Pz(2) Nc(2,3)*Px(2) 0 0 Nc(2,1) Nc(2,2) Nc(2,3);
     0 0 Nc(3,1) 0 0 Nc(3,2) 0 0 Nc(3,3) 0 0 0;%3
     0 0 Nc(3,1)*Pz(3) 0 0 Nc(3,2)*Pz(3) 0 0 Nc(3,3)*Pz(3) Nc(3,1) Nc(3,2) Nc(3,3);
     Nc(4,1) 0 0 Nc(4,2) 0 0 Nc(4,3) 0 0 0 0 0;%4
     Nc(4,1)*Px(4) Nc(4,1)*Px(4) Nc(4,1)*Px(4) Nc(4,2)*Py(4) Nc(4,2)*Py(4) Nc(4,2)*Py(4) Nc(4,3)*Pz(4) Nc(4,3)*Pz(4) Nc(4,3)*Pz(4) Nc(4,1) Nc(4,2) Nc(4,3);
     0 0 Nc(5,1) 0 0 Nc(5,2) 0 0 Nc(5,3) 0 0 0;%5
     Nc(5,1)*Px(5) 0 Nc(5,1)*Pz(5) Nc(5,2)*Px(5) 0 Nc(5,2)*Pz(5) Nc(5,3)*Px(5) 0 Nc(5,3)*Pz(5) Nc(5,1) Nc(5,2) Nc(5,3);
     0 0 Nc(6,1) 0 0 Nc(6,2) 0 0 Nc(6,3) 0 0 0;%6
     0 Nc(6,1)*Py(6) Nc(6,1)*Pz(6) 0 Nc(6,2)*Py(6) Nc(6,2)*Pz(6) 0 Nc(6,3)*Py(6) Nc(6,3)*Pz(6) Nc(6,1) Nc(6,2) Nc(6,3);
     0 Nc(7,1) 0 0 Nc(7,2) 0 0 Nc(7,3) 0 0 0 0;%7
     0 Nc(7,1)*Py(7) Nc(7,1)*Pz(7) 0 Nc(7,2)*Py(7) Nc(7,2)*Pz(7) 0 Nc(7,3)*Py(7) Nc(7,3)*Pz(7) Nc(7,1) Nc(7,2) Nc(7,3);
     0 Nc(8,1) 0 0 Nc(8,2) 0 0 Nc(8,3) 0 0 0 0;%8
     0 Nc(8,1)*Py(8) 0 0 Nc(8,2)*Py(8) 0 0 Nc(8,3)*Py(8) 0 Nc(8,1) Nc(8,2) Nc(8,3);
     0 Nc(9,1) 0 0 Nc(9,2) 0 0 Nc(9,3) 0 0 0 0;%9
     Nc(9,1)*Px(9) Nc(9,1)*Py(9) Nc(9,1)*Pz(9) Nc(9,2)*Px(9) Nc(9,2)*Py(9) Nc(9,2)*Pz(9) Nc(9,3)*Px(9) Nc(9,3)*Py(9) Nc(9,3)*Pz(9) Nc(9,1) Nc(9,2) Nc(9,3);
     0 0 1 0 0 0 0 0 0 0 0 0;%circle
     0 0 0 0 0 1 0 0 0 0 0 0;
     0 0 0 0 0 0 0 0 1 0 0 0;
     -.4226 0 0 -.6943 0 0 -.5826 0 0 0 0 0;
     0 -.4226 0 0 -.6943 0 0 -.5826 0 0 0 0;
     0 0 -.4226 0 0 -.6943 0 0 -.5826 0 0 0];



B=inv(W'*W)*W'*V


% figure;
% imshow(image);
% title('Original Image');
% hold on;
% for i = 1:length(lines)
% 
%     xy = [lines(i).point1; lines(i).point2];
%     plot(xy(:, 1), xy(:, 2), 'LineWidth', 2, 'Color', 'r'); 
% end