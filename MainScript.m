% MATLAB script for Assessment Item-1
close all;

% Step-1: Load input image
I = imread('AssignmentInput.jpg');
figure;
imshow(I);
title('Step-1: Load input image');

% Step-2: Conversion of input image to greyscale
figure;
grayImage = rgb2gray(I);
imshow(grayImage);
title('Step-2: Conversion of input image to greyscale');

% Step-3: Noise removal

