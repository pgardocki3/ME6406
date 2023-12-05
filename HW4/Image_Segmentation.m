clc;
close all;
clear all;
he = imread('Chicken.jpg');
figure;
imshow(he);cform = makecform('srgb2lab');
lab_he = applycform(he,cform);
ab = double(lab_he(:,:,2:3));
nrows = size(ab,1);
ncols = size(ab,2);
ab = reshape(ab,nrows*ncols,2);
nColors = 3;
% repeat the clustering 3 times to avoid local minima
[cluster_idx, cluster_center] = kmeans(ab,nColors,'distance','sqEuclidean', ...
                                      'Replicates',3);                                  
figure;plot(ab(cluster_idx==1,1),ab(cluster_idx==1,2),'r.','MarkerSize',12)
hold on
plot(ab(cluster_idx==2,1),ab(cluster_idx==2,2),'b.','MarkerSize',12)
hold on
plot(ab(cluster_idx==3,1),ab(cluster_idx==3,2),'g.','MarkerSize',12)
plot(cluster_center(:,1),cluster_center(:,2),'kx','MarkerSize',15,'LineWidth',3)
legend('Cluster 1','Cluster 2','Cluster3','Centroids','Location','NW')
title 'Cluster Assignments and Centroids'
pixel_labels = reshape(cluster_idx,nrows,ncols);
segmented_images = cell(1,3);rgb_label = repmat(pixel_labels,[1 1 3]);

for k = 1:nColors
    color = he;
    color(rgb_label ~= k) = 0;
    segmented_images{k} = color;
end

figure;
subplot(1,3,1);imshow(segmented_images{1}), title('Cluster 1');
subplot(1,3,2);imshow(segmented_images{2}), title('Cluster 2');
subplot(1,3,3);imshow(segmented_images{3}), title('Cluster 3');