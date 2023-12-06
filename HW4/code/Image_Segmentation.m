clc;
close all;
clear all;
im = imread('Chicken.jpg');
figure;

c = makecform('srgb2lab');
lab_he = applycform(im,c);
a = double(lab_he(:,:,2:3));
rows = size(a,1);
cols = size(a,2);
a = reshape(a,rows*cols,2);
n = 3;

[cluster_idx, cluster_center] = kmeans(a,n,'distance','sqEuclidean','Replicates',3);                                  

labels = reshape(cluster_idx,rows,cols);
ims = cell(1,3);
rlabel = repmat(labels,[1 1 3]);

for k = 1:n
    color = im;
    color(rlabel ~= k) = 0;
    ims{k} = color;
end

figure;
subplot(1,3,1);imshow(ims{1}), title('Cluster 1');
subplot(1,3,2);imshow(ims{2}), title('Cluster 2');
subplot(1,3,3);imshow(ims{3}), title('Cluster 3');