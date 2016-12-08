% MATLAB script for Assessment Item-1
close all;

% Step-1: Load input image
IM = imread('AssignmentInput.jpg');
figure;
imshow(IM);
title('Step-1: Load input image');

% Step-2: Conversion of input image to greyscale
% Create new 2d matrix for grayscale image
IM = im2double(IM);
IM2 = zeros(size(IM,1), size(IM,2));

% Using Y = 0.289*R + 0.5870*G + 0.1140*B to change from RGB to grayscale
for row = 1 : size(IM,1)
    for col = 1 : size(IM,2)        
        IM2(row, col) = 0.2989 * IM(row, col, 1) + 0.5870 * IM(row, col, 2) + 0.1140 * IM(row, col, 3);
    end
end

figure;
subplot(1,2,1);
%IM2 = rgb2gray(IM);
imshow(IM);
title('Coloured input');
subplot(1,2,2);
imshow(IM2);
title('Grayscale output');

% ------ Step-3: Noise removal ~ Median Filter ------ % 
% Converting both the input, and output images to double for consistency

noNoise = zeros(size(IM2));
IMD = im2double(IM2); 
count = 1;
array = zeros(1,9);
% Run over the entire image with a 3x3 kernel.
% Sort these 9 pixel values and use the median value for the center pixel
for row = 2 : size(IMD, 1) - 1
    for col = 2 : size(IMD, 2) - 1      
        for a = row - 1 : row + 1
            for b = col - 1 : col + 1
                array(count) = IMD(a,b);
                count = count + 1;
            end
        end
        count = 1;
        sortedArray = sort(array);
        noNoise(row, col) = sortedArray(5);
    end
end
% Compare the noisy imge to my median filtered no noise image
figure;
subplot(1,3,1);
imshow(IM2);
title('Noisy input');
subplot(1,3,2);
imshow(noNoise);
title('Median filter - My Code');

% ------ Step-3: Noise Removal Matlab Code ------ %
% This is here just to compare against my median filter 
IM3 = medfilt2(IM2);
subplot(1,3,3);
imshow(IM3);
title('Matlab Medfilt2');
% subplot(1, 2, 2);
% imhist(IM3);
% title('Noiseless image hist');

% Step-4: Image Sharpening
sm1 = noNoise;
sm2 = zeros(size(sm1));

% Run through image 5 times with 3x3 kernel. Sum each pixel neighbourhood
% and apply mean value of neighbourhood to middle pixel for a mean filter
sum = 0;
for loopcount = 0 : 5
    for row = 2 : size(sm1, 1) - 1
        for col = 2 : size(sm1, 2) - 1      
            for a = row - 1 : row + 1
                for b = col - 1 : col + 1
                    sum = sum + sm1(a,b);
                end
            end
            
            sum = sum / 9;
            sm2(row, col) = sum;
            sum = 0;
        end
    end
end

% Subtract smooth from original to make edge image
% Then add edge to original to enhance edges for sharpening effect
edge = sm1 - sm2;
sharp = sm1 + edge;

figure;
subplot(1, 3, 1);
imshow(IM3);
title('IM2');
subplot(1, 3, 2);
imshow(edge);
title('Edge');
subplot(1, 3, 3);
imshow(sharp);
title('Sharp');

%----- This is the matlab code for image sharpening -----%
%IM4 = imsharpen(IM3);
% figure;
% subplot(1, 2, 1);
% imshow(IM4);
% title('Sharp matlab');
% subplot(1, 2, 2);
% imshow(sharp);
% title('Sharp me');

% Step-5: Binary Image Segmentation 

%level = graythresh(IM4);

% This threshold lets more data through into the foreground, which makes
% allows the morphological processing step to produce better results. Any
% extra data that gets through is easy to clean up anyway.
threshold = 0.935;

BW = false(size(sharp));

for row = 1 : size(sharp, 1)
    for col = 1 : size(sharp, 2)
        if sharp(row, col) > threshold
            BW(row, col) = true;
        end
    end
end

% Invert the image such that black is the background
BW = ~BW ;

figure;
imshow(BW);
title('Binary Image');

%Step-6: Morphological Processing

se = strel('square',4);
se2 = strel('disk',3);
IM5 = imerode(BW, se);
IM6 = imdilate(IM5, se2);
% Clear away the extra data and random clusters 
IM7 = bwareaopen(IM6, 200);

figure;
imshow(IM7);
title('Step-6: Morphological Processing');

% Step-7: Starfish recognition

IM8 = IM7;
L = bwlabel(IM8);
S = regionprops(L, 'Area', 'Perimeter');
metrics = zeros(1,25);
area = [S.Area];
perimeter = [S.Perimeter];
for i = 1 : length(metrics)
    metrics(i) = 4*pi*area(i)/perimeter(i).^2;
end
% Show all metric values to inspect them
display(metrics);

% Find all starfish obejcts based on roundness metric range and move into
% new image
idx = find(( metrics > 0.21)  & (metrics < 0.26));
IM9 = ismember(L, idx);

figure;
imshow(IM9);
title('Step-7 Automatic recognition');
