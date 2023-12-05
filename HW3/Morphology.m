A = imread('HeadCT.png');

figure;
subplot(2, 2, 1);
imshow(A);
title('Original Image');

B = ones(3);

dilation = imdilate(A, B);
subplot(2, 2, 2);
imshow(dilation);
title('1. Dilation (A ⊕ B)');

erosion = imerode(A, B);
subplot(2, 2, 3);
imshow(erosion);
title('2. Erosion (AӨB)');


Amorphgrad = imsubtract(dilation, erosion);
subplot(2, 2, 4);
imshow(Amorphgrad);
title('3. Dilation-Erosion (A ⊕ B - (AӨB))');
